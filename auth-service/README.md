# Auth Service

A comprehensive authentication service built with Dart and the Vaden framework. This service provides REST endpoints for user authentication, registration, password management, JWT token generation/validation, and integrates with RabbitMQ for event publishing.

## Features

- **User Authentication**: Registration, login, password reset with secure hashing
- **JWT Token Management**: Stateless token generation, validation, and introspection
- **Security Features**: Account lockout, password complexity validation, rate limiting
- **REST API**: Complete authentication endpoints with proper error handling
- **Database Storage**: PostgreSQL with Drift ORM for user data persistence
- **Event Publishing**: RabbitMQ integration for user lifecycle events
- **OpenAPI Documentation**: Auto-generated API documentation with Swagger UI

## Architecture

### Core Components

- **AuthController**: REST API endpoints for authentication operations
- **AuthService**: Business logic for user authentication and management
- **JwtManager**: JWT token generation, validation, and introspection
- **PasswordEncoder**: Secure password hashing with BCrypt and complexity validation
- **EventPublisher**: RabbitMQ integration for publishing user events
- **Repositories**: Data access layer for users and password reset tokens

### Database Schema

- **UserAuthData**: User authentication information (email, password, role, security)
- **PasswordResetTokens**: Temporary tokens for password reset functionality
- **AuditLog**: System audit trail for security and compliance

## Project Structure

```
auth-service/
├── bin/                    # Application entry point
├── lib/src/               # Core application code
│   ├── controllers/       # REST API controllers
│   ├── services/          # Business logic services
│   ├── repositories/      # Data access layer
│   ├── models/           # Database models and schemas
│   ├── dtos/             # Data transfer objects
│   ├── errors/           # Custom error classes
│   └── providers/        # Dependency injection providers
├── scripts/              # Development and deployment scripts
├── test/                 # Unit and integration tests
├── application.yaml      # Application configuration
└── .env.example         # Environment variables template
```

## Getting Started

### Prerequisites

- Dart SDK 3.0+
- PostgreSQL 13+
- RabbitMQ 3.8+

### Installation

1. **Clone and install dependencies**
   ```bash
   git clone <repository-url>
   cd auth-service
   dart pub get
   ```

2. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. **Generate Drift code**
   ```bash
   dart run build_runner build
   ```

4. **Set up database**
   ```bash
   # Create PostgreSQL database and user
   createdb auth_db
   createuser auth_user
   
   # Test database connection
   dart run scripts/test_database_connection.dart
   ```

5. **Start the service**
   ```bash
   dart run bin/server.dart
   ```

### Configuration

#### Environment Variables

```bash
# Database Configuration
DB_HOST=localhost
DB_PORT=5432
DB_NAME=auth_db
DB_USER=auth_user
DB_PASSWORD=auth_password

# RabbitMQ Configuration
RABBITMQ_URL=amqp://localhost:5672

# JWT Configuration
JWT_SECRET=your-very-secure-secret-key-change-in-production
JWT_EXPIRATION_IN_MINUTES=60
JWT_ISSUER=auth-service

# Security Configuration
MAX_FAILED_LOGIN_ATTEMPTS=5
ACCOUNT_LOCKOUT_MINUTES=15
API_KEY_INTROSPECTION=your-api-key-for-introspection

# Password Reset Configuration
PASSWORD_RESET_TOKEN_EXPIRATION_HOURS=1

# Application Configuration
PORT=3000
ENVIRONMENT=development
```

## API Endpoints

### Authentication

| Method | Endpoint         | Description                         |
| ------ | ---------------- | ----------------------------------- |
| POST   | `/auth/register` | Register a new user                 |
| POST   | `/auth/login`    | Authenticate user and get JWT token |
| POST   | `/auth/logout`   | Logout user (invalidate token)      |
| POST   | `/auth/refresh`  | Refresh JWT token                   |

### Password Management

| Method | Endpoint                | Description                     |
| ------ | ----------------------- | ------------------------------- |
| POST   | `/auth/forgot-password` | Request password reset          |
| POST   | `/auth/reset-password`  | Reset password with token       |
| POST   | `/auth/change-password` | Change password (authenticated) |

### Token Management

| Method | Endpoint           | Description                    |
| ------ | ------------------ | ------------------------------ |
| POST   | `/auth/introspect` | Validate and inspect JWT token |

### API Documentation

Once the service is running, access the interactive API documentation at:
- Swagger UI: `http://localhost:3000/docs`
- OpenAPI Spec: `http://localhost:3000/openapi.json`

## Development

### Creating Test Users

```bash
# Create a test user
dart run scripts/create_test_user.dart admin@test.com Password123! gestor

# Create and test login
dart run scripts/create_test_user.dart user@test.com Password123! formando test_login
```

### Running Tests

```bash
# Run all tests
dart test

# Run specific test files
dart test test/unit/auth_service_test.dart
dart test test/integration/auth_controller_test.dart
```

### Database Operations

```bash
# Test database connection
dart run scripts/test_database_connection.dart

# Run migrations (handled automatically by Drift)
dart run build_runner build

# View data with Prisma Studio equivalent (if using compatible tools)
```

## Security Features

### Password Security
- BCrypt hashing with configurable salt rounds
- Password complexity requirements (length, uppercase, lowercase, digits, special characters)
- Password history prevention (optional)

### Account Security
- Account lockout after failed login attempts
- Email verification requirement
- Role-based access control (formando, formador, gestor)

### Token Security
- JWT tokens with configurable expiration
- Secure token validation and introspection
- Token revocation support

### Audit Trail
- Comprehensive logging of authentication events
- Failed login attempt tracking
- Password change history

## Event Publishing

The service publishes events to RabbitMQ for integration with other services:

- `user.registered` - New user registration
- `user.login` - Successful login
- `user.logout` - User logout
- `password.reset.requested` - Password reset requested
- `password.reset.completed` - Password successfully reset
- `password.changed` - Password changed by user
- `account.locked` - Account locked due to failed attempts
- `account.unlocked` - Account unlocked

## Error Handling

The service provides structured error responses:

```json
{
  "error": "AUTHENTICATION_FAILED",
  "message": "Invalid email or password",
  "timestamp": "2024-01-15T10:30:00Z",
  "details": {
    "attempts_remaining": 3
  }
}
```

Common error codes:
- `VALIDATION_ERROR` - Input validation failed
- `AUTHENTICATION_FAILED` - Invalid credentials
- `ACCOUNT_LOCKED` - Account temporarily locked
- `TOKEN_EXPIRED` - JWT token has expired
- `TOKEN_INVALID` - JWT token is malformed or invalid
- `USER_NOT_FOUND` - User does not exist
- `EMAIL_ALREADY_EXISTS` - Email already registered

## Monitoring and Health Checks

- Health check endpoint: `GET /health`
- Metrics endpoint: `GET /metrics` (if enabled)
- Logging with structured JSON format

## Deployment

### Docker Deployment

```dockerfile
FROM dart:stable AS build
WORKDIR /app
COPY . .
RUN dart pub get
RUN dart run build_runner build --delete-conflicting-outputs
RUN dart compile exe bin/server.dart -o bin/server

FROM debian:bookworm-slim
RUN apt-get update && apt-get install -y ca-certificates && rm -rf /var/lib/apt/lists/*
COPY --from=build /app/bin/server /app/bin/
COPY --from=build /app/application.yaml /app/
EXPOSE 3000
CMD ["/app/bin/server"]
```

### Environment Variables for Production

Ensure all sensitive values are properly configured:
- Use strong JWT secret keys
- Enable database SSL connections
- Configure proper CORS settings
- Set appropriate log levels
- Use secure RabbitMQ connections

## Contributing

1. Fork the repository
2. Create a feature branch
3. Make your changes
4. Add tests for new functionality
5. Submit a pull request

## License

This project is licensed under the MIT License.
