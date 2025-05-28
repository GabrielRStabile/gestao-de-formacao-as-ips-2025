import 'dart:async';

import 'package:vaden/vaden.dart';
import 'package:vaden/vaden_openapi.dart' hide Response;

/// Controller for serving OpenAPI documentation
///
/// Provides endpoints for accessing Swagger UI and OpenAPI JSON schema.
/// Documentation access can be controlled via application settings.
@Controller('/docs')
class OpenAPIController {
  /// Swagger UI service for rendering documentation
  final SwaggerUI swaggerUI;

  /// Application settings for configuration
  final ApplicationSettings settings;

  /// Creates a new OpenAPIController
  ///
  /// [swaggerUI] The Swagger UI service
  /// [settings] The application settings
  const OpenAPIController(this.swaggerUI, this.settings);

  /// Serves the Swagger UI documentation interface
  ///
  /// Returns the Swagger UI if OpenAPI is enabled in settings,
  /// otherwise returns a 404 Not Found response.
  ///
  /// [request] The HTTP request
  /// Returns [Response] with Swagger UI or 404
  @Get('/')
  FutureOr<Response> getSwagger(Request request) {
    if (settings['openapi']['enable'] == true) {
      return swaggerUI.call(request);
    }

    return Response.notFound('Not Found');
  }

  /// Serves the OpenAPI JSON schema
  ///
  /// Returns the OpenAPI specification in JSON format
  /// for API documentation and client generation.
  ///
  /// [request] The HTTP request
  /// Returns [Response] with OpenAPI JSON schema
  @Get('/openapi.json')
  Response getOpenApiJSON(Request request) {
    return Response.ok(
      swaggerUI.schemaText,
      headers: {'Content-Type': 'application/json'},
    );
  }
}
