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

  /// Cancels an enrollment request by the trainee
  ///
  /// PUT /enrollments/{enrollmentId}/cancel
  @ApiOperation(
    summary: 'Cancel enrollment request',
    description:
        'Cancels an enrollment request. Only the trainee who created the request can cancel it.',
  )
  @ApiResponse(
    200,
    description: 'Enrollment request cancelled successfully',
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
    description: 'Usuário não é formando ou não pode cancelar esta inscrição',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    404,
    description: 'Inscrição não encontrada',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    409,
    description: 'Inscrição não pode ser cancelada (status inválido)',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    500,
    description: 'Ocorreu um erro interno ao processar sua solicitação',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiSecurity(['bearer'])
  @UseMiddleware([TokenDecodeMiddleware])
  @Put('/{enrollmentId}/cancel')
  Future<EnrollmentRequestResponseDto> cancelEnrollment(
    @Body() EnrollmentCancelDto cancelDto,
    Request request,
  ) async {
    // Extract enrollmentId from path parameters
    final enrollmentId = request.params['enrollmentId'];

    if (enrollmentId == null) {
      throw ValidationError(['Path parameter enrollmentId is required']);
    }
    // Get user context from middleware
    final userId = request.context['userId'] as String?;
    final role = request.context['role'] as String?;

    // Validate role - only formandos can cancel their own enrollments
    if (role != 'formando') {
      throw ValidationError(['Only formandos can cancel enrollment requests']);
    }

    // Validate the request DTO
    final validationResult = cancelDto
        .validate(ValidatorBuilder<EnrollmentCancelDto>())
        .validate(cancelDto);

    if (!validationResult.isValid) {
      throw ValidationError(
        validationResult.exceptions.map((e) => e.message).toList(),
      );
    }

    // Cancel the enrollment
    final response = await _enrollmentService.cancelEnrollmentByTrainee(
      enrollmentId: enrollmentId,
      traineeUserId: userId!,
      reason: cancelDto.reason,
    );

    return response;
  }

  /// Lists enrollment requests for the authenticated trainee
  ///
  /// GET /enrollments/my-enrollments
  @ApiOperation(
    summary: 'List my enrollment requests',
    description:
        'Lists enrollment requests for the authenticated trainee with optional pagination and filters.',
  )
  @ApiResponse(
    200,
    description: 'Enrollment requests retrieved successfully',
    content: ApiContent(
      type: 'application/json',
      schema: PaginatedEnrollmentsDto,
    ),
  )
  @ApiResponse(
    400,
    description: 'Invalid query parameters',
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
    500,
    description: 'Ocorreu um erro interno ao processar sua solicitação',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiSecurity(['bearer'])
  @UseMiddleware([TokenDecodeMiddleware])
  @Get('/my-enrollments')
  Future<PaginatedEnrollmentsDto> getMyEnrollments(
    @Query() MyEnrollmentsQueryDto queryDto,
    Request request,
  ) async {
    // Get user context from middleware
    final userId = request.context['userId'] as String?;
    final role = request.context['role'] as String?;

    // Validate role - only formandos can view their enrollments
    if (role != 'formando') {
      throw ValidationError(['Only formandos can view enrollment requests']);
    }

    // Validate query parameters
    final validationResult = queryDto
        .validate(ValidatorBuilder<MyEnrollmentsQueryDto>())
        .validate(queryDto);

    if (!validationResult.isValid) {
      throw ValidationError(
        validationResult.exceptions.map((e) => e.message).toList(),
      );
    }

    // Get enrollments for the trainee
    final response = await _enrollmentService.getMyEnrollments(
      traineeUserId: userId!,
      queryDto: queryDto,
    );

    return response;
  }

  /// Lists all enrollment requests for managers
  ///
  /// GET /enrollments/
  @ApiOperation(
    summary: 'List enrollment requests for managers',
    description:
        'Lists all enrollment requests with advanced filtering and pagination options. Requires manager role.',
  )
  @ApiResponse(
    200,
    description: 'Enrollment requests retrieved successfully',
    content: ApiContent(
      type: 'application/json',
      schema: PaginatedEnrollmentsDto,
    ),
  )
  @ApiResponse(
    400,
    description: 'Invalid query parameters',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    401,
    description: 'Token JWT ausente ou inválido',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    403,
    description: 'Usuário não é manager',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    500,
    description: 'Ocorreu um erro interno ao processar sua solicitação',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiSecurity(['bearer'])
  @UseMiddleware([TokenDecodeMiddleware])
  @Get('/')
  Future<PaginatedEnrollmentsDto> getAllEnrollments(
    @Query() ManagerEnrollmentsQueryDto queryDto,
    Request request,
  ) async {
    // Get user context from middleware
    final role = request.context['role'] as String?;

    // Validate role - only managers can view all enrollment requests
    if (role != 'manager') {
      throw ValidationError(['Only managers can view all enrollment requests']);
    }

    // Validate query parameters
    final validationResult = queryDto
        .validate(ValidatorBuilder<ManagerEnrollmentsQueryDto>())
        .validate(queryDto);

    if (!validationResult.isValid) {
      throw ValidationError(
        validationResult.exceptions.map((e) => e.message).toList(),
      );
    }

    // Get enrollments for the manager
    final response = await _enrollmentService.getEnrollmentsForManager(
      queryDto: queryDto,
    );

    return response;
  }

  /// Gets specific enrollment details with status history
  ///
  /// GET /enrollments/{enrollmentId}
  @ApiOperation(
    summary: 'Get enrollment details',
    description:
        'Retrieves detailed information about a specific enrollment request including complete status history. Managers can view any enrollment, trainees can only view their own enrollments.',
  )
  @ApiResponse(
    200,
    description: 'Enrollment details retrieved successfully',
    content: ApiContent(
      type: 'application/json',
      schema: EnrollmentDetailsResponseDto,
    ),
  )
  @ApiResponse(
    400,
    description: 'Invalid enrollment ID parameter',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    401,
    description: 'Token JWT ausente ou inválido',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    403,
    description: 'Usuário não tem permissão para visualizar esta inscrição',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    404,
    description: 'Inscrição não encontrada',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    500,
    description: 'Ocorreu um erro interno ao processar sua solicitação',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiSecurity(['bearer'])
  @UseMiddleware([TokenDecodeMiddleware])
  @Get('/{enrollmentId}')
  Future<EnrollmentDetailsResponseDto> getEnrollmentDetails(
    Request request,
  ) async {
    // Extract enrollmentId from path parameters
    final enrollmentId = request.params['enrollmentId'];

    if (enrollmentId == null) {
      throw ValidationError(['Path parameter enrollmentId is required']);
    }

    // Get user context from middleware
    final userId = request.context['userId'] as String?;
    final role = request.context['role'] as String?;

    // Validate that user has appropriate role (manager or formando)
    if (role != 'manager' && role != 'formando') {
      throw ValidationError([
        'Only managers and formandos can view enrollment details',
      ]);
    }

    // Get enrollment details with authorization check
    final response = await _enrollmentService.getEnrollmentDetailsById(
      enrollmentId: enrollmentId,
      requestingUserId: userId!,
      userRole: role!,
    );

    if (response == null) {
      throw ValidationError(['Enrollment not found']);
    }

    return response;
  }

  /// Approves an enrollment request
  ///
  /// PUT /enrollments/{enrollmentId}/approve
  @ApiOperation(
    summary: 'Approve enrollment request',
    description:
        'Approves an enrollment request. Only managers can perform this action. The enrollment must be in pending approval status.',
  )
  @ApiResponse(
    200,
    description: 'Enrollment approved successfully',
    content: ApiContent(
      type: 'application/json',
      schema: EnrollmentRequestResponseDto,
    ),
  )
  @ApiResponse(
    400,
    description: 'Invalid request data or enrollment cannot be approved',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    401,
    description: 'Token JWT ausente ou inválido',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    403,
    description: 'Usuário não é manager',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    404,
    description: 'Enrollment request não encontrado',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    500,
    description: 'Ocorreu um erro interno ao processar sua solicitação',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiSecurity(['bearer'])
  @UseMiddleware([TokenDecodeMiddleware])
  @Put('/{enrollmentId}/approve')
  Future<EnrollmentRequestResponseDto> approveEnrollment(
    @Body() EnrollmentApproveDto approveDto,
    Request request,
  ) async {
    // Extract enrollmentId from path parameters
    final enrollmentId = request.params['enrollmentId'];

    if (enrollmentId == null) {
      throw ValidationError(['Path parameter enrollmentId is required']);
    }

    // Get user context from middleware
    final userId = request.context['userId'] as String?;
    final role = request.context['role'] as String?;

    // Validate role - only managers can approve enrollments
    if (role != 'manager') {
      throw ValidationError(['Only managers can approve enrollment requests']);
    }

    // Validate the request DTO
    final validationResult = approveDto
        .validate(ValidatorBuilder<EnrollmentApproveDto>())
        .validate(approveDto);

    if (!validationResult.isValid) {
      throw ValidationError(
        validationResult.exceptions.map((e) => e.message).toList(),
      );
    }

    // Approve the enrollment
    final response = await _enrollmentService.approveEnrollmentByManager(
      enrollmentId: enrollmentId,
      managerUserId: userId!,
      notes: approveDto.notes,
    );

    return response;
  }

  /// Rejects an enrollment request
  ///
  /// PUT /enrollments/{enrollmentId}/reject
  @ApiOperation(
    summary: 'Reject enrollment request',
    description:
        'Rejects an enrollment request with a required reason. Only managers can perform this action. The enrollment must be in pending approval status.',
  )
  @ApiResponse(
    200,
    description: 'Enrollment rejected successfully',
    content: ApiContent(
      type: 'application/json',
      schema: EnrollmentRequestResponseDto,
    ),
  )
  @ApiResponse(
    400,
    description: 'Invalid request data or enrollment cannot be rejected',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    401,
    description: 'Token JWT ausente ou inválido',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    403,
    description: 'Usuário não é manager',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    404,
    description: 'Enrollment request não encontrado',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    500,
    description: 'Ocorreu um erro interno ao processar sua solicitação',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiSecurity(['bearer'])
  @UseMiddleware([TokenDecodeMiddleware])
  @Put('/{enrollmentId}/reject')
  Future<EnrollmentRequestResponseDto> rejectEnrollment(
    @Body() EnrollmentRejectDto rejectDto,
    Request request,
  ) async {
    // Extract enrollmentId from path parameters
    final enrollmentId = request.params['enrollmentId'];

    if (enrollmentId == null) {
      throw ValidationError(['Path parameter enrollmentId is required']);
    }

    // Get user context from middleware
    final userId = request.context['userId'] as String?;
    final role = request.context['role'] as String?;

    // Validate role - only managers can reject enrollments
    if (role != 'manager') {
      throw ValidationError(['Only managers can reject enrollment requests']);
    }

    // Validate the request DTO
    final validationResult = rejectDto
        .validate(ValidatorBuilder<EnrollmentRejectDto>())
        .validate(rejectDto);

    if (!validationResult.isValid) {
      throw ValidationError(
        validationResult.exceptions.map((e) => e.message).toList(),
      );
    }

    // Reject the enrollment
    final response = await _enrollmentService.rejectEnrollmentByManager(
      enrollmentId: enrollmentId,
      managerUserId: userId!,
      reason: rejectDto.reason,
    );

    return response;
  }
}
