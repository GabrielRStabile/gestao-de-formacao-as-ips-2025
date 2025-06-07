import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';

/// Database table definition for issued certificates
///
/// Defines the schema for storing issued certificate data in PostgreSQL.
/// Uses Drift ORM annotations for type safety and validation.
class IssuedCertificates extends Table {
  /// Primary key - unique certificate identifier
  TextColumn get certificateId => text().withLength(min: 1, max: 100)();

  /// ID of the trainee/student user
  TextColumn get traineeUserId => text().withLength(min: 1, max: 100)();

  /// Foreign key to CourseOffering(id) in Course Service
  TextColumn get enrollmentId => text().withLength(min: 1, max: 100)();

  /// Foreign key to Course(id) in Course Service
  TextColumn get courseId => text().withLength(min: 1, max: 100)();

  /// Certificate status enum
  TextColumn get status =>
      text().check(
        status.isIn([
          'PENDING_APPROVAL',
          'PENDING_TEMPLATE',
          'APPROVED_FOR_EMISSION',
          'GENERATING',
          'ISSUED',
          'GENERATION_FAILED',
          'REVOKED',
        ]),
      )();

  /// Timestamp when emission was approved (nullable)
  TimestampColumn get emissionApprovedAt =>
      customType(PgTypes.timestampWithTimezone).nullable()();

  /// ID of user who approved emission (nullable)
  TextColumn get emissionApprovedByUserId =>
      text().withLength(min: 1, max: 100).nullable()();

  /// Timestamp when certificate was issued (nullable)
  TimestampColumn get issuedAt =>
      customType(PgTypes.timestampWithTimezone).nullable()();

  /// URL/Key for PDF certificate in Azure Blob Storage (nullable)
  TextColumn get certificateBlobUrl =>
      text().withLength(min: 1, max: 1000).nullable()();

  /// Unique verification code for the certificate (nullable)
  TextColumn get verificationCode =>
      text().withLength(min: 1, max: 100).nullable().unique()();

  /// Certificate expiration date (nullable)
  TimestampColumn get expiresAt =>
      customType(PgTypes.timestampWithTimezone).nullable()();

  /// Timestamp when the certificate record was created
  TimestampColumn get createdAt =>
      customType(PgTypes.timestampWithTimezone).withDefault(now())();

  /// Timestamp when the certificate record was last updated
  TimestampColumn get updatedAt =>
      customType(PgTypes.timestampWithTimezone).withDefault(now())();

  /// Additional notes about the certificate (nullable)
  TextColumn get notes => text().nullable()();

  @override
  Set<Column> get primaryKey => {certificateId};
}
