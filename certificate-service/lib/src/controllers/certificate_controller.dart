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
    // Extract user context from middleware
    final userId = request.context['userId'] as String?;
    final email = request.context['email'] as String?;
    final role = request.context['role'] as String?;

    // Create request DTO with query parameters and context
    final requestDto = ListTemplatesRequestDto(
      courseId: courseId,
      isActive: isActive,
      page: page ?? 1,
      limit: limit ?? 10,
      userId: userId,
      email: email,
      role: role,
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
}
