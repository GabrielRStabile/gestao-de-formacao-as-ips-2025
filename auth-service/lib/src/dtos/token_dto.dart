import 'package:vaden/vaden.dart';

/// Data Transfer Object for token introspection request
///
/// Contains the token to be validated
@DTO()
class IntrospectTokenRequestDto {
  /// JWT token to validate
  final String token;

  /// Creates a new IntrospectTokenRequestDto
  const IntrospectTokenRequestDto({required this.token});
}

/// Data Transfer Object for token introspection response
///
/// Contains the validation result and token claims (RFC 7662 compliant)
@DTO()
class IntrospectTokenResponseDto {
  /// Whether the token is active
  final bool active;

  /// Token subject (user ID) - only present if active
  final String? sub;

  /// Token issuer - only present if active
  final String? iss;

  /// Token audience - only present if active
  final String? aud;

  /// Token expiration timestamp - only present if active
  final int? exp;

  /// Token issued at timestamp - only present if active
  final int? iat;

  /// User email - custom claim, only present if active
  final String? email;

  /// User role - custom claim, only present if active
  final String? role;

  /// Creates a new IntrospectTokenResponseDto
  const IntrospectTokenResponseDto({
    required this.active,
    this.sub,
    this.iss,
    this.aud,
    this.exp,
    this.iat,
    this.email,
    this.role,
  });

  /// Creates an inactive token response
  factory IntrospectTokenResponseDto.inactive() {
    return const IntrospectTokenResponseDto(active: false);
  }

  /// Creates an active token response with claims
  factory IntrospectTokenResponseDto.active({
    required String sub,
    required String iss,
    String? aud,
    required int exp,
    required int iat,
    required String email,
    required String role,
  }) {
    return IntrospectTokenResponseDto(
      active: true,
      sub: sub,
      iss: iss,
      aud: aud,
      exp: exp,
      iat: iat,
      email: email,
      role: role,
    );
  }
}
