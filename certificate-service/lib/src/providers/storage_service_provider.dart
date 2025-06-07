import 'package:vaden/vaden.dart';

import '../config/storage_config.dart';
import '../services/storage/certificate_storage_service.dart';
import '../services/storage/minio_certificate_storage_service.dart';
import '../services/storage/minio_object_storage_service.dart';
import '../services/storage/object_storage_service.dart';
import '../services/storage/storage_initialization_service.dart';

/// Service provider for storage-related services
///
/// Configures and provides dependency injection for storage services
/// including MinIO client configuration and bucket setup.
@Configuration()
class StorageServiceProvider {
  /// Provides StorageConfig instance from environment variables
  @Bean()
  StorageConfig storageConfig() {
    return StorageConfig.fromEnvironment();
  }

  /// Provides ObjectStorageService implementation using MinIO
  @Bean()
  ObjectStorageService objectStorageService() {
    final config = storageConfig();

    return MinIOObjectStorageService.connect(
      endpoint: config.endpoint,
      accessKey: config.accessKey,
      secretKey: config.secretKey,
      useSSL: config.useSSL,
      port: config.port,
      region: config.region,
    );
  }

  /// Provides CertificateStorageService implementation
  @Bean()
  CertificateStorageService certificateStorageService() {
    final config = storageConfig();
    final objectStorage = objectStorageService();

    return MinIOCertificateStorageService(
      objectStorage,
      templatesBucketName: config.templatesBucketName,
      certificatesBucketName: config.certificatesBucketName,
    );
  }

  /// Provides StorageInitializationService for setup
  @Bean()
  StorageInitializationService storageInitializationService() {
    final config = storageConfig();
    final minioService = objectStorageService() as MinIOObjectStorageService;

    return StorageInitializationService(config, minioService);
  }
}
