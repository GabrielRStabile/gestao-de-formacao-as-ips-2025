import 'dart:typed_data';

import 'package:certificate_service/src/services/storage/certificate_storage_service.dart';
import 'package:vaden/vaden.dart';

import '../dtos/template_dtos.dart';
import '../errors/template_errors.dart';
import '../models/database.dart';
import '../repositories/template_repository.dart';

/// Service for managing certificate templates
///
/// Provides business logic for template operations including validation,
/// authorization, and data transformation between DTOs and entities.
@Service()
class TemplateManagementService {
  final TemplateRepository _templateRepository;
  final CertificateStorageService _certificateStorageService;

  TemplateManagementService(
    this._templateRepository,
    this._certificateStorageService,
  );

  /// Lists templates with optional filtering and pagination
  ///
  /// [request] The request DTO containing filters and pagination
  ///
  /// Returns a paginated response with templates
  /// Throws [TemplateAccessForbiddenError] if user is not a gestor
  /// Throws [InvalidTemplateDataError] if request parameters are invalid
  /// Throws [TemplateServiceError] if there's an internal error
  Future<ListTemplatesResponseDto> listTemplates(
    ListTemplatesRequestDto request,
  ) async {
    try {
      // Validate user role
      _validateGestorRole(request.role);

      // Validate pagination parameters
      _validatePaginationParameters(request);

      // Get templates based on filters
      List<CertificateTemplate> templates;
      int totalCount;

      if (request.courseId != null) {
        // Filter by course ID
        templates = await _templateRepository.getTemplatesByCourseId(
          request.courseId!,
        );
        totalCount = await _templateRepository.countTemplatesByCourseId(
          request.courseId!,
        );
      } else {
        // Get all templates with pagination
        templates = await _templateRepository.getAllTemplates(
          limit: request.limit!,
          offset: request.offset,
        );
        totalCount = await _templateRepository.countTemplates();
      }

      // Convert to DTOs
      final templateDtos = templates.map(_convertToDto).toList();

      // Calculate pagination
      final pagination = _calculatePagination(
        currentPage: request.page!,
        pageSize: request.limit!,
        totalItems: totalCount,
      );

      return ListTemplatesResponseDto(
        pagination: pagination,
        data: templateDtos,
      );
    } on TemplateAccessForbiddenError {
      rethrow;
    } on InvalidTemplateDataError {
      rethrow;
    } catch (e) {
      throw TemplateServiceError(
        'Ocorreu um erro interno ao processar sua solicitação: ${e.toString()}',
      );
    }
  }

  /// Creates a new certificate template
  ///
  /// [request] The request DTO containing template data and file
  ///
  /// Returns the created template data
  /// Throws [TemplateAccessForbiddenError] if user is not a gestor
  /// Throws [InvalidTemplateDataError] if request data is invalid
  /// Throws [TemplateConflictError] if template already exists for the course
  /// Throws [TemplateServiceError] if there's an internal error
  Future<TemplateOperationResponseDto> createTemplate(
    CreateTemplateRequestDto request,
  ) async {
    try {
      // Validate user role
      _validateGestorRole(request.role);

      // Validate template data
      await _validateTemplateCreation(request);

      // Generate unique template ID
      final templateId = _generateTemplateId();

      // Upload template file to storage
      final templateBlobUrl = await _uploadTemplateFile(
        templateId: templateId,
        courseId: request.courseId,
        fileName: '$templateId.pdf',
        fileData: request.templateFile,
      );

      // Create template in database
      final template = await _templateRepository.createTemplate(
        templateId: templateId,
        courseId: request.courseId,
        templateName: request.templateName,
        templateBlobUrl: templateBlobUrl,
        uploadedByUserId: request.userId!,
      );

      return TemplateOperationResponseDto.fromModel(template);
    } on TemplateConflictError {
      rethrow;
    } on TemplateAccessForbiddenError {
      rethrow;
    } on InvalidTemplateDataError {
      rethrow;
    } catch (e) {
      throw TemplateServiceError(
        'Ocorreu um erro interno ao processar sua solicitação: ${e.toString()}',
      );
    }
  }

  /// Updates an existing certificate template
  ///
  /// [templateId] The ID of the template to update
  /// [request] The request DTO containing updated template data and file
  ///
  /// Returns the updated template data
  /// Throws [TemplateAccessForbiddenError] if user is not a gestor
  /// Throws [TemplateNotFoundError] if template doesn't exist
  /// Throws [InvalidTemplateDataError] if request data is invalid
  /// Throws [TemplateServiceError] if there's an internal error
  Future<TemplateOperationResponseDto> updateTemplate(
    String templateId,
    UpdateTemplateRequestDto request,
  ) async {
    try {
      // Validate user role
      _validateGestorRole(request.role);

      // Validate template update data
      await _validateTemplateUpdate(templateId, request);

      // Update template file in storage
      final templateBlobUrl = await _updateTemplateFile(
        templateId: templateId,
        fileName: '$templateId.pdf',
        fileData: request.templateFile,
      );

      // Update template in database
      final template = await _templateRepository.updateTemplate(
        templateId: templateId,
        templateName: request.templateName,
        templateBlobUrl: templateBlobUrl,
      );

      if (template == null) {
        throw TemplateNotFoundError('Template não encontrado');
      }

      return TemplateOperationResponseDto.fromModel(template);
    } on TemplateNotFoundError {
      rethrow;
    } on TemplateAccessForbiddenError {
      rethrow;
    } on InvalidTemplateDataError {
      rethrow;
    } catch (e) {
      throw TemplateServiceError(
        'Ocorreu um erro interno ao processar sua solicitação: ${e.toString()}',
      );
    }
  }

  /// Deletes an existing certificate template
  ///
  /// [templateId] The ID of the template to delete
  /// [userId] ID of the user requesting the deletion
  /// [role] Role of the user requesting the deletion
  ///
  /// Returns void on successful deletion
  /// Throws [TemplateAccessForbiddenError] if user is not a gestor
  /// Throws [TemplateNotFoundError] if template doesn't exist
  /// Throws [TemplateServiceError] if there's an internal error
  Future<void> deleteTemplate({
    required String templateId,
    required String? userId,
    required String? role,
  }) async {
    try {
      // Validate user role
      _validateGestorRole(role);

      // Check if template exists
      final existingTemplate = await _templateRepository.getTemplateById(
        templateId,
      );
      if (existingTemplate == null) {
        throw TemplateNotFoundError('Template não encontrado');
      }

      // Delete template file from storage
      await _certificateStorageService.deleteCertificateTemplate(
        templateId: templateId,
      );

      // Delete template from database
      final deleted = await _templateRepository.deleteTemplate(templateId);

      if (!deleted) {
        throw TemplateNotFoundError('Template não encontrado');
      }
    } on TemplateNotFoundError {
      rethrow;
    } on TemplateAccessForbiddenError {
      rethrow;
    } catch (e) {
      throw TemplateServiceError(
        'Ocorreu um erro interno ao processar sua solicitação: ${e.toString()}',
      );
    }
  }

  /// Validates that the user has gestor role
  void _validateGestorRole(String? role) {
    if (role == null || role.toLowerCase() != 'gestor') {
      throw TemplateAccessForbiddenError('Usuário não é gestor');
    }
  }

  /// Validates pagination parameters
  void _validatePaginationParameters(ListTemplatesRequestDto request) {
    if (request.page! < 1) {
      throw InvalidTemplateDataError('Número da página deve ser maior que 0');
    }

    if (request.limit! < 1 || request.limit! > 100) {
      throw InvalidTemplateDataError(
        'Limite de itens por página deve estar entre 1 e 100',
      );
    }
  }

  /// Converts a CertificateTemplate entity to TemplateDto
  TemplateDto _convertToDto(CertificateTemplate template) {
    return TemplateDto(
      templateId: template.templateId,
      courseId: template.courseId,
      templateName: template.templateName,
      templateBlobUrl: template.templateBlobUrl,
      uploadedByUserId: template.uploadedByUserId,
      createdAt: template.createdAt.dateTime,
      updatedAt: template.updatedAt.dateTime,
    );
  }

  /// Calculates pagination information
  PaginationDto _calculatePagination({
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
    );
  }

  /// Validates template creation data
  Future<void> _validateTemplateCreation(
    CreateTemplateRequestDto request,
  ) async {
    // Validate required user context
    if (request.userId == null || request.userId!.isEmpty) {
      throw InvalidTemplateDataError('User ID is required');
    }

    // Validate file data
    if (request.templateFile.isEmpty) {
      throw InvalidTemplateDataError('Template file cannot be empty');
    }

    // Check if template already exists for this course
    final existingTemplates = await _templateRepository.getTemplatesByCourseId(
      request.courseId,
    );

    if (existingTemplates.isNotEmpty) {
      throw TemplateConflictError(
        'Já existe um template cadastrado para o curso',
      );
    }

    // Validate file size (max 10MB)
    const maxFileSizeBytes = 10 * 1024 * 1024; // 10MB
    if (request.templateFile.length > maxFileSizeBytes) {
      throw InvalidTemplateDataError('File size cannot exceed 10MB');
    }

    // Validate file type (basic PDF validation)
    if (!_isPdfFile(request.templateFile)) {
      throw InvalidTemplateDataError('File must be a valid PDF');
    }
  }

  /// Validates template update data
  Future<void> _validateTemplateUpdate(
    String templateId,
    UpdateTemplateRequestDto request,
  ) async {
    // Validate required user context
    if (request.userId == null || request.userId!.isEmpty) {
      throw InvalidTemplateDataError('User ID is required');
    }

    // Validate file data
    if (request.templateFile.isEmpty) {
      throw InvalidTemplateDataError('Template file cannot be empty');
    }

    // Check if template exists
    final existingTemplate = await _templateRepository.getTemplateById(
      templateId,
    );

    if (existingTemplate == null) {
      throw TemplateNotFoundError('Template não encontrado');
    }

    // Validate file size (max 10MB)
    const maxFileSizeBytes = 10 * 1024 * 1024; // 10MB
    if (request.templateFile.length > maxFileSizeBytes) {
      throw InvalidTemplateDataError('File size cannot exceed 10MB');
    }

    // Validate file type (basic PDF validation)
    if (!_isPdfFile(request.templateFile)) {
      throw InvalidTemplateDataError('File must be a valid PDF');
    }
  }

  /// Generates a unique template ID
  String _generateTemplateId() {
    // Using current timestamp + random for uniqueness
    final timestamp = DateTime.now().millisecondsSinceEpoch;
    final random = (timestamp % 10000).toString().padLeft(4, '0');
    return 'template-$timestamp-$random';
  }

  /// Uploads template file to storage
  Future<String> _uploadTemplateFile({
    required String templateId,
    required String courseId,
    required String fileName,
    required Uint8List fileData,
  }) async {
    try {
      final storageUrl = await _certificateStorageService
          .uploadCertificateTemplate(
            templateId: templateId,
            fileName: fileName,
            templateData: fileData,
          );

      return storageUrl;
    } catch (e) {
      throw TemplateServiceError(
        'Failed to upload template file: ${e.toString()}',
      );
    }
  }

  /// Updates template file in storage
  Future<String> _updateTemplateFile({
    required String templateId,
    required String fileName,
    required Uint8List fileData,
  }) async {
    try {
      final storageUrl = await _certificateStorageService
          .updateCertificateTemplate(
            templateId: templateId,
            fileName: fileName,
            templateData: fileData,
          );

      return storageUrl;
    } catch (e) {
      throw TemplateServiceError(
        'Failed to update template file: ${e.toString()}',
      );
    }
  }

  /// Basic PDF file validation
  bool _isPdfFile(List<int> fileData) {
    // Check PDF magic number (first 4 bytes should be %PDF)
    if (fileData.length < 4) return false;

    final pdfSignature = [0x25, 0x50, 0x44, 0x46]; // %PDF
    for (int i = 0; i < 4; i++) {
      if (fileData[i] != pdfSignature[i]) {
        return false;
      }
    }

    return true;
  }
}
