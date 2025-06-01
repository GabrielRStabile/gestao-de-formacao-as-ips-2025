import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';

/// Password reset tokens table
///
/// Stores temporary tokens for password reset functionality
@DataClassName('PasswordResetTokenEntry')
class PasswordResetTokens extends Table {
  /// Unique token identifier
  TextColumn get token => text()();

  /// Associated user ID
  TextColumn get userId => text().named('user_id')();

  /// Token expiration timestamp
  TimestampColumn get expiresAt =>
      customType(PgTypes.timestampWithTimezone).named('expires_at')();

  /// Whether token has been used
  BoolColumn get isUsed =>
      boolean().named('is_used').withDefault(const Constant(false))();

  /// Token creation timestamp
  TimestampColumn get createdAt =>
      customType(
        PgTypes.timestampWithTimezone,
      ).named('created_at').withDefault(now())();

  @override
  Set<Column> get primaryKey => {token};
}
