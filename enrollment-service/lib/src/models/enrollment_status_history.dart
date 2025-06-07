import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';

/// Database table definition for enrollment status history
///
/// Defines the schema for storing enrollment status change history in PostgreSQL.
/// Tracks all status changes for audit and monitoring purposes.
class EnrollmentStatusHistories extends Table {
  /// Primary key - unique history record identifier
  TextColumn get historyId => text().withLength(min: 1, max: 100)();

  /// Foreign key to EnrollmentRequest.enrollmentId
  TextColumn get enrollmentId => text().withLength(min: 1, max: 100)();

  /// Previous status before the change
  TextColumn get oldStatus =>
      text().check(
        oldStatus.isIn([
          'PENDING_APPROVAL',
          'APPROVED',
          'REJECTED',
          'CANCELLED_BY_TRAINEE',
          'CANCELLED_BY_SYSTEM',
          'COMPLETED',
        ]),
      )();

  /// New status after the change
  TextColumn get newStatus =>
      text().check(
        newStatus.isIn([
          'PENDING_APPROVAL',
          'APPROVED',
          'REJECTED',
          'CANCELLED_BY_TRAINEE',
          'CANCELLED_BY_SYSTEM',
          'COMPLETED',
        ]),
      )();

  /// Timestamp when the status change occurred
  TimestampColumn get changedAt =>
      customType(PgTypes.timestampWithTimezone).withDefault(now())();

  /// ID of the user who made the change (nullable)
  /// Can be the trainee, manager, or system
  /// Foreign key to User(id) in Identity/Auth Service
  TextColumn get changedByUserId =>
      text().withLength(min: 1, max: 100).nullable()();

  /// Reason for the status change (nullable)
  /// Examples: 'Aprovado pelo gestor', 'Cancelado pelo formando', 'Pré-requisitos não atendidos'
  TextColumn get reason => text().nullable()();

  @override
  Set<Column> get primaryKey => {historyId};
}
