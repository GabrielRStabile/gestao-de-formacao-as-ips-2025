import 'package:drift_postgres/drift_postgres.dart';
import 'package:vaden/vaden.dart';

/// Data Transfer Object for enrollment request creation
///
/// Used for receiving enrollment registration requests from clients.
/// Contains only the necessary fields for creating a new enrollment.
@DTO()
class EnrollmentRequestCreateDto with Validator<EnrollmentRequestCreateDto> {
  /// ID of the course offering to enroll in
  final String courseOfferingId;

  /// Optional notes from the trainee about the enrollment
  final String? notes;

  const EnrollmentRequestCreateDto({
    required this.courseOfferingId,
    this.notes,
  });

  /// Validates the DTO using the Vaden validation framework
  @override
  LucidValidator<EnrollmentRequestCreateDto> validate(
    ValidatorBuilder<EnrollmentRequestCreateDto> builder,
  ) {
    return builder
      ..ruleFor(
        (r) => r.courseOfferingId,
        key: 'courseOfferingId',
      ).notEmptyOrNull().minLength(1).maxLength(100)
      ..ruleFor(
        (r) => r.notes,
        key: 'notes',
      ).maxLength(500).when((r) => r.notes != null);
  }
}

/// Data Transfer Object for enrollment request responses
///
/// Used for sending enrollment request data to clients.
/// Contains complete enrollment information including status and timestamps.
class EnrollmentRequestResponseDto {
  /// Unique enrollment request identifier
  final String enrollmentId;

  /// ID of the trainee/student user
  final String traineeUserId;

  /// ID of the course offering
  final String courseOfferingId;

  /// Current enrollment status
  final String status;

  /// When the enrollment request was created
  final DateTime requestDate;

  /// When the enrollment decision was made (if any)
  final DateTime? decisionDate;

  /// ID of the manager who made the decision (if any)
  final String? managerUserId;

  /// Reason for rejection if status is REJECTED
  final String? rejectionReason;

  /// When the enrollment record was last updated
  final DateTime updatedAt;

  /// Additional notes about the enrollment
  final String? notes;

  const EnrollmentRequestResponseDto({
    required this.enrollmentId,
    required this.traineeUserId,
    required this.courseOfferingId,
    required this.status,
    required this.requestDate,
    this.decisionDate,
    this.managerUserId,
    this.rejectionReason,
    required this.updatedAt,
    this.notes,
  });

  /// Creates an instance from an EnrollmentRequest database model
  factory EnrollmentRequestResponseDto.fromModel(dynamic enrollmentRequest) {
    return EnrollmentRequestResponseDto(
      enrollmentId: enrollmentRequest.enrollmentId,
      traineeUserId: enrollmentRequest.traineeUserId,
      courseOfferingId: enrollmentRequest.courseOfferingId,
      status: enrollmentRequest.status,
      requestDate: (enrollmentRequest.requestDate as PgDateTime).toDateTime(),
      decisionDate:
          enrollmentRequest.decisionDate != null
              ? (enrollmentRequest.decisionDate as PgDateTime).toDateTime()
              : null,
      managerUserId: enrollmentRequest.managerUserId,
      rejectionReason: enrollmentRequest.rejectionReason,
      updatedAt: (enrollmentRequest.updatedAt as PgDateTime).toDateTime(),
      notes: enrollmentRequest.notes,
    );
  }
}

/// Data Transfer Object for enrollment status enumeration
///
/// Provides a type-safe way to work with enrollment statuses.
class EnrollmentStatus {
  /// Status values that can be used for enrollment requests
  static const String pendingApproval = 'PENDING_APPROVAL';
  static const String approved = 'APPROVED';
  static const String rejected = 'REJECTED';
  static const String cancelledByTrainee = 'CANCELLED_BY_TRAINEE';
  static const String cancelledBySystem = 'CANCELLED_BY_SYSTEM';
  static const String completed = 'COMPLETED';

  /// List of all valid status values
  static const List<String> validStatuses = [
    pendingApproval,
    approved,
    rejected,
    cancelledByTrainee,
    cancelledBySystem,
    completed,
  ];

  /// Validates if a status value is valid
  static bool isValid(String status) {
    return validStatuses.contains(status);
  }
}

/// Data Transfer Object for enrollment cancellation requests
///
/// Used for receiving cancellation requests from trainees.
/// Contains optional reason for the cancellation.
@DTO()
class EnrollmentCancelDto with Validator<EnrollmentCancelDto> {
  /// Optional reason for the cancellation
  final String? reason;

  const EnrollmentCancelDto({this.reason});

  /// Validates the DTO using the Vaden validation framework
  @override
  LucidValidator<EnrollmentCancelDto> validate(
    ValidatorBuilder<EnrollmentCancelDto> builder,
  ) {
    return builder
      ..ruleFor(
        (r) => r.reason,
        key: 'reason',
      ).maxLength(500).when((r) => r.reason != null);
  }
}

/// Data Transfer Object for querying trainee enrollments with pagination
///
/// Used for GET /my-enrollments endpoint to support filtering, sorting, and pagination.
@DTO()
class MyEnrollmentsQueryDto with Validator<MyEnrollmentsQueryDto> {
  /// Page number (1-based)
  final int page;

  /// Number of items per page
  final int limit;

  /// Sort field (requestDate, status, updatedAt)
  final String sortBy;

  /// Sort direction (asc, desc)
  final String sortOrder;

  /// Filter by enrollment status (optional)
  final String? status;

  /// Gets the offset for database queries
  int get offset => (page - 1) * limit;

  const MyEnrollmentsQueryDto({
    this.page = 1,
    this.limit = 10,
    this.sortBy = 'requestDate',
    this.sortOrder = 'desc',
    this.status,
  });

  /// Creates an instance from query parameters
  factory MyEnrollmentsQueryDto.fromQueryParams(Map<String, String> params) {
    return MyEnrollmentsQueryDto(
      page: int.tryParse(params['page'] ?? '1') ?? 1,
      limit: int.tryParse(params['limit'] ?? '10') ?? 10,
      sortBy: params['sortBy'] ?? 'requestDate',
      sortOrder: params['sortOrder'] ?? 'desc',
      status: params['status'],
    );
  }

  /// Validates the query parameters
  @override
  LucidValidator<MyEnrollmentsQueryDto> validate(
    ValidatorBuilder<MyEnrollmentsQueryDto> builder,
  ) {
    return builder
      ..ruleFor((r) => r.page, key: 'page').greaterThan(0)
      ..ruleFor((r) => r.limit, key: 'limit').greaterThan(0).lessThan(100)
      ..ruleFor((r) => r.sortBy, key: 'sortBy').must(
        (value) => ['requestDate', 'status', 'updatedAt'].contains(value),
        'Invalid sort field',
        '400',
      )
      ..ruleFor((r) => r.sortOrder, key: 'sortOrder').must(
        (value) => value == 'asc' || value == 'desc',
        'Invalid sort order',
        '400',
      )
      ..ruleFor((r) => r.status, key: 'status')
          .must(
            (value) => value == null || EnrollmentStatus.isValid(value),
            'Invalid status',
            '400',
          )
          .when((r) => r.status != null);
  }
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

  const PaginationDto({
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
    required this.hasNext,
    required this.hasPrevious,
  });

  /// Creates pagination from query parameters and total count
  factory PaginationDto.fromQuery({
    required int page,
    required int limit,
    required int totalItems,
  }) {
    final totalPages = (totalItems / limit).ceil();
    return PaginationDto(
      currentPage: page,
      pageSize: limit,
      totalItems: totalItems,
      totalPages: totalPages,
      hasNext: page < totalPages,
      hasPrevious: page > 1,
    );
  }
}

/// Response DTO for paginated enrollment requests
///
/// Contains the enrollment data along with pagination metadata
/// to help clients navigate through large result sets.
@DTO()
class PaginatedEnrollmentsDto {
  /// Pagination metadata
  final PaginationDto pagination;

  /// List of enrollment entries for the current page
  final List<EnrollmentRequestResponseDto> data;

  const PaginatedEnrollmentsDto({required this.pagination, required this.data});
}

/// Data Transfer Object for manager enrollment queries
///
/// Used by managers to list all enrollment requests with filtering,
/// sorting, and pagination options.
@DTO()
class ManagerEnrollmentsQueryDto with Validator<ManagerEnrollmentsQueryDto> {
  /// Page number for pagination (starting from 1)
  final int page;

  /// Number of items per page (max 100)
  final int pageSize;

  /// Filter by enrollment status
  final String? status;

  /// Filter by trainee ID
  final String? traineeId;

  /// Filter by course offering ID
  final String? courseOfferingId;

  /// Field to sort by
  final String sortBy;

  /// Sort order (asc or desc)
  final String sortOrder;

  /// Start date for filtering by request date (ISO 8601 format)
  final String? startDate;

  /// End date for filtering by request date (ISO 8601 format)
  final String? endDate;

  const ManagerEnrollmentsQueryDto({
    this.page = 1,
    this.pageSize = 10,
    this.status,
    this.traineeId,
    this.courseOfferingId,
    this.sortBy = 'requestDate',
    this.sortOrder = 'desc',
    this.startDate,
    this.endDate,
  });

  /// Creates an instance from query parameters
  factory ManagerEnrollmentsQueryDto.fromQuery(Map<String, String> query) {
    return ManagerEnrollmentsQueryDto(
      page: int.tryParse(query['page'] ?? '1') ?? 1,
      pageSize: int.tryParse(query['pageSize'] ?? '10') ?? 10,
      status: query['status'],
      traineeId: query['traineeId'],
      courseOfferingId: query['courseOfferingId'],
      sortBy: query['sortBy'] ?? 'requestDate',
      sortOrder: query['sortOrder'] ?? 'desc',
      startDate: query['startDate'],
      endDate: query['endDate'],
    );
  }

  /// Validates the query parameters using the Vaden validation framework
  @override
  LucidValidator<ManagerEnrollmentsQueryDto> validate(
    ValidatorBuilder<ManagerEnrollmentsQueryDto> builder,
  ) {
    return builder
      ..ruleFor((r) => r.page, key: 'page').greaterThan(0)
      ..ruleFor((r) => r.pageSize, key: 'pageSize').greaterThan(0).lessThan(101)
      ..ruleFor((r) => r.sortBy, key: 'sortBy').must(
        (value) => [
          'requestDate',
          'status',
          'updatedAt',
          'traineeId',
          'courseOfferingId',
        ].contains(value),
        'Invalid sort field',
        '400',
      )
      ..ruleFor((r) => r.sortOrder, key: 'sortOrder').must(
        (value) => value == 'asc' || value == 'desc',
        'Invalid sort order',
        '400',
      )
      ..ruleFor((r) => r.status, key: 'status')
          .must(
            (value) => value == null || EnrollmentStatus.isValid(value),
            'Invalid status',
            '400',
          )
          .when((r) => r.status != null)
      ..ruleFor(
        (r) => r.traineeId,
        key: 'traineeId',
      ).minLength(1).maxLength(100).when((r) => r.traineeId != null)
      ..ruleFor(
        (r) => r.courseOfferingId,
        key: 'courseOfferingId',
      ).minLength(1).maxLength(100).when((r) => r.courseOfferingId != null)
      ..ruleFor((r) => r.startDate, key: 'startDate')
          .must(
            (value) => value == null || DateTime.tryParse(value) != null,
            'Invalid start date format (ISO 8601 required)',
            '400',
          )
          .when((r) => r.startDate != null)
      ..ruleFor((r) => r.endDate, key: 'endDate')
          .must(
            (value) => value == null || DateTime.tryParse(value) != null,
            'Invalid end date format (ISO 8601 required)',
            '400',
          )
          .when((r) => r.endDate != null);
  }
}

/// Data Transfer Object for enrollment status history entry
///
/// Represents a single status change in the enrollment history.
class EnrollmentStatusHistoryDto {
  /// Unique history record identifier
  final String historyId;

  /// Previous status before the change
  final String oldStatus;

  /// New status after the change
  final String newStatus;

  /// When the status change occurred
  final DateTime changedAt;

  /// ID of the user who made the change (nullable)
  final String? changedByUserId;

  /// Reason for the status change (nullable)
  final String? reason;

  const EnrollmentStatusHistoryDto({
    required this.historyId,
    required this.oldStatus,
    required this.newStatus,
    required this.changedAt,
    this.changedByUserId,
    this.reason,
  });

  /// Creates an instance from an EnrollmentStatusHistory database model
  factory EnrollmentStatusHistoryDto.fromModel(dynamic statusHistory) {
    return EnrollmentStatusHistoryDto(
      historyId: statusHistory.historyId,
      oldStatus: statusHistory.oldStatus,
      newStatus: statusHistory.newStatus,
      changedAt: (statusHistory.changedAt as PgDateTime).toDateTime(),
      changedByUserId: statusHistory.changedByUserId,
      reason: statusHistory.reason,
    );
  }
}

/// Data Transfer Object for enrollment details with status history
///
/// Used for sending comprehensive enrollment information including
/// enrollment details and complete status change history.
class EnrollmentDetailsResponseDto {
  /// Enrollment request details
  final EnrollmentRequestResponseDto enrollment;

  /// Complete status change history ordered by most recent first
  final List<EnrollmentStatusHistoryDto> statusHistory;

  const EnrollmentDetailsResponseDto({
    required this.enrollment,
    required this.statusHistory,
  });

  /// Creates an instance from enrollment and status history models
  factory EnrollmentDetailsResponseDto.fromModels({
    required dynamic enrollmentRequest,
    required List<dynamic> statusHistoryRecords,
  }) {
    return EnrollmentDetailsResponseDto(
      enrollment: EnrollmentRequestResponseDto.fromModel(enrollmentRequest),
      statusHistory:
          statusHistoryRecords
              .map((history) => EnrollmentStatusHistoryDto.fromModel(history))
              .toList(),
    );
  }
}

/// Data Transfer Object for enrollment approval requests
///
/// Used for receiving approval requests from managers.
/// Contains optional notes for the approval.
@DTO()
class EnrollmentApproveDto with Validator<EnrollmentApproveDto> {
  /// Optional notes for the approval
  final String? notes;

  const EnrollmentApproveDto({this.notes});

  /// Validates the DTO using the Vaden validation framework
  @override
  LucidValidator<EnrollmentApproveDto> validate(
    ValidatorBuilder<EnrollmentApproveDto> builder,
  ) {
    return builder
      ..ruleFor(
        (r) => r.notes,
        key: 'notes',
      ).maxLength(500).when((r) => r.notes != null);
  }
}
