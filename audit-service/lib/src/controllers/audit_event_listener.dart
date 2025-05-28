import 'dart:async';

import 'package:audit_service/src/providers/amqp_provider.dart';
import 'package:audit_service/src/services/audit_event_processor.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:vaden/vaden.dart';

/// Component that listens to audit event messages from RabbitMQ
///
/// Establishes connection to the audit_events queue and processes
/// incoming messages through the audit event processor.
/// Handles message acknowledgment and error recovery.
@Component()
class AuditEventListener {
  /// Provider for AMQP/RabbitMQ operations
  AmqpProvider amqpProvider;

  /// Processor for handling audit event messages
  AuditEventProcessor auditEventProcessor;

  /// Creates a new instance of AuditEventListener
  ///
  /// [amqpProvider] The AMQP provider for queue operations
  /// [auditEventProcessor] The processor for audit events
  ///
  /// Automatically initializes the message listener upon creation
  AuditEventListener(this.amqpProvider, this.auditEventProcessor) {
    _initialize();
  }

  /// Initializes the message listener for the audit_events queue
  ///
  /// Sets up message consumption with proper acknowledgment handling.
  /// Messages are processed through the audit event processor.
  /// Failed messages are rejected and may be sent to dead letter queue.
  Future<void> _initialize() async {
    late final StreamSubscription<AmqpMessage> subscription;

    subscription = await amqpProvider.listenToQueue(
      'audit_events',
      onMessage: (message) async {
        final processed = await auditEventProcessor.processMessage(
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
