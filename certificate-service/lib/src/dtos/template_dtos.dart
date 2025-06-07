import 'dart:typed_data';

import 'package:certificate_service/src/utils/date_time_parse.dart';
import 'package:vaden/vaden.dart';

import '../models/database.dart';

/// Request DTO for listing templates with optional filters and pagination
@DTO()
class ListTemplatesRequestDto with Validator<ListTemplatesRequestDto> {
  /// Filter templates by course ID (optional)
  final String? courseId;

  /// Filter templates by active status (optional)
  final bool? isActive;

  /// Page number for pagination (default: 1)
  final int? page;

  /// Number of items per page (default: 10)
  final int? limit;

  /// User ID from token context (set by middleware)
  final String? userId;

  /// User email from token context (set by middleware)
  final String? email;

  /// User role from token context (set by middleware)
  final String? role;

  /// Gets the offset for database queries
  int get offset => (page! - 1) * limit!;

  const ListTemplatesRequestDto({
    this.courseId,
    this.isActive,
    this.page = 1,
    this.limit = 10,
    this.userId,
    this.email,
    this.role,
  });

  @override
  LucidValidator<ListTemplatesRequestDto> validate(
    ValidatorBuilder<ListTemplatesRequestDto> builder,
  ) {
    return builder
      ..ruleFor(
        (r) => r.courseId,
        key: 'courseId',
      ).isNotNull().minLength(1).maxLength(100).when((r) => r.courseId != null)
      ..ruleFor(
        (r) => r.page,
        key: 'page',
      ).isNotNull().greaterThan(0).when((r) => r.page != null)
      ..ruleFor(
        (r) => r.limit,
        key: 'limit',
      ).isNotNull().greaterThan(0).lessThan(100).when((r) => r.limit != null);
  }

  /// Creates a new instance with token context data
  ListTemplatesRequestDto copyWithContext({
    String? userId,
    String? email,
    String? role,
  }) {
    return ListTemplatesRequestDto(
      courseId: courseId,
      isActive: isActive,
      page: page,
      limit: limit,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }
}

/// Response DTO for template data
@DTO()
class TemplateDto {
  /// Unique template identifier
  final String templateId;

  /// Course identifier that this template belongs to
  final String courseId;

  /// Name of the template
  final String templateName;

  /// URL/Key for PDF template stored in storage
  final String templateBlobUrl;

  /// ID of the user who uploaded this template
  final String uploadedByUserId;

  /// Timestamp when the template was created
  @UseParse(DateTimeParse)
  final DateTime createdAt;

  /// Timestamp when the template was last updated
  @UseParse(DateTimeParse)
  final DateTime updatedAt;

  const TemplateDto({
    required this.templateId,
    required this.courseId,
    required this.templateName,
    required this.templateBlobUrl,
    required this.uploadedByUserId,
    required this.createdAt,
    required this.updatedAt,
  });
}

/// Pagination information DTO
@DTO()
class PaginationDto {
  /// Current page number
  final int currentPage;

  /// Number of items per page
  final int pageSize;

  /// Total number of items
  final int totalItems;

  /// Total number of pages
  final int totalPages;

  const PaginationDto({
    required this.currentPage,
    required this.pageSize,
    required this.totalItems,
    required this.totalPages,
  });
}

/// Response DTO for listing templates with pagination
@DTO()
class ListTemplatesResponseDto {
  /// Pagination information
  final PaginationDto pagination;

  /// List of templates
  final List<TemplateDto> data;

  const ListTemplatesResponseDto({
    required this.pagination,
    required this.data,
  });
}

/// Request DTO for creating a new template
class CreateTemplateRequestDto with Validator<CreateTemplateRequestDto> {
  /// Course ID that this template belongs to
  final String courseId;

  /// Name of the template
  final String templateName;

  /// Template file data (PDF)
  final Uint8List templateFile;

  /// User ID from token context (set by middleware)
  final String? userId;

  /// User email from token context (set by middleware)
  final String? email;

  /// User role from token context (set by middleware)
  final String? role;

  const CreateTemplateRequestDto({
    required this.courseId,
    required this.templateName,
    required this.templateFile,

    this.userId,
    this.email,
    this.role,
  });

  @override
  LucidValidator<CreateTemplateRequestDto> validate(
    ValidatorBuilder<CreateTemplateRequestDto> builder,
  ) {
    return builder
      ..ruleFor(
        (r) => r.courseId,
        key: 'courseId',
      ).notEmptyOrNull().minLength(1).maxLength(100)
      ..ruleFor(
        (r) => r.templateName,
        key: 'templateName',
      ).notEmptyOrNull().minLength(1).maxLength(255);
  }

  /// Creates a new instance with token context data
  CreateTemplateRequestDto copyWithContext({
    String? userId,
    String? email,
    String? role,
  }) {
    return CreateTemplateRequestDto(
      courseId: courseId,
      templateName: templateName,
      templateFile: templateFile,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }
}

/// Request DTO for updating an existing template
class UpdateTemplateRequestDto with Validator<UpdateTemplateRequestDto> {
  /// Name of the template
  final String templateName;

  /// Template file data (PDF)
  final Uint8List templateFile;

  /// User ID from token context (set by middleware)
  final String? userId;

  /// User email from token context (set by middleware)
  final String? email;

  /// User role from token context (set by middleware)
  final String? role;

  const UpdateTemplateRequestDto({
    required this.templateName,
    required this.templateFile,
    this.userId,
    this.email,
    this.role,
  });

  @override
  LucidValidator<UpdateTemplateRequestDto> validate(
    ValidatorBuilder<UpdateTemplateRequestDto> builder,
  ) {
    return builder
      ..ruleFor(
        (r) => r.templateName,
        key: 'templateName',
      ).notEmptyOrNull().minLength(1).maxLength(255);
  }

  /// Creates a new instance with token context data
  UpdateTemplateRequestDto copyWithContext({
    String? userId,
    String? email,
    String? role,
  }) {
    return UpdateTemplateRequestDto(
      templateName: templateName,
      templateFile: templateFile,
      userId: userId ?? this.userId,
      email: email ?? this.email,
      role: role ?? this.role,
    );
  }
}

/// Response DTO for template creation/update operations
@DTO()
class TemplateOperationResponseDto {
  /// Unique template identifier
  final String templateId;

  /// Course identifier that this template belongs to
  final String courseId;

  /// Name of the template
  final String templateName;

  /// URL/Key for PDF template stored in storage
  final String templateBlobUrl;

  /// ID of the user who uploaded this template
  final String uploadedByUserId;

  /// Timestamp when the template was created
  @UseParse(DateTimeParse)
  final DateTime createdAt;

  /// Timestamp when the template was last updated
  @UseParse(DateTimeParse)
  final DateTime updatedAt;

  const TemplateOperationResponseDto({
    required this.templateId,
    required this.courseId,
    required this.templateName,
    required this.templateBlobUrl,
    required this.uploadedByUserId,
    required this.createdAt,
    required this.updatedAt,
  });

  /// Creates from database model
  factory TemplateOperationResponseDto.fromModel(CertificateTemplate template) {
    return TemplateOperationResponseDto(
      templateId: template.templateId,
      courseId: template.courseId,
      templateName: template.templateName,
      templateBlobUrl: template.templateBlobUrl,
      uploadedByUserId: template.uploadedByUserId,
      createdAt: template.createdAt.toDateTime(),
      updatedAt: template.updatedAt.toDateTime(),
    );
  }
}
