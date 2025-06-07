import 'dart:async';

import 'package:certificate_service/src/providers/amqp_provider.dart';
import 'package:certificate_service/src/services/enrollment_event_processor.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:vaden/vaden.dart';

/// Component that listens to enrollment event messages from RabbitMQ
///
/// Establishes connection to the enrollment_events queue and processes
/// incoming messages through the enrollment event processor.
/// Handles message acknowledgment and error recovery.
@Component()
class EnrollmentEventListener {
  /// Provider for AMQP/RabbitMQ operations
  final AmqpProvider _amqpProvider;

  /// Processor for handling enrollment event messages
  final EnrollmentEventProcessor _enrollmentEventProcessor;

  /// Creates a new instance of EnrollmentEventListener
  ///
  /// [_amqpProvider] The AMQP provider for queue operations
  /// [_enrollmentEventProcessor] The processor for enrollment events
  ///
  /// Automatically initializes the message listener upon creation
  EnrollmentEventListener(this._amqpProvider, this._enrollmentEventProcessor) {
    _initialize();
  }

  /// Initializes the message listener for the enrollment_events queue
  ///
  /// Sets up message consumption with proper acknowledgment handling.
  /// Messages are processed through the enrollment event processor.
  /// Failed messages are rejected and may be sent to dead letter queue.
  Future<void> _initialize() async {
    late final StreamSubscription<AmqpMessage> subscription;

    subscription = await _amqpProvider.listenToQueue(
      'enrollment_events',
      onMessage: (message) async {
        final processed = await _enrollmentEventProcessor.processMessage(
          message.payloadAsString,
        );

        if (!processed) {
          print('Failed to process message: ${message.payloadAsString}');
          message.reject(false);
          subscription.cancel();
          _initialize();
          return;
        }

        message.ack();
      },
    );
  }
}
