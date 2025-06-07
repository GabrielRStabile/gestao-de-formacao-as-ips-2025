// DTOs for certificate events
import 'package:vaden/vaden.dart';

/// DTO for certificate approved event
///
/// Represents an event when a certificate is approved for emission
@DTO()
class CertificateApprovedEventDto {
  /// Unique identifier for the event
  final String eventId;

  /// Timestamp when the event occurred
  final String eventTimestamp;

  /// Service that generated the event
  final String sourceService;

  /// Type of the event
  final String eventType;

  /// ID of the approved certificate
  final String certificateId;

  /// ID of the trainee who owns the certificate
  final String traineeUserId;

  /// ID of the course
  final String courseId;

  /// ID of the formador who approved the certificate
  final String approvedByUserId;

  /// New status of the certificate
  final String status;

  const CertificateApprovedEventDto({
    required this.eventId,
    required this.eventTimestamp,
    required this.sourceService,
    required this.eventType,
    required this.certificateId,
    required this.traineeUserId,
    required this.courseId,
    required this.approvedByUserId,
    required this.status,
  });

  /// Creates a CertificateApprovedEventDto from JSON
  factory CertificateApprovedEventDto.fromJson(Map<String, dynamic> json) {
    return CertificateApprovedEventDto(
      eventId: json['eventId'] as String,
      eventTimestamp: json['eventTimestamp'] as String,
      sourceService: json['sourceService'] as String,
      eventType: json['eventType'] as String,
      certificateId: json['certificateId'] as String,
      traineeUserId: json['traineeUserId'] as String,
      courseId: json['courseId'] as String,
      approvedByUserId: json['approvedByUserId'] as String,
      status: json['status'] as String,
    );
  }

  /// Converts the DTO to JSON
  Map<String, dynamic> toJson() {
    return {
      'eventId': eventId,
      'eventTimestamp': eventTimestamp,
      'sourceService': sourceService,
      'eventType': eventType,
      'certificateId': certificateId,
      'traineeUserId': traineeUserId,
      'courseId': courseId,
      'approvedByUserId': approvedByUserId,
      'status': status,
    };
  }
}
