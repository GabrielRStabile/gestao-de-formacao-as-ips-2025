import 'package:audit_service/src/dtos/error_dto.dart';
import 'package:vaden/vaden.dart';

import '../dtos/list_audit_logs_dto.dart';
import '../services/audit_log_service.dart';

/// Controller for audit log query endpoints
///
/// Provides REST API endpoints for querying and testing audit logs.
/// Supports filtering, pagination, and test log creation.
@Controller('/audit')
@Api(
  tag: 'Audit',
  description: 'Handles audit logging and retrieval of audit logs',
)
class AuditController {
  final AuditLogService _auditLogService;

  /// Creates a new instance of AuditController
  ///
  /// [_auditLogService] The audit log service for business logic operations
  AuditController(this._auditLogService);

  /// Lists audit logs with filters and pagination
  ///
  /// GET /audit/logs
  /// Retrieves a paginated list of audit logs based on provided filters
  @ApiOperation(
    summary: 'List audit logs',
    description: 'Retrieve a list of audit logs with filters and pagination',
  )
  @ApiResponse(
    200,
    description: 'List of audit logs',
    content: ApiContent(
      type: 'application/json',
      schema: PaginatedAuditLogsDto,
    ),
  )
  @ApiResponse(
    400,
    description: 'Invalid request parameters',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @ApiResponse(
    500,
    description: 'Internal server error',
    content: ApiContent(type: 'application/json', schema: ErrorDto),
  )
  @Get('/logs')
  Future<PaginatedAuditLogsDto> listAuditLogs(
    @Body() ListAuditLogsRequestDto requestDto,
  ) async {
    return await _auditLogService.listAuditLogs(requestDto);
  }
}
