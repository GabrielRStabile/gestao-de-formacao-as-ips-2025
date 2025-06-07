// DTOs for issued certificate operations
import 'package:vaden/vaden.dart';

/// Request DTO for listing pending approval certificates
///
/// Used by formador role to list certificates that need approval
@DTO()
class ListPendingCertificatesRequestDto
    with Validator<ListPendingCertificatesRequestDto> {
  /// Optional course ID to filter certificates
  final String? courseId;

  /// Page number for pagination (default: 1)
  final int page;

  /// Number of items per page (default: 10, max: 50)
  final int limit;

  /// User ID from JWT token
  final String? userId;

  /// User email from JWT token
  final String? email;

  /// User role from JWT token
  final String? role;

  const ListPendingCertificatesRequestDto({
    this.courseId,
    required this.page,
    required this.limit,
    this.userId,
    this.email,
    this.role,
  });

  @override
  LucidValidator<ListPendingCertificatesRequestDto> validate(
    ValidatorBuilder<ListPendingCertificatesRequestDto> builder,
  ) {
    return builder
      ..ruleFor((dto) => dto.page, key: 'page').isNotNull().greaterThan(0)
      ..ruleFor(
        (dto) => dto.limit,
        key: 'limit',
      ).isNotNull().greaterThan(0).lessThan(50)
      ..ruleFor(
        (dto) => dto.role,
        key: 'role',
      ).isNotNull().equalTo((entity) => 'FORMADOR')
      ..ruleFor((dto) => dto.userId, key: 'userId').isNotNull().notEmpty();
  }
}

/// DTO representing an issued certificate
@DTO()
class IssuedCertificateDto {
  /// Unique identifier for the certificate
  final String certificateId;

  /// ID of the trainee/student user
  final String traineeUserId;

  /// ID of the enrollment
  final String enrollmentId;

  /// ID of the course
  final String courseId;

  /// Current status of the certificate
  final String status;

  /// ID of the user who approved emission (if applicable)
  final String? emissionApprovedByUserId;

  /// URL to the generated certificate blob (if applicable)
  final String? certificateBlobUrl;

  /// Verification code for the certificate (if applicable)
  final String? verificationCode;

  /// When the certificate was created
  final DateTime createdAt;

  /// When emission was approved (if applicable)
  final DateTime? emissionApprovedAt;

  /// When the certificate was issued (if applicable)
  final DateTime? issuedAt;

  /// When the record was last updated
  final DateTime updatedAt;

  const IssuedCertificateDto({
    required this.certificateId,
    required this.traineeUserId,
    required this.enrollmentId,
    required this.courseId,
    required this.status,
    this.emissionApprovedByUserId,
    this.certificateBlobUrl,
    this.verificationCode,
    required this.createdAt,
    this.emissionApprovedAt,
    this.issuedAt,
    required this.updatedAt,
  });
}

/// Response DTO for listing pending certificates
@DTO()
class ListPendingCertificatesResponseDto {
  /// List of pending certificates
  final List<IssuedCertificateDto> certificates;

  /// Pagination information
  final CertificatePaginationDto pagination;

  const ListPendingCertificatesResponseDto({
    required this.certificates,
    required this.pagination,
  });
}

/// Pagination DTO for certificate lists
@DTO()
class CertificatePaginationDto {
  /// Current page number
  final int currentPage;

  /// Number of items per page
  final int itemsPerPage;

  /// Total number of items
  final int totalItems;

  /// Total number of pages
  final int totalPages;

  /// Whether there is a next page
  final bool hasNextPage;

  /// Whether there is a previous page
  final bool hasPreviousPage;

  const CertificatePaginationDto({
    required this.currentPage,
    required this.itemsPerPage,
    required this.totalItems,
    required this.totalPages,
    required this.hasNextPage,
    required this.hasPreviousPage,
  });
}

/// DTO for approving certificate emission
@DTO()
class ApproveCertificateRequestDto
    with Validator<ApproveCertificateRequestDto> {
  /// User ID from JWT token
  final String? userId;

  /// User email from JWT token
  final String? email;

  /// User role from JWT token
  final String? role;

  const ApproveCertificateRequestDto({this.userId, this.email, this.role});

  @override
  LucidValidator<ApproveCertificateRequestDto> validate(
    ValidatorBuilder<ApproveCertificateRequestDto> builder,
  ) {
    return builder
      ..ruleFor(
        (dto) => dto.role,
        key: 'role',
      ).isNotNull().equalTo((entity) => 'FORMADOR')
      ..ruleFor((dto) => dto.userId, key: 'userId').isNotNull();
  }
}

/// Response DTO for certificate approval operations
@DTO()
class CertificateApprovalResponseDto {
  /// ID of the approved certificate
  final String certificateId;

  /// Updated status of the certificate
  final String status;

  /// Message describing the operation result
  final String message;

  const CertificateApprovalResponseDto({
    required this.certificateId,
    required this.status,
    required this.message,
  });
}

/// Request DTO for listing my certificates (formando role)
///
/// Used by formando role to list their own certificates
@DTO()
class ListMyCertificatesRequestDto
    with Validator<ListMyCertificatesRequestDto> {
  /// Optional course ID to filter certificates
  final String? courseId;

  /// Page number for pagination (default: 1)
  final int page;

  /// Number of items per page (default: 10, max: 50)
  final int limit;

  /// User ID from JWT token
  final String? userId;

  /// User email from JWT token
  final String? email;

  /// User role from JWT token
  final String? role;

  const ListMyCertificatesRequestDto({
    this.courseId,
    required this.page,
    required this.limit,
    this.userId,
    this.email,
    this.role,
  });

  @override
  LucidValidator<ListMyCertificatesRequestDto> validate(
    ValidatorBuilder<ListMyCertificatesRequestDto> builder,
  ) {
    return builder
      ..ruleFor((dto) => dto.page, key: 'page').isNotNull().greaterThan(0)
      ..ruleFor(
        (dto) => dto.limit,
        key: 'limit',
      ).isNotNull().greaterThan(0).lessThan(50)
      ..ruleFor(
        (dto) => dto.role,
        key: 'role',
      ).isNotNull().equalTo((entity) => 'FORMANDO')
      ..ruleFor((dto) => dto.userId, key: 'userId').isNotNull().notEmpty();
  }
}

/// DTO representing a certificate with course information for formando view
@DTO()
class MyCertificateDto {
  /// Unique identifier for the certificate
  final String certificateId;

  /// ID of the course
  final String courseId;

  /// Name of the course (fetched from course service)
  final String? courseName;

  /// Current status of the certificate
  final String status;

  /// URL to the generated certificate blob (if applicable)
  final String? certificateBlobUrl;

  /// Verification code for the certificate (if applicable)
  final String? verificationCode;

  /// When the certificate was issued (if applicable)
  final DateTime? issuedAt;

  /// When the certificate expires (if applicable)
  final DateTime? expiresAt;

  /// When the record was last updated
  final DateTime updatedAt;

  const MyCertificateDto({
    required this.certificateId,
    required this.courseId,
    this.courseName,
    required this.status,
    this.certificateBlobUrl,
    this.verificationCode,
    this.issuedAt,
    this.expiresAt,
    required this.updatedAt,
  });
}

/// Response DTO for listing my certificates
@DTO()
class ListMyCertificatesResponseDto {
  /// List of certificates for the formando
  final List<MyCertificateDto> certificates;

  /// Pagination information
  final CertificatePaginationDto pagination;

  const ListMyCertificatesResponseDto({
    required this.certificates,
    required this.pagination,
  });
}

/// Request DTO for downloading a certificate (formando role)
///
/// Used by formando role to download their own certificate
@DTO()
class DownloadCertificateRequestDto
    with Validator<DownloadCertificateRequestDto> {
  /// Certificate ID to download
  final String certificateId;

  /// User ID from JWT token
  final String? userId;

  /// User email from JWT token
  final String? email;

  /// User role from JWT token
  final String? role;

  const DownloadCertificateRequestDto({
    required this.certificateId,
    this.userId,
    this.email,
    this.role,
  });

  @override
  LucidValidator<DownloadCertificateRequestDto> validate(
    ValidatorBuilder<DownloadCertificateRequestDto> builder,
  ) {
    return builder
      ..ruleFor(
        (dto) => dto.certificateId,
        key: 'certificateId',
      ).isNotNull().notEmpty()
      ..ruleFor(
        (dto) => dto.role,
        key: 'role',
      ).isNotNull().equalTo((entity) => 'FORMANDO')
      ..ruleFor((dto) => dto.userId, key: 'userId').isNotNull().notEmpty();
  }
}

/// Response DTO for certificate download
@DTO()
class CertificateDownloadResponseDto {
  /// URL to redirect to for downloading the certificate
  final String downloadUrl;

  /// Certificate ID that was requested
  final String certificateId;

  /// Message about the operation
  final String message;

  const CertificateDownloadResponseDto({
    required this.downloadUrl,
    required this.certificateId,
    required this.message,
  });
}
