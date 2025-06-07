import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:vaden/vaden.dart';

import '../models/database.dart';

/// Repository for managing enrollment request data
///
/// Provides CRUD operations for enrollment requests in the database.
/// Handles all database interactions related to enrollment management.
@Repository()
class EnrollmentRequestRepository {
  final EnrollmentDatabaseAccess _database;

  /// Creates a new EnrollmentRequestRepository instance
  EnrollmentRequestRepository(this._database);

  /// Creates a new enrollment request record
  ///
  /// [enrollmentId] Unique identifier for the enrollment request
  /// [traineeUserId] ID of the trainee/student user
  /// [courseOfferingId] Foreign key to CourseOffering(id) in Course Service
  /// [status] Initial enrollment status (default: 'PENDING_APPROVAL')
  /// [notes] Optional notes about the enrollment
  ///
  /// Returns the created enrollment request data
  /// Throws [Exception] if creation fails
  Future<EnrollmentRequest> createEnrollmentRequest({
    required String enrollmentId,
    required String traineeUserId,
    required String courseOfferingId,
    String status = 'PENDING_APPROVAL',
    String? notes,
  }) async {
    try {
      final enrollmentRequest = await _database.database
          .into(_database.database.enrollmentRequests)
          .insertReturning(
            EnrollmentRequestsCompanion.insert(
              enrollmentId: enrollmentId,
              traineeUserId: traineeUserId,
              courseOfferingId: courseOfferingId,
              status: status,
              notes: Value(notes),
            ),
          );

      return enrollmentRequest;
    } catch (e) {
      throw Exception('Failed to create enrollment request: ${e.toString()}');
    }
  }

  /// Gets an enrollment request by its ID
  ///
  /// [enrollmentId] The enrollment request ID to search for
  ///
  /// Returns the enrollment request if found, null otherwise
  /// Throws [Exception] if query fails
  Future<EnrollmentRequest?> getEnrollmentRequestById(
    String enrollmentId,
  ) async {
    try {
      final query = _database.database.select(
        _database.database.enrollmentRequests,
      )..where((e) => e.enrollmentId.equals(enrollmentId));

      return await query.getSingleOrNull();
    } catch (e) {
      throw Exception(
        'Failed to get enrollment request by ID: ${e.toString()}',
      );
    }
  }

  /// Gets all enrollment requests for a trainee
  ///
  /// [traineeUserId] The trainee user ID to search for
  ///
  /// Returns a list of enrollment requests for the trainee
  /// Throws [Exception] if query fails
  Future<List<EnrollmentRequest>> getEnrollmentRequestsByTraineeId(
    String traineeUserId,
  ) async {
    try {
      final query =
          _database.database.select(_database.database.enrollmentRequests)
            ..where((e) => e.traineeUserId.equals(traineeUserId))
            ..orderBy([(e) => OrderingTerm.desc(e.requestDate)]);

      return await query.get();
    } catch (e) {
      throw Exception(
        'Failed to get enrollment requests by trainee ID: ${e.toString()}',
      );
    }
  }

  /// Gets enrollment requests by status
  ///
  /// [status] The status to filter by
  ///
  /// Returns a list of enrollment requests with the specified status
  /// Throws [Exception] if query fails
  Future<List<EnrollmentRequest>> getEnrollmentRequestsByStatus(
    String status,
  ) async {
    try {
      final query =
          _database.database.select(_database.database.enrollmentRequests)
            ..where((e) => e.status.equals(status))
            ..orderBy([(e) => OrderingTerm.desc(e.requestDate)]);

      return await query.get();
    } catch (e) {
      throw Exception(
        'Failed to get enrollment requests by status: ${e.toString()}',
      );
    }
  }

  /// Updates the status of an enrollment request
  ///
  /// [enrollmentId] The ID of the enrollment request to update
  /// [newStatus] The new status to set
  /// [managerUserId] Optional ID of the manager making the decision
  /// [rejectionReason] Optional reason for rejection
  /// [notes] Optional additional notes
  ///
  /// Returns the number of affected rows
  /// Throws [Exception] if update fails
  Future<int> updateEnrollmentStatus({
    required String enrollmentId,
    required String newStatus,
    String? managerUserId,
    String? rejectionReason,
    String? notes,
  }) async {
    try {
      final updateCompanion = EnrollmentRequestsCompanion(
        status: Value(newStatus),
        decisionDate: Value(PgDateTime(DateTime.now())),
        managerUserId: Value(managerUserId),
        rejectionReason: Value(rejectionReason),
        notes: Value(notes),
        updatedAt: Value(PgDateTime(DateTime.now())),
      );

      final query = _database.database.update(
        _database.database.enrollmentRequests,
      )..where((e) => e.enrollmentId.equals(enrollmentId));

      return await query.write(updateCompanion);
    } catch (e) {
      throw Exception('Failed to update enrollment status: ${e.toString()}');
    }
  }

  /// Updates notes for an enrollment request
  ///
  /// [enrollmentId] The ID of the enrollment request to update
  /// [notes] The new notes to set
  ///
  /// Returns the number of affected rows
  /// Throws [Exception] if update fails
  Future<int> updateEnrollmentNotes({
    required String enrollmentId,
    required String notes,
  }) async {
    try {
      final updateCompanion = EnrollmentRequestsCompanion(
        notes: Value(notes),
        updatedAt: Value(PgDateTime(DateTime.now())),
      );

      final query = _database.database.update(
        _database.database.enrollmentRequests,
      )..where((e) => e.enrollmentId.equals(enrollmentId));

      return await query.write(updateCompanion);
    } catch (e) {
      throw Exception('Failed to update enrollment notes: ${e.toString()}');
    }
  }

  /// Deletes an enrollment request
  ///
  /// [enrollmentId] The ID of the enrollment request to delete
  ///
  /// Returns the number of affected rows
  /// Throws [Exception] if deletion fails
  Future<int> deleteEnrollmentRequest(String enrollmentId) async {
    try {
      final query = _database.database.delete(
        _database.database.enrollmentRequests,
      )..where((e) => e.enrollmentId.equals(enrollmentId));

      return await query.go();
    } catch (e) {
      throw Exception('Failed to delete enrollment request: ${e.toString()}');
    }
  }

  /// Gets enrollment requests by course offering ID
  ///
  /// [courseOfferingId] The course offering ID to search for
  ///
  /// Returns a list of enrollment requests for the course offering
  /// Throws [Exception] if query fails
  Future<List<EnrollmentRequest>> getEnrollmentRequestsByCourseOfferingId(
    String courseOfferingId,
  ) async {
    try {
      final query =
          _database.database.select(_database.database.enrollmentRequests)
            ..where((e) => e.courseOfferingId.equals(courseOfferingId))
            ..orderBy([(e) => OrderingTerm.desc(e.requestDate)]);

      return await query.get();
    } catch (e) {
      throw Exception(
        'Failed to get enrollment requests by course offering ID: ${e.toString()}',
      );
    }
  }

  /// Gets enrollment requests with pagination
  ///
  /// [limit] Maximum number of records to return
  /// [offset] Number of records to skip
  /// [status] Optional status filter
  ///
  /// Returns a list of enrollment requests
  /// Throws [Exception] if query fails
  Future<List<EnrollmentRequest>> getEnrollmentRequestsPaginated({
    required int limit,
    required int offset,
    String? status,
  }) async {
    try {
      var query = _database.database.select(
        _database.database.enrollmentRequests,
      );

      if (status != null) {
        query = query..where((e) => e.status.equals(status));
      }

      query =
          query
            ..orderBy([(e) => OrderingTerm.desc(e.requestDate)])
            ..limit(limit, offset: offset);

      return await query.get();
    } catch (e) {
      throw Exception(
        'Failed to get enrollment requests with pagination: ${e.toString()}',
      );
    }
  }

  /// Counts enrollment requests by status
  ///
  /// [status] Optional status filter
  ///
  /// Returns the count of enrollment requests
  /// Throws [Exception] if query fails
  Future<int> countEnrollmentRequests({String? status}) async {
    try {
      var query = _database.database.selectOnly(
        _database.database.enrollmentRequests,
      )..addColumns([
        _database.database.enrollmentRequests.enrollmentId.count(),
      ]);

      if (status != null) {
        query =
            query..where(
              _database.database.enrollmentRequests.status.equals(status),
            );
      }

      final result = await query.getSingle();
      return result.read(
            _database.database.enrollmentRequests.enrollmentId.count(),
          ) ??
          0;
    } catch (e) {
      throw Exception('Failed to count enrollment requests: ${e.toString()}');
    }
  }
}
