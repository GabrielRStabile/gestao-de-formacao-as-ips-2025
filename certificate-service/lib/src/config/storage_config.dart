import 'package:certificate_service/config/app_configuration.dart';

/// Configuration class for object storage settings
///
/// Contains all configuration parameters needed to connect to MinIO/S3 storage.
/// Values are typically loaded from environment variables.
class StorageConfig {
  /// MinIO/S3 server endpoint (e.g., 'localhost:9000' or 's3.amazonaws.com')
  final String endpoint;

  /// Access key for authentication
  final String accessKey;

  /// Secret key for authentication
  final String secretKey;

  /// Whether to use HTTPS/SSL (default: false for local development)
  final bool useSSL;

  /// Custom port if different from default (80 for HTTP, 443 for HTTPS)
  final int? port;

  /// Server region (optional, required for some S3 implementations)
  final String? region;

  /// Bucket name for certificate templates
  final String templatesBucketName;

  /// Bucket name for generated certificates
  final String certificatesBucketName;

  /// Creates a new StorageConfig instance
  const StorageConfig({
    required this.endpoint,
    required this.accessKey,
    required this.secretKey,
    this.useSSL = false,
    this.port,
    this.region,
    this.templatesBucketName = 'certificate-templates',
    this.certificatesBucketName = 'generated-certificates',
  });

  /// Creates StorageConfig from environment variables
  ///
  /// Expected environment variables:
  /// - MINIO_ENDPOINT: MinIO server endpoint
  /// - MINIO_ACCESS_KEY: Access key for authentication
  /// - MINIO_SECRET_KEY: Secret key for authentication
  /// - MINIO_USE_SSL: Whether to use SSL (optional, default: false)
  /// - MINIO_PORT: Custom port (optional)
  /// - MINIO_REGION: Server region (optional)
  /// - MINIO_TEMPLATES_BUCKET: Templates bucket name (optional)
  /// - MINIO_CERTIFICATES_BUCKET: Certificates bucket name (optional)
  factory StorageConfig.fromEnvironment() {
    final endpoint = env['MINIO_ENDPOINT'];
    final accessKey = env['MINIO_ACCESS_KEY'];
    final secretKey = env['MINIO_SECRET_KEY'];

    if (endpoint?.isEmpty ?? true) {
      throw ArgumentError('MINIO_ENDPOINT environment variable is required');
    }
    if (accessKey?.isEmpty ?? true) {
      throw ArgumentError('MINIO_ACCESS_KEY environment variable is required');
    }
    if (secretKey?.isEmpty ?? true) {
      throw ArgumentError('MINIO_SECRET_KEY environment variable is required');
    }

    return StorageConfig(
      endpoint: endpoint!,
      accessKey: accessKey!,
      secretKey: secretKey!,
      useSSL: env['MINIO_USE_SSL']?.toLowerCase() == 'true',
      region:
          env['MINIO_REGION']?.isNotEmpty == true ? env['MINIO_REGION'] : null,
      templatesBucketName:
          env['MINIO_TEMPLATES_BUCKET'] ?? 'certificate-templates',
      certificatesBucketName:
          env['MINIO_CERTIFICATES_BUCKET'] ?? 'generated-certificates',
    );
  }

  /// Creates StorageConfig from a Map (useful for loading from config files)
  factory StorageConfig.fromMap(Map<String, dynamic> map) {
    return StorageConfig(
      endpoint: map['endpoint'] as String,
      accessKey: map['accessKey'] as String,
      secretKey: map['secretKey'] as String,
      useSSL: map['useSSL'] as bool? ?? false,
      port: map['port'] as int?,
      region: map['region'] as String?,
      templatesBucketName:
          map['templatesBucketName'] as String? ?? 'certificate-templates',
      certificatesBucketName:
          map['certificatesBucketName'] as String? ?? 'generated-certificates',
    );
  }

  /// Converts StorageConfig to a Map
  Map<String, dynamic> toMap() {
    return {
      'endpoint': endpoint,
      'accessKey': accessKey,
      'secretKey': secretKey,
      'useSSL': useSSL,
      'port': port,
      'region': region,
      'templatesBucketName': templatesBucketName,
      'certificatesBucketName': certificatesBucketName,
    };
  }

  @override
  String toString() {
    return 'StorageConfig(endpoint: $endpoint, useSSL: $useSSL, port: $port, '
        'region: $region, templatesBucket: $templatesBucketName, '
        'certificatesBucket: $certificatesBucketName)';
  }
}
