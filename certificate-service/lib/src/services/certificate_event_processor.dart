import 'dart:convert';

import 'package:vaden/vaden.dart';

import '../dtos/certificate_event_dto.dart';
import '../services/certificate_generation_service.dart';

/// Processor for certificate events
///
/// Handles incoming certificate events from RabbitMQ
/// and processes them accordingly (e.g., generating certificates)
@Component()
class CertificateEventProcessor {
  final CertificateGenerationService _certificateGenerationService;

  /// Creates a new CertificateEventProcessor instance
  CertificateEventProcessor(this._certificateGenerationService);

  /// Processes a certificate event message
  ///
  /// [messageBody] The raw message body from RabbitMQ
  ///
  /// Returns true if the message was processed successfully
  Future<bool> processMessage(String messageBody) async {
    try {
      final messageData = jsonDecode(messageBody);

      if (messageData is! Map<String, dynamic>) {
        print('Error: Message is not a valid JSON object');
        return false;
      }

      // Convert to DTO
      final eventDto = CertificateApprovedEventDto.fromJson(messageData);

      // Validate event type
      if (eventDto.eventType != 'CERTIFICATE_APPROVED') {
        print('Ignoring non-certificate-approved event: ${eventDto.eventType}');
        return true; // Not an error, just not our event type
      }

      // Process the certificate approved event
      await _processCertificateApproved(eventDto);

      print('Certificate event processed successfully: ${eventDto.eventId}');
      return true;
    } catch (e, stackTrace) {
      print('Error processing certificate event: $e');
      print('StackTrace: $stackTrace');
      print('Original message: $messageBody');
      return false;
    }
  }

  /// Processes a certificate approved event
  ///
  /// [event] The certificate approved event to process
  Future<void> _processCertificateApproved(
    CertificateApprovedEventDto event,
  ) async {
    try {
      print(
        'Processing certificate approved event for certificate: ${event.certificateId}',
      );

      // Generate the certificate
      await _certificateGenerationService.generateCertificate(
        certificateId: event.certificateId,
        traineeUserId: event.traineeUserId,
        courseId: event.courseId,
      );

      print('Certificate generated successfully for: ${event.certificateId}');
    } catch (e) {
      print('Failed to generate certificate for ${event.certificateId}: $e');
      rethrow;
    }
  }
}
