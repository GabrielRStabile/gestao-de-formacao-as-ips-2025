import 'dart:convert';

import 'package:certificate_service/config/app_configuration.dart';
import 'package:dart_amqp/dart_amqp.dart';
import 'package:uuid/uuid.dart';
import 'package:vaden/vaden.dart' as vaden;

/// Event publisher for RabbitMQ messaging
///
/// Publishes authentication-related events to message queues
@vaden.Component()
class EventPublisher {
  Client? _client;
  Channel? _channel;

  static String get _host => env['AMQP_HOST'] ?? 'localhost';
  static int get _port => int.tryParse(env['AMQP_PORT'] ?? '5672') ?? 5672;
  static String get _username => env['AMQP_USER'] ?? 'guest';
  static String get _password => env['AMQP_PASSWORD'] ?? 'guest';

  /// Exchange name for authentication events
  static const String _authExchangeName = 'auth.events';
  late final Exchange _authExchange;

  /// Exchange name for audit events
  static const String _auditExchangeName = 'audit.events';
  late final Exchange _auditExchange;

  /// Initializes the RabbitMQ connection
  Future<void> initialize() async {
    try {
      final settings = ConnectionSettings(
        host: _host,
        port: _port,
        authProvider: PlainAuthenticator(_username, _password),
      );

      _client = Client(settings: settings);
      _channel = await _client!.channel();

      // Declare exchanges
      _authExchange = await _channel!.exchange(
        _authExchangeName,
        ExchangeType.TOPIC,
        durable: true,
      );

      _auditExchange = await _channel!.exchange(
        _auditExchangeName,
        ExchangeType.DIRECT,
        durable: true,
      );

      print('EventPublisher initialized successfully');
    } catch (e) {
      print('Failed to initialize EventPublisher: $e');
      rethrow;
    }
  }

  /// Publishes an audit event
  ///
  /// Creates an audit event that matches the AuditEventDto structure
  /// expected by the audit service.
  ///
  /// [eventType] The type of audit event (e.g., CREATE, UPDATE, DELETE)
  /// [userId] The user who performed the action (optional)
  /// [targetEntityId] ID of the target entity affected (optional)
  /// [targetEntityType] Type of the target entity (optional)
  /// [ipAddress] User's IP address (optional)
  /// [details] Additional details about the event (optional)
  Future<void> publishAuditEvent({
    required EventType eventType,
    String? userId,
    String? targetEntityId,
    String? targetEntityType,
    String? ipAddress,
    Map<String, dynamic>? details,
  }) async {
    final uuid = Uuid();
    final eventTimestamp = DateTime.now();

    final event = {
      'eventId': uuid.v4(),
      'eventTimestamp': eventTimestamp.toIso8601String(),
      'sourceService': 'auth-service',
      'eventType': eventType.toString(),
      if (userId != null) 'userId': userId,
      if (targetEntityId != null) 'targetEntityId': targetEntityId,
      if (targetEntityType != null) 'targetEntityType': targetEntityType,
      if (ipAddress != null) 'ipAddress': ipAddress,
      if (details != null) 'details': details,
    };

    await _publishToExchange(
      exchange: _auditExchange,
      routingKey: 'audit',
      message: event,
    );
  }

  /// Generic method to publish to an exchange
  ///
  /// [exchange] The exchange to publish to
  /// [routingKey] The routing key
  /// [message] The message data
  Future<void> _publishToExchange({
    required Exchange exchange,
    String? routingKey,
    required Map<String, dynamic> message,
  }) async {
    if (_channel == null) {
      await initialize();
    }

    try {
      final messageBody = jsonEncode(message);

      exchange.publish(messageBody, routingKey);

      print('Published event: $routingKey');
    } catch (e) {
      print('Failed to publish event $routingKey: $e');
      rethrow;
    }
  }

  /// Closes the connection
  Future<void> close() async {
    try {
      await _channel?.close();
      await _client?.close();
      print('EventPublisher closed successfully');
    } catch (e) {
      print('Error closing EventPublisher: $e');
    }
  }
}

enum EventType {
  create,
  update,
  delete;

  @override
  String toString() => name.toUpperCase();
}
