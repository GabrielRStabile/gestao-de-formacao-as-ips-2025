import 'package:auth_service/config/app_configuration.dart';
import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:postgres/postgres.dart';
import 'package:vaden/vaden.dart' as vaden;

import 'password_reset_token.dart';
import 'user_auth_data.dart';

part 'database.g.dart';

/// Main database class for auth service
///
/// Manages PostgreSQL connection and provides access to all tables.
/// Includes migration strategy and connection configuration.
@DriftDatabase(tables: [UserAuthData, PasswordResetTokens])
class AuthDatabase extends _$AuthDatabase {
  /// Creates a new instance of AuthDatabase
  ///
  /// [executor] Optional custom query executor, defaults to PostgreSQL connection
  AuthDatabase([QueryExecutor? executor])
    : super(executor ?? _openConnection());

  /// Database schema version for migrations
  @override
  int get schemaVersion => 1;

  /// Migration strategy for database schema changes
  ///
  /// Handles initial table creation and future schema migrations
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (m) => m.createAll(),
      beforeOpen: (details) async {
        if (details.wasCreated) {
          return;
        }
      },
    );
  }

  /// Creates a PostgreSQL connection using environment variables
  ///
  /// Requires the following environment variables:
  /// - DB_HOST: PostgreSQL host
  /// - DB_NAME: Database name
  /// - DB_USER: Database username
  /// - DB_PASSWORD: Database password
  /// - DB_PORT: Database port (optional, defaults to 5432)
  ///
  /// Returns a configured PgDatabase instance
  static QueryExecutor _openConnection() {
    assert(
      env['DB_HOST'] != null &&
          env['DB_NAME'] != null &&
          env['DB_USER'] != null &&
          env['DB_PASSWORD'] != null,
      'Database environment variables are not set',
    );

    return PgDatabase(
      endpoint: Endpoint(
        host: env['DB_HOST']!,
        database: env['DB_NAME']!,
        username: env['DB_USER']!,
        password: env['DB_PASSWORD']!,
        port: int.tryParse(env['DB_PORT'] ?? '5432') ?? 5432,
      ),
      settings: ConnectionSettings(sslMode: SslMode.disable),
    );
  }
}

/// Component wrapper for AuthDatabase
///
/// Provides dependency injection support for the auth database.
/// Manages the database lifecycle and provides access to repositories.
@vaden.Component()
class AuthDatabaseAccess {
  /// The auth database instance
  final AuthDatabase _database = AuthDatabase();

  /// Gets the auth database instance
  ///
  /// Returns the configured AuthDatabase for use in repositories
  AuthDatabase get database => _database;
}
