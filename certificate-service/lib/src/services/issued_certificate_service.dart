import 'package:vaden/vaden.dart';

import '../dtos/issued_certificate_dtos.dart';
import '../models/database.dart';
import '../repositories/issued_certificate_repository.dart';
import 'event_publisher.dart';

/// Service for managing issued certificate operations
///
/// Provides business logic for listing and managing issued certificates.
/// Handles role validation and data transformation.
@Service()
class IssuedCertificateService {
  final IssuedCertificateRepository _issuedCertificateRepository;
  final EventPublisher _eventPublisher;

  /// Creates a new IssuedCertificateService instance
  IssuedCertificateService(
    this._issuedCertificateRepository,
    this._eventPublisher,
  );

  /// Lists pending approval certificates for formador role
  ///
  /// [request] The request containing filtering and pagination parameters
  ///
  /// Returns a paginated list of pending certificates
  /// Throws [UnauthorizedException] if user is not formador
  /// Throws [Exception] if there's an error retrieving certificates
  Future<ListPendingCertificatesResponseDto> listPendingCertificates(
    ListPendingCertificatesRequestDto request,
  ) async {
    try {
      // Validate role authorization
      if (request.role != 'FORMADOR') {
        throw UnauthorizedException(
          'Only formador can access pending certificates',
        );
      }

      // Get certificates with pagination
      final certificates = await _issuedCertificateRepository
          .getPendingCertificatesWithPagination(
            courseId: request.courseId,
            page: request.page,
            limit: request.limit,
          );

      // Get total count for pagination
      final totalCount = await _issuedCertificateRepository
          .getPendingCertificatesCount(courseId: request.courseId);

      // Transform to DTOs
      final certificateDtos =
          certificates.map((cert) => _certificateToDto(cert)).toList();

      // Calculate pagination data
      final totalPages = (totalCount / request.limit).ceil();
      final pagination = CertificatePaginationDto(
        currentPage: request.page,
        itemsPerPage: request.limit,
        totalItems: totalCount,
        totalPages: totalPages,
        hasNextPage: request.page < totalPages,
        hasPreviousPage: request.page > 1,
      );

      return ListPendingCertificatesResponseDto(
        certificates: certificateDtos,
        pagination: pagination,
      );
    } catch (e) {
      if (e is UnauthorizedException) {
        rethrow;
      }
      throw Exception('Failed to list pending certificates: ${e.toString()}');
    }
  }

  /// Approves a certificate for emission
  ///
  /// [certificateId] The ID of the certificate to approve
  /// [request] The request containing user context
  ///
  /// Returns the approval response
  /// Throws [UnauthorizedException] if user is not formador
  /// Throws [NotFoundException] if certificate is not found
  /// Throws [ValidationException] if certificate is not in pending status
  Future<CertificateApprovalResponseDto> approveCertificate(
    String certificateId,
    ApproveCertificateRequestDto request,
  ) async {
    try {
      // Validate role authorization
      if (request.role != 'FORMADOR') {
        throw UnauthorizedException('Only formador can approve certificates');
      }

      // Get current certificate
      final currentCertificate = await _issuedCertificateRepository
          .getCertificateById(certificateId);

      if (currentCertificate == null) {
        throw NotFoundException('Certificate not found');
      }

      // Validate current status
      if (currentCertificate.status != 'PENDING_APPROVAL') {
        throw ValidationException(
          'Certificate is not in pending approval status. Current status: ${currentCertificate.status}',
        );
      }

      // Update certificate status to approved
      final updatedCertificate = await _issuedCertificateRepository
          .updateCertificateStatus(
            certificateId: certificateId,
            status: 'APPROVED_FOR_EMISSION',
            emissionApprovedByUserId: request.userId,
          );

      if (updatedCertificate == null) {
        throw Exception('Failed to update certificate status');
      }

      // Publish certificate approved event
      try {
        await _eventPublisher.publishCertificateApproved(
          certificateId: certificateId,
          traineeUserId: currentCertificate.traineeUserId,
          courseId: currentCertificate.courseId,
          approvedByUserId: request.userId!,
          status: 'APPROVED_FOR_EMISSION',
        );
      } catch (eventError) {
        // Log the error but don't fail the operation
        print('Failed to publish certificate approved event: $eventError');
      }

      return CertificateApprovalResponseDto(
        certificateId: certificateId,
        status: 'APPROVED_FOR_EMISSION',
        message: 'Certificate approved for emission successfully',
      );
    } catch (e) {
      if (e is UnauthorizedException ||
          e is NotFoundException ||
          e is ValidationException) {
        rethrow;
      }
      throw Exception('Failed to approve certificate: ${e.toString()}');
    }
  }

  /// Lists certificates for formando role (my certificates)
  ///
  /// [request] The request containing filtering and pagination parameters
  ///
  /// Returns a paginated list of the formando's certificates
  /// Throws [UnauthorizedException] if user is not formando
  /// Throws [Exception] if there's an error retrieving certificates
  Future<ListMyCertificatesResponseDto> listMyCertificates(
    ListMyCertificatesRequestDto request,
  ) async {
    try {
      // Validate role authorization
      if (request.role != 'FORMANDO') {
        throw UnauthorizedException(
          'Only formando can access their own certificates',
        );
      }

      // Validate user ID is present
      if (request.userId == null || request.userId!.isEmpty) {
        throw ValidationException('User ID is required');
      }

      // Get certificates with pagination
      final certificates = await _issuedCertificateRepository
          .getTraineeCertificatesWithPagination(
            traineeUserId: request.userId!,
            courseId: request.courseId,
            page: request.page,
            limit: request.limit,
          );

      // Get total count for pagination
      final totalCount = await _issuedCertificateRepository
          .getTraineeCertificatesCount(
            traineeUserId: request.userId!,
            courseId: request.courseId,
          );

      // Transform to DTOs
      final certificateDtos =
          certificates
              .map((cert) => _certificateToMyCertificateDto(cert))
              .toList();

      // Calculate pagination data
      final totalPages = (totalCount / request.limit).ceil();
      final pagination = CertificatePaginationDto(
        currentPage: request.page,
        itemsPerPage: request.limit,
        totalItems: totalCount,
        totalPages: totalPages,
        hasNextPage: request.page < totalPages,
        hasPreviousPage: request.page > 1,
      );

      return ListMyCertificatesResponseDto(
        certificates: certificateDtos,
        pagination: pagination,
      );
    } catch (e) {
      if (e is UnauthorizedException || e is ValidationException) {
        rethrow;
      }
      throw Exception('Failed to list my certificates: ${e.toString()}');
    }
  }

  /// Downloads a certificate for formando role
  ///
  /// [request] The request containing certificate ID and user context
  ///
  /// Returns the download response with redirect URL
  /// Throws [UnauthorizedException] if user is not formando
  /// Throws [NotFoundException] if certificate is not found
  /// Throws [ValidationException] if certificate cannot be downloaded
  Future<CertificateDownloadResponseDto> downloadCertificate(
    DownloadCertificateRequestDto request,
  ) async {
    try {
      // Validate role authorization
      if (request.role != 'FORMANDO') {
        throw UnauthorizedException('Only formando can download certificates');
      }

      // Validate user ID is present
      if (request.userId == null || request.userId!.isEmpty) {
        throw ValidationException('User ID is required');
      }

      // Get certificate
      final certificate = await _issuedCertificateRepository.getCertificateById(
        request.certificateId,
      );

      if (certificate == null) {
        throw NotFoundException('Certificate not found');
      }

      // Validate that the certificate belongs to the requesting user
      if (certificate.traineeUserId != request.userId) {
        throw UnauthorizedException(
          'Formando tentando baixar certificado de outro formando',
        );
      }

      // Validate certificate status and blob URL
      if (certificate.status != 'ISSUED') {
        throw NotFoundException('certificateId não foi aprovado pelo formador');
      }

      if (certificate.certificateBlobUrl == null ||
          certificate.certificateBlobUrl!.isEmpty) {
        throw NotFoundException(
          'certificateId não tem blobUrl (não foi emitido)',
        );
      }

      return CertificateDownloadResponseDto(
        downloadUrl: certificate.certificateBlobUrl!,
        certificateId: request.certificateId,
        message: 'Certificate download URL retrieved successfully',
      );
    } catch (e) {
      if (e is UnauthorizedException ||
          e is NotFoundException ||
          e is ValidationException) {
        rethrow;
      }
      throw Exception('Failed to download certificate: ${e.toString()}');
    }
  }

  /// Converts an IssuedCertificate model to DTO
  ///
  /// [certificate] The certificate model to convert
  ///
  /// Returns the certificate DTO
  IssuedCertificateDto _certificateToDto(IssuedCertificate certificate) {
    return IssuedCertificateDto(
      certificateId: certificate.certificateId,
      traineeUserId: certificate.traineeUserId,
      enrollmentId: certificate.enrollmentId,
      courseId: certificate.courseId,
      status: certificate.status,
      emissionApprovedByUserId: certificate.emissionApprovedByUserId,
      certificateBlobUrl: certificate.certificateBlobUrl,
      verificationCode: certificate.verificationCode,
      createdAt: certificate.createdAt.dateTime,
      emissionApprovedAt: certificate.emissionApprovedAt?.dateTime,
      issuedAt: certificate.issuedAt?.dateTime,
      updatedAt: certificate.updatedAt.dateTime,
    );
  }

  /// Converts an IssuedCertificate model to MyCertificateDto for formando view
  ///
  /// [certificate] The certificate model to convert
  ///
  /// Returns the MyCertificateDto
  MyCertificateDto _certificateToMyCertificateDto(
    IssuedCertificate certificate,
  ) {
    return MyCertificateDto(
      certificateId: certificate.certificateId,
      courseId: certificate.courseId,
      status: certificate.status,
      certificateBlobUrl: certificate.certificateBlobUrl,
      verificationCode: certificate.verificationCode,
      issuedAt: certificate.issuedAt?.dateTime,
      updatedAt: certificate.updatedAt.dateTime,
    );
  }
}

/// Exception thrown when user is not authorized
class UnauthorizedException implements Exception {
  final String message;

  const UnauthorizedException(this.message);

  @override
  String toString() => 'UnauthorizedException: $message';
}

/// Exception thrown when a resource is not found
class NotFoundException implements Exception {
  final String message;

  const NotFoundException(this.message);

  @override
  String toString() => 'NotFoundException: $message';
}

/// Exception thrown when validation fails
class ValidationException implements Exception {
  final String message;

  const ValidationException(this.message);

  @override
  String toString() => 'ValidationException: $message';
}
