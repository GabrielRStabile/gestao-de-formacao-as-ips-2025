import 'dart:io';

import 'package:vaden/vaden.dart';

import '../dtos/error_dto.dart';
import '../dtos/login_dto.dart';
import '../dtos/password_dto.dart';
import '../dtos/register_dto.dart';
import '../dtos/token_dto.dart';
import '../services/auth_service.dart';

/// REST controller for authentication endpoints
///
/// Handles user authentication, registration, and password management
@Api(
  tag: 'Authentication',
  description:
      'Handles user authentication, registration, and password management',
)
@Controller('/auth')
class AuthController {
  final AuthService _authService;

  AuthController(this._authService);

  /// Registers a new user
  ///
  /// POST /auth/register
  @ApiOperation(
    summary: 'Register new user',
    description: 'Creates a new user account with email and password',
  )
  @ApiResponse(
    201,
    description: 'User registered successfully',
    content: ApiContent(type: 'application/json', schema: RegisterResponseDto),
  )
  @ApiResponse(
    400,
    description: 'Invalid input data',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @Post('/register')
  Future<RegisterResponseDto> register(
    @Body() RegisterRequestDto registerRequest,
    @Header('X-Forwarded-For') String? forwardedFor,
    @Header('X-Real-IP') String? realIp,
    Request request,
  ) async {
    final ipAddress = _extractIpAddress(forwardedFor, realIp, request);
    return await _authService.register(registerRequest, ipAddress);
  }

  /// Authenticates a user and returns JWT token
  ///
  /// POST /auth/login
  @ApiOperation(
    summary: 'User login',
    description: 'Authenticates user and returns JWT access token',
  )
  @ApiResponse(
    200,
    description: 'Login successful',
    content: ApiContent(type: 'application/json', schema: LoginResponseDto),
  )
  @ApiResponse(
    401,
    description: 'Invalid credentials',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    400,
    description: 'Invalid input data',
    content: ApiContent(
      type: 'application/json',
      schema: ResponseException<List<Map<String, dynamic>>>,
    ),
  )
  @Post('/login')
  Future<LoginResponseDto> login(
    @Body() LoginRequestDto loginRequest,
    @Header('X-Forwarded-For') String? forwardedFor,
    @Header('X-Real-IP') String? realIp,
    Request request,
  ) async {
    final ipAddress = _extractIpAddress(forwardedFor, realIp, request);
    return await _authService.login(loginRequest, ipAddress);
  }

  /// Validates a JWT token (for other services)
  ///
  /// POST /auth/introspect-token
  /// Requires an API key that is handled by API Gateway
  @ApiOperation(
    summary: 'Token introspection',
    description: 'Validates JWT token and returns claims',
  )
  @ApiResponse(
    200,
    description: 'Token validation result',
    content: ApiContent(
      type: 'application/json',
      schema: IntrospectTokenResponseDto,
    ),
  )
  @ApiResponse(
    401,
    description: 'Invalid API key',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @Post('/introspect-token')
  Future<IntrospectTokenResponseDto> introspectToken(
    @Body() IntrospectTokenRequestDto introspectRequest,
  ) async => await _authService.introspectToken(introspectRequest);

  /// Changes user password
  ///
  /// PUT /auth/change-password
  /// Requires JWT authentication
  @ApiOperation(
    summary: 'Change password',
    description: 'Changes user password with current password verification',
  )
  @ApiResponse(
    200,
    description: 'Password changed successfully',
    content: ApiContent(type: 'application/json', schema: SuccessResponseDto),
  )
  @ApiResponse(
    401,
    description: 'Invalid authorization or current password',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @Put('/change-password')
  Future<SuccessResponseDto> changePassword(
    @Body() ChangePasswordRequestDto changeRequest,
    @Query() String userId,
    @Header('X-Forwarded-For') String? forwardedFor,
    @Header('X-Real-IP') String? realIp,
    Request request,
  ) async {
    final ipAddress = _extractIpAddress(forwardedFor, realIp, request);
    return await _authService.changePassword(userId, changeRequest, ipAddress);
  }

  /// Initiates password reset process
  ///
  /// POST /auth/forgot-password
  @ApiOperation(
    summary: 'Forgot password',
    description: 'Initiates password reset process by sending reset email',
  )
  @ApiResponse(
    200,
    description: 'Reset email sent if account exists',
    content: ApiContent(type: 'application/json', schema: SuccessResponseDto),
  )
  @Post('/forgot-password')
  Future<SuccessResponseDto> forgotPassword(
    @Body() ForgotPasswordRequestDto forgotRequest,
    @Header('X-Forwarded-For') String? forwardedFor,
    @Header('X-Real-IP') String? realIp,
    Request request,
  ) async {
    final ipAddress = _extractIpAddress(forwardedFor, realIp, request);
    return await _authService.forgotPassword(forgotRequest, ipAddress);
  }

  /// Resets password using reset token
  ///
  /// POST /auth/reset-password
  @ApiOperation(
    summary: 'Reset password',
    description: 'Resets password using valid reset token',
  )
  @ApiResponse(
    200,
    description: 'Password reset successfully',
    content: ApiContent(type: 'application/json', schema: SuccessResponseDto),
  )
  @ApiResponse(
    400,
    description: 'Invalid or expired reset token',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @Post('/reset-password')
  Future<SuccessResponseDto> resetPassword(
    @Body() ResetPasswordRequestDto resetRequest,
    @Header('X-Forwarded-For') String? forwardedFor,
    @Header('X-Real-IP') String? realIp,
    Request request,
  ) async {
    final ipAddress = _extractIpAddress(forwardedFor, realIp, request);
    return await _authService.resetPassword(resetRequest, ipAddress);
  }

  /// Extracts IP address from request headers and connection info
  String? _extractIpAddress(
    String? forwardedFor,
    String? realIp,
    Request request,
  ) {
    // Try X-Forwarded-For header first (for proxy/load balancer setups)
    if (forwardedFor != null && forwardedFor.isNotEmpty) {
      // Take the first IP if there are multiple
      return forwardedFor.split(',').first.trim();
    }

    // Try X-Real-IP header
    if (realIp != null && realIp.isNotEmpty) {
      return realIp;
    }

    // Fall back to remote address
    return request.remoteIp;
  }
}

extension on Request {
  /// Gets the remote IP address from the request
  String get remoteIp {
    final connectionInfo =
        context['shelf.io.connection_info'] as HttpConnectionInfo?;
    return connectionInfo?.remoteAddress.address ?? 'unknown';
  }
}
