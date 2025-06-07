import 'dart:convert';

import 'package:vaden/vaden.dart';

import '../dtos/enrollment_event_dto.dart';
import '../services/certificate_issuance_service.dart';

/// Service for processing enrollment events from message queues
///
/// Handles deserialization of incoming enrollment event messages and
/// delegates processing to the certificate issuance service.
@Service()
class EnrollmentEventProcessor {
  /// Service for certificate issuance business logic
  final CertificateIssuanceService _certificateIssuanceService;

  /// DSON instance for JSON serialization/deserialization
  final DSON _dson;

  /// Creates a new instance of EnrollmentEventProcessor
  ///
  /// [_certificateIssuanceService] The service for processing certificate issuance
  /// [_dson] The DSON instance for JSON operations
  EnrollmentEventProcessor(this._certificateIssuanceService, this._dson);

  /// Processes an enrollment event message from a message queue
  ///
  /// Deserializes the JSON message, validates it, and creates a pending certificate.
  /// Returns true if processing was successful, false otherwise.
  ///
  /// [messageBody] The JSON string containing the enrollment event data
  /// Returns true if the message was processed successfully
  Future<bool> processMessage(String messageBody) async {
    try {
      final messageData = jsonDecode(messageBody);

      if (messageData is! Map<String, dynamic>) {
        print('Error: Message is not a valid JSON object');
        return false;
      }

      // Convert to DTO using DSON
      final eventDto = _dson.fromJson<EnrollmentEventDto>(messageData);

      // Validate the event DTO
      final validationResult = eventDto
          .validate(ValidatorBuilder<EnrollmentEventDto>())
          .validate(eventDto);

      if (!validationResult.isValid) {
        print(
          'Error: Invalid enrollment event data: ${validationResult.exceptions.map((e) => e.message).toList()}',
        );
        return false;
      }

      // Process the enrollment event
      await _certificateIssuanceService.createPendingCertificate(eventDto);

      print(
        'Enrollment event processed successfully: ${eventDto.enrollmentId}',
      );
      return true;
    } catch (e, stackTrace) {
      print('Error processing enrollment event: $e');
      print('StackTrace: $stackTrace');
      print('Original message: $messageBody');
      return false;
    }
  }
}
