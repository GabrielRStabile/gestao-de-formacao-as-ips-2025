import 'package:drift/drift.dart';
import 'package:drift_postgres/drift_postgres.dart';
import 'package:vaden/vaden.dart';

import '../dtos/audit_event_dto.dart';
import '../dtos/list_audit_logs_dto.dart';
import '../models/database.dart';
import '../utils/json_helper.dart';

/// Repository for audit log data access operations
///
/// Provides database operations for audit logs including:
/// - Creating new audit log entries
/// - Querying with filters and pagination
/// - Counting records
/// - Converting between entities and DTOs
@Repository()
class AuditLogRepository {
  /// Database access instance for audit operations
  final AuditDatabaseAccess access;

  /// Creates a new instance of AuditLogRepository
  ///
  /// [access] The database access instance
  AuditLogRepository(this.access);

  /// Inserts a new audit log entry into the database
  ///
  /// [eventDto] The audit event data to be stored
  /// Returns the ID of the inserted record
  Future<int> insertAuditLog(AuditEventDto eventDto) async {
    final companion = AuditLogEntriesCompanion(
      eventTimestamp: Value(PgDateTime(eventDto.eventTimestamp)),
      sourceService: Value(eventDto.sourceService),
      eventType: Value(eventDto.eventType),
      userId: Value(eventDto.userId),
      targetEntityId: Value(eventDto.targetEntityId),
      targetEntityType: Value(eventDto.targetEntityType),
      ipAddress: Value(eventDto.ipAddress),
      details: Value(JsonHelper.mapToJsonString(eventDto.details)),
    );

    return await access.database
        .into(access.database.auditLogEntries)
        .insert(companion);
  }

  /// Searches for audit logs with filters and pagination
  ///
  /// Supports multiple filter criteria:
  /// - [page] Page number for pagination (starts from 1)
  /// - [limit] Maximum number of records per page
  /// - [sortBy] Field to sort by (eventTimestamp, sourceService, etc.)
  /// - [sortOrder] Sort direction ('asc' or 'desc')
  /// - [startDate] Filter by minimum event timestamp
  /// - [endDate] Filter by maximum event timestamp
  /// - [userId] Filter by user ID
  /// - [sourceService] Filter by source service name
  /// - [eventType] Filter by event type
  /// - [targetEntityId] Filter by target entity ID
  /// - [targetEntityType] Filter by target entity type
  /// - [ipAddress] Filter by IP address
  ///
  /// Returns a list of matching audit log entries
  Future<List<AuditLogEntry>> findAuditLogs({
    int? page,
    int? limit,
    String? sortBy,
    String? sortOrder,
    DateTime? startDate,
    DateTime? endDate,
    String? userId,
    String? sourceService,
    String? eventType,
    String? targetEntityId,
    String? targetEntityType,
    String? ipAddress,
  }) async {
    final query = access.database.select(access.database.auditLogEntries);

    // Apply filters to the query
    if (startDate != null) {
      query.where(
        (tbl) => tbl.eventTimestamp.isBiggerOrEqualValue(PgDateTime(startDate)),
      );
    }

    if (endDate != null) {
      query.where(
        (tbl) => tbl.eventTimestamp.isSmallerOrEqualValue(PgDateTime(endDate)),
      );
    }

    if (userId != null && userId.isNotEmpty) {
      query.where((tbl) => tbl.userId.equals(userId));
    }

    if (sourceService != null && sourceService.isNotEmpty) {
      query.where((tbl) => tbl.sourceService.equals(sourceService));
    }

    if (eventType != null && eventType.isNotEmpty) {
      query.where((tbl) => tbl.eventType.equals(eventType));
    }

    if (targetEntityId != null && targetEntityId.isNotEmpty) {
      query.where((tbl) => tbl.targetEntityId.equals(targetEntityId));
    }

    if (targetEntityType != null && targetEntityType.isNotEmpty) {
      query.where((tbl) => tbl.targetEntityType.equals(targetEntityType));
    }

    if (ipAddress != null && ipAddress.isNotEmpty) {
      query.where((tbl) => tbl.ipAddress.equals(ipAddress));
    }

    // Apply sorting
    final sortColumn = _getSortColumn(sortBy ?? 'eventTimestamp');
    final isAscending = sortOrder?.toLowerCase() == 'asc';

    if (isAscending) {
      query.orderBy([(t) => OrderingTerm.asc(sortColumn)]);
    } else {
      query.orderBy([(t) => OrderingTerm.desc(sortColumn)]);
    }

    if (limit != null) {
      query.limit(limit);
      if (page != null && page > 1) {
        query.limit(limit, offset: (page - 1) * limit);
      }
    }

    return await query.get();
  }

  /// Counts the total number of logs that match the specified filters
  ///
  /// Uses the same filter criteria as [findAuditLogs] but returns only the count.
  /// This is useful for pagination calculations.
  ///
  /// Returns the total number of matching records
  Future<int> countAuditLogs({
    DateTime? startDate,
    DateTime? endDate,
    String? userId,
    String? sourceService,
    String? eventType,
    String? targetEntityId,
    String? targetEntityType,
    String? ipAddress,
  }) async {
    final query = access.database.selectOnly(access.database.auditLogEntries)
      ..addColumns([access.database.auditLogEntries.logId.count()]);

    // Apply the same filters as findAuditLogs
    if (startDate != null) {
      query.where(
        access.database.auditLogEntries.eventTimestamp.isBiggerOrEqualValue(
          PgDateTime(startDate),
        ),
      );
    }

    if (endDate != null) {
      query.where(
        access.database.auditLogEntries.eventTimestamp.isSmallerOrEqualValue(
          PgDateTime(endDate),
        ),
      );
    }

    if (userId != null && userId.isNotEmpty) {
      query.where(access.database.auditLogEntries.userId.equals(userId));
    }

    if (sourceService != null && sourceService.isNotEmpty) {
      query.where(
        access.database.auditLogEntries.sourceService.equals(sourceService),
      );
    }

    if (eventType != null && eventType.isNotEmpty) {
      query.where(access.database.auditLogEntries.eventType.equals(eventType));
    }

    if (targetEntityId != null && targetEntityId.isNotEmpty) {
      query.where(
        access.database.auditLogEntries.targetEntityId.equals(targetEntityId),
      );
    }

    if (targetEntityType != null && targetEntityType.isNotEmpty) {
      query.where(
        access.database.auditLogEntries.targetEntityType.equals(
          targetEntityType,
        ),
      );
    }

    if (ipAddress != null && ipAddress.isNotEmpty) {
      query.where(access.database.auditLogEntries.ipAddress.equals(ipAddress));
    }

    final result = await query.getSingle();
    return result.read(access.database.auditLogEntries.logId.count()) ?? 0;
  }

  /// Finds a specific audit log by its ID
  ///
  /// [logId] The ID of the log to retrieve
  /// Returns the audit log entry if found, null otherwise
  Future<AuditLogEntry?> findAuditLogById(int logId) async {
    final query = access.database.select(access.database.auditLogEntries)
      ..where((tbl) => tbl.logId.equals(BigInt.from(logId)));

    final results = await query.get();
    return results.isNotEmpty ? results.first : null;
  }

  /// Converts a database entity to a response DTO
  ///
  /// [entry] The audit log entry from the database
  /// Returns a formatted DTO suitable for API responses
  AuditLogResponseDto toResponseDto(AuditLogEntry entry) {
    final details = JsonHelper.jsonStringToMap(entry.details as String?);

    return AuditLogResponseDto(
      logId: entry.logId.toInt(),
      eventTimestamp: entry.eventTimestamp.toDateTime(),
      sourceService: entry.sourceService,
      eventType: entry.eventType,
      userId: entry.userId,
      targetEntityId: entry.targetEntityId,
      targetEntityType: entry.targetEntityType,
      ipAddress: entry.ipAddress,
      details: details,
      createdAt: entry.createdAt.toDateTime(),
    );
  }

  /// Calculates pagination metadata
  ///
  /// [currentPage] The current page number (1-based)
  /// [pageSize] Number of items per page
  /// [totalItems] Total number of items across all pages
  ///
  /// Returns pagination information including total pages and navigation flags
  PaginationDto calculatePagination({
    required int currentPage,
    required int pageSize,
    required int totalItems,
  }) {
    final totalPages = (totalItems / pageSize).ceil();

    return PaginationDto(
      currentPage: currentPage,
      pageSize: pageSize,
      totalItems: totalItems,
      totalPages: totalPages,
      hasNext: currentPage < totalPages,
      hasPrevious: currentPage > 1,
    );
  }

  /// Maps sort field names to database columns
  ///
  /// [sortBy] The field name to sort by
  /// Returns the corresponding database column
  GeneratedColumn _getSortColumn(String sortBy) {
    switch (sortBy.toLowerCase()) {
      case 'eventtimestamp':
        return access.database.auditLogEntries.eventTimestamp;
      case 'sourceservice':
        return access.database.auditLogEntries.sourceService;
      case 'eventtype':
        return access.database.auditLogEntries.eventType;
      case 'userid':
        return access.database.auditLogEntries.userId;
      case 'createdat':
        return access.database.auditLogEntries.createdAt;
      default:
        return access.database.auditLogEntries.eventTimestamp;
    }
  }
}
