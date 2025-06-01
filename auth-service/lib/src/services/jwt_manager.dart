import 'package:auth_service/config/app_configuration.dart';
import 'package:auth_service/src/errors/authentication_error.dart';
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';
import 'package:vaden/vaden.dart' as vaden;

/// Service for JWT token generation and validation
///
/// Handles JWT creation, signing, and verification using configured secret
@vaden.Component()
class JwtManager {
  /// JWT secret key from environment
  static String get _secretKey => env['JWT_SECRET']!;

  /// JWT expiration time in minutes
  static int get _expirationMinutes =>
      int.tryParse(env['JWT_EXPIRATION_IN_MINUTES'] ?? '60') ?? 60;

  /// JWT issuer identifier
  static String get _issuer => env['JWT_ISSUER'] ?? 'auth-service';

  /// Generates a JWT token for a user
  ///
  /// [userId] The user's unique identifier
  /// [email] The user's email address
  /// [role] The user's role in the system
  /// Returns a signed JWT token string
  String generateToken({
    required String userId,
    required String email,
    required String role,
  }) {
    final now = DateTime.now();
    final expiry = now.add(Duration(minutes: _expirationMinutes));

    final jwt = JWT({
      'sub': userId,
      'email': email,
      'role': role,
      'iss': _issuer,
      'iat': (now.millisecondsSinceEpoch / 1000).round(),
      'exp': (expiry.millisecondsSinceEpoch / 1000).round(),
    });

    return jwt.sign(SecretKey(_secretKey));
  }

  /// Gets the token expiration time in seconds
  ///
  /// Returns the configured JWT expiration time in seconds
  int getExpirationTimeInSeconds() {
    return _expirationMinutes * 60;
  }

  /// Validates and decodes a JWT token
  ///
  /// [token] The JWT token to validate
  /// Returns the decoded payload if valid.
  /// Throws [AuthenticationError] if the token is invalid.
  Map<String, dynamic>? validateToken(String token) {
    try {
      final jwt = JWT.verify(token, SecretKey(_secretKey), issuer: _issuer);

      return jwt.payload;
    } catch (e) {
      throw AuthenticationError('Invalid JWT token: ${e.toString()}');
    }
  }
}
