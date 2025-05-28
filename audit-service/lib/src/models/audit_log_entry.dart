import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';

/// Database table definition for audit log entries
///
/// Defines the schema for storing audit events in PostgreSQL.
/// Uses Drift ORM annotations for type safety and validation.
class AuditLogEntries extends Table {
  /// Primary key - auto-incrementing unique identifier
  Int64Column get logId => int64().autoIncrement()();

  /// Timestamp when the audited event occurred
  TimestampColumn get eventTimestamp =>
      customType(PgTypes.timestampWithTimezone)();

  /// Name of the service that generated the audit event
  TextColumn get sourceService => text().withLength(min: 1, max: 100)();

  /// Type of event that was audited (CREATE, UPDATE, DELETE, etc.)
  TextColumn get eventType => text().withLength(min: 1, max: 100)();

  /// ID of the user who performed the action (optional)
  TextColumn get userId => text().nullable()();

  /// ID of the entity that was affected by the action (optional)
  TextColumn get targetEntityId => text().nullable()();

  /// Type of the entity that was affected (optional)
  TextColumn get targetEntityType => text().nullable()();

  /// IP address from which the action was performed (optional)
  TextColumn get ipAddress => text().nullable()();

  /// Additional event details stored as JSONB (optional)
  JsonColumn get details => customType(PgTypes.jsonb).nullable()();

  /// Timestamp when the audit log entry was created in the database
  TimestampColumn get createdAt =>
      customType(PgTypes.timestampWithTimezone).withDefault(now())();
}
