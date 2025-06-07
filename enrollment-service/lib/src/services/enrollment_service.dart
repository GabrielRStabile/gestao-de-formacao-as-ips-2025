import 'package:uuid/uuid.dart';
import 'package:vaden/vaden.dart';

import '../dtos/enrollment_request_dto.dart';
import '../repositories/enrollment_request_repository.dart';
import '../repositories/enrollment_status_history_repository.dart';

/// Service for managing enrollment business logic
///
/// Provides high-level operations for enrollment management,
/// including validation, status changes, and business rules.
@Service()
class EnrollmentService {
  final EnrollmentRequestRepository _enrollmentRequestRepository;
  final EnrollmentStatusHistoryRepository _enrollmentStatusHistoryRepository;
  final Uuid _uuid = const Uuid();

  /// Creates a new EnrollmentService instance
  EnrollmentService(
    this._enrollmentRequestRepository,
    this._enrollmentStatusHistoryRepository,
  );

  /// Registers a new enrollment request for a trainee
  ///
  /// [traineeUserId] The ID of the trainee user making the request
  /// [createDto] The enrollment request data
  ///
  /// Returns the created enrollment request as a response DTO
  /// Throws [Exception] if the enrollment request fails validation or creation
  Future<EnrollmentRequestResponseDto> registerEnrollment({
    required String traineeUserId,
    required EnrollmentRequestCreateDto createDto,
  }) async {
    // Validate input
    await _validateEnrollmentRequest(traineeUserId, createDto);

    // Generate unique enrollment ID
    final enrollmentId = _uuid.v4();

    try {
      // Create the enrollment request with PENDING_APPROVAL status
      final enrollmentRequest = await _enrollmentRequestRepository
          .createEnrollmentRequest(
            enrollmentId: enrollmentId,
            traineeUserId: traineeUserId,
            courseOfferingId: createDto.courseOfferingId,
            status: EnrollmentStatus.pendingApproval,
            notes: createDto.notes,
          );

      // Create initial status history record
      await _createStatusHistoryRecord(
        enrollmentId: enrollmentId,
        oldStatus: '', // No previous status for new requests
        newStatus: EnrollmentStatus.pendingApproval,
        changedByUserId: traineeUserId,
        reason: 'Solicitação de inscrição criada pelo formando',
      );

      // Convert to response DTO and return
      return EnrollmentRequestResponseDto.fromModel(enrollmentRequest);
    } catch (e) {
      throw Exception('Failed to register enrollment: ${e.toString()}');
    }
  }

  /// Gets enrollment requests for a specific trainee
  ///
  /// [traineeUserId] The trainee user ID
  ///
  /// Returns a list of enrollment requests for the trainee
  Future<List<EnrollmentRequestResponseDto>> getEnrollmentsByTraineeId(
    String traineeUserId,
  ) async {
    try {
      final enrollmentRequests = await _enrollmentRequestRepository
          .getEnrollmentRequestsByTraineeId(traineeUserId);

      return enrollmentRequests
          .map((request) => EnrollmentRequestResponseDto.fromModel(request))
          .toList();
    } catch (e) {
      throw Exception('Failed to get enrollments for trainee: ${e.toString()}');
    }
  }

  /// Gets a specific enrollment request by ID
  ///
  /// [enrollmentId] The enrollment request ID
  ///
  /// Returns the enrollment request if found, null otherwise
  Future<EnrollmentRequestResponseDto?> getEnrollmentById(
    String enrollmentId,
  ) async {
    try {
      final enrollmentRequest = await _enrollmentRequestRepository
          .getEnrollmentRequestById(enrollmentId);

      if (enrollmentRequest == null) {
        return null;
      }

      return EnrollmentRequestResponseDto.fromModel(enrollmentRequest);
    } catch (e) {
      throw Exception('Failed to get enrollment by ID: ${e.toString()}');
    }
  }

  /// Updates the status of an enrollment request
  ///
  /// [enrollmentId] The enrollment request ID
  /// [newStatus] The new status to set
  /// [changedByUserId] The user ID making the change
  /// [reason] Optional reason for the status change
  /// [rejectionReason] Optional rejection reason if status is REJECTED
  ///
  /// Returns the updated enrollment request
  Future<EnrollmentRequestResponseDto> updateEnrollmentStatus({
    required String enrollmentId,
    required String newStatus,
    required String changedByUserId,
    String? reason,
    String? rejectionReason,
  }) async {
    // Validate the new status
    if (!EnrollmentStatus.isValid(newStatus)) {
      throw Exception('Invalid enrollment status: $newStatus');
    }

    try {
      // Get the current enrollment to track status change
      final currentEnrollment = await _enrollmentRequestRepository
          .getEnrollmentRequestById(enrollmentId);

      if (currentEnrollment == null) {
        throw Exception('Enrollment request not found');
      }

      final oldStatus = currentEnrollment.status;

      // Update the enrollment status
      await _enrollmentRequestRepository.updateEnrollmentStatus(
        enrollmentId: enrollmentId,
        newStatus: newStatus,
        managerUserId: changedByUserId,
        rejectionReason: rejectionReason,
        notes: reason,
      );

      // Create status history record
      await _createStatusHistoryRecord(
        enrollmentId: enrollmentId,
        oldStatus: oldStatus,
        newStatus: newStatus,
        changedByUserId: changedByUserId,
        reason: reason ?? _getDefaultReasonForStatus(newStatus),
      );

      // Get and return the updated enrollment
      final updatedEnrollment = await _enrollmentRequestRepository
          .getEnrollmentRequestById(enrollmentId);

      return EnrollmentRequestResponseDto.fromModel(updatedEnrollment!);
    } catch (e) {
      throw Exception('Failed to update enrollment status: ${e.toString()}');
    }
  }

  /// Cancels an enrollment request by the trainee
  ///
  /// [enrollmentId] The enrollment request ID
  /// [traineeUserId] The trainee user ID making the cancellation
  /// [reason] Optional reason for cancellation
  ///
  /// Returns the updated enrollment request
  Future<EnrollmentRequestResponseDto> cancelEnrollmentByTrainee({
    required String enrollmentId,
    required String traineeUserId,
    String? reason,
  }) async {
    return updateEnrollmentStatus(
      enrollmentId: enrollmentId,
      newStatus: EnrollmentStatus.cancelledByTrainee,
      changedByUserId: traineeUserId,
      reason: reason ?? 'Cancelado pelo formando',
    );
  }

  /// Gets enrollment requests for a specific trainee with pagination and filters
  ///
  /// [traineeUserId] The ID of the trainee user
  /// [queryDto] Query parameters for pagination and filtering
  ///
  /// Returns paginated enrollment requests for the trainee
  Future<PaginatedEnrollmentsDto> getMyEnrollments({
    required String traineeUserId,
    required MyEnrollmentsQueryDto queryDto,
  }) async {
    // Validate trainee user ID
    if (traineeUserId.trim().isEmpty) {
      throw Exception('Trainee user ID cannot be empty');
    }

    try {
      // Get paginated enrollments from repository
      final result = await _enrollmentRequestRepository
          .getEnrollmentsByTraineeWithPagination(
            traineeUserId: traineeUserId,
            page: queryDto.page,
            limit: queryDto.limit,
            status: queryDto.status,
            sortBy: queryDto.sortBy,
            sortOrder: queryDto.sortOrder,
          );

      // Create pagination metadata
      final pagination = PaginationDto.fromQuery(
        page: queryDto.page,
        limit: queryDto.limit,
        totalItems: result.totalItems,
      );

      // Convert enrollment requests to response DTOs
      final enrollmentDtos =
          result.enrollments
              .map(
                (enrollment) =>
                    EnrollmentRequestResponseDto.fromModel(enrollment),
              )
              .toList();

      return PaginatedEnrollmentsDto(
        pagination: pagination,
        data: enrollmentDtos,
      );
    } catch (e) {
      throw Exception('Failed to get enrollment requests: ${e.toString()}');
    }
  }

  /// Validates an enrollment request before creation
  ///
  /// [traineeUserId] The trainee user ID
  /// [createDto] The enrollment request data
  ///
  /// Throws [Exception] if validation fails
  Future<void> _validateEnrollmentRequest(
    String traineeUserId,
    EnrollmentRequestCreateDto createDto,
  ) async {
    // Validate trainee user ID
    if (traineeUserId.trim().isEmpty) {
      throw Exception('Trainee user ID cannot be empty');
    }

    // Validate course offering ID
    if (createDto.courseOfferingId.trim().isEmpty) {
      throw Exception('Course offering ID cannot be empty');
    }

    // Check if trainee already has an active enrollment for this course offering
    final existingEnrollments = await _enrollmentRequestRepository
        .getEnrollmentRequestsByTraineeId(traineeUserId);

    final activeEnrollmentExists = existingEnrollments.any(
      (enrollment) =>
          enrollment.courseOfferingId == createDto.courseOfferingId &&
          (enrollment.status == EnrollmentStatus.pendingApproval ||
              enrollment.status == EnrollmentStatus.approved),
    );

    if (activeEnrollmentExists) {
      throw Exception(
        'Trainee already has an active enrollment for this course offering',
      );
    }

    // TODO: Add additional validations:
    // - Check if course offering exists and is available for enrollment
    // - Check if trainee meets prerequisites
    // - Check if course offering has available spots
    // - Validate enrollment period/deadlines
  }

  /// Creates a status history record for an enrollment status change
  ///
  /// [enrollmentId] The enrollment request ID
  /// [oldStatus] The previous status
  /// [newStatus] The new status
  /// [changedByUserId] The user making the change
  /// [reason] The reason for the change
  Future<void> _createStatusHistoryRecord({
    required String enrollmentId,
    required String oldStatus,
    required String newStatus,
    required String changedByUserId,
    required String reason,
  }) async {
    final historyId = _uuid.v4();

    await _enrollmentStatusHistoryRepository.createStatusHistoryRecord(
      historyId: historyId,
      enrollmentId: enrollmentId,
      oldStatus: oldStatus,
      newStatus: newStatus,
      changedByUserId: changedByUserId,
      reason: reason,
    );
  }

  /// Gets default reason text for a status change
  String _getDefaultReasonForStatus(String status) {
    switch (status) {
      case EnrollmentStatus.approved:
        return 'Aprovado pelo gestor';
      case EnrollmentStatus.rejected:
        return 'Rejeitado pelo gestor';
      case EnrollmentStatus.cancelledByTrainee:
        return 'Cancelado pelo formando';
      case EnrollmentStatus.cancelledBySystem:
        return 'Cancelado pelo sistema';
      case EnrollmentStatus.completed:
        return 'Formação concluída';
      case EnrollmentStatus.pendingApproval:
        return 'Aguardando aprovação';
      default:
        return 'Alteração de status';
    }
  }
}
