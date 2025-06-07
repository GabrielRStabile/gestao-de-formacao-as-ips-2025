import 'dart:convert';

import 'package:vaden/vaden.dart';
import 'package:vaden/vaden_openapi.dart';

/// OpenAPI configuration for the audit service
///
/// Configures OpenAPI specification and Swagger UI
/// for API documentation and testing interface.
@Configuration()
class OpenApiConfiguration {
  /// Configures the OpenAPI specification
  ///
  /// Creates the OpenAPI specification with metadata,
  /// server information, and component schemas.
  ///
  /// [config] The OpenAPI configuration
  /// Returns configured [OpenApi] specification
  @Bean()
  OpenApi openApi(OpenApiConfig config) {
    return OpenApi(
      version: '3.0.0',
      info: Info(
        title: 'Certificate Service API',
        version: '1.0.0',
        description:
            'Comprehensive certificate management service with REST endpoints',
      ),
      servers: [config.localServer],
      tags: config.tags,
      paths: config.paths,
      components: Components(
        schemas: config.schemas,
        securitySchemes: {
          'bearer': SecurityScheme.http(
            scheme: HttpSecurityScheme.bearer,
            bearerFormat: 'JWT',
            description: 'Bearer token for authentication',
          ),
        },
      ),
    );
  }

  /// Configures the Swagger UI interface
  ///
  /// Creates a Swagger UI instance with custom settings
  /// for better user experience and documentation presentation.
  ///
  /// [openApi] The OpenAPI specification
  /// Returns configured [SwaggerUI] instance
  @Bean()
  SwaggerUI swaggerUI(OpenApi openApi) {
    return SwaggerUI(
      jsonEncode(openApi.toJson()),
      title: 'Certificate Service API',
      docExpansion: DocExpansion.list,
      deepLink: true,
      persistAuthorization: false,
      syntaxHighlightTheme: SyntaxHighlightTheme.agate,
    );
  }
}
