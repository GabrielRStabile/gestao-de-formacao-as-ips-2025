import 'dart:convert';
import 'dart:typed_data';

import 'package:certificate_service/src/errors/validation_error.dart';
import 'package:vaden/vaden.dart';

import '../../config/middlewares/token_decode_middleware.dart';
import '../dtos/error_dto.dart';
import '../dtos/template_dtos.dart';
import '../services/template_management_service.dart';

/// Controller for certificate-related operations
///
/// Handles HTTP requests for certificate templates and certificate management.
/// Includes role-based access control for different user types.

@Api(
  tag: 'Certificate Management',
  description:
      'Handles certificate template management, including creation, updating, and deletion',
)
@Controller('/certificates')
class CertificateController {
  final TemplateManagementService _templateManagementService;

  CertificateController(this._templateManagementService);

  /// Lists certificate templates with optional filtering and pagination
  ///
  /// GET /certificates/templates
  @ApiOperation(
    summary: 'List certificate templates',
    description:
        'Lists certificate templates with optional filtering and pagination. Requires Gestor role.',
  )
  @ApiResponse(
    200,
    description: 'Templates retrieved successfully',
    content: ApiContent(
      type: 'application/json',
      schema: ListTemplatesResponseDto,
    ),
  )
  @ApiResponse(
    400,
    description: 'Invalid input parameters',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    401,
    description: 'Token JWT ausente ou inválido',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    403,
    description: 'Usuário não é gestor',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    500,
    description: 'Ocorreu um erro interno ao processar sua solicitação',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiSecurity(['bearer'])
  @UseMiddleware([TokenDecodeMiddleware])
  @Get('/templates')
  Future<ListTemplatesResponseDto> listTemplates(
    @Query('courseId') String? courseId,
    @Query('isActive') bool? isActive,
    @Query('page') int? page,
    @Query('limit') int? limit,
    Request request,
  ) async {
    // Create request DTO with query parameters and context
    final requestDto = ListTemplatesRequestDto(
      courseId: courseId,
      isActive: isActive,
      page: page ?? 1,
      limit: limit ?? 10,
      userId: request.userId,
      email: request.email,
      role: request.role,
    );

    // Validate the request DTO
    final validationResult = requestDto
        .validate(ValidatorBuilder<ListTemplatesRequestDto>())
        .validate(requestDto);

    if (!validationResult.isValid) {
      throw ValidationError(
        validationResult.exceptions.map((e) => e.message).toList(),
      );
    }

    final response = await _templateManagementService.listTemplates(requestDto);

    return response;
  }

  /// Creates a new certificate template with file upload
  ///
  /// POST /certificates/templates
  @ApiOperation(
    summary: 'Create certificate template',
    description:
        'Creates a new certificate template with PDF file upload. Requires Gestor role.',
  )
  @ApiResponse(
    201,
    description: 'Template created successfully',
    content: ApiContent(
      type: 'application/json',
      schema: TemplateOperationResponseDto,
    ),
  )
  @ApiResponse(
    400,
    description: 'Invalid input parameters or file',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    401,
    description: 'Token JWT ausente ou inválido',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    403,
    description: 'Usuário não é gestor',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    409,
    description: 'Já existe um template cadastrado para o curso',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    500,
    description: 'Ocorreu um erro interno ao processar sua solicitação',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiSecurity(['bearer'])
  @UseMiddleware([TokenDecodeMiddleware])
  @Post('/templates')
  Future<TemplateOperationResponseDto> createTemplate(
    Request request,

    @Query('courseId') String courseId,
    @Query('templateName') String templateName,
  ) async {
    // Parse multipart form data
    final formData = request.multipart();

    if (formData == null) {
      throw ValidationError(['Form data is required']);
    }

    late final Uint8List templateFile;

    await for (final part in formData.parts) {
      final fileBase64 = await part.readString();

      final Base64Decoder base64Decoder = Base64Decoder();
      templateFile = base64Decoder.convert(fileBase64);
    }

    // Create request DTO with form data and context
    final requestDto = CreateTemplateRequestDto(
      courseId: courseId,
      templateName: templateName,
      templateFile: templateFile,
      userId: request.userId,
      email: request.email,
      role: request.role,
    );

    // Validate the request DTO
    final validationResult = requestDto
        .validate(ValidatorBuilder<CreateTemplateRequestDto>())
        .validate(requestDto);

    if (!validationResult.isValid) {
      throw ValidationError(
        validationResult.exceptions.map((e) => e.message).toList(),
      );
    }

    // Create template
    final response = await _templateManagementService.createTemplate(
      requestDto,
    );

    return response;
  }

  /// Updates an existing certificate template
  ///
  /// PUT /certificates/templates/{templateId}
  @ApiOperation(
    summary: 'Update certificate template',
    description:
        'Updates an existing certificate template with new name and/or PDF file. Requires Gestor role.',
  )
  @ApiResponse(
    200,
    description: 'Template updated successfully',
    content: ApiContent(
      type: 'application/json',
      schema: TemplateOperationResponseDto,
    ),
  )
  @ApiResponse(
    400,
    description: 'Invalid input parameters or file',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    401,
    description: 'Token JWT ausente ou inválido',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    403,
    description: 'Usuário não é gestor',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    404,
    description: 'Template não encontrado',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    500,
    description: 'Ocorreu um erro interno ao processar sua solicitação',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiSecurity(['bearer'])
  @UseMiddleware([TokenDecodeMiddleware])
  @Put('/templates/{templateId}')
  Future<TemplateOperationResponseDto> updateTemplate(
    @Param('templateId') String templateId,
    @Query('templateName') String templateName,
    Request request,
  ) async {
    // Parse multipart form data
    final formData = request.multipart();

    if (formData == null) {
      throw ValidationError(['Form data is required']);
    }

    late final Uint8List templateFile;

    await for (final part in formData.parts) {
      final fileBase64 = await part.readString();

      final Base64Decoder base64Decoder = Base64Decoder();
      templateFile = base64Decoder.convert(fileBase64);
    }

    // Create request DTO with form data and context
    final requestDto = UpdateTemplateRequestDto(
      templateName: templateName,
      templateFile: templateFile,
      userId: request.userId,
      email: request.email,
      role: request.role,
    );

    // Validate the request DTO
    final validationResult = requestDto
        .validate(ValidatorBuilder<UpdateTemplateRequestDto>())
        .validate(requestDto);

    if (!validationResult.isValid) {
      throw ValidationError(
        validationResult.exceptions.map((e) => e.message).toList(),
      );
    }

    // Update template
    final response = await _templateManagementService.updateTemplate(
      templateId,
      requestDto,
    );

    return response;
  }

  /// Deletes an existing certificate template
  ///
  /// DELETE /certificates/templates/{templateId}
  @ApiOperation(
    summary: 'Delete certificate template',
    description:
        'Deletes an existing certificate template from storage and database. Requires Gestor role.',
  )
  @ApiResponse(204, description: 'Template deleted successfully')
  @ApiResponse(
    401,
    description: 'Token JWT ausente ou inválido',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    403,
    description: 'Usuário não é gestor',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    404,
    description: 'Template não encontrado',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    500,
    description: 'Ocorreu um erro interno ao processar sua solicitação',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiSecurity(['bearer'])
  @UseMiddleware([TokenDecodeMiddleware])
  @Delete('/templates/{templateId}')
  Future<void> deleteTemplate(
    @Param('templateId') String templateId,
    Request request,
  ) async {
    // Delete template
    await _templateManagementService.deleteTemplate(
      templateId: templateId,
      userId: request.userId,
      role: request.role,
    );
  }
}

extension on Request {
  String? get userId => context['userId'] as String?;
  String? get email => context['email'] as String?;
  String? get role => context['role'] as String?;
}
