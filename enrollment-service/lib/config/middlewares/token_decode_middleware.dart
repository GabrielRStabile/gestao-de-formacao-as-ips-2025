import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:enrollment_service/config/app_configuration.dart';
import 'package:vaden/vaden.dart';

@Component()
class TokenDecodeMiddleware extends VadenMiddleware {
  final authServiceUrl = env['AUTH_SERVICE_URL'];
  final authServiceApiKey = env['AUTH_SERVICE_API_KEY'];

  @override
  FutureOr<Response> handler(Request request, Handler handler) async {
    final token = request.headers['Authorization']?.split('Bearer ').last;

    if (token == null || token.isEmpty) {
      return Response.unauthorized('Authorization token is missing or invalid');
    }

    final client = HttpClient();

    try {
      final apiRequest = await client.postUrl(
        Uri.parse('$authServiceUrl/auth/introspect-token'),
      );
      apiRequest.headers.set('Content-Type', 'application/json');
      apiRequest.headers.set('Authorization', 'ApiKey $authServiceApiKey');
      apiRequest.write(json.encode({'token': token}));

      final response = await apiRequest.close();

      if (response.statusCode != 200) {
        return Response.unauthorized('Failed to validate token');
      }

      final userData = json.decode(
        await response.transform(utf8.decoder).join(),
      );

      if (userData['active'] != true) {
        return Response.unauthorized('Token is not active');
      }

      return handler(
        request.change(
          context: {
            'userId': userData['sub'],
            'email': userData['email'],
            'role': userData['role'],
          },
        ),
      );
    } catch (e) {
      return Response.internalServerError(
        body: 'Error authenticating: ${e.toString()}',
      );
    } finally {
      client.close();
    }
  }
}
