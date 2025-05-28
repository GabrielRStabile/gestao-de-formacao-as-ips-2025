import 'package:dotenv/dotenv.dart';
import 'package:vaden/vaden.dart';

/// Environment variables loader
/// Loads configuration from .env file
final env = DotEnv()..load();

/// Application configuration class
///
/// Configures the main application beans including settings,
/// middleware pipeline, and cross-origin resource sharing.
@Configuration()
class AppConfiguration {
  /// Configures application settings from YAML configuration
  ///
  /// Returns [ApplicationSettings] loaded from application.yaml
  @Bean()
  ApplicationSettings settings() {
    return ApplicationSettings.load('application.yaml');
  }

  /// Configures the global middleware pipeline
  ///
  /// Sets up CORS, JSON content type enforcement, and request logging.
  /// [settings] The application settings
  /// Returns configured [Pipeline] with middleware stack
  @Bean()
  Pipeline globalMiddleware(ApplicationSettings settings) {
    return Pipeline() //
        .addMiddleware(cors(allowedOrigins: ['*']))
        .addVadenMiddleware(EnforceJsonContentType())
        .addMiddleware(logRequests());
  }
}
