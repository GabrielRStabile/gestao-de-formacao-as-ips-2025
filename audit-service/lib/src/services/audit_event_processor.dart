import 'dart:convert';

import 'package:vaden/vaden.dart';

import '../dtos/audit_event_dto.dart';
import '../services/audit_log_service.dart';

/// Service for processing audit events from message queues
///
/// Handles deserialization of incoming audit event messages and
/// delegates processing to the audit log service.
@Service()
class AuditEventProcessor {
  /// Service for audit log business logic
  final AuditLogService _auditLogService;

  /// DSON instance for JSON serialization/deserialization
  final DSON _dson;

  /// Creates a new instance of AuditEventProcessor
  ///
  /// [_auditLogService] The service for processing audit events
  /// [_dson] The DSON instance for JSON operations
  AuditEventProcessor(this._auditLogService, this._dson);

  /// Processes an audit event message from a message queue
  ///
  /// Deserializes the JSON message, validates it, and processes the audit event.
  /// Returns true if processing was successful, false otherwise.
  ///
  /// [messageBody] The JSON string containing the audit event data
  /// Returns true if the message was processed successfully
  Future<bool> processMessage(String messageBody) async {
    try {
      final messageData = jsonDecode(messageBody);

      if (messageData is! Map<String, dynamic>) {
        print('Error: Message is not a valid JSON object');
        return false;
      }

      // Convert to DTO using DSON
      final eventDto = _dson.fromJson<AuditEventDto>(messageData);

      // Process the event
      await _auditLogService.processAuditEvent(eventDto);

      print('Audit event processed successfully: ${eventDto.eventId}');
      return true;
    } catch (e, stackTrace) {
      print('Error processing audit event: $e');
      print('StackTrace: $stackTrace');
      print('Original message: $messageBody');
      return false;
    }
  }

  /// Creates a sample audit event for testing purposes
  ///
  /// Generates a test audit event with optional custom values.
  /// Useful for testing and development scenarios.
  ///
  /// [eventId] Optional custom event ID
  /// [sourceService] Optional custom source service name
  /// [eventType] Optional custom event type
  /// [userId] Optional custom user ID
  ///
  /// Returns a Map representing the audit event data
  Map<String, dynamic> createSampleEvent({
    String? eventId,
    String? sourceService,
    String? eventType,
    String? userId,
  }) {
    final now = DateTime.now();

    return {
      'eventId': eventId ?? 'test-${now.millisecondsSinceEpoch}',
      'eventTimestamp': now.toIso8601String(),
      'sourceService': sourceService ?? 'audit-service',
      'eventType': eventType ?? 'TEST_EVENT',
      'userId': userId,
      'targetEntityId': null,
      'targetEntityType': null,
      'ipAddress': '127.0.0.1',
      'details': {
        'message': 'Test event created by AuditEventProcessor',
        'timestamp': now.toIso8601String(),
      },
    };
  }
}
