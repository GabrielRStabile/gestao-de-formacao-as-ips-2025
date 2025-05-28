import 'package:audit_service/src/utils/date_time_parse.dart';
import 'package:vaden/vaden.dart';

/// Data Transfer Object for audit events
///
/// Represents an audit event with all necessary information for tracking
/// user actions, system events, and security-related activities.
@DTO()
class AuditEventDto with Validator<AuditEventDto> {
  /// Unique identifier for the audit event
  final String eventId;

  /// Timestamp when the event occurred
  @UseParse(DateTimeParse)
  final DateTime eventTimestamp;

  /// Name of the service that generated the event
  final String sourceService;

  /// Type of event that occurred (e.g., CREATE, UPDATE, DELETE)
  final String eventType;

  /// ID of the user who performed the action (optional)
  final String? userId;

  /// ID of the target entity affected by the action (optional)
  final String? targetEntityId;

  /// Type of the target entity (optional)
  final String? targetEntityType;

  /// IP address from which the action was performed (optional)
  final String? ipAddress;

  /// Additional details about the event (optional)
  final Map<String, dynamic>? details;

  /// Creates a new instance of AuditEventDto
  ///
  /// [eventId] Unique identifier for the event
  /// [eventTimestamp] When the event occurred
  /// [sourceService] Service that generated the event
  /// [eventType] Type of event
  /// [userId] Optional user ID
  /// [targetEntityId] Optional target entity ID
  /// [targetEntityType] Optional target entity type
  /// [ipAddress] Optional IP address
  /// [details] Optional additional details
  AuditEventDto({
    required this.eventId,
    required this.eventTimestamp,
    required this.sourceService,
    required this.eventType,
    this.userId,
    this.targetEntityId,
    this.targetEntityType,
    this.ipAddress,
    this.details,
  });

  /// Returns sanitized details with sensitive information removed
  ///
  /// Removes fields that may contain sensitive data like passwords,
  /// tokens, secrets, and other credential information.
  Map<String, dynamic>? get sanitizedDetails {
    if (details == null) return null;

    final sanitized = Map<String, dynamic>.from(details!);

    const sensitiveFields = [
      'password',
      'token',
      'secret',
      'key',
      'credential',
      'authorization',
      'session',
    ];

    for (final field in sensitiveFields) {
      sanitized.removeWhere(
        (key, value) => key.toLowerCase().contains(field.toLowerCase()),
      );
    }

    // Truncate very long string values to prevent storage issues
    sanitized.forEach((key, value) {
      if (value is String && value.length > 1000) {
        sanitized[key] = '${value.substring(0, 997)}...';
      }
    });

    return sanitized;
  }

  /// Validates the audit event data
  ///
  /// Ensures required fields are present and not empty.
  @override
  LucidValidator<AuditEventDto> validate(
    ValidatorBuilder<AuditEventDto> builder,
  ) {
    return builder
      ..ruleFor((dto) => dto.eventId, key: 'eventId').notEmptyOrNull()
      ..ruleFor((dto) => dto.eventTimestamp, key: 'eventTimestamp').isNotNull()
      ..ruleFor(
        (dto) => dto.sourceService,
        key: 'sourceService',
      ).notEmptyOrNull()
      ..ruleFor((dto) => dto.eventType, key: 'eventType').notEmptyOrNull();
  }

  /// Returns a human-readable summary of the audit event
  ///
  /// Combines event type, source service, and user information
  /// for logging and display purposes.
  String get summary {
    final userPart = userId != null ? ' by user $userId' : ' by system';
    return '$eventType from $sourceService$userPart';
  }
}
