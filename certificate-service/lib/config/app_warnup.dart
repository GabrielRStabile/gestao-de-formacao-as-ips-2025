import 'package:certificate_service/src/controllers/enrollment_event_listener.dart';
import 'package:certificate_service/src/services/event_publisher.dart';
import 'package:vaden/vaden.dart';

/// Application warmup component
///
/// Initializes components that need to be started
/// during application startup, such as message listeners.
@Component(true)
class AppWarnup implements ApplicationRunner {
  /// Runs the application warmup process
  ///
  /// Initializes the event publisher and enrollment event listener
  ///
  /// [app] The Vaden application instance
  @override
  Future<void> run(VadenApplication app) async {
    app.injector.get<EventPublisher>().initialize();
    app.injector.get<EnrollmentEventListener>();
  }
}
