import 'package:audit_service/src/controllers/audit_event_listener.dart';
import 'package:vaden/vaden.dart';

/// Application warmup component
///
/// Initializes components that need to be started
/// during application startup, such as message listeners.
@Component(true)
class AppWarnup implements ApplicationRunner {
  /// Runs the application warmup process
  ///
  /// Initializes the audit event listener to start
  /// consuming messages from RabbitMQ immediately.
  ///
  /// [app] The Vaden application instance
  @override
  Future<void> run(VadenApplication app) async {
    app.injector.get<AuditEventListener>();
  }
}
