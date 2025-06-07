import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:vaden/vaden.dart';

import '../models/database.dart';

/// Repository for managing enrollment status history data
///
/// Provides CRUD operations for enrollment status history in the database.
/// Handles all database interactions related to enrollment status tracking.
@Repository()
class EnrollmentStatusHistoryRepository {
  final EnrollmentDatabaseAccess _database;

  /// Creates a new EnrollmentStatusHistoryRepository instance
  EnrollmentStatusHistoryRepository(this._database);

  /// Creates a new enrollment status history record
  ///
  /// [historyId] Unique identifier for the history record
  /// [enrollmentId] Foreign key to EnrollmentRequest.enrollmentId
  /// [oldStatus] Previous status before the change
  /// [newStatus] New status after the change
  /// [changedByUserId] Optional ID of the user who made the change
  /// [reason] Optional reason for the status change
  ///
  /// Returns the created history record
  /// Throws [Exception] if creation fails
  Future<EnrollmentStatusHistory> createStatusHistoryRecord({
    required String historyId,
    required String enrollmentId,
    required String oldStatus,
    required String newStatus,
    String? changedByUserId,
    String? reason,
  }) async {
    try {
      final historyRecord = await _database.database
          .into(_database.database.enrollmentStatusHistories)
          .insertReturning(
            EnrollmentStatusHistoriesCompanion.insert(
              historyId: historyId,
              enrollmentId: enrollmentId,
              oldStatus: oldStatus,
              newStatus: newStatus,
              changedByUserId: Value(changedByUserId),
              reason: Value(reason),
            ),
          );

      return historyRecord;
    } catch (e) {
      throw Exception(
        'Failed to create status history record: ${e.toString()}',
      );
    }
  }

  /// Gets all status history records for an enrollment
  ///
  /// [enrollmentId] The enrollment ID to search for
  ///
  /// Returns a list of status history records ordered by change date
  /// Throws [Exception] if query fails
  Future<List<EnrollmentStatusHistory>> getStatusHistoryByEnrollmentId(
    String enrollmentId,
  ) async {
    try {
      final query =
          _database.database.select(
              _database.database.enrollmentStatusHistories,
            )
            ..where((h) => h.enrollmentId.equals(enrollmentId))
            ..orderBy([(h) => OrderingTerm.desc(h.changedAt)]);

      return await query.get();
    } catch (e) {
      throw Exception(
        'Failed to get status history by enrollment ID: ${e.toString()}',
      );
    }
  }

  /// Gets a specific status history record by its ID
  ///
  /// [historyId] The history record ID to search for
  ///
  /// Returns the history record if found, null otherwise
  /// Throws [Exception] if query fails
  Future<EnrollmentStatusHistory?> getStatusHistoryById(
    String historyId,
  ) async {
    try {
      final query = _database.database.select(
        _database.database.enrollmentStatusHistories,
      )..where((h) => h.historyId.equals(historyId));

      return await query.getSingleOrNull();
    } catch (e) {
      throw Exception('Failed to get status history by ID: ${e.toString()}');
    }
  }

  /// Gets status history records by user who made the change
  ///
  /// [changedByUserId] The user ID to search for
  ///
  /// Returns a list of status history records made by the user
  /// Throws [Exception] if query fails
  Future<List<EnrollmentStatusHistory>> getStatusHistoryByChangedByUserId(
    String changedByUserId,
  ) async {
    try {
      final query =
          _database.database.select(
              _database.database.enrollmentStatusHistories,
            )
            ..where((h) => h.changedByUserId.equals(changedByUserId))
            ..orderBy([(h) => OrderingTerm.desc(h.changedAt)]);

      return await query.get();
    } catch (e) {
      throw Exception(
        'Failed to get status history by changed by user ID: ${e.toString()}',
      );
    }
  }

  /// Gets status history records within a date range
  ///
  /// [startDate] Start date for the range
  /// [endDate] End date for the range
  /// [enrollmentId] Optional enrollment ID filter
  ///
  /// Returns a list of status history records within the date range
  /// Throws [Exception] if query fails
  Future<List<EnrollmentStatusHistory>> getStatusHistoryByDateRange({
    required DateTime startDate,
    required DateTime endDate,
    String? enrollmentId,
  }) async {
    try {
      var query = _database.database.select(
        _database.database.enrollmentStatusHistories,
      )..where(
        (h) => h.changedAt.isBetweenValues(
          PgDateTime(startDate),
          PgDateTime(endDate),
        ),
      );

      if (enrollmentId != null) {
        query = query..where((h) => h.enrollmentId.equals(enrollmentId));
      }

      query = query..orderBy([(h) => OrderingTerm.desc(h.changedAt)]);

      return await query.get();
    } catch (e) {
      throw Exception(
        'Failed to get status history by date range: ${e.toString()}',
      );
    }
  }

  /// Gets the latest status change for an enrollment
  ///
  /// [enrollmentId] The enrollment ID to search for
  ///
  /// Returns the most recent status history record if found, null otherwise
  /// Throws [Exception] if query fails
  Future<EnrollmentStatusHistory?> getLatestStatusChange(
    String enrollmentId,
  ) async {
    try {
      final query =
          _database.database.select(
              _database.database.enrollmentStatusHistories,
            )
            ..where((h) => h.enrollmentId.equals(enrollmentId))
            ..orderBy([(h) => OrderingTerm.desc(h.changedAt)])
            ..limit(1);

      return await query.getSingleOrNull();
    } catch (e) {
      throw Exception('Failed to get latest status change: ${e.toString()}');
    }
  }

  /// Gets status history records by status transition
  ///
  /// [oldStatus] The old status to filter by
  /// [newStatus] The new status to filter by
  ///
  /// Returns a list of status history records matching the transition
  /// Throws [Exception] if query fails
  Future<List<EnrollmentStatusHistory>> getStatusHistoryByTransition({
    required String oldStatus,
    required String newStatus,
  }) async {
    try {
      final query =
          _database.database.select(
              _database.database.enrollmentStatusHistories,
            )
            ..where(
              (h) =>
                  h.oldStatus.equals(oldStatus) & h.newStatus.equals(newStatus),
            )
            ..orderBy([(h) => OrderingTerm.desc(h.changedAt)]);

      return await query.get();
    } catch (e) {
      throw Exception(
        'Failed to get status history by transition: ${e.toString()}',
      );
    }
  }

  /// Updates the reason for a status history record
  ///
  /// [historyId] The ID of the history record to update
  /// [reason] The new reason to set
  ///
  /// Returns the number of affected rows
  /// Throws [Exception] if update fails
  Future<int> updateStatusHistoryReason({
    required String historyId,
    required String reason,
  }) async {
    try {
      final updateCompanion = EnrollmentStatusHistoriesCompanion(
        reason: Value(reason),
      );

      final query = _database.database.update(
        _database.database.enrollmentStatusHistories,
      )..where((h) => h.historyId.equals(historyId));

      return await query.write(updateCompanion);
    } catch (e) {
      throw Exception(
        'Failed to update status history reason: ${e.toString()}',
      );
    }
  }

  /// Deletes a status history record
  ///
  /// [historyId] The ID of the history record to delete
  ///
  /// Returns the number of affected rows
  /// Throws [Exception] if deletion fails
  Future<int> deleteStatusHistoryRecord(String historyId) async {
    try {
      final query = _database.database.delete(
        _database.database.enrollmentStatusHistories,
      )..where((h) => h.historyId.equals(historyId));

      return await query.go();
    } catch (e) {
      throw Exception(
        'Failed to delete status history record: ${e.toString()}',
      );
    }
  }

  /// Gets status history records with pagination
  ///
  /// [limit] Maximum number of records to return
  /// [offset] Number of records to skip
  /// [enrollmentId] Optional enrollment ID filter
  ///
  /// Returns a list of status history records
  /// Throws [Exception] if query fails
  Future<List<EnrollmentStatusHistory>> getStatusHistoryPaginated({
    required int limit,
    required int offset,
    String? enrollmentId,
  }) async {
    try {
      var query = _database.database.select(
        _database.database.enrollmentStatusHistories,
      );

      if (enrollmentId != null) {
        query = query..where((h) => h.enrollmentId.equals(enrollmentId));
      }

      query =
          query
            ..orderBy([(h) => OrderingTerm.desc(h.changedAt)])
            ..limit(limit, offset: offset);

      return await query.get();
    } catch (e) {
      throw Exception(
        'Failed to get status history with pagination: ${e.toString()}',
      );
    }
  }

  /// Counts status history records
  ///
  /// [enrollmentId] Optional enrollment ID filter
  ///
  /// Returns the count of status history records
  /// Throws [Exception] if query fails
  Future<int> countStatusHistoryRecords({String? enrollmentId}) async {
    try {
      var query = _database.database.selectOnly(
        _database.database.enrollmentStatusHistories,
      )..addColumns([
        _database.database.enrollmentStatusHistories.historyId.count(),
      ]);

      if (enrollmentId != null) {
        query =
            query..where(
              _database.database.enrollmentStatusHistories.enrollmentId.equals(
                enrollmentId,
              ),
            );
      }

      final result = await query.getSingle();
      return result.read(
            _database.database.enrollmentStatusHistories.historyId.count(),
          ) ??
          0;
    } catch (e) {
      throw Exception(
        'Failed to count status history records: ${e.toString()}',
      );
    }
  }
}
