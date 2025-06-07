import 'dart:async';

import 'package:audit_service/config/app_configuration.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:vaden/vaden.dart';

/// Provider for AMQP/RabbitMQ operations
///
/// Manages connections to RabbitMQ and provides methods for
/// consuming messages from queues. Handles connection configuration
/// using environment variables.
@Component()
class AmqpProvider {
  /// AMQP client configured with connection settings from environment
  final client = Client(
    settings: ConnectionSettings(
      host: env['AMQP_HOST'] ?? 'localhost',
      port: int.tryParse(env['AMQP_PORT'] ?? '5672') ?? 5672,
      authProvider: PlainAuthenticator(
        env['AMQP_USER'] ?? 'guest',
        env['AMQP_PASSWORD'] ?? 'guest',
      ),
    ),
  );

  /// Sets up a listener for messages from a specific queue
  ///
  /// Creates a durable queue and starts consuming messages.
  /// Returns a StreamSubscription that can be used to cancel the listener.
  ///
  /// [queueName] Name of the queue to listen to
  /// [onMessage] Callback function to handle incoming messages
  /// [onError] Optional error handler for consumption errors
  /// [onDone] Optional callback when the stream is closed
  ///
  /// Returns a StreamSubscription for the message consumer
  Future<StreamSubscription<AmqpMessage>> listenToQueue(
    String queueName, {
    required Function(AmqpMessage) onMessage,
    Function? onError,
    void Function()? onDone,
  }) async {
    final channel = await client.channel();
    final queue = await channel.queue(queueName, durable: true);
    final consumer = await queue.consume(noAck: true);

    return consumer.listen(
      (message) => onMessage(message),
      onError:
          onError ??
          (error) {
            print('Error consuming messages from queue $queueName: $error');
          },
    );
  }
}
