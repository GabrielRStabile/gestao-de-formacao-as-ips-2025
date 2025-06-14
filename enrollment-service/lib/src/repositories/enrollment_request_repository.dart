import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:vaden/vaden.dart';

import '../models/database.dart';

/// Result class for paginated enrollment queries
class PaginatedEnrollmentResult {
  final List<EnrollmentRequest> enrollments;
  final int totalItems;

  const PaginatedEnrollmentResult({
    required this.enrollments,
    required this.totalItems,
  });
}

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

  /// Gets enrollment requests for a trainee with pagination and filters
  ///
  /// [traineeUserId] The trainee user ID to search for
  /// [page] Page number (1-based)
  /// [limit] Maximum number of records to return
  /// [status] Optional status filter
  /// [sortBy] Field to sort by (requestDate, status, updatedAt)
  /// [sortOrder] Sort order (asc, desc)
  ///
  /// Returns paginated enrollment requests for the trainee
  /// Throws [Exception] if query fails
  Future<PaginatedEnrollmentResult> getEnrollmentsByTraineeWithPagination({
    required String traineeUserId,
    required int page,
    required int limit,
    String? status,
    String sortBy = 'requestDate',
    String sortOrder = 'desc',
  }) async {
    try {
      // Calculate offset for pagination (1-based page)
      final offset = (page - 1) * limit;

      // Build the main query
      var query = _database.database.select(
        _database.database.enrollmentRequests,
      )..where((e) => e.traineeUserId.equals(traineeUserId));

      // Apply status filter if provided
      if (status != null && status.isNotEmpty) {
        query = query..where((e) => e.status.equals(status));
      }

      // Apply sorting
      final isAsc = sortOrder.toLowerCase() == 'asc';
      switch (sortBy) {
        case 'status':
          query =
              query..orderBy([
                (e) =>
                    isAsc
                        ? OrderingTerm.asc(e.status)
                        : OrderingTerm.desc(e.status),
              ]);
          break;
        case 'updatedAt':
          query =
              query..orderBy([
                (e) =>
                    isAsc
                        ? OrderingTerm.asc(e.updatedAt)
                        : OrderingTerm.desc(e.updatedAt),
              ]);
          break;
        case 'requestDate':
        default:
          query =
              query..orderBy([
                (e) =>
                    isAsc
                        ? OrderingTerm.asc(e.requestDate)
                        : OrderingTerm.desc(e.requestDate),
              ]);
          break;
      }

      query = query..limit(limit, offset: offset);

      // Get the enrollment requests
      final enrollments = await query.get();

      // Get total count for pagination
      var countQuery =
          _database.database.selectOnly(_database.database.enrollmentRequests)
            ..addColumns([
              _database.database.enrollmentRequests.enrollmentId.count(),
            ])
            ..where(
              _database.database.enrollmentRequests.traineeUserId.equals(
                traineeUserId,
              ),
            );

      if (status != null && status.isNotEmpty) {
        countQuery =
            countQuery..where(
              _database.database.enrollmentRequests.status.equals(status),
            );
      }

      final countResult = await countQuery.getSingle();
      final totalItems =
          countResult.read(
            _database.database.enrollmentRequests.enrollmentId.count(),
          ) ??
          0;

      return PaginatedEnrollmentResult(
        enrollments: enrollments,
        totalItems: totalItems,
      );
    } catch (e) {
      throw Exception(
        'Failed to get paginated enrollment requests for trainee: ${e.toString()}',
      );
    }
  }

  /// Gets all enrollment requests with advanced filtering for managers
  ///
  /// [page] Page number (1-based)
  /// [pageSize] Maximum number of records to return per page
  /// [status] Optional status filter
  /// [traineeId] Optional trainee ID filter
  /// [courseOfferingId] Optional course offering ID filter
  /// [sortBy] Field to sort by
  /// [sortOrder] Sort order (asc, desc)
  /// [startDate] Optional start date filter (ISO 8601 format)
  /// [endDate] Optional end date filter (ISO 8601 format)
  ///
  /// Returns paginated enrollment requests with manager filters
  /// Throws [Exception] if query fails
  Future<PaginatedEnrollmentResult> getEnrollmentsForManagerWithPagination({
    required int page,
    required int pageSize,
    String? status,
    String? traineeId,
    String? courseOfferingId,
    String sortBy = 'requestDate',
    String sortOrder = 'desc',
    String? startDate,
    String? endDate,
  }) async {
    try {
      // Calculate offset for pagination (1-based page)
      final offset = (page - 1) * pageSize;

      // Build the main query
      var query = _database.database.select(
        _database.database.enrollmentRequests,
      );

      // Apply status filter if provided
      if (status != null && status.isNotEmpty) {
        query = query..where((e) => e.status.equals(status));
      }

      // Apply trainee ID filter if provided
      if (traineeId != null && traineeId.isNotEmpty) {
        query = query..where((e) => e.traineeUserId.equals(traineeId));
      }

      // Apply course offering ID filter if provided
      if (courseOfferingId != null && courseOfferingId.isNotEmpty) {
        query =
            query..where((e) => e.courseOfferingId.equals(courseOfferingId));
      }

      // Apply date range filters if provided
      if (startDate != null && startDate.isNotEmpty) {
        try {
          final startDateTime = DateTime.parse(startDate);
          query =
              query..where(
                (e) => e.requestDate.isBiggerOrEqualValue(
                  PgDateTime(startDateTime),
                ),
              );
        } catch (e) {
          throw Exception('Invalid startDate format. Use ISO 8601 format.');
        }
      }

      if (endDate != null && endDate.isNotEmpty) {
        try {
          final endDateTime = DateTime.parse(endDate);
          query =
              query..where(
                (e) => e.requestDate.isSmallerOrEqualValue(
                  PgDateTime(endDateTime),
                ),
              );
        } catch (e) {
          throw Exception('Invalid endDate format. Use ISO 8601 format.');
        }
      }

      // Apply sorting
      final isAsc = sortOrder.toLowerCase() == 'asc';
      switch (sortBy) {
        case 'status':
          query =
              query..orderBy([
                (e) =>
                    isAsc
                        ? OrderingTerm.asc(e.status)
                        : OrderingTerm.desc(e.status),
              ]);
          break;
        case 'updatedAt':
          query =
              query..orderBy([
                (e) =>
                    isAsc
                        ? OrderingTerm.asc(e.updatedAt)
                        : OrderingTerm.desc(e.updatedAt),
              ]);
          break;
        case 'traineeId':
          query =
              query..orderBy([
                (e) =>
                    isAsc
                        ? OrderingTerm.asc(e.traineeUserId)
                        : OrderingTerm.desc(e.traineeUserId),
              ]);
          break;
        case 'courseOfferingId':
          query =
              query..orderBy([
                (e) =>
                    isAsc
                        ? OrderingTerm.asc(e.courseOfferingId)
                        : OrderingTerm.desc(e.courseOfferingId),
              ]);
          break;
        case 'requestDate':
        default:
          query =
              query..orderBy([
                (e) =>
                    isAsc
                        ? OrderingTerm.asc(e.requestDate)
                        : OrderingTerm.desc(e.requestDate),
              ]);
          break;
      }

      query = query..limit(pageSize, offset: offset);

      // Get the enrollment requests
      final enrollments = await query.get();

      // Build count query with same filters
      var countQuery = _database.database.selectOnly(
        _database.database.enrollmentRequests,
      )..addColumns([
        _database.database.enrollmentRequests.enrollmentId.count(),
      ]);

      // Apply same filters to count query
      if (status != null && status.isNotEmpty) {
        countQuery =
            countQuery..where(
              _database.database.enrollmentRequests.status.equals(status),
            );
      }

      if (traineeId != null && traineeId.isNotEmpty) {
        countQuery =
            countQuery..where(
              _database.database.enrollmentRequests.traineeUserId.equals(
                traineeId,
              ),
            );
      }

      if (courseOfferingId != null && courseOfferingId.isNotEmpty) {
        countQuery =
            countQuery..where(
              _database.database.enrollmentRequests.courseOfferingId.equals(
                courseOfferingId,
              ),
            );
      }

      if (startDate != null && startDate.isNotEmpty) {
        final startDateTime = DateTime.parse(startDate);
        countQuery =
            countQuery..where(
              _database.database.enrollmentRequests.requestDate
                  .isBiggerOrEqualValue(PgDateTime(startDateTime)),
            );
      }

      if (endDate != null && endDate.isNotEmpty) {
        final endDateTime = DateTime.parse(endDate);
        countQuery =
            countQuery..where(
              _database.database.enrollmentRequests.requestDate
                  .isSmallerOrEqualValue(PgDateTime(endDateTime)),
            );
      }

      final countResult = await countQuery.getSingle();
      final totalItems =
          countResult.read(
            _database.database.enrollmentRequests.enrollmentId.count(),
          ) ??
          0;

      return PaginatedEnrollmentResult(
        enrollments: enrollments,
        totalItems: totalItems,
      );
    } catch (e) {
      throw Exception(
        'Failed to get paginated enrollment requests for manager: ${e.toString()}',
      );
    }
  }
}
