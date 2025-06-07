import 'base_error.dart';

/// Exception thrown when authentication fails
///
/// Used for login failures, invalid credentials, account lockouts, etc.
class AuthenticationError extends BaseError {
  /// Creates a new authentication error
  ///
  /// [message] The error message
  /// [statusCode] HTTP status code (defaults to 401)
  AuthenticationError(String message, [int statusCode = 401])
    : super(statusCode, message);
}
