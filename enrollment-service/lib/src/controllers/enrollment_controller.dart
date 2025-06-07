import 'package:enrollment_service/config/middlewares/token_decode_middleware.dart';
import 'package:enrollment_service/src/errors/validation_error.dart';
import 'package:vaden/vaden.dart';

import '../dtos/enrollment_request_dto.dart';
import '../dtos/error_dto.dart';
import '../services/enrollment_service.dart';

/// Controller for enrollment-related operations
///
/// Handles HTTP requests for enrollment registration and management.
/// Includes role-based access control for different user types.

@Api(
  tag: 'Enrollment Management',
  description: 'Handles enrollment request registration and management',
)
@Controller('/enrollments')
class EnrollmentController {
  final EnrollmentService _enrollmentService;

  EnrollmentController(this._enrollmentService);

  /// Registers a new enrollment request for a course offering
  ///
  /// POST /enrollments/register
  @ApiOperation(
    summary: 'Register for course offering',
    description:
        'Creates a new enrollment request for a course offering. Requires formando role.',
  )
  @ApiResponse(
    201,
    description: 'Enrollment request created successfully',
    content: ApiContent(
      type: 'application/json',
      schema: EnrollmentRequestResponseDto,
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
    description: 'Usuário não é formando',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    409,
    description: 'Já existe inscrição para este curso',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    500,
    description: 'Ocorreu um erro interno ao processar sua solicitação',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiSecurity(['bearer'])
  @UseMiddleware([TokenDecodeMiddleware])
  @Post('/register')
  Future<EnrollmentRequestResponseDto> registerEnrollment(
    @Body() EnrollmentRequestCreateDto createDto,
    Request request,
  ) async {
    // Get user context from middleware
    final userId = request.context['userId'] as String?;
    final role = request.context['role'] as String?;

    // Validate role - only formandos can register
    if (role != 'formando') {
      throw ValidationError(['Only formandos can register for courses']);
    }

    // Validate the request DTO
    final validationResult = createDto
        .validate(ValidatorBuilder<EnrollmentRequestCreateDto>())
        .validate(createDto);

    if (!validationResult.isValid) {
      throw ValidationError(
        validationResult.exceptions.map((e) => e.message).toList(),
      );
    }

    // Register the enrollment
    final response = await _enrollmentService.registerEnrollment(
      traineeUserId: userId!,
      createDto: createDto,
    );

    return response;
  }
}
