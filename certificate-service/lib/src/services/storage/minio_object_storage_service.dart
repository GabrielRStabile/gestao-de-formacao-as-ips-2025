import 'dart:typed_data';

import 'package:minio/minio.dart';

import 'object_storage_service.dart';

/// MinIO implementation of ObjectStorageService
///
/// Provides concrete implementation for object storage operations using MinIO client.
/// This service is compatible with MinIO and Amazon S3 storage systems.
class MinIOObjectStorageService implements ObjectStorageService {
  final Minio _client;

  /// Creates a new MinIOObjectStorageService instance
  ///
  /// [client] Configured MinIO client instance
  MinIOObjectStorageService({required Minio client}) : _client = client;

  /// Factory constructor to create service with connection parameters
  ///
  /// [endpoint] MinIO server endpoint (e.g., 'localhost:9000')
  /// [accessKey] Access key for authentication
  /// [secretKey] Secret key for authentication
  /// [useSSL] Whether to use HTTPS (default: false for local development)
  /// [port] Custom port if different from default
  /// [region] Server region (optional)
  factory MinIOObjectStorageService.connect({
    required String endpoint,
    required String accessKey,
    required String secretKey,
    bool useSSL = false,
    int? port,
    String? region,
  }) {
    final client = Minio(
      endPoint: endpoint,
      accessKey: accessKey,
      secretKey: secretKey,
      useSSL: useSSL,
      port: port,
      region: region,
    );

    return MinIOObjectStorageService(client: client);
  }

  @override
  Future<String> uploadObject({
    required String bucketName,
    required String objectKey,
    required Uint8List data,
    required String contentType,
    Map<String, String>? metadata,
  }) async {
    try {
      // Ensure bucket exists
      await _ensureBucketExists(bucketName);

      // Convert metadata to MinIO format
      final minioMetadata = metadata?.map(
        (key, value) => MapEntry('x-amz-meta-$key', value),
      );

      // Upload object
      await _client.putObject(
        bucketName,
        objectKey,
        Stream.fromIterable([data]),
        size: data.length,
        metadata: minioMetadata,
      );

      // Return the object key as the identifier
      return objectKey;
    } catch (e) {
      throw ObjectStorageException(
        'Failed to upload object $objectKey to bucket $bucketName',
        cause: e,
      );
    }
  }

  @override
  Future<Uint8List> downloadObject({
    required String bucketName,
    required String objectKey,
  }) async {
    try {
      final stream = await _client.getObject(bucketName, objectKey);
      final bytes = <int>[];

      await for (final chunk in stream) {
        bytes.addAll(chunk);
      }

      return Uint8List.fromList(bytes);
    } catch (e) {
      if (e.toString().contains('NoSuchKey') || e.toString().contains('404')) {
        throw ObjectStorageException(
          'Object $objectKey not found in bucket $bucketName',
          statusCode: 404,
          cause: e,
        );
      }
      throw ObjectStorageException(
        'Failed to download object $objectKey from bucket $bucketName',
        cause: e,
      );
    }
  }

  @override
  Future<bool> deleteObject({
    required String bucketName,
    required String objectKey,
  }) async {
    try {
      await _client.removeObject(bucketName, objectKey);
      return true;
    } catch (e) {
      throw ObjectStorageException(
        'Failed to delete object $objectKey from bucket $bucketName',
        cause: e,
      );
    }
  }

  @override
  Future<String> generatePresignedUrl({
    required String bucketName,
    required String objectKey,
    required Duration expiration,
  }) async {
    try {
      return await _client.presignedGetObject(
        bucketName,
        objectKey,
        expires: expiration.inSeconds,
      );
    } catch (e) {
      throw ObjectStorageException(
        'Failed to generate presigned URL for object $objectKey in bucket $bucketName',
        cause: e,
      );
    }
  }

  @override
  Future<bool> objectExists({
    required String bucketName,
    required String objectKey,
  }) async {
    try {
      await _client.statObject(bucketName, objectKey);
      return true;
    } catch (e) {
      // If object doesn't exist, statObject throws an exception
      if (e.toString().contains('NoSuchKey') || e.toString().contains('404')) {
        return false;
      }
      throw ObjectStorageException(
        'Failed to check existence of object $objectKey in bucket $bucketName',
        cause: e,
      );
    }
  }

  @override
  Future<ObjectMetadata> getObjectMetadata({
    required String bucketName,
    required String objectKey,
  }) async {
    try {
      final stat = await _client.statObject(bucketName, objectKey);

      // Extract custom metadata (remove MinIO prefix)
      final customMetadata = <String, String>{};
      stat.metaData?.forEach((key, value) {
        if (key.startsWith('x-amz-meta-')) {
          final customKey = key.substring('x-amz-meta-'.length);
          customMetadata[customKey] = value ?? '';
        }
      });

      return ObjectMetadata(
        size: stat.size ?? 0,
        contentType:
            stat.metaData?['content-type'] ?? 'application/octet-stream',
        lastModified: stat.lastModified ?? DateTime.now(),
        etag: stat.etag ?? '',
        metadata: customMetadata,
      );
    } catch (e) {
      if (e.toString().contains('NoSuchKey') || e.toString().contains('404')) {
        throw ObjectStorageException(
          'Object $objectKey not found in bucket $bucketName',
          statusCode: 404,
          cause: e,
        );
      }
      throw ObjectStorageException(
        'Failed to get metadata for object $objectKey in bucket $bucketName',
        cause: e,
      );
    }
  }

  /// Lists all objects in a bucket with optional prefix filtering
  ///
  /// [bucketName] The name of the bucket to list objects from
  /// [prefix] Optional prefix to filter objects
  /// [recursive] Whether to list objects recursively (default: true)
  ///
  /// Returns a list of object names
  /// Throws [ObjectStorageException] if listing fails
  Future<List<String>> listObjects({
    required String bucketName,
    String? prefix,
    bool recursive = true,
  }) async {
    try {
      final objects =
          await _client
              .listObjects(
                bucketName,
                prefix: prefix ?? '',
                recursive: recursive,
              )
              .toList();

      return objects
              .expand((obj) => obj.objects)
              .map((obj) => obj.key)
              .where((key) => key != null)
              .toList()
          as List<String>;
    } catch (e) {
      throw ObjectStorageException(
        'Failed to list objects in bucket $bucketName',
        cause: e,
      );
    }
  }

  /// Gets a list of all buckets
  ///
  /// Returns a list of bucket names
  /// Throws [ObjectStorageException] if operation fails
  Future<List<String>> listBuckets() async {
    try {
      final buckets = await _client.listBuckets();
      return buckets
          .map((bucket) => bucket.name)
          .where((name) => name.isNotEmpty)
          .toList();
    } catch (e) {
      throw ObjectStorageException('Failed to list buckets', cause: e);
    }
  }

  /// Creates a new bucket if it doesn't exist
  ///
  /// [bucketName] The name of the bucket to create
  /// [region] Optional region for the bucket
  ///
  /// Returns true if bucket was created or already exists
  /// Throws [ObjectStorageException] if creation fails
  Future<bool> createBucket({
    required String bucketName,
    String? region,
  }) async {
    try {
      final exists = await _client.bucketExists(bucketName);
      if (!exists) {
        await _client.makeBucket(bucketName, region);
      }
      return true;
    } catch (e) {
      throw ObjectStorageException(
        'Failed to create bucket $bucketName',
        cause: e,
      );
    }
  }

  /// Ensures a bucket exists, creating it if necessary
  Future<void> _ensureBucketExists(String bucketName) async {
    try {
      final exists = await _client.bucketExists(bucketName);
      if (!exists) {
        await _client.makeBucket(bucketName);
      }
    } catch (e) {
      throw ObjectStorageException(
        'Failed to ensure bucket $bucketName exists',
        cause: e,
      );
    }
  }
}
