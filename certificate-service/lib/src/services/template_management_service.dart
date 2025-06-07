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

  TemplateManagementService(this._templateRepository);

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
}
