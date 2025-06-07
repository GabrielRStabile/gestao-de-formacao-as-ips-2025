import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';

/// Database table definition for external certification logs
///
/// Defines the schema for storing external certification integration logs in PostgreSQL.
/// Uses Drift ORM annotations for type safety and validation.
class ExternalCertificationLogs extends Table {
  /// Primary key - unique log identifier
  TextColumn get logId => text().withLength(min: 1, max: 100)();

  /// Foreign key to IssuedCertificate
  TextColumn get certificateId => text().withLength(min: 1, max: 100)();

  /// Name of the external system
  TextColumn get externalSystemName => text().withLength(min: 1, max: 255)();

  /// Type of action performed
  TextColumn get actionType => text().withLength(min: 1, max: 100)();

  /// Timestamp when the action was performed
  TimestampColumn get actionTimestamp =>
      customType(PgTypes.timestampWithTimezone).withDefault(now())();

  /// Status of the action
  TextColumn get status => text().withLength(min: 1, max: 100)();

  /// External reference ID from the external system (nullable)
  TextColumn get externalReferenceId =>
      text().withLength(min: 1, max: 255).nullable()();

  /// Response details from the external system (nullable)
  TextColumn get responseDetails => text().nullable()();

  @override
  Set<Column> get primaryKey => {logId};
}
