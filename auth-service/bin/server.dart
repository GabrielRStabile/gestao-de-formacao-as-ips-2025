import 'package:auth_service/vaden_application.dart';

/// Main entry point for the audit service application
///
/// Initializes and starts the Vaden application server
/// with all configured components and middleware.
Future<void> main(List<String> args) async {
  final vaden = VadenApplicationImpl();
  await vaden.setup();
  final server = await vaden.run(args);
  print('Server listening on port ${server.port}');
}
