import 'package:vaden/vaden.dart';

/// Data Transfer Object for password change request
///
/// Contains the data required to change a user's password
@DTO()
class ChangePasswordRequestDto with Validator<ChangePasswordRequestDto> {
  /// Current password for verification
  final String currentPassword;

  /// New password to set
  final String newPassword;

  /// Creates a new ChangePasswordRequestDto
  const ChangePasswordRequestDto({
    required this.currentPassword,
    required this.newPassword,
  });

  @override
  LucidValidator<ChangePasswordRequestDto> validate(
    ValidatorBuilder<ChangePasswordRequestDto> builder,
  ) {
    return builder
      ..ruleFor(
        (r) => r.currentPassword,
        key: 'currentPassword',
      ).notEmptyOrNull().minLength(6).maxLength(100)
      ..ruleFor(
        (r) => r.newPassword,
        key: 'newPassword',
      ).notEmptyOrNull().minLength(6).maxLength(100);
  }
}

/// Data Transfer Object for forgot password request
///
/// Contains the email address for password reset
@DTO()
class ForgotPasswordRequestDto with Validator<ForgotPasswordRequestDto> {
  /// User email address
  final String email;

  /// Creates a new ForgotPasswordRequestDto
  const ForgotPasswordRequestDto({required this.email});

  @override
  LucidValidator<ForgotPasswordRequestDto> validate(
    ValidatorBuilder<ForgotPasswordRequestDto> builder,
  ) {
    return builder
      ..ruleFor((r) => r.email, key: 'email').notEmptyOrNull().validEmail();
  }
}

/// Data Transfer Object for password reset request
///
/// Contains the reset token and new password
@DTO()
class ResetPasswordRequestDto with Validator<ResetPasswordRequestDto> {
  /// Password reset token
  final String resetToken;

  /// New password to set
  final String newPassword;

  /// Creates a new ResetPasswordRequestDto
  const ResetPasswordRequestDto({
    required this.resetToken,
    required this.newPassword,
  });

  @override
  LucidValidator<ResetPasswordRequestDto> validate(
    ValidatorBuilder<ResetPasswordRequestDto> builder,
  ) {
    return builder
      ..ruleFor((r) => r.resetToken, key: 'resetToken').notEmptyOrNull()
      ..ruleFor(
        (r) => r.newPassword,
        key: 'newPassword',
      ).notEmptyOrNull().minLength(6).maxLength(100);
  }
}

/// Data Transfer Object for generic success response
///
/// Used for successful operations that don't return specific data
@DTO()
class SuccessResponseDto {
  /// Success message
  final String message;

  /// Creates a new SuccessResponseDto
  const SuccessResponseDto({required this.message});
}
