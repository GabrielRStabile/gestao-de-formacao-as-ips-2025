import 'package:bcrypt/bcrypt.dart';
import 'package:vaden/vaden.dart' as vaden;

/// Service for password hashing and verification
///
/// Provides secure password hashing using BCrypt algorithm
@vaden.Component()
class PasswordEncoder {
  /// BCrypt work factor (cost)
  static const int _workFactor = 12;

  /// Hashes a plain text password
  ///
  /// [password] The plain text password to hash
  /// Returns the BCrypt hash of the password
  String hashPassword(String password) {
    return BCrypt.hashpw(password, BCrypt.gensalt(logRounds: _workFactor));
  }

  /// Verifies a password against its hash
  ///
  /// [password] The plain text password to verify
  /// [hashedPassword] The stored hash to verify against
  /// Returns true if password matches the hash
  bool verifyPassword(String password, String hashedPassword) {
    return BCrypt.checkpw(password, hashedPassword);
  }

  /// Validates password complexity
  ///
  /// [password] The password to validate
  /// Returns a list of validation errors (empty if valid)
  List<String> validatePasswordComplexity(String password) {
    final errors = <String>[];

    if (password.length < 8) {
      errors.add('Password must be at least 8 characters long');
    }

    if (password.length > 128) {
      errors.add('Password must be no more than 128 characters long');
    }

    if (!password.contains(RegExp(r'[A-Z]'))) {
      errors.add('Password must contain at least one uppercase letter');
    }

    if (!password.contains(RegExp(r'[a-z]'))) {
      errors.add('Password must contain at least one lowercase letter');
    }

    if (!password.contains(RegExp(r'[0-9]'))) {
      errors.add('Password must contain at least one number');
    }

    if (!password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      errors.add('Password must contain at least one special character');
    }

    return errors;
  }

  /// Checks if password meets complexity requirements
  ///
  /// [password] The password to check
  /// Returns true if password is valid
  bool isPasswordValid(String password) {
    return validatePasswordComplexity(password).isEmpty;
  }
}
