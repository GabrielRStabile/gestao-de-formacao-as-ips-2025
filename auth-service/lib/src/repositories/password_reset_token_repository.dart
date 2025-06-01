import 'package:auth_service/src/errors/authentication_error.dart';
import 'package:auth_service/src/models/database.dart';
import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:vaden/vaden.dart' as vaden;

/// Repository for password reset token operations
///
/// Provides CRUD operations for password reset tokens
@vaden.Component()
class PasswordResetTokenRepository {
  /// Database access component
  final AuthDatabaseAccess _databaseAccess;

  /// Creates a new PasswordResetTokenRepository
  PasswordResetTokenRepository(this._databaseAccess);

  /// Gets the database instance
  AuthDatabase get _database => _databaseAccess.database;

  /// Creates a new password reset token
  ///
  /// [tokenData] The token data to insert
  /// Returns the created token entry
  Future<PasswordResetTokenEntry> create(
    PasswordResetTokensCompanion tokenData,
  ) async {
    await _database.into(_database.passwordResetTokens).insert(tokenData);

    final token = await findByToken(tokenData.token.value);

    if (token == null) {
      throw AuthenticationError(
        'Failed to create token: token not found after insertion',
      );
    }

    return token;
  }

  /// Finds a token by its value
  ///
  /// [token] The token to search for
  /// Returns the token if found, null otherwise
  Future<PasswordResetTokenEntry?> findByToken(String token) async {
    final query = _database.select(_database.passwordResetTokens)
      ..where((t) => t.token.equals(token));

    final results = await query.get();
    return results.isEmpty ? null : results.first;
  }

  /// Finds all tokens for a user
  ///
  /// [userId] The user ID to search for
  /// Returns list of tokens for the user
  Future<List<PasswordResetTokenEntry>> findByUserId(String userId) async {
    final query =
        _database.select(_database.passwordResetTokens)
          ..where((t) => t.userId.equals(userId))
          ..orderBy([(t) => OrderingTerm.desc(t.createdAt)]);

    return await query.get();
  }

  /// Marks a token as used
  ///
  /// [token] The token to mark as used
  /// Returns the number of affected rows
  Future<int> markAsUsed(String token) async {
    final query = _database.update(_database.passwordResetTokens)
      ..where((t) => t.token.equals(token));

    return await query.write(
      PasswordResetTokensCompanion(isUsed: const Value(true)),
    );
  }

  /// Checks if a token is valid (not expired and not used)
  ///
  /// [tokenEntry] The token entry to check
  /// Returns true if token is valid
  bool isTokenValid(PasswordResetTokenEntry tokenEntry) {
    if (tokenEntry.isUsed) return false;
    return DateTime.now().isBefore(tokenEntry.expiresAt.dateTime);
  }

  /// Deletes expired tokens
  ///
  /// Returns the number of deleted tokens
  Future<int> deleteExpiredTokens() async {
    final query = _database.delete(
      _database.passwordResetTokens,
    )..where((t) => t.expiresAt.isSmallerThanValue(PgDateTime(DateTime.now())));

    return await query.go();
  }

  /// Deletes all tokens for a user (useful after password change)
  ///
  /// [userId] The user ID
  /// Returns the number of deleted tokens
  Future<int> deleteUserTokens(String userId) async {
    final query = _database.delete(_database.passwordResetTokens)
      ..where((t) => t.userId.equals(userId));

    return await query.go();
  }
}
