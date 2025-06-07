import 'package:vaden/vaden.dart';

/// Data Transfer Object for API error responses
///
/// Provides a consistent structure for error information across all endpoints.
@DTO()
class ErrorDto {
  /// Human-readable error message
  final String message;

  /// HTTP status code as string
  final String status;

  /// Timestamp when the error occurred
  final DateTime timestamp;

  /// Error type or category
  final String error;

  /// Creates a new ErrorDto instance
  ///
  /// [message] The error message
  /// [status] The HTTP status code
  /// [error] The error type/category
  ///
  /// The timestamp is automatically set to the current time
  ErrorDto({required this.message, required this.status, required this.error})
    : timestamp = DateTime.now();
}
