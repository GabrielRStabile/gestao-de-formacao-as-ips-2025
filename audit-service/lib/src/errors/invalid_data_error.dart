import 'package:audit_service/src/errors/base_error.dart';

/// Error thrown when invalid data is provided to the audit service
///
/// This error is typically thrown during validation of audit event data
/// when required fields are missing or data format is incorrect.
class InvalidDataError extends BaseError {
  /// Creates a new InvalidDataError with validation messages
  ///
  /// [validationErrors] List of validation error messages
  InvalidDataError(List<String> validationErrors)
    : super(400, 'Invalid data provided: ${validationErrors.join(', ')}');
}
