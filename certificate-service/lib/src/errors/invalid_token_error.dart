import 'package:certificate_service/src/errors/base_error.dart';

class InvalidTokenError extends BaseError {
  InvalidTokenError(String message) : super(401, message);
}
