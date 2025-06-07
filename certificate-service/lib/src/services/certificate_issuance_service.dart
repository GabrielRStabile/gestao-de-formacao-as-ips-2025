import 'package:uuid/uuid.dart';
import 'package:vaden/vaden.dart';

import '../dtos/enrollment_event_dto.dart';
import '../repositories/issued_certificate_repository.dart';

/// Service for handling certificate issuance operations
///
/// Provides business logic for creating pending certificates from enrollment events.
@Service()
class CertificateIssuanceService {
  final IssuedCertificateRepository _issuedCertificateRepository;
  final Uuid _uuid = const Uuid();

  /// Creates a new instance of CertificateIssuanceService
  ///
  /// [_issuedCertificateRepository] The repository for certificate operations
  /// [_uuid] UUID generator for certificate IDs
  CertificateIssuanceService(this._issuedCertificateRepository);

  /// Creates a pending certificate from an enrollment event
  ///
  /// When a student enrolls in a course, this method creates an IssuedCertificate
  /// record with PENDING_APPROVAL status. Checks if a certificate already exists
  /// for the enrollment to avoid duplicates.
  ///
  /// [enrollmentEvent] The enrollment event data
  ///
  /// Throws [Exception] if there's an error creating the certificate
  Future<void> createPendingCertificate(
    EnrollmentEventDto enrollmentEvent,
  ) async {
    try {
      // Check if certificate already exists for this enrollment
      final existingCertificate = await _issuedCertificateRepository
          .certificateExistsForEnrollment(enrollmentEvent.enrollmentId);

      if (existingCertificate) {
        print(
          'Certificate already exists for enrollment ${enrollmentEvent.enrollmentId}',
        );
        return;
      }

      final certificateId = _uuid.v4();

      await _issuedCertificateRepository.createIssuedCertificate(
        certificateId: certificateId,
        traineeUserId: enrollmentEvent.traineeUserId,
        enrollmentId: enrollmentEvent.enrollmentId,
        courseId: enrollmentEvent.courseId,
        status: 'PENDING_APPROVAL',
      );

      print(
        'Created pending certificate $certificateId for enrollment ${enrollmentEvent.enrollmentId}',
      );
    } catch (e) {
      print(
        'Error creating pending certificate for enrollment ${enrollmentEvent.enrollmentId}: $e',
      );
      rethrow;
    }
  }
}
