import 'dart:typed_data';

import 'object_storage_service.dart';

/// Service interface for certificate document storage operations
///
/// Provides high-level operations for managing certificate templates and
/// generated certificates in object storage. Acts as a facade over the
/// generic ObjectStorageService with certificate-specific functionality.
abstract class CertificateStorageService {
  /// Uploads a certificate template PDF
  ///
  /// [templateId] Unique identifier for the template
  /// [templateData] PDF data as Uint8List
  /// [fileName] Original filename of the template
  ///
  /// Returns the storage URL/key for the uploaded template
  /// Throws [CertificateStorageException] if upload fails
  Future<String> uploadCertificateTemplate({
    required String templateId,
    required Uint8List templateData,
    required String fileName,
  });

  /// Updates an existing certificate template PDF
  ///
  /// [templateId] Unique identifier for the template
  /// [templateData] New PDF data as Uint8List
  /// [fileName] New filename of the template
  ///
  /// Returns the storage URL/key for the updated template
  /// Throws [CertificateStorageException] if update fails or template not found
  Future<String> updateCertificateTemplate({
    required String templateId,
    required Uint8List templateData,
    required String fileName,
  });

  /// Downloads a certificate template PDF
  ///
  /// [templateId] Unique identifier for the template
  ///
  /// Returns the template PDF data as Uint8List
  /// Throws [CertificateStorageException] if template not found or download fails
  Future<Uint8List> downloadCertificateTemplate({required String templateId});

  /// Deletes a certificate template from storage
  ///
  /// [templateId] Unique identifier for the template
  ///
  /// Returns true if deletion was successful
  /// Throws [CertificateStorageException] if deletion fails
  Future<bool> deleteCertificateTemplate({required String templateId});

  /// Uploads a generated certificate PDF
  ///
  /// [certificateId] Unique identifier for the certificate
  /// [certificateData] PDF data as Uint8List
  /// [studentName] Name of the student for metadata
  /// [courseName] Name of the course for metadata
  ///
  /// Returns the storage URL/key for the uploaded certificate
  /// Throws [CertificateStorageException] if upload fails
  Future<String> uploadGeneratedCertificate({
    required String certificateId,
    required Uint8List certificateData,
    required String studentName,
    required String courseName,
  });

  /// Downloads a generated certificate PDF
  ///
  /// [certificateId] Unique identifier for the certificate
  ///
  /// Returns the certificate PDF data as Uint8List
  /// Throws [CertificateStorageException] if certificate not found or download fails
  Future<Uint8List> downloadGeneratedCertificate({
    required String certificateId,
  });

  /// Deletes a generated certificate from storage
  ///
  /// [certificateId] Unique identifier for the certificate
  ///
  /// Returns true if deletion was successful
  /// Throws [CertificateStorageException] if deletion fails
  Future<bool> deleteGeneratedCertificate({required String certificateId});

  /// Generates a temporary download URL for a certificate
  ///
  /// [certificateId] Unique identifier for the certificate
  /// [expiration] Duration for which the URL will be valid (default: 1 hour)
  ///
  /// Returns a pre-signed URL for temporary access
  /// Throws [CertificateStorageException] if URL generation fails
  Future<String> generateCertificateDownloadUrl({
    required String certificateId,
    Duration expiration = const Duration(hours: 1),
  });

  /// Checks if a certificate template exists in storage
  ///
  /// [templateId] Unique identifier for the template
  ///
  /// Returns true if the template exists, false otherwise
  Future<bool> certificateTemplateExists({required String templateId});

  /// Checks if a generated certificate exists in storage
  ///
  /// [certificateId] Unique identifier for the certificate
  ///
  /// Returns true if the certificate exists, false otherwise
  Future<bool> generatedCertificateExists({required String certificateId});

  /// Gets storage information about a certificate template
  ///
  /// [templateId] Unique identifier for the template
  ///
  /// Returns [CertificateStorageInfo] with template information
  /// Throws [CertificateStorageException] if template not found
  Future<CertificateStorageInfo> getCertificateTemplateInfo({
    required String templateId,
  });

  /// Gets storage information about a generated certificate
  ///
  /// [certificateId] Unique identifier for the certificate
  ///
  /// Returns [CertificateStorageInfo] with certificate information
  /// Throws [CertificateStorageException] if certificate not found
  Future<CertificateStorageInfo> getGeneratedCertificateInfo({
    required String certificateId,
  });
}

/// Information about a stored certificate or template
class CertificateStorageInfo {
  /// Unique identifier
  final String id;

  /// Storage URL/key
  final String storageUrl;

  /// File size in bytes
  final int sizeBytes;

  /// Content type (should be 'application/pdf')
  final String contentType;

  /// When the file was uploaded/last modified
  final DateTime lastModified;

  /// Original filename if available
  final String? originalFileName;

  /// Additional metadata
  final Map<String, String> metadata;

  /// Creates a new CertificateStorageInfo instance
  const CertificateStorageInfo({
    required this.id,
    required this.storageUrl,
    required this.sizeBytes,
    required this.contentType,
    required this.lastModified,
    this.originalFileName,
    required this.metadata,
  });

  /// Creates CertificateStorageInfo from ObjectMetadata
  factory CertificateStorageInfo.fromObjectMetadata({
    required String id,
    required String storageUrl,
    required ObjectMetadata metadata,
  }) {
    return CertificateStorageInfo(
      id: id,
      storageUrl: storageUrl,
      sizeBytes: metadata.size,
      contentType: metadata.contentType,
      lastModified: metadata.lastModified,
      originalFileName: metadata.metadata['original-filename'],
      metadata: metadata.metadata,
    );
  }

  /// Converts to a Map representation
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'storageUrl': storageUrl,
      'sizeBytes': sizeBytes,
      'contentType': contentType,
      'lastModified': lastModified.toIso8601String(),
      'originalFileName': originalFileName,
      'metadata': metadata,
    };
  }

  @override
  String toString() {
    return 'CertificateStorageInfo(id: $id, storageUrl: $storageUrl, '
        'sizeBytes: $sizeBytes, contentType: $contentType, '
        'lastModified: $lastModified, originalFileName: $originalFileName)';
  }
}

/// Exception thrown by certificate storage operations
class CertificateStorageException implements Exception {
  /// Error message describing what went wrong
  final String message;

  /// Type of storage operation that failed
  final String operation;

  /// Identifier of the certificate/template involved
  final String? resourceId;

  /// Optional underlying exception
  final dynamic cause;

  /// Creates a new CertificateStorageException
  const CertificateStorageException(
    this.message, {
    required this.operation,
    this.resourceId,
    this.cause,
  });

  @override
  String toString() {
    var result = 'CertificateStorageException [$operation]: $message';
    if (resourceId != null) result += ' (resource: $resourceId)';
    if (cause != null) result += ' (cause: $cause)';
    return result;
  }
}
