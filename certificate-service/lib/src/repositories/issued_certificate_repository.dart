import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:vaden/vaden.dart';

import '../models/database.dart';

/// Repository for managing issued certificate data
///
/// Provides CRUD operations for issued certificates in the database.
/// Handles all database interactions related to certificate issuance.
@Repository()
class IssuedCertificateRepository {
  final CertificateDatabaseAccess _database;

  /// Creates a new IssuedCertificateRepository instance
  IssuedCertificateRepository(this._database);

  /// Creates a new issued certificate record
  ///
  /// [certificateId] Unique identifier for the certificate
  /// [traineeUserId] ID of the trainee/student user
  /// [enrollmentId] Foreign key to CourseOffering(id) in Course Service
  /// [courseId] Foreign key to Course(id) in Course Service
  /// [status] Certificate status
  ///
  /// Returns the created certificate data
  /// Throws [Exception] if creation fails
  Future<IssuedCertificate> createIssuedCertificate({
    required String certificateId,
    required String traineeUserId,
    required String enrollmentId,
    required String courseId,
    required String status,
  }) async {
    try {
      final certificate = await _database.database
          .into(_database.database.issuedCertificates)
          .insertReturning(
            IssuedCertificatesCompanion.insert(
              certificateId: certificateId,
              traineeUserId: traineeUserId,
              enrollmentId: enrollmentId,
              courseId: courseId,
              status: status,
            ),
          );

      return certificate;
    } catch (e) {
      throw Exception('Failed to create issued certificate: ${e.toString()}');
    }
  }

  /// Gets a certificate by its ID
  ///
  /// [certificateId] The unique identifier of the certificate
  ///
  /// Returns the certificate data or null if not found
  Future<IssuedCertificate?> getCertificateById(String certificateId) async {
    try {
      final query = _database.database.select(
        _database.database.issuedCertificates,
      )..where((cert) => cert.certificateId.equals(certificateId));

      return await query.getSingleOrNull();
    } catch (e) {
      throw Exception('Failed to get certificate by ID: ${e.toString()}');
    }
  }

  /// Gets all certificates for a specific trainee
  ///
  /// [traineeUserId] The trainee user identifier
  ///
  /// Returns a list of certificates for the trainee
  Future<List<IssuedCertificate>> getCertificatesByTraineeId(
    String traineeUserId,
  ) async {
    try {
      final query =
          _database.database.select(_database.database.issuedCertificates)
            ..where((cert) => cert.traineeUserId.equals(traineeUserId))
            ..orderBy([(cert) => OrderingTerm.desc(cert.createdAt)]);

      return await query.get();
    } catch (e) {
      throw Exception(
        'Failed to get certificates by trainee ID: ${e.toString()}',
      );
    }
  }

  /// Gets all certificates for a specific course
  ///
  /// [courseId] The course identifier
  ///
  /// Returns a list of certificates for the course
  Future<List<IssuedCertificate>> getCertificatesByCourseId(
    String courseId,
  ) async {
    try {
      final query =
          _database.database.select(_database.database.issuedCertificates)
            ..where((cert) => cert.courseId.equals(courseId))
            ..orderBy([(cert) => OrderingTerm.desc(cert.createdAt)]);

      return await query.get();
    } catch (e) {
      throw Exception(
        'Failed to get certificates by course ID: ${e.toString()}',
      );
    }
  }

  /// Gets all certificates with a specific status
  ///
  /// [status] The certificate status to filter by
  ///
  /// Returns a list of certificates with the specified status
  Future<List<IssuedCertificate>> getCertificatesByStatus(String status) async {
    try {
      final query =
          _database.database.select(_database.database.issuedCertificates)
            ..where((cert) => cert.status.equals(status))
            ..orderBy([(cert) => OrderingTerm.desc(cert.createdAt)]);

      return await query.get();
    } catch (e) {
      throw Exception('Failed to get certificates by status: ${e.toString()}');
    }
  }

  /// Gets pending approval certificates with pagination and optional course filtering
  ///
  /// [courseId] Optional course ID to filter certificates
  /// [page] Page number (1-based)
  /// [limit] Number of items per page
  ///
  /// Returns a paginated list of pending certificates
  Future<List<IssuedCertificate>> getPendingCertificatesWithPagination({
    String? courseId,
    required int page,
    required int limit,
  }) async {
    try {
      final query = _database.database.select(
        _database.database.issuedCertificates,
      );

      // Filter by pending status
      query.where((cert) => cert.status.equals('PENDING_APPROVAL'));

      // Optional course filter
      if (courseId != null) {
        query.where((cert) => cert.courseId.equals(courseId));
      }

      // Order by creation date (most recent first)
      query.orderBy([(cert) => OrderingTerm.desc(cert.createdAt)]);

      // Apply pagination
      final offset = (page - 1) * limit;
      query.limit(limit, offset: offset);

      return await query.get();
    } catch (e) {
      throw Exception('Failed to get pending certificates: ${e.toString()}');
    }
  }

  /// Gets the total count of pending approval certificates
  ///
  /// [courseId] Optional course ID to filter certificates
  ///
  /// Returns the total count of pending certificates
  Future<int> getPendingCertificatesCount({String? courseId}) async {
    try {
      final query = _database.database.selectOnly(
        _database.database.issuedCertificates,
      )..addColumns([
        _database.database.issuedCertificates.certificateId.count(),
      ]);

      // Filter by pending status
      query.where(
        _database.database.issuedCertificates.status.equals('PENDING_APPROVAL'),
      );

      // Optional course filter
      if (courseId != null) {
        query.where(
          _database.database.issuedCertificates.courseId.equals(courseId),
        );
      }

      final result = await query.getSingle();
      return result.read(
            _database.database.issuedCertificates.certificateId.count(),
          ) ??
          0;
    } catch (e) {
      throw Exception(
        'Failed to get pending certificates count: ${e.toString()}',
      );
    }
  }

  /// Updates the status of an issued certificate
  ///
  /// [certificateId] The unique identifier of the certificate
  /// [status] The new status
  /// [emissionApprovedByUserId] Optional user ID who approved emission
  /// [certificateBlobUrl] Optional URL for the generated certificate
  /// [verificationCode] Optional verification code
  ///
  /// Returns the updated certificate data or null if not found
  Future<IssuedCertificate?> updateCertificateStatus({
    required String certificateId,
    required String status,
    String? emissionApprovedByUserId,
    String? certificateBlobUrl,
    String? verificationCode,
  }) async {
    try {
      final companion = IssuedCertificatesCompanion(
        certificateId: Value(certificateId),
        status: Value(status),
        emissionApprovedByUserId:
            emissionApprovedByUserId != null
                ? Value(emissionApprovedByUserId)
                : const Value.absent(),
        certificateBlobUrl:
            certificateBlobUrl != null
                ? Value(certificateBlobUrl)
                : const Value.absent(),
        verificationCode:
            verificationCode != null
                ? Value(verificationCode)
                : const Value.absent(),
        emissionApprovedAt:
            (status == 'APPROVED_FOR_EMISSION' ||
                    status == 'GENERATING' ||
                    status == 'ISSUED')
                ? Value(PgDateTime(DateTime.now()))
                : const Value.absent(),
        issuedAt:
            status == 'ISSUED'
                ? Value(PgDateTime(DateTime.now()))
                : const Value.absent(),
        updatedAt: Value(PgDateTime(DateTime.now())),
      );

      final updated = await (_database.database.update(
        _database.database.issuedCertificates,
      )..where(
        (cert) => cert.certificateId.equals(certificateId),
      )).writeReturning(companion);

      return updated.isNotEmpty ? updated.first : null;
    } catch (e) {
      throw Exception('Failed to update certificate status: ${e.toString()}');
    }
  }

  /// Checks if a certificate exists for a specific enrollment
  ///
  /// [enrollmentId] The enrollment identifier
  ///
  /// Returns true if a certificate exists for the enrollment
  Future<bool> certificateExistsForEnrollment(String enrollmentId) async {
    try {
      final query =
          _database.database.select(_database.database.issuedCertificates)
            ..where((cert) => cert.enrollmentId.equals(enrollmentId))
            ..limit(1);

      final result = await query.getSingleOrNull();
      return result != null;
    } catch (e) {
      throw Exception(
        'Failed to check certificate existence for enrollment: ${e.toString()}',
      );
    }
  }
}
