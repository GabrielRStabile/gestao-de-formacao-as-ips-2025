import 'dart:async';

import 'package:auth_service/config/app_configuration.dart';
import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:uuid/uuid.dart';
import 'package:vaden/vaden.dart' as vaden;
import 'package:vaden/vaden.dart';

import '../dtos/login_dto.dart';
import '../dtos/password_dto.dart';
import '../dtos/register_dto.dart';
import '../dtos/token_dto.dart';
import '../errors/authentication_error.dart';
import '../errors/validation_error.dart';
import '../models/database.dart';
import '../repositories/password_reset_token_repository.dart';
import '../repositories/user_auth_data_repository.dart';
import '../services/event_publisher.dart';
import '../services/jwt_manager.dart';
import '../services/password_encoder.dart';

/// Main authentication service
///
/// Handles user registration, login, password management, and token operations
@vaden.Service()
class AuthService {
  final UserAuthDataRepository _userRepository;
  final PasswordResetTokenRepository _tokenRepository;
  final PasswordEncoder _passwordEncoder;
  final JwtManager _jwtManager;
  final EventPublisher _eventPublisher;
  final Uuid _uuid = const Uuid();

  /// Maximum failed login attempts before account lockout
  static int get _maxFailedAttempts =>
      int.tryParse(env['MAX_FAILED_LOGIN_ATTEMPTS'] ?? '5') ?? 5;

  /// Account lockout duration in minutes
  static int get _lockoutMinutes =>
      int.tryParse(env['ACCOUNT_LOCKOUT_MINUTES'] ?? '15') ?? 15;

  /// Password reset token expiration in hours
  static int get _resetTokenExpirationHours =>
      int.tryParse(env['PASSWORD_RESET_TOKEN_EXPIRATION_HOURS'] ?? '1') ?? 1;

  AuthService(
    this._userRepository,
    this._tokenRepository,
    this._passwordEncoder,
    this._jwtManager,
    this._eventPublisher,
  );

  /// Registers a new user
  ///
  /// [request] The registration request data
  /// Returns registration response with user details
  /// Throws [ValidationError] if validation fails
  Future<RegisterResponseDto> register(
    RegisterRequestDto request, [
    String? ipAddress,
  ]) async {
    final validationResult = request
        .validate(ValidatorBuilder<RegisterRequestDto>())
        .validate(request);

    if (!validationResult.isValid) {
      throw ValidationError(
        validationResult.exceptions.map((e) => e.message).toList(),
      );
    }

    // Validate input
    final validationErrors = <String>[];

    final passwordErrors = _passwordEncoder.validatePasswordComplexity(
      request.password,
    );
    validationErrors.addAll(passwordErrors);

    if (validationErrors.isNotEmpty) {
      throw ValidationError(validationErrors);
    }

    // Check if email already exists
    if (await _userRepository.emailExists(request.email)) {
      throw ValidationError(['Email already exists']);
    }

    // Create user
    final userId = _uuid.v4();
    final role = 'formando';
    final hashedPassword = _passwordEncoder.hashPassword(request.password);

    final userData = UserAuthDataCompanion(
      userId: Value(userId),
      email: Value(request.email),
      role: Value(role),
      hashedPassword: Value(hashedPassword),
      isActive: const Value(true),
    );

    await _userRepository.create(userData);

    // Publish events
    await _eventPublisher.publishUserRegistered(
      userId: userId,
      email: request.email,
      role: role,
    );

    unawaited(
      _eventPublisher.publishAuditEvent(
        eventType: EventType.create,
        userId: userId,
        targetEntityType: 'user',
        targetEntityId: userId,
        details: {'email': request.email, 'role': role},
        ipAddress: ipAddress,
      ),
    );

    return RegisterResponseDto(
      userId: userId,
      email: request.email,
      role: role,
    );
  }

  /// Authenticates a user and returns JWT token
  ///
  /// [request] The login request data
  /// [ipAddress] Optional IP address for audit
  /// Returns login response with JWT token
  /// Throws [AuthenticationError] if authentication fails
  Future<LoginResponseDto> login(
    LoginRequestDto request, [
    String? ipAddress,
  ]) async {
    final validationResult = request
        .validate(ValidatorBuilder<LoginRequestDto>())
        .validate(request);

    if (!validationResult.isValid) {
      throw ValidationError(
        validationResult.exceptions.map((e) => e.message).toList(),
      );
    }

    // Find user
    final user = await _userRepository.findByEmail(request.email);
    if (user == null || !user.isActive) {
      _publishFailedLoginAudit(
        request.email,
        'User not found or inactive',
        ipAddress,
      );
      throw AuthenticationError('Invalid credentials');
    }

    // Check if account is locked
    if (_userRepository.isAccountLocked(user)) {
      _publishFailedLoginAudit(request.email, 'Account locked', ipAddress);
      throw AuthenticationError(
        'Account is temporarily locked due to multiple failed login attempts',
      );
    }

    // Verify password
    if (!_passwordEncoder.verifyPassword(
      request.password,
      user.hashedPassword,
    )) {
      await _handleFailedLogin(user, ipAddress);
      throw AuthenticationError('Invalid credentials');
    }

    // Reset failed attempts on successful login
    await _userRepository.resetFailedLoginAttempts(user.userId);

    // Generate JWT token
    final token = _jwtManager.generateToken(
      userId: user.userId,
      email: user.email,
      role: user.role,
    );

    // Publish audit event
    await _eventPublisher.publishAuditEvent(
      eventType: EventType.update,
      userId: user.userId,
      targetEntityType: 'user',
      targetEntityId: user.userId,
      ipAddress: ipAddress,
      details: {'action': 'login', 'email': user.email, 'role': user.role},
    );

    return LoginResponseDto(
      accessToken: token,
      tokenType: 'Bearer',
      expiresIn: _jwtManager.getExpirationTimeInSeconds(),
      userId: user.userId,
      email: user.email,
      role: user.role,
    );
  }

  /// Validates a JWT token and returns its claims
  ///
  /// [request] The token introspection request
  /// Returns token validation response
  Future<IntrospectTokenResponseDto> introspectToken(
    IntrospectTokenRequestDto request,
  ) async {
    final payload = _jwtManager.validateToken(request.token);

    if (payload == null) {
      return IntrospectTokenResponseDto.inactive();
    }

    return IntrospectTokenResponseDto.active(
      sub: payload['sub'] as String,
      iss: payload['iss'] as String,
      exp: payload['exp'] as int,
      iat: payload['iat'] as int,
      email: payload['email'] as String,
      role: payload['role'] as String,
    );
  }

  /// Changes a user's password
  ///
  /// [userId] The user ID from JWT token
  /// [request] The password change request
  /// [ipAddress] Optional IP address for audit
  /// Returns success response
  /// Throws [AuthenticationError] or [ValidationError] if operation fails
  Future<SuccessResponseDto> changePassword(
    String userId,
    ChangePasswordRequestDto request, [
    String? ipAddress,
  ]) async {
    final validationResult = request
        .validate(ValidatorBuilder<ChangePasswordRequestDto>())
        .validate(request);

    if (!validationResult.isValid) {
      throw ValidationError(
        validationResult.exceptions.map((e) => e.message).toList(),
      );
    }

    // Validate new password
    final passwordErrors = _passwordEncoder.validatePasswordComplexity(
      request.newPassword,
    );

    if (passwordErrors.isNotEmpty) {
      throw ValidationError(passwordErrors);
    }

    // Find user
    final user = await _userRepository.findByUserId(userId);
    if (user == null || !user.isActive) {
      throw AuthenticationError('User not found');
    }

    // Verify current password
    if (!_passwordEncoder.verifyPassword(
      request.currentPassword,
      user.hashedPassword,
    )) {
      await _eventPublisher.publishAuditEvent(
        eventType: EventType.update,
        userId: userId,
        targetEntityType: 'user',
        targetEntityId: userId,
        ipAddress: ipAddress,
        details: {'reason': 'invalid_current_password'},
      );
      throw AuthenticationError('Current password is incorrect');
    }

    // Update password
    final newHashedPassword = _passwordEncoder.hashPassword(
      request.newPassword,
    );
    await _userRepository.updatePassword(userId, newHashedPassword);

    // Invalidate any existing reset tokens
    await _tokenRepository.deleteUserTokens(userId);

    // Publish audit event
    await _eventPublisher.publishAuditEvent(
      eventType: EventType.update,
      userId: userId,
      targetEntityType: 'user',
      targetEntityId: userId,
      ipAddress: ipAddress,
      details: {'action': 'password_changed'},
    );

    return const SuccessResponseDto(message: 'Password changed successfully');
  }

  /// Initiates password reset process
  ///
  /// [request] The forgot password request
  /// [ipAddress] Optional IP address for audit
  /// Returns success response (always, for security)
  Future<SuccessResponseDto> forgotPassword(
    ForgotPasswordRequestDto request, [
    String? ipAddress,
  ]) async {
    final validationResult = request
        .validate(ValidatorBuilder<ForgotPasswordRequestDto>())
        .validate(request);

    if (!validationResult.isValid) {
      throw ValidationError(
        validationResult.exceptions.map((e) => e.message).toList(),
      );
    }

    // Always return success for security (don't reveal if email exists)
    const response = SuccessResponseDto(
      message: 'If the email exists, a password reset link has been sent',
    );

    final user = await _userRepository.findByEmail(request.email);
    if (user == null || !user.isActive) {
      // Still publish audit event for monitoring
      await _eventPublisher.publishAuditEvent(
        eventType: EventType.update,
        targetEntityType: 'user',
        details: {'email': request.email, 'reason': 'email_not_found'},
        ipAddress: ipAddress,
      );
      return response;
    }

    // Generate reset token
    final resetToken = _uuid.v4();
    final expiresAt = DateTime.now().add(
      Duration(hours: _resetTokenExpirationHours),
    );

    final tokenData = PasswordResetTokensCompanion(
      token: Value(resetToken),
      userId: Value(user.userId),
      expiresAt: Value(PgDateTime(expiresAt)),
    );

    await _tokenRepository.create(tokenData);

    // Send reset email via event
    await _eventPublisher.publishPasswordResetRequested(
      email: user.email,
      resetToken: resetToken,
    );

    // Publish audit event
    unawaited(
      _eventPublisher.publishAuditEvent(
        eventType: EventType.update,
        userId: user.userId,
        targetEntityType: 'user',
        targetEntityId: user.userId,
        ipAddress: ipAddress,
      ),
    );

    return response;
  }

  /// Resets password using reset token
  ///
  /// [request] The password reset request
  /// [ipAddress] Optional IP address for audit
  /// Returns success response
  /// Throws [AuthenticationError] or [ValidationError] if operation fails
  Future<SuccessResponseDto> resetPassword(
    ResetPasswordRequestDto request, [
    String? ipAddress,
  ]) async {
    final validationResult = request
        .validate(ValidatorBuilder<ResetPasswordRequestDto>())
        .validate(request);

    if (!validationResult.isValid) {
      throw ValidationError(
        validationResult.exceptions.map((e) => e.message).toList(),
      );
    }

    // Validate new password
    final passwordErrors = _passwordEncoder.validatePasswordComplexity(
      request.newPassword,
    );
    if (passwordErrors.isNotEmpty) {
      throw ValidationError(passwordErrors);
    }

    // Find and validate token
    final tokenEntry = await _tokenRepository.findByToken(request.resetToken);
    if (tokenEntry == null || !_tokenRepository.isTokenValid(tokenEntry)) {
      await _eventPublisher.publishAuditEvent(
        eventType: EventType.update,
        targetEntityType: 'token',
        details: {
          'token_hash': request.resetToken.substring(0, 8),
          'reason': 'invalid_token',
        },
        ipAddress: ipAddress,
      );
      throw AuthenticationError('Invalid or expired reset token');
    }

    // Find user
    final user = await _userRepository.findByUserId(tokenEntry.userId);
    if (user == null || !user.isActive) {
      throw AuthenticationError('User not found');
    }

    // Update password
    final newHashedPassword = _passwordEncoder.hashPassword(
      request.newPassword,
    );
    await _userRepository.updatePassword(user.userId, newHashedPassword);

    // Mark token as used
    await _tokenRepository.markAsUsed(request.resetToken);

    // Delete all other tokens for this user
    await _tokenRepository.deleteUserTokens(user.userId);

    // Publish audit event
    unawaited(
      _eventPublisher.publishAuditEvent(
        eventType: EventType.update,
        userId: user.userId,
        targetEntityType: 'user',
        targetEntityId: user.userId,
        ipAddress: ipAddress,
      ),
    );

    return const SuccessResponseDto(message: 'Password reset successfully');
  }

  /// Handles failed login attempts
  Future<void> _handleFailedLogin(
    UserAuthDataEntry user,
    String? ipAddress,
  ) async {
    final newAttempts = user.failedLoginAttempts + 1;
    DateTime? lockUntil;

    if (newAttempts >= _maxFailedAttempts) {
      lockUntil = DateTime.now().add(Duration(minutes: _lockoutMinutes));
    }

    await _userRepository.updateFailedLoginAttempts(
      user.userId,
      newAttempts,
      lockUntil,
    );

    await _eventPublisher.publishAuditEvent(
      eventType: EventType.update,
      userId: user.userId,
      targetEntityType: 'user',
      targetEntityId: user.userId,
      details: {
        'failedAttempts': newAttempts,
        'accountLocked': lockUntil != null,
        'reason': lockUntil != null ? 'account_locked' : 'invalid_password',
      },
      ipAddress: ipAddress,
    );
  }

  /// Publishes failed login audit for unknown users
  void _publishFailedLoginAudit(
    String email,
    String reason,
    String? ipAddress,
  ) {
    unawaited(
      _eventPublisher.publishAuditEvent(
        eventType: EventType.update,
        targetEntityType: 'user',
        details: {'email': email, 'reason': reason},
        ipAddress: ipAddress,
      ),
    );
  }
}
