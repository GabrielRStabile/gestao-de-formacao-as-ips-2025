import 'dart:convert';

import 'package:audit_service/src/errors/base_error.dart';
import 'package:vaden/vaden.dart';

/// Global exception handler for the application
///
/// Provides centralized error handling and response formatting
/// for different types of exceptions that can occur in the API.
@ControllerAdvice()
class AppControllerAdvice {
  /// Data serialization object
  final DSON _dson;

  /// Creates a new AppControllerAdvice
  ///
  /// [_dson] The data serialization object
  AppControllerAdvice(this._dson);

  /// Handles ResponseException instances
  ///
  /// Processes framework-specific response exceptions
  /// using the built-in response generation.
  ///
  /// [e] The ResponseException to handle
  /// Returns [Response] with appropriate status and body
  @ExceptionHandler(ResponseException)
  Future<Response> handleResponseException(ResponseException e) async {
    return e.generateResponse(_dson);
  }

  /// Handles BaseError instances
  ///
  /// Processes custom application errors with structured
  /// JSON response including error details and timestamp.
  ///
  /// [e] The BaseError to handle
  /// Returns [Response] with error details
  @ExceptionHandler(BaseError)
  Response handleBaseError(BaseError e) {
    return Response(
      e.code,
      body: jsonEncode({
        'message': e.message,
        'status': e.code,
        'error': e.runtimeType.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      }),
    );
  }

  /// Handles general Exception instances
  ///
  /// Provides fallback error handling for unhandled exceptions
  /// with a generic internal server error response.
  ///
  /// [e] The Exception to handle
  /// Returns [Response] with internal server error status
  @ExceptionHandler(Exception)
  Response handleGeneralExceptions(Exception e) {
    return Response.internalServerError(
      body: jsonEncode({
        'message': 'Internal server error',
        'error': e.toString(),
        'timestamp': DateTime.now().toIso8601String(),
        'status': 500,
      }),
    );
  }
}
