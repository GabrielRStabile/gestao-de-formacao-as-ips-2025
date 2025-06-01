import 'package:vaden/vaden.dart';

/// Data Transfer Object for user registration request
///
/// Contains the data required to register a new user
@DTO()
class RegisterRequestDto with Validator<RegisterRequestDto> {
  /// User email address
  final String email;

  /// User password (plain text, will be hashed)
  final String password;

  /// Creates a new RegisterRequestDto
  const RegisterRequestDto({required this.email, required this.password});

  @override
  LucidValidator<RegisterRequestDto> validate(
    ValidatorBuilder<RegisterRequestDto> builder,
  ) {
    return builder
      ..ruleFor((r) => r.email, key: 'email').notEmptyOrNull().validEmail()
      ..ruleFor(
        (r) => r.password,
        key: 'password',
      ).notEmptyOrNull().minLength(6).maxLength(100);
  }
}

/// Data Transfer Object for user registration response
///
/// Contains the response data after successful registration
@DTO()
class RegisterResponseDto {
  /// Generated user ID
  final String userId;

  /// User email address
  final String email;

  /// User role assigned
  final String role;

  /// Creates a new RegisterResponseDto
  const RegisterResponseDto({
    required this.userId,
    required this.email,
    required this.role,
  });
}
