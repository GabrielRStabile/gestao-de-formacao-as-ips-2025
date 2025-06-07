import 'base_error.dart';

/// Exception thrown when validation fails
///
/// Used for input validation errors like invalid email, weak password, etc.
class ValidationError extends BaseError {
  /// List of validation error messages
  final List<String> errors;

  /// Creates a new validation error
  ///
  /// [errors] List of validation error messages
  /// [statusCode] HTTP status code (defaults to 400)
  ValidationError(this.errors, [int statusCode = 400])
    : super(statusCode, errors.join('; '));
}
