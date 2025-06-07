import 'dart:typed_data';

import 'certificate_storage_service.dart';
import 'object_storage_service.dart';

/// Implementation of CertificateStorageService using MinIO/S3 compatible storage
///
/// Provides certificate-specific storage operations by wrapping the generic
/// ObjectStorageService with business logic for certificates and templates.
class MinIOCertificateStorageService implements CertificateStorageService {
  /// The underlying object storage service (MinIO/S3 compatible)
  final ObjectStorageService _objectStorageService;

  /// Bucket name for certificate templates
  final String _templatesBucketName;

  /// Bucket name for generated certificates
  final String _certificatesBucketName;

  /// Creates a new MinIOCertificateStorageService
  ///
  /// [_objectStorageService] The underlying storage service implementation
  /// [_templatesBucketName] Name of the bucket for storing templates (default: 'certificate-templates')
  /// [_certificatesBucketName] Name of the bucket for storing certificates (default: 'generated-certificates')
  MinIOCertificateStorageService(
    this._objectStorageService, {
    String templatesBucketName = 'certificate-templates',
    String certificatesBucketName = 'generated-certificates',
  }) : _templatesBucketName = templatesBucketName,
       _certificatesBucketName = certificatesBucketName;

  @override
  Future<String> uploadCertificateTemplate({
    required String templateId,
    required Uint8List templateData,
    required String fileName,
  }) async {
    try {
      final objectKey = _buildTemplateObjectKey(templateId);
      final metadata = {
        'template-id': templateId,
        'original-filename': fileName,
        'uploaded-at': DateTime.now().toIso8601String(),
      };

      return await _objectStorageService.uploadObject(
        bucketName: _templatesBucketName,
        objectKey: objectKey,
        data: templateData,
        contentType: 'application/pdf',
        metadata: metadata,
      );
    } catch (e) {
      throw CertificateStorageException(
        'Failed to upload certificate template',
        operation: 'uploadTemplate',
        resourceId: templateId,
        cause: e,
      );
    }
  }

  @override
  Future<String> updateCertificateTemplate({
    required String templateId,
    required Uint8List templateData,
    required String fileName,
  }) async {
    try {
      // Check if template exists first
      final exists = await certificateTemplateExists(templateId: templateId);
      if (!exists) {
        throw CertificateStorageException(
          'Certificate template not found',
          operation: 'updateTemplate',
          resourceId: templateId,
        );
      }

      final objectKey = _buildTemplateObjectKey(templateId);
      final metadata = {
        'template-id': templateId,
        'original-filename': fileName,
        'uploaded-at': DateTime.now().toIso8601String(),
        'updated-at': DateTime.now().toIso8601String(),
      };

      // MinIO putObject automatically overwrites existing objects with the same key
      return await _objectStorageService.uploadObject(
        bucketName: _templatesBucketName,
        objectKey: objectKey,
        data: templateData,
        contentType: 'application/pdf',
        metadata: metadata,
      );
    } catch (e) {
      if (e is CertificateStorageException) {
        rethrow;
      }
      throw CertificateStorageException(
        'Failed to update certificate template',
        operation: 'updateTemplate',
        resourceId: templateId,
        cause: e,
      );
    }
  }

  @override
  Future<Uint8List> downloadCertificateTemplate({
    required String templateId,
  }) async {
    try {
      final objectKey = _buildTemplateObjectKey(templateId);
      return await _objectStorageService.downloadObject(
        bucketName: _templatesBucketName,
        objectKey: objectKey,
      );
    } catch (e) {
      throw CertificateStorageException(
        'Failed to download certificate template',
        operation: 'downloadTemplate',
        resourceId: templateId,
        cause: e,
      );
    }
  }

  @override
  Future<bool> deleteCertificateTemplate({required String templateId}) async {
    try {
      final objectKey = _buildTemplateObjectKey(templateId);
      return await _objectStorageService.deleteObject(
        bucketName: _templatesBucketName,
        objectKey: objectKey,
      );
    } catch (e) {
      throw CertificateStorageException(
        'Failed to delete certificate template',
        operation: 'deleteTemplate',
        resourceId: templateId,
        cause: e,
      );
    }
  }

  @override
  Future<String> uploadGeneratedCertificate({
    required String certificateId,
    required Uint8List certificateData,
    required String studentName,
    required String courseName,
  }) async {
    try {
      final objectKey = _buildCertificateObjectKey(certificateId);
      final metadata = {
        'certificate-id': certificateId,
        'student-name': studentName,
        'course-name': courseName,
        'generated-at': DateTime.now().toIso8601String(),
      };

      return await _objectStorageService.uploadObject(
        bucketName: _certificatesBucketName,
        objectKey: objectKey,
        data: certificateData,
        contentType: 'application/pdf',
        metadata: metadata,
      );
    } catch (e) {
      throw CertificateStorageException(
        'Failed to upload generated certificate',
        operation: 'uploadCertificate',
        resourceId: certificateId,
        cause: e,
      );
    }
  }

  @override
  Future<Uint8List> downloadGeneratedCertificate({
    required String certificateId,
  }) async {
    try {
      final objectKey = _buildCertificateObjectKey(certificateId);
      return await _objectStorageService.downloadObject(
        bucketName: _certificatesBucketName,
        objectKey: objectKey,
      );
    } catch (e) {
      throw CertificateStorageException(
        'Failed to download generated certificate',
        operation: 'downloadCertificate',
        resourceId: certificateId,
        cause: e,
      );
    }
  }

  @override
  Future<bool> deleteGeneratedCertificate({
    required String certificateId,
  }) async {
    try {
      final objectKey = _buildCertificateObjectKey(certificateId);
      return await _objectStorageService.deleteObject(
        bucketName: _certificatesBucketName,
        objectKey: objectKey,
      );
    } catch (e) {
      throw CertificateStorageException(
        'Failed to delete generated certificate',
        operation: 'deleteCertificate',
        resourceId: certificateId,
        cause: e,
      );
    }
  }

  @override
  Future<String> generateCertificateDownloadUrl({
    required String certificateId,
    Duration expiration = const Duration(hours: 1),
  }) async {
    try {
      final objectKey = _buildCertificateObjectKey(certificateId);
      return await _objectStorageService.generatePresignedUrl(
        bucketName: _certificatesBucketName,
        objectKey: objectKey,
        expiration: expiration,
      );
    } catch (e) {
      throw CertificateStorageException(
        'Failed to generate certificate download URL',
        operation: 'generateDownloadUrl',
        resourceId: certificateId,
        cause: e,
      );
    }
  }

  @override
  Future<bool> certificateTemplateExists({required String templateId}) async {
    try {
      final objectKey = _buildTemplateObjectKey(templateId);
      return await _objectStorageService.objectExists(
        bucketName: _templatesBucketName,
        objectKey: objectKey,
      );
    } catch (e) {
      throw CertificateStorageException(
        'Failed to check certificate template existence',
        operation: 'templateExists',
        resourceId: templateId,
        cause: e,
      );
    }
  }

  @override
  Future<bool> generatedCertificateExists({
    required String certificateId,
  }) async {
    try {
      final objectKey = _buildCertificateObjectKey(certificateId);
      return await _objectStorageService.objectExists(
        bucketName: _certificatesBucketName,
        objectKey: objectKey,
      );
    } catch (e) {
      throw CertificateStorageException(
        'Failed to check generated certificate existence',
        operation: 'certificateExists',
        resourceId: certificateId,
        cause: e,
      );
    }
  }

  @override
  Future<CertificateStorageInfo> getCertificateTemplateInfo({
    required String templateId,
  }) async {
    try {
      final objectKey = _buildTemplateObjectKey(templateId);
      final metadata = await _objectStorageService.getObjectMetadata(
        bucketName: _templatesBucketName,
        objectKey: objectKey,
      );

      return CertificateStorageInfo.fromObjectMetadata(
        id: templateId,
        storageUrl: objectKey,
        metadata: metadata,
      );
    } catch (e) {
      throw CertificateStorageException(
        'Failed to get certificate template info',
        operation: 'getTemplateInfo',
        resourceId: templateId,
        cause: e,
      );
    }
  }

  @override
  Future<CertificateStorageInfo> getGeneratedCertificateInfo({
    required String certificateId,
  }) async {
    try {
      final objectKey = _buildCertificateObjectKey(certificateId);
      final metadata = await _objectStorageService.getObjectMetadata(
        bucketName: _certificatesBucketName,
        objectKey: objectKey,
      );

      return CertificateStorageInfo.fromObjectMetadata(
        id: certificateId,
        storageUrl: objectKey,
        metadata: metadata,
      );
    } catch (e) {
      throw CertificateStorageException(
        'Failed to get generated certificate info',
        operation: 'getCertificateInfo',
        resourceId: certificateId,
        cause: e,
      );
    }
  }

  /// Builds the object key for a certificate template
  ///
  /// [templateId] The template identifier
  /// Returns a structured object key like 'templates/{templateId}.pdf'
  String _buildTemplateObjectKey(String templateId) {
    return 'templates/$templateId.pdf';
  }

  /// Builds the object key for a generated certificate
  ///
  /// [certificateId] The certificate identifier
  /// Returns a structured object key like 'certificates/{certificateId}.pdf'
  String _buildCertificateObjectKey(String certificateId) {
    return 'certificates/$certificateId.pdf';
  }
}
