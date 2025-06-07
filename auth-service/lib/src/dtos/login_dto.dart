import 'package:vaden/vaden.dart';

/// Data Transfer Object for user login request
///
/// Contains the credentials required for user authentication
@DTO()
class LoginRequestDto with Validator<LoginRequestDto> {
  /// User email address
  final String email;

  /// User password (plain text)
  final String password;

  /// Creates a new LoginRequestDto
  const LoginRequestDto({required this.email, required this.password});

  @override
  LucidValidator<LoginRequestDto> validate(
    ValidatorBuilder<LoginRequestDto> builder,
  ) {
    return builder
      ..ruleFor((r) => r.email, key: 'email').notEmptyOrNull().validEmail()
      ..ruleFor(
        (r) => r.password,
        key: 'password',
      ).notEmptyOrNull().minLength(6).maxLength(100);
  }
}

/// Data Transfer Object for user login response
///
/// Contains the JWT token and user information after successful login
@DTO()
class LoginResponseDto {
  /// JWT access token
  final String accessToken;

  /// Token type (always 'Bearer')
  final String tokenType;

  /// Token expiration time in seconds
  final int expiresIn;

  /// User ID
  final String userId;

  /// User email
  final String email;

  /// User role
  final String role;

  /// Creates a new LoginResponseDto
  const LoginResponseDto({
    required this.accessToken,
    required this.tokenType,
    required this.expiresIn,
    required this.userId,
    required this.email,
    required this.role,
  });

  /// Converts this DTO to JSON
  Map<String, dynamic> toJson() {
    return {
      'access_token': accessToken,
      'token_type': tokenType,
      'expires_in': expiresIn,
      'user_id': userId,
      'email': email,
      'role': role,
    };
  }
}
