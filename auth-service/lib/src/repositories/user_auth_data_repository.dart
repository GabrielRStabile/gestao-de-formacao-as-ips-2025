import 'package:auth_service/src/errors/authentication_error.dart';
import 'package:auth_service/src/models/database.dart';
import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:vaden/vaden.dart' as vaden;

/// Repository for user authentication data operations
///
/// Provides CRUD operations for user authentication data
@vaden.Component()
class UserAuthDataRepository {
  /// Database access component
  final AuthDatabaseAccess _databaseAccess;

  /// Creates a new UserAuthDataRepository
  UserAuthDataRepository(this._databaseAccess);

  /// Gets the database instance
  AuthDatabase get _database => _databaseAccess.database;

  /// Finds a user by email address
  ///
  /// [email] The email address to search for
  /// Returns the user if found, null otherwise
  Future<UserAuthDataEntry?> findByEmail(String email) async {
    final query = _database.select(_database.userAuthData)
      ..where((user) => user.email.equals(email));

    final results = await query.get();
    return results.isEmpty ? null : results.first;
  }

  /// Finds a user by user ID
  ///
  /// [userId] The user ID to search for
  /// Returns the user if found, null otherwise
  Future<UserAuthDataEntry?> findByUserId(String userId) async {
    final query = _database.select(_database.userAuthData)
      ..where((user) => user.userId.equals(userId));

    final results = await query.get();
    return results.isEmpty ? null : results.first;
  }

  /// Creates a new user
  ///
  /// [userData] The user data to insert
  /// Returns the created user entry
  Future<UserAuthDataEntry> create(UserAuthDataCompanion userData) async {
    await _database.into(_database.userAuthData).insert(userData);

    final user = await findByUserId(userData.userId.value);

    if (user == null) {
      throw AuthenticationError(
        'Failed to create user: user not found after insertion',
      );
    }
    return user;
  }

  /// Updates user data
  ///
  /// [userId] The user ID to update
  /// [userData] The user data updates
  /// Returns the number of affected rows
  Future<int> update(String userId, UserAuthDataCompanion userData) async {
    final query = _database.update(_database.userAuthData)
      ..where((user) => user.userId.equals(userId));

    return await query.write(userData);
  }

  /// Updates password-related fields
  ///
  /// [userId] The user ID
  /// [hashedPassword] The new hashed password
  /// Returns the number of affected rows
  Future<int> updatePassword(String userId, String hashedPassword) async {
    final updates = UserAuthDataCompanion(
      hashedPassword: Value(hashedPassword),
      passwordLastChangedAt: Value(PgDateTime(DateTime.now())),
      failedLoginAttempts: const Value(0), // Reset failed attempts
      accountLockedUntil: const Value(null), // Unlock account
      updatedAt: Value(PgDateTime(DateTime.now())),
    );

    return await update(userId, updates);
  }

  /// Updates failed login attempt count
  ///
  /// [userId] The user ID
  /// [attempts] The new failed attempt count
  /// [lockUntil] Optional lock timestamp
  /// Returns the number of affected rows
  Future<int> updateFailedLoginAttempts(
    String userId,
    int attempts, [
    DateTime? lockUntil,
  ]) async {
    final updates = UserAuthDataCompanion(
      failedLoginAttempts: Value(attempts),
      lastLoginAttemptAt: Value(PgDateTime(DateTime.now())),
      accountLockedUntil:
          lockUntil != null ? Value(PgDateTime(lockUntil)) : const Value(null),
      updatedAt: Value(PgDateTime(DateTime.now())),
    );

    return await update(userId, updates);
  }

  /// Resets failed login attempts (successful login)
  ///
  /// [userId] The user ID
  /// Returns the number of affected rows
  Future<int> resetFailedLoginAttempts(String userId) async {
    final updates = UserAuthDataCompanion(
      failedLoginAttempts: const Value(0),
      lastLoginAttemptAt: Value(PgDateTime(DateTime.now())),
      accountLockedUntil: const Value(null),
      updatedAt: Value(PgDateTime(DateTime.now())),
    );

    return await update(userId, updates);
  }

  /// Marks email as verified
  ///
  /// [userId] The user ID
  /// Returns the number of affected rows
  Future<int> markEmailVerified(String userId) async {
    final updates = UserAuthDataCompanion(
      emailVerifiedAt: Value(PgDateTime(DateTime.now())),
      updatedAt: Value(PgDateTime(DateTime.now())),
    );

    return await update(userId, updates);
  }

  /// Checks if account is locked
  ///
  /// [user] The user entry to check
  /// Returns true if account is currently locked
  bool isAccountLocked(UserAuthDataEntry user) {
    if (user.accountLockedUntil == null) return false;
    return DateTime.now().isBefore(user.accountLockedUntil!.dateTime);
  }

  /// Checks if email exists in the system
  ///
  /// [email] The email to check
  /// Returns true if email exists
  Future<bool> emailExists(String email) async {
    final user = await findByEmail(email);
    return user != null;
  }
}
