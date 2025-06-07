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

  /// Creates an instance from JSON data
  factory EnrollmentRequestCreateDto.fromJson(Map<String, dynamic> json) {
    return EnrollmentRequestCreateDto(
      courseOfferingId: json['courseOfferingId'] as String,
      notes: json['notes'] as String?,
    );
  }

  /// Converts the instance to JSON
  Map<String, dynamic> toJson() {
    return {'courseOfferingId': courseOfferingId, 'notes': notes};
  }

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

  /// Converts the instance to JSON
  Map<String, dynamic> toJson() {
    return {
      'enrollmentId': enrollmentId,
      'traineeUserId': traineeUserId,
      'courseOfferingId': courseOfferingId,
      'status': status,
      'requestDate': requestDate.toIso8601String(),
      'decisionDate': decisionDate?.toIso8601String(),
      'managerUserId': managerUserId,
      'rejectionReason': rejectionReason,
      'updatedAt': updatedAt.toIso8601String(),
      'notes': notes,
    };
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

  /// Creates an instance from JSON data
  factory EnrollmentCancelDto.fromJson(Map<String, dynamic> json) {
    return EnrollmentCancelDto(reason: json['reason'] as String?);
  }

  /// Converts the instance to JSON
  Map<String, dynamic> toJson() {
    return {'reason': reason};
  }

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
