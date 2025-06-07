import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';

/// Database table definition for certificate templates
///
/// Defines the schema for storing certificate template data in PostgreSQL.
/// Uses Drift ORM annotations for type safety and validation.
class CertificateTemplates extends Table {
  /// Primary key - unique template identifier
  TextColumn get templateId => text().withLength(min: 1, max: 100)();

  /// Course identifier that this template belongs to
  TextColumn get courseId => text().withLength(min: 1, max: 100)();

  /// Name of the template
  TextColumn get templateName => text().withLength(min: 1, max: 255)();

  /// URL/Key for PDF template stored in Azure Blob Storage
  TextColumn get templateBlobUrl => text().withLength(min: 1, max: 1000)();

  /// ID of the user who uploaded this template
  TextColumn get uploadedByUserId => text().withLength(min: 1, max: 100)();

  /// Timestamp when the template was created
  TimestampColumn get createdAt =>
      customType(PgTypes.timestampWithTimezone).withDefault(now())();

  /// Timestamp when the template was last updated
  TimestampColumn get updatedAt =>
      customType(PgTypes.timestampWithTimezone).withDefault(now())();

  @override
  Set<Column> get primaryKey => {templateId};
}
