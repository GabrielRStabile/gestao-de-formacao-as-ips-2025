# Audit Service

A comprehensive audit logging service built with Dart and the Vaden framework. This service provides REST endpoints for managing audit logs with PostgreSQL storage and RabbitMQ integration for real-time event processing.

## Features

- **REST API**: Full CRUD operations for audit logs with filtering and pagination
- **Message Queue Integration**: RabbitMQ consumer for real-time audit event processing
- **Database Storage**: PostgreSQL with Drift ORM for robust data persistence
- **OpenAPI Documentation**: Auto-generated API documentation with Swagger UI
- **Data Validation**: Comprehensive input validation and sanitization
- **Error Handling**: Structured error responses with proper HTTP status codes

## Project Structure

- `bin/` - Application entry point
- `lib/src/` - Core application code
  - `controllers/` - REST API controllers
  - `services/` - Business logic layer
  - `repositories/` - Data access layer
  - `models/` - Database models and schemas
  - `dtos/` - Data transfer objects
  - `errors/` - Custom error classes
  - `utils/` - Utility functions
- `test/` - Unit and integration tests

## Getting Started

1. Install dependencies: `dart pub get`
2. Generate code: `dart run build_runner build`
3. Run the service: `dart run bin/server.dart`

The service will start on `http://localhost:8080` with API documentation available at `/docs`.
