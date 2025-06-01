import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';

/// User authentication data table
///
/// Stores user credentials and authentication-related information
/// as defined in the technical documentation ERD.
@DataClassName('UserAuthDataEntry')
class UserAuthData extends Table {
  /// Primary key - unique user identifier
  TextColumn get userId => text().named('user_id')();

  /// User email address - must be unique
  TextColumn get email => text().unique()();

  /// User role in the system
  TextColumn get role =>
      text().check(role.isIn(['formando', 'formador', 'gestor']))();

  /// Hashed password (BCrypt hash)
  TextColumn get hashedPassword => text().named('hashed_password')();

  /// Account active status
  BoolColumn get isActive =>
      boolean().named('is_active').withDefault(const Constant(true))();

  /// Timestamp of last password change
  TimestampColumn get passwordLastChangedAt =>
      customType(PgTypes.timestampWithTimezone).nullable()();

  /// Number of consecutive failed login attempts
  IntColumn get failedLoginAttempts =>
      integer().named('failed_login_attempts').withDefault(const Constant(0))();

  /// Timestamp until which account is locked (nullable)
  TimestampColumn get accountLockedUntil =>
      customType(PgTypes.timestampWithTimezone).nullable()();

  /// Timestamp of last login attempt (nullable)
  TimestampColumn get lastLoginAttemptAt =>
      customType(PgTypes.timestampWithTimezone).nullable()();

  /// Timestamp when email was verified (nullable)
  TimestampColumn get emailVerifiedAt =>
      customType(PgTypes.timestampWithTimezone).nullable()();

  /// Record creation timestamp
  TimestampColumn get createdAt =>
      customType(PgTypes.timestampWithTimezone).withDefault(now())();

  /// Record last update timestamp
  TimestampColumn get updatedAt =>
      customType(PgTypes.timestampWithTimezone).withDefault(now())();

  @override
  Set<Column> get primaryKey => {userId};
}
