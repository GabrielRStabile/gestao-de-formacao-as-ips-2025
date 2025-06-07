import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';

/// Database table definition for enrollment requests
///
/// Defines the schema for storing enrollment request data in PostgreSQL.
/// Uses Drift ORM annotations for type safety and validation.
class EnrollmentRequests extends Table {
  /// Primary key - unique enrollment request identifier
  TextColumn get enrollmentId => text().withLength(min: 1, max: 100)();

  /// ID of the trainee/student user
  TextColumn get traineeUserId => text().withLength(min: 1, max: 100)();

  /// Foreign key to CourseOffering(id) in Course Service
  TextColumn get courseOfferingId => text().withLength(min: 1, max: 100)();

  /// Enrollment status enum
  TextColumn get status =>
      text().check(
        status.isIn([
          'PENDING_APPROVAL',
          'APPROVED',
          'REJECTED',
          'CANCELLED_BY_TRAINEE',
          'CANCELLED_BY_SYSTEM',
          'COMPLETED',
        ]),
      )();

  /// Timestamp when the enrollment request was created
  TimestampColumn get requestDate =>
      customType(PgTypes.timestampWithTimezone).withDefault(now())();

  /// Timestamp when the enrollment decision was made (nullable)
  TimestampColumn get decisionDate =>
      customType(PgTypes.timestampWithTimezone).nullable()();

  /// ID of the manager who made the decision (nullable)
  /// Foreign key to User(id) in Identity/Auth Service
  TextColumn get managerUserId =>
      text().withLength(min: 1, max: 100).nullable()();

  /// Reason for rejection if status is REJECTED (nullable)
  TextColumn get rejectionReason => text().nullable()();

  /// Timestamp when the enrollment record was last updated
  TimestampColumn get updatedAt =>
      customType(PgTypes.timestampWithTimezone).withDefault(now())();

  /// Additional notes about the enrollment (nullable)
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {enrollmentId};
}
