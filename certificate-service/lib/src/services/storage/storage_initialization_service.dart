import '../../config/storage_config.dart';
import 'minio_object_storage_service.dart';

/// Service responsible for initializing storage infrastructure
///
/// This service ensures that required buckets exist and are properly configured
/// during application startup.
class StorageInitializationService {
  final StorageConfig _config;
  final MinIOObjectStorageService _storageService;

  StorageInitializationService(this._config, this._storageService);

  /// Initializes storage infrastructure
  ///
  /// Creates required buckets if they don't exist and sets up any necessary
  /// policies or configurations.
  ///
  /// Should be called during application startup.
  /// Throws [Exception] if initialization fails
  Future<void> initialize() async {
    await _storageService.createBucket(
      bucketName: _config.templatesBucketName,
      region: _config.region,
    );

    await _storageService.createBucket(
      bucketName: _config.certificatesBucketName,
      region: _config.region,
    );
  }

  /// Validates storage configuration
  ///
  /// Checks if the storage service is accessible and properly configured.
  /// Returns true if everything is working correctly.
  Future<bool> validateConfiguration() async {
    try {
      // Try to list buckets to verify connection
      final buckets = await _storageService.listBuckets();

      // Check if required buckets exist
      final templatesBucketExists = buckets.contains(
        _config.templatesBucketName,
      );
      final certificatesBucketExists = buckets.contains(
        _config.certificatesBucketName,
      );

      final isValid = templatesBucketExists && certificatesBucketExists;

      return isValid;
    } catch (e) {
      return false;
    }
  }

  /// Gets storage service health information
  ///
  /// Returns a map containing health status and metrics about the storage service.
  Future<Map<String, dynamic>> getHealthInfo() async {
    try {
      final buckets = await _storageService.listBuckets();

      final health = <String, dynamic>{
        'status': 'healthy',
        'totalBuckets': buckets.length,
        'requiredBuckets': {
          'templates': {
            'name': _config.templatesBucketName,
            'exists': buckets.contains(_config.templatesBucketName),
          },
          'certificates': {
            'name': _config.certificatesBucketName,
            'exists': buckets.contains(_config.certificatesBucketName),
          },
        },
        'configuration': {
          'endpoint': _config.endpoint,
          'useSSL': _config.useSSL,
          'region': _config.region,
        },
        'timestamp': DateTime.now().toIso8601String(),
      };

      return health;
    } catch (e) {
      return {
        'status': 'unhealthy',
        'error': e.toString(),
        'timestamp': DateTime.now().toIso8601String(),
      };
    }
  }
}
