import 'dart:async';

import 'package:certificate_service/src/providers/amqp_provider.dart';
import 'package:certificate_service/src/services/certificate_event_processor.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:vaden/vaden.dart';

/// Component that listens to certificate event messages from RabbitMQ
///
/// Establishes connection to the certificate_events queue and processes
/// incoming messages through the certificate event processor.
/// Handles message acknowledgment and error recovery.
@Component()
class CertificateEventListener {
  /// Provider for AMQP/RabbitMQ operations
  final AmqpProvider _amqpProvider;

  /// Processor for handling certificate event messages
  final CertificateEventProcessor _certificateEventProcessor;

  /// Creates a new instance of CertificateEventListener
  ///
  /// [_amqpProvider] The AMQP provider for queue operations
  /// [_certificateEventProcessor] The processor for certificate events
  ///
  /// Automatically initializes the message listener upon creation
  CertificateEventListener(
    this._amqpProvider,
    this._certificateEventProcessor,
  ) {
    _initialize();
  }

  /// Initializes the message listener for the certificate_events queue
  ///
  /// Sets up message consumption with proper acknowledgment handling.
  /// Messages are processed through the certificate event processor.
  /// Failed messages are rejected and may be sent to dead letter queue.
  Future<void> _initialize() async {
    late final StreamSubscription<AmqpMessage> subscription;

    subscription = await _amqpProvider.listenToQueue(
      'certificate_events',
      onMessage: (message) async {
        final processed = await _certificateEventProcessor.processMessage(
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
