import 'base_error.dart';

/// Error thrown when template data is invalid or incomplete
class InvalidTemplateDataError extends BaseError {
  InvalidTemplateDataError(String message) : super(400, message);
}

/// Error thrown when user lacks permission to access templates
class TemplateAccessForbiddenError extends BaseError {
  TemplateAccessForbiddenError(String message) : super(403, message);
}

/// Error thrown when a template is not found
class TemplateNotFoundError extends BaseError {
  TemplateNotFoundError(String message) : super(404, message);
}

/// Error thrown when there's an internal error with template operations
class TemplateServiceError extends BaseError {
  TemplateServiceError(String message) : super(500, message);
}
