import 'dart:typed_data';

import 'package:vaden/vaden.dart';

import '../repositories/issued_certificate_repository.dart';
import '../repositories/template_repository.dart';
import '../utils/verification_code_generator.dart';
import 'storage/certificate_storage_service.dart';

/// Service for generating certificates
///
/// Handles the process of generating certificates from templates,
/// uploading to blob storage, and updating certificate records
@Service()
class CertificateGenerationService {
  final IssuedCertificateRepository _issuedCertificateRepository;
  final TemplateRepository _templateRepository;
  final CertificateStorageService _certificateStorageService;
  final VerificationCodeGenerator _verificationCodeGenerator;

  /// Creates a new CertificateGenerationService instance
  CertificateGenerationService(
    this._issuedCertificateRepository,
    this._templateRepository,
    this._certificateStorageService,
    this._verificationCodeGenerator,
  );

  /// Generates a certificate for the specified parameters
  ///
  /// [certificateId] The ID of the certificate to generate
  /// [traineeUserId] The ID of the trainee
  /// [courseId] The ID of the course
  ///
  /// Throws [Exception] if generation fails
  Future<void> generateCertificate({
    required String certificateId,
    required String traineeUserId,
    required String courseId,
  }) async {
    try {
      print('Starting certificate generation for: $certificateId');

      // Update status to generating
      await _issuedCertificateRepository.updateCertificateStatus(
        certificateId: certificateId,
        status: 'GENERATING',
      );

      // Get the current certificate record
      final certificate = await _issuedCertificateRepository.getCertificateById(
        certificateId,
      );

      if (certificate == null) {
        throw Exception('Certificate not found: $certificateId');
      }

      // Find an active template for the course
      final templates = await _templateRepository.getTemplatesByCourseId(
        courseId,
      );
      final activeTemplate = templates.isNotEmpty ? templates.first : null;

      if (activeTemplate == null) {
        throw Exception('No active template found for course: $courseId');
      }

      print(
        'Using template: ${activeTemplate.templateId} for certificate: $certificateId',
      );

      // Generate verification code
      final verificationCode = _verificationCodeGenerator.generate();

      // Create certificate file name
      final fileName =
          'certificate_${certificateId}_${DateTime.now().millisecondsSinceEpoch}.pdf';

      // For now, we'll copy the template file as the certificate
      // In a real implementation, you would generate a personalized certificate
      // using the template and user data
      final certificateBlob = await _copyTemplateAsCertificate(
        activeTemplate.templateBlobUrl,
        fileName,
        traineeUserId,
        courseId,
      );

      // Upload the generated certificate to storage
      final certificateBlobUrl = await _certificateStorageService
          .uploadGeneratedCertificate(
            certificateId: certificateId,
            certificateData: Uint8List.fromList(certificateBlob),
            studentName: 'Student $traineeUserId',
            courseName: 'Course $courseId',
          );

      // Update certificate record with blob URL, verification code, and issued status
      await _issuedCertificateRepository.updateCertificateStatus(
        certificateId: certificateId,
        status: 'ISSUED',
        certificateBlobUrl: certificateBlobUrl,
        verificationCode: verificationCode,
      );

      print('Certificate generated and uploaded successfully: $certificateId');
    } catch (e) {
      print('Failed to generate certificate $certificateId: $e');

      // Update status to failed
      try {
        await _issuedCertificateRepository.updateCertificateStatus(
          certificateId: certificateId,
          status: 'GENERATION_FAILED',
        );
      } catch (updateError) {
        print('Failed to update certificate status to failed: $updateError');
      }

      rethrow;
    }
  }

  /// Copies a template as a certificate (placeholder implementation)
  ///
  /// In a real implementation, this would:
  /// 1. Download the template from blob storage
  /// 2. Fill in user-specific information (name, course, date, etc.)
  /// 3. Generate a new PDF with the personalized data
  ///
  /// [templateBlobUrl] The URL of the template blob
  /// [fileName] The name for the generated certificate file
  /// [traineeUserId] The ID of the trainee
  /// [courseId] The ID of the course
  ///
  /// Returns the certificate file data as bytes
  Future<List<int>> _copyTemplateAsCertificate(
    String templateBlobUrl,
    String fileName,
    String traineeUserId,
    String courseId,
  ) async {
    final placeholderContent = '''
Certificate of Completion

This certifies that trainee $traineeUserId
has successfully completed the course $courseId

Generated on: ${DateTime.now().toIso8601String()}
Certificate ID: $fileName
''';

    return placeholderContent.codeUnits;
  }
}
