import 'package:audit_service/src/errors/invalid_data_error.dart';
import 'package:vaden/vaden.dart';

import '../dtos/audit_event_dto.dart';
import '../dtos/list_audit_logs_dto.dart';
import '../repositories/audit_log_repository.dart';

/// Service layer for audit log business logic
///
/// Handles audit event processing, validation, and query operations.
/// Acts as an intermediary between controllers and repository layer.
@Service()
class AuditLogService {
  /// Repository for audit log data access
  final AuditLogRepository _repository;

  /// Creates a new instance of AuditLogService
  ///
  /// [_repository] The repository for database operations
  AuditLogService(this._repository);

  /// Processes and stores an audit event
  ///
  /// Validates the event data and stores it in the database.
  /// Throws [InvalidDataError] if validation fails.
  ///
  /// [eventDto] The audit event to process
  Future<void> processAuditEvent(AuditEventDto eventDto) async {
    final validationResult = eventDto
        .validate(ValidatorBuilder<AuditEventDto>())
        .validate(eventDto);

    if (!validationResult.isValid) {
      throw InvalidDataError(
        validationResult.exceptions.map((e) => e.message).toList(),
      );
    }

    try {
      await _repository.insertAuditLog(eventDto);

      print('Event processed: ${eventDto.summary}');
    } catch (e) {
      print('Error inserting audit log: $e');
      rethrow;
    }
  }

  /// Retrieves a paginated list of audit logs with filters
  ///
  /// Applies the provided filters and returns a paginated result set.
  /// Includes total count for pagination calculations.
  ///
  /// [requestDto] The request parameters including filters and pagination
  /// Returns a paginated response with audit logs and metadata
  Future<PaginatedAuditLogsDto> listAuditLogs(
    ListAuditLogsRequestDto requestDto,
  ) async {
    try {
      // Fetch logs with filters
      final logs = await _repository.findAuditLogs(
        page: requestDto.page,
        limit: requestDto.limit,
        sortBy: requestDto.sortBy,
        sortOrder: requestDto.sortOrder,
        startDate: requestDto.startDate,
        endDate: requestDto.endDate,
        userId: requestDto.userId,
        sourceService: requestDto.sourceService,
        eventType: requestDto.eventType,
        targetEntityId: requestDto.targetEntityId,
        targetEntityType: requestDto.targetEntityType,
        ipAddress: requestDto.ipAddress,
      );

      // Count total records
      final totalItems = await _repository.countAuditLogs(
        startDate: requestDto.startDate,
        endDate: requestDto.endDate,
        userId: requestDto.userId,
        sourceService: requestDto.sourceService,
        eventType: requestDto.eventType,
        targetEntityId: requestDto.targetEntityId,
        targetEntityType: requestDto.targetEntityType,
        ipAddress: requestDto.ipAddress,
      );

      // Convert entities to DTOs
      final logDtos =
          logs.map((log) => _repository.toResponseDto(log)).toList();

      // Calculate pagination
      final pagination = _repository.calculatePagination(
        currentPage: requestDto.page,
        pageSize: requestDto.limit,
        totalItems: totalItems,
      );

      return PaginatedAuditLogsDto(pagination: pagination, data: logDtos);
    } catch (e) {
      print('Error fetching audit logs: $e');
      rethrow;
    }
  }

  /// Finds a specific audit log by its ID
  ///
  /// [logId] The ID of the audit log to retrieve
  /// Returns the audit log if found, null otherwise
  /// Throws [ArgumentError] if logId is invalid
  Future<AuditLogResponseDto?> getAuditLogById(int logId) async {
    if (logId < 1) {
      throw ArgumentError('Log ID must be greater than 0');
    }

    try {
      final log = await _repository.findAuditLogById(logId);
      return log != null ? _repository.toResponseDto(log) : null;
    } catch (e) {
      print('Error fetching audit log by ID: $e');
      rethrow;
    }
  }
}
