import 'package:audit_service/src/utils/date_time_parse.dart';
import 'package:vaden/vaden.dart';

/// Request DTO for listing audit logs with filters and pagination
///
/// Supports various filter criteria and pagination options for
/// querying audit logs from the database.
@DTO()
class ListAuditLogsRequestDto with Validator<ListAuditLogsRequestDto> {
  /// Page number for pagination (starts from 1)
  final int page;

  /// Maximum number of records per page
  final int limit;

  /// Field to sort by (eventTimestamp, sourceService, etc.)
  final String sortBy;

  /// Sort direction ('asc' or 'desc')
  final String sortOrder;

  /// Filter by events after this date
  @UseParse(DateTimeParse)
  final DateTime? startDate;

  /// Filter by events before this date
  @UseParse(DateTimeParse)
  final DateTime? endDate;

  /// Filter by user ID
  final String? userId;

  /// Filter by source service name
  final String? sourceService;

  /// Filter by event type
  final String? eventType;

  /// Filter by target entity ID
  final String? targetEntityId;

  /// Filter by target entity type
  final String? targetEntityType;

  /// Filter by IP address
  final String? ipAddress;

  /// Creates a new ListAuditLogsRequestDto with default values
  ///
  /// Default pagination: page 1, limit 20
  /// Default sorting: by eventTimestamp in descending order
  ListAuditLogsRequestDto({
    this.page = 1,
    this.limit = 20,
    this.sortBy = 'eventTimestamp',
    this.sortOrder = 'desc',
    this.startDate,
    this.endDate,
    this.userId,
    this.sourceService,
    this.eventType,
    this.targetEntityId,
    this.targetEntityType,
    this.ipAddress,
  });

  /// Validates the request parameters
  ///
  /// Ensures pagination values are valid, sort fields are allowed,
  /// and sort direction is either 'asc' or 'desc'.
  @override
  LucidValidator<ListAuditLogsRequestDto> validate(
    ValidatorBuilder<ListAuditLogsRequestDto> builder,
  ) {
    return builder
      ..ruleFor((x) => x.page, key: 'page').greaterThan(0)
      ..ruleFor((x) => x.limit, key: 'limit').greaterThan(0).lessThan(100)
      ..ruleFor((x) => x.sortBy, key: 'sortBy').notEmpty().matchesPattern(
        r'^(eventTimestamp|sourceService|eventType|userId|targetEntityId|targetEntityType)$',
      )
      ..ruleFor(
        (x) => x.sortOrder,
        key: 'sortOrder',
      ).notEmpty().matchesPattern(r'^(asc|desc)$')
      ..ruleFor((x) => x.startDate, key: 'startDate')
      ..ruleFor((x) => x.endDate, key: 'endDate')
      ..ruleFor((x) => x.userId, key: 'userId')
      ..ruleFor((x) => x.sourceService, key: 'sourceService')
      ..ruleFor((x) => x.eventType, key: 'eventType')
      ..ruleFor((x) => x.targetEntityId, key: 'targetEntityId')
      ..ruleFor((x) => x.targetEntityType, key: 'targetEntityType')
      ..ruleFor((x) => x.ipAddress, key: 'ipAddress');
  }
}

/// Response DTO for paginated audit logs
///
/// Contains the audit log data along with pagination metadata
/// to help clients navigate through large result sets.
@DTO()
class PaginatedAuditLogsDto {
  /// Pagination metadata
  final PaginationDto pagination;

  /// List of audit log entries for the current page
  final List<AuditLogResponseDto> data;

  /// Creates a new PaginatedAuditLogsDto
  ///
  /// [pagination] The pagination information
  /// [data] The audit log entries for this page
  PaginatedAuditLogsDto({required this.pagination, required this.data});
}

/// Response DTO for individual audit log entries
///
/// Represents a single audit log entry with all its fields
/// formatted for API responses.
@DTO()
class AuditLogResponseDto {
  /// Unique identifier for the audit log entry
  final int logId;

  /// Timestamp when the audited event occurred
  @UseParse(DateTimeParse)
  final DateTime eventTimestamp;

  /// Name of the service that generated the audit event
  final String sourceService;

  /// Type of event that was audited
  final String eventType;

  /// ID of the user who performed the action (optional)
  final String? userId;

  /// ID of the entity that was affected (optional)
  final String? targetEntityId;

  /// Type of the entity that was affected (optional)
  final String? targetEntityType;

  /// IP address from which the action was performed (optional)
  final String? ipAddress;

  /// Additional event details (optional)
  final Map<String, dynamic>? details;

  @UseParse(DateTimeParse)
  final DateTime createdAt;

  AuditLogResponseDto({
    required this.logId,
    required this.eventTimestamp,
    required this.sourceService,
    required this.eventType,
    this.userId,
    this.targetEntityId,
    this.targetEntityType,
    this.ipAddress,
    this.details,
    required this.createdAt,
  });
}

/// Pagination metadata for paginated responses
///
/// Contains information about the current page, total items,
/// and navigation flags to help clients implement pagination.
@DTO()
class PaginationDto {
  /// Current page number (1-based)
  final int currentPage;

  /// Number of items per page
  final int pageSize;

  /// Total number of items across all pages
  final int totalItems;

  /// Total number of pages available
  final int totalPages;

  /// Whether there is a next page available
  final bool hasNext;

  /// Whether there is a previous page available
  final bool hasPrevious;

  /// Creates a new PaginationDto
  ///
  /// [currentPage] The current page number (1-based)
  /// [pageSize] The number of items per page
  /// [totalItems] The total number of items
  /// [totalPages] The total number of pages
  /// [hasNext] Whether there is a next page
  /// [hasPrevious] Whether there is a previous page
  PaginationDto({
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
  });
}
