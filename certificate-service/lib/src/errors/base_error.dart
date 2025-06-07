/// Base class for all application errors
///
/// Provides a common structure for error handling throughout the audit service.
/// All custom errors should extend this class to maintain consistency.
abstract class BaseError {
  /// Human-readable error message
  final String message;

  /// Numeric error code for programmatic handling
  final int code;

  /// Creates a new BaseError instance
  ///
  /// [code] The error code
  /// [message] The error message
  BaseError(this.code, this.message);
}
