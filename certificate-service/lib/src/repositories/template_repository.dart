import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:vaden/vaden.dart';

import '../models/database.dart';

/// Repository for managing certificate template data
///
/// Provides CRUD operations for certificate templates in the database.
/// Handles all database interactions related to template management.
@Repository()
class TemplateRepository {
  final CertificateDatabaseAccess _database;

  /// Creates a new TemplateRepository instance
  TemplateRepository(this._database);

  /// Creates a new certificate template
  ///
  /// [templateId] Unique identifier for the template
  /// [courseId] Course identifier that this template belongs to
  /// [templateName] Name/title of the template
  /// [templateBlobUrl] URL/key for the template file in storage
  /// [uploadedByUserId] ID of the user who uploaded the template
  ///
  /// Returns the created template data
  /// Throws [InvalidDataException] if template already exists
  Future<CertificateTemplate> createTemplate({
    required String templateId,
    required String courseId,
    required String templateName,
    required String templateBlobUrl,
    required String uploadedByUserId,
  }) async {
    try {
      final template = await _database.database
          .into(_database.database.certificateTemplates)
          .insertReturning(
            CertificateTemplatesCompanion.insert(
              templateId: templateId,
              courseId: courseId,
              templateName: templateName,
              templateBlobUrl: templateBlobUrl,
              uploadedByUserId: uploadedByUserId,
            ),
          );

      return template;
    } catch (e) {
      throw Exception('Failed to create template: ${e.toString()}');
    }
  }

  /// Gets a template by its ID
  ///
  /// [templateId] The unique identifier of the template
  ///
  /// Returns the template data or null if not found
  Future<CertificateTemplate?> getTemplateById(String templateId) async {
    try {
      final query = _database.database.select(
        _database.database.certificateTemplates,
      )..where((template) => template.templateId.equals(templateId));

      return await query.getSingleOrNull();
    } catch (e) {
      throw Exception('Failed to get template by ID: ${e.toString()}');
    }
  }

  /// Gets all templates for a specific course
  ///
  /// [courseId] The course identifier
  ///
  /// Returns a list of templates for the course
  Future<List<CertificateTemplate>> getTemplatesByCourseId(
    String courseId,
  ) async {
    try {
      final query =
          _database.database.select(_database.database.certificateTemplates)
            ..where((template) => template.courseId.equals(courseId))
            ..orderBy([(template) => OrderingTerm.desc(template.createdAt)]);

      return await query.get();
    } catch (e) {
      throw Exception('Failed to get templates by course ID: ${e.toString()}');
    }
  }

  /// Gets all templates uploaded by a specific user
  ///
  /// [userId] The user identifier
  ///
  /// Returns a list of templates uploaded by the user
  Future<List<CertificateTemplate>> getTemplatesByUserId(String userId) async {
    try {
      final query =
          _database.database.select(_database.database.certificateTemplates)
            ..where((template) => template.uploadedByUserId.equals(userId))
            ..orderBy([(template) => OrderingTerm.desc(template.createdAt)]);

      return await query.get();
    } catch (e) {
      throw Exception('Failed to get templates by user ID: ${e.toString()}');
    }
  }

  /// Gets all templates with pagination
  ///
  /// [limit] Maximum number of templates to return (default: 50)
  /// [offset] Number of templates to skip (default: 0)
  ///
  /// Returns a list of templates with pagination
  Future<List<CertificateTemplate>> getAllTemplates({
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final query =
          _database.database.select(_database.database.certificateTemplates)
            ..orderBy([(template) => OrderingTerm.desc(template.createdAt)])
            ..limit(limit, offset: offset);

      return await query.get();
    } catch (e) {
      throw Exception('Failed to get all templates: ${e.toString()}');
    }
  }

  /// Updates an existing template
  ///
  /// [templateId] The unique identifier of the template to update
  /// [templateName] New name for the template (optional)
  /// [templateBlobUrl] New blob URL for the template (optional)
  ///
  /// Returns the updated template data or null if not found
  Future<CertificateTemplate?> updateTemplate({
    required String templateId,
    String? templateName,
    String? templateBlobUrl,
  }) async {
    try {
      final companion = CertificateTemplatesCompanion(
        templateId: Value(templateId),
        templateName:
            templateName != null ? Value(templateName) : const Value.absent(),
        templateBlobUrl:
            templateBlobUrl != null
                ? Value(templateBlobUrl)
                : const Value.absent(),
        updatedAt: Value(PgDateTime(DateTime.now())),
      );

      final updated = await (_database.database.update(
        _database.database.certificateTemplates,
      )..where(
        (template) => template.templateId.equals(templateId),
      )).writeReturning(companion);

      return updated.isNotEmpty ? updated.first : null;
    } catch (e) {
      throw Exception('Failed to update template: ${e.toString()}');
    }
  }

  /// Deletes a template by its ID
  ///
  /// [templateId] The unique identifier of the template to delete
  ///
  /// Returns true if the template was deleted, false if not found
  Future<bool> deleteTemplate(String templateId) async {
    try {
      final deletedRows =
          await (_database.database.delete(
            _database.database.certificateTemplates,
          )..where((template) => template.templateId.equals(templateId))).go();

      return deletedRows > 0;
    } catch (e) {
      throw Exception('Failed to delete template: ${e.toString()}');
    }
  }

  /// Checks if a template exists by its ID
  ///
  /// [templateId] The unique identifier of the template
  ///
  /// Returns true if the template exists, false otherwise
  Future<bool> templateExists(String templateId) async {
    try {
      final query =
          _database.database.select(_database.database.certificateTemplates)
            ..where((template) => template.templateId.equals(templateId))
            ..limit(1);

      final result = await query.getSingleOrNull();
      return result != null;
    } catch (e) {
      throw Exception('Failed to check template existence: ${e.toString()}');
    }
  }

  /// Counts total number of templates
  ///
  /// Returns the total count of templates in the database
  Future<int> countTemplates() async {
    try {
      final query = _database.database.selectOnly(
        _database.database.certificateTemplates,
      )..addColumns([
        _database.database.certificateTemplates.templateId.count(),
      ]);

      final result = await query.getSingle();
      return result.read(
            _database.database.certificateTemplates.templateId.count(),
          ) ??
          0;
    } catch (e) {
      throw Exception('Failed to count templates: ${e.toString()}');
    }
  }

  /// Counts templates for a specific course
  ///
  /// [courseId] The course identifier
  ///
  /// Returns the count of templates for the course
  Future<int> countTemplatesByCourseId(String courseId) async {
    try {
      final query =
          _database.database.selectOnly(_database.database.certificateTemplates)
            ..addColumns([
              _database.database.certificateTemplates.templateId.count(),
            ])
            ..where(
              _database.database.certificateTemplates.courseId.equals(courseId),
            );

      final result = await query.getSingle();
      return result.read(
            _database.database.certificateTemplates.templateId.count(),
          ) ??
          0;
    } catch (e) {
      throw Exception(
        'Failed to count templates by course ID: ${e.toString()}',
      );
    }
  }

  /// Searches templates by name (case-insensitive)
  ///
  /// [searchTerm] The term to search for in template names
  /// [limit] Maximum number of results to return (default: 50)
  /// [offset] Number of results to skip (default: 0)
  ///
  /// Returns a list of templates matching the search term
  Future<List<CertificateTemplate>> searchTemplatesByName({
    required String searchTerm,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final query =
          _database.database.select(_database.database.certificateTemplates)
            ..where((template) => template.templateName.like('%$searchTerm%'))
            ..orderBy([(template) => OrderingTerm.desc(template.createdAt)])
            ..limit(limit, offset: offset);

      return await query.get();
    } catch (e) {
      throw Exception('Failed to search templates by name: ${e.toString()}');
    }
  }

  /// Gets templates within a date range
  ///
  /// [startDate] Start date for the range
  /// [endDate] End date for the range
  /// [limit] Maximum number of results to return (default: 50)
  /// [offset] Number of results to skip (default: 0)
  ///
  /// Returns a list of templates created within the date range
  Future<List<CertificateTemplate>> getTemplatesByDateRange({
    required DateTime startDate,
    required DateTime endDate,
    int limit = 50,
    int offset = 0,
  }) async {
    try {
      final query =
          _database.database.select(_database.database.certificateTemplates)
            ..where(
              (template) =>
                  template.createdAt.isBiggerOrEqualValue(
                    PgDateTime(startDate),
                  ) &
                  template.createdAt.isSmallerOrEqualValue(PgDateTime(endDate)),
            )
            ..orderBy([(template) => OrderingTerm.desc(template.createdAt)])
            ..limit(limit, offset: offset);

      return await query.get();
    } catch (e) {
      throw Exception('Failed to get templates by date range: ${e.toString()}');
    }
  }

  /// Batch deletes templates by course ID
  ///
  /// [courseId] The course identifier
  ///
  /// Returns the number of templates deleted
  Future<int> deleteTemplatesByCourseId(String courseId) async {
    try {
      return await (_database.database.delete(
        _database.database.certificateTemplates,
      )..where((template) => template.courseId.equals(courseId))).go();
    } catch (e) {
      throw Exception(
        'Failed to delete templates by course ID: ${e.toString()}',
      );
    }
  }
}
