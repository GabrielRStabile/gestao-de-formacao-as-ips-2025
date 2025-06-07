import 'dart:typed_data';

/// Interface for object storage operations
///
/// Defines the contract for object storage services that are compatible with S3/MinIO.
/// Provides methods for uploading, downloading, and deleting objects from storage.
abstract class ObjectStorageService {
  /// Uploads an object to the storage bucket
  ///
  /// [bucketName] The name of the bucket where the object will be stored
  /// [objectKey] The unique key/path for the object within the bucket
  /// [data] The file data to upload as Uint8List
  /// [contentType] MIME type of the file (e.g., 'application/pdf', 'image/png')
  /// [metadata] Optional metadata to associate with the object
  ///
  /// Returns the URL or key of the uploaded object
  /// Throws [ObjectStorageException] if upload fails
  Future<String> uploadObject({
    required String bucketName,
    required String objectKey,
    required Uint8List data,
    required String contentType,
    Map<String, String>? metadata,
  });

  /// Downloads an object from the storage bucket
  ///
  /// [bucketName] The name of the bucket containing the object
  /// [objectKey] The unique key/path of the object to download
  ///
  /// Returns the object data as Uint8List
  /// Throws [ObjectStorageException] if download fails or object not found
  Future<Uint8List> downloadObject({
    required String bucketName,
    required String objectKey,
  });

  /// Deletes an object from the storage bucket
  ///
  /// [bucketName] The name of the bucket containing the object
  /// [objectKey] The unique key/path of the object to delete
  ///
  /// Returns true if deletion was successful
  /// Throws [ObjectStorageException] if deletion fails
  Future<bool> deleteObject({
    required String bucketName,
    required String objectKey,
  });

  /// Generates a pre-signed URL for temporary access to an object
  ///
  /// [bucketName] The name of the bucket containing the object
  /// [objectKey] The unique key/path of the object
  /// [expiration] Duration for which the URL will be valid
  ///
  /// Returns a pre-signed URL string
  /// Throws [ObjectStorageException] if URL generation fails
  Future<String> generatePresignedUrl({
    required String bucketName,
    required String objectKey,
    required Duration expiration,
  });

  /// Checks if an object exists in the storage bucket
  ///
  /// [bucketName] The name of the bucket to check
  /// [objectKey] The unique key/path of the object to check
  ///
  /// Returns true if the object exists, false otherwise
  /// Throws [ObjectStorageException] if check operation fails
  Future<bool> objectExists({
    required String bucketName,
    required String objectKey,
  });

  /// Gets metadata information about an object
  ///
  /// [bucketName] The name of the bucket containing the object
  /// [objectKey] The unique key/path of the object
  ///
  /// Returns [ObjectMetadata] containing object information
  /// Throws [ObjectStorageException] if object not found or operation fails
  Future<ObjectMetadata> getObjectMetadata({
    required String bucketName,
    required String objectKey,
  });
}

/// Metadata information about a stored object
class ObjectMetadata {
  /// Size of the object in bytes
  final int size;

  /// Content type/MIME type of the object
  final String contentType;

  /// Last modified timestamp
  final DateTime lastModified;

  /// ETag/checksum of the object
  final String etag;

  /// Custom metadata associated with the object
  final Map<String, String> metadata;

  /// Creates a new ObjectMetadata instance
  const ObjectMetadata({
    required this.size,
    required this.contentType,
    required this.lastModified,
    required this.etag,
    required this.metadata,
  });

  /// Creates ObjectMetadata from a Map
  factory ObjectMetadata.fromMap(Map<String, dynamic> map) {
    return ObjectMetadata(
      size: map['size'] as int,
      contentType: map['contentType'] as String,
      lastModified: DateTime.parse(map['lastModified'] as String),
      etag: map['etag'] as String,
      metadata: Map<String, String>.from(map['metadata'] as Map),
    );
  }

  /// Converts ObjectMetadata to a Map
  Map<String, dynamic> toMap() {
    return {
      'size': size,
      'contentType': contentType,
      'lastModified': lastModified.toIso8601String(),
      'etag': etag,
      'metadata': metadata,
    };
  }

  @override
  String toString() {
    return 'ObjectMetadata(size: $size, contentType: $contentType, '
        'lastModified: $lastModified, etag: $etag, metadata: $metadata)';
  }
}

/// Exception thrown by object storage operations
class ObjectStorageException implements Exception {
  /// Error message describing what went wrong
  final String message;

  /// Optional error code from the storage service
  final String? code;

  /// Optional HTTP status code if applicable
  final int? statusCode;

  /// Optional underlying exception that caused this error
  final dynamic cause;

  /// Creates a new ObjectStorageException
  const ObjectStorageException(
    this.message, {
    this.code,
    this.statusCode,
    this.cause,
  });

  @override
  String toString() {
    var result = 'ObjectStorageException: $message';
    if (code != null) result += ' (code: $code)';
    if (statusCode != null) result += ' (status: $statusCode)';
    if (cause != null) result += ' (cause: $cause)';
    return result;
  }
}
