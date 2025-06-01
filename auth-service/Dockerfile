# Auth Service Docker Configuration
# Multi-stage build for optimized production deployment

# Build stage - Use official Dart image
FROM dart:3.7.2 AS build

# Set working directory
WORKDIR /app

# Copy dependency files first for better caching
COPY pubspec.* ./
RUN dart pub get

# Copy source code and build
COPY . .
RUN dart pub get --offline
RUN dart run build_runner build --delete-conflicting-outputs
RUN dart compile exe bin/server.dart -o bin/server

# Production stage - Minimal runtime image
FROM scratch
WORKDIR /app

# Copy runtime dependencies and compiled binary
COPY --from=build /runtime/ /
COPY --from=build /app/bin/server /app/

# Expose service port
EXPOSE 8080

# Start the audit service
CMD ["./server"]
