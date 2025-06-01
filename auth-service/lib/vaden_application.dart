// GENERATED CODE - DO NOT MODIFY BY HAND
// Aggregated Vaden application file
// ignore_for_file: prefer_function_declarations_over_variables, implementation_imports

import 'dart:convert';
import 'dart:io';
import 'package:vaden/vaden.dart';

import 'package:auth_service/config/app_controller_advice.dart';
import 'package:auth_service/src/errors/base_error.dart' show BaseError;
import 'package:auth_service/config/app_warnup.dart';
import 'package:auth_service/config/openapi/openapi_configuration.dart';
import 'package:auth_service/config/openapi/openapi_controller.dart';
import 'package:auth_service/config/app_configuration.dart';
import 'package:auth_service/src/utils/date_time_parse.dart';
import 'package:auth_service/src/repositories/user_auth_data_repository.dart';
import 'package:auth_service/src/models/database.dart';
import 'package:auth_service/src/dtos/token_dto.dart';
import 'package:auth_service/src/dtos/register_dto.dart';
import 'package:auth_service/src/dtos/password_dto.dart';
import 'package:auth_service/src/dtos/error_dto.dart';
import 'package:auth_service/src/dtos/login_dto.dart';
import 'package:auth_service/src/repositories/password_reset_token_repository.dart';
import 'package:auth_service/src/services/password_encoder.dart';
import 'package:auth_service/src/services/jwt_manager.dart';
import 'package:auth_service/src/services/event_publisher.dart';
import 'package:auth_service/src/services/auth_service.dart';
import 'package:auth_service/src/controllers/auth_controller.dart';

class VadenApplicationImpl implements VadenApplication {
  final _router = Router();
  final _injector = AutoInjector();

  @override
  Injector get injector => _injector;

  @override
  Router get router => _router;

  VadenApplicationImpl();

  @override
  Future<HttpServer> run(List<String> args) async {
    _injector.tryGet<CommandLineRunner>()?.run(args);
    _injector.tryGet<ApplicationRunner>()?.run(this);
    final pipeline = _injector.get<Pipeline>();
    final handler = pipeline.addHandler((request) async {
      try {
        final response = await _router(request);
        return response;
      } catch (e, stack) {
        print(e);
        print(stack);
        return _handleException(e);
      }
    });

    final settings = _injector.get<ApplicationSettings>();
    final port = settings['server']['port'] ?? 8080;
    final host = settings['server']['host'] ?? '0.0.0.0';

    final server = await serve(handler, host, port);

    return server;
  }

  @override
  Future<void> setup() async {
    final paths = <String, dynamic>{};
    final apis = <Api>[];
    final asyncBeans = <Future<void> Function()>[];
    _injector.addLazySingleton<DSON>(_DSON.new);
    _injector.addLazySingleton(AppControllerAdvice.new);

    _injector.addBind(
      Bind.withClassName(
        constructor: AppWarnup.new,
        type: BindType.lazySingleton,
        className: 'ApplicationRunner',
      ),
    );

    final configurationOpenApiConfiguration = OpenApiConfiguration();

    _injector.addLazySingleton(configurationOpenApiConfiguration.openApi);
    _injector.addLazySingleton(configurationOpenApiConfiguration.swaggerUI);

    _injector.addLazySingleton(OpenAPIController.new);
    final routerOpenAPIController = Router();
    var pipelineOpenAPIControllergetSwagger = const Pipeline();
    final handlerOpenAPIControllergetSwagger = (Request request) async {
      final ctrl = _injector.get<OpenAPIController>();
      final result = await ctrl.getSwagger(request);
      return result;
    };
    routerOpenAPIController.get(
      '/',
      pipelineOpenAPIControllergetSwagger.addHandler(
        handlerOpenAPIControllergetSwagger,
      ),
    );
    var pipelineOpenAPIControllergetOpenApiJSON = const Pipeline();
    final handlerOpenAPIControllergetOpenApiJSON = (Request request) async {
      final ctrl = _injector.get<OpenAPIController>();
      final result = ctrl.getOpenApiJSON(request);
      return result;
    };
    routerOpenAPIController.get(
      '/openapi.json',
      pipelineOpenAPIControllergetOpenApiJSON.addHandler(
        handlerOpenAPIControllergetOpenApiJSON,
      ),
    );
    _router.mount('/docs', routerOpenAPIController.call);

    final configurationAppConfiguration = AppConfiguration();

    _injector.addLazySingleton(configurationAppConfiguration.settings);
    _injector.addLazySingleton(configurationAppConfiguration.globalMiddleware);

    _injector.addLazySingleton(UserAuthDataRepository.new);

    _injector.addLazySingleton(AuthDatabaseAccess.new);

    _injector.addLazySingleton(PasswordResetTokenRepository.new);

    _injector.addLazySingleton(PasswordEncoder.new);

    _injector.addLazySingleton(JwtManager.new);

    _injector.addLazySingleton(EventPublisher.new);

    _injector.addLazySingleton(AuthService.new);

    _injector.addLazySingleton(AuthController.new);
    apis.add(
      const Api(
        tag: 'Authentication',
        description:
            'Handles user authentication, registration, and password management',
      ),
    );
    final routerAuthController = Router();
    paths['/auth/register'] = <String, dynamic>{
      ...paths['/auth/register'] ?? <String, dynamic>{},
      'post': {
        'tags': ['Authentication'],
        'summary': '',
        'description': '',
        'responses': <String, dynamic>{},
        'parameters': <Map<String, dynamic>>[],
        'security': <Map<String, dynamic>>[],
      },
    };

    paths['/auth/register']['post']['summary'] = 'Register new user';
    paths['/auth/register']['post']['description'] =
        'Creates a new user account with email and password';
    paths['/auth/register']['post']['responses']['201'] = {
      'description': 'User registered successfully',
      'content': <String, dynamic>{},
    };

    paths['/auth/register']['post']['responses']['201']['content']['application/json'] =
        <String, dynamic>{};

    paths['/auth/register']['post']['responses']['201']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/RegisterResponseDto'};

    paths['/auth/register']['post']['responses']['400'] = {
      'description': 'Invalid input data',
      'content': <String, dynamic>{},
    };

    paths['/auth/register']['post']['responses']['400']['content']['application/json'] =
        <String, dynamic>{};

    paths['/auth/register']['post']['responses']['400']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    var pipelineAuthControllerregister = const Pipeline();
    paths['/auth/register']['post']['requestBody'] = {
      'content': {
        'application/json': {
          'schema': {'\$ref': '#/components/schemas/RegisterRequestDto'},
        },
      },
      'required': true,
    };

    final handlerAuthControllerregister = (Request request) async {
      final bodyString = await request.readAsString();
      final bodyJson = jsonDecode(bodyString) as Map<String, dynamic>;
      final registerRequest =
          _injector.get<DSON>().fromJson<RegisterRequestDto>(bodyJson)
              as dynamic;

      if (registerRequest == null) {
        return Response(
          400,
          body: jsonEncode({'error': 'Invalid body: (RegisterRequestDto)'}),
        );
      }

      if (registerRequest is Validator<RegisterRequestDto>) {
        final validator = registerRequest.validate(
          ValidatorBuilder<RegisterRequestDto>(),
        );
        final resultValidator = validator.validate(
          registerRequest as RegisterRequestDto,
        );
        if (!resultValidator.isValid) {
          throw ResponseException<List<Map<String, dynamic>>>(
            400,
            resultValidator.exceptionToJson(),
          );
        }
      }

      final forwardedFor = _parse<String?>(request.headers['X-Forwarded-For']);
      final realIp = _parse<String?>(request.headers['X-Real-IP']);
      final ctrl = _injector.get<AuthController>();
      final result = await ctrl.register(
        registerRequest,
        forwardedFor,
        realIp,
        request,
      );
      final jsoResponse = _injector.get<DSON>().toJson<RegisterResponseDto>(
        result,
      );
      return Response.ok(
        jsonEncode(jsoResponse),
        headers: {'Content-Type': 'application/json'},
      );
    };
    routerAuthController.post(
      '/register',
      pipelineAuthControllerregister.addHandler(handlerAuthControllerregister),
    );
    paths['/auth/login'] = <String, dynamic>{
      ...paths['/auth/login'] ?? <String, dynamic>{},
      'post': {
        'tags': ['Authentication'],
        'summary': '',
        'description': '',
        'responses': <String, dynamic>{},
        'parameters': <Map<String, dynamic>>[],
        'security': <Map<String, dynamic>>[],
      },
    };

    paths['/auth/login']['post']['summary'] = 'User login';
    paths['/auth/login']['post']['description'] =
        'Authenticates user and returns JWT access token';
    paths['/auth/login']['post']['responses']['200'] = {
      'description': 'Login successful',
      'content': <String, dynamic>{},
    };

    paths['/auth/login']['post']['responses']['200']['content']['application/json'] =
        <String, dynamic>{};

    paths['/auth/login']['post']['responses']['200']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/LoginResponseDto'};

    paths['/auth/login']['post']['responses']['401'] = {
      'description': 'Invalid credentials',
      'content': <String, dynamic>{},
    };

    paths['/auth/login']['post']['responses']['401']['content']['application/json'] =
        <String, dynamic>{};

    paths['/auth/login']['post']['responses']['401']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/auth/login']['post']['responses']['400'] = {
      'description': 'Invalid input data',
      'content': <String, dynamic>{},
    };

    paths['/auth/login']['post']['responses']['400']['content']['application/json'] =
        <String, dynamic>{};

    paths['/auth/login']['post']['responses']['400']['content']['application/json']['schema'] = {
      '\$ref':
          '#/components/schemas/ResponseException<List<Map<String, dynamic>>>',
    };

    var pipelineAuthControllerlogin = const Pipeline();
    paths['/auth/login']['post']['requestBody'] = {
      'content': {
        'application/json': {
          'schema': {'\$ref': '#/components/schemas/LoginRequestDto'},
        },
      },
      'required': true,
    };

    final handlerAuthControllerlogin = (Request request) async {
      final bodyString = await request.readAsString();
      final bodyJson = jsonDecode(bodyString) as Map<String, dynamic>;
      final loginRequest =
          _injector.get<DSON>().fromJson<LoginRequestDto>(bodyJson) as dynamic;

      if (loginRequest == null) {
        return Response(
          400,
          body: jsonEncode({'error': 'Invalid body: (LoginRequestDto)'}),
        );
      }

      if (loginRequest is Validator<LoginRequestDto>) {
        final validator = loginRequest.validate(
          ValidatorBuilder<LoginRequestDto>(),
        );
        final resultValidator = validator.validate(
          loginRequest as LoginRequestDto,
        );
        if (!resultValidator.isValid) {
          throw ResponseException<List<Map<String, dynamic>>>(
            400,
            resultValidator.exceptionToJson(),
          );
        }
      }

      final forwardedFor = _parse<String?>(request.headers['X-Forwarded-For']);
      final realIp = _parse<String?>(request.headers['X-Real-IP']);
      final ctrl = _injector.get<AuthController>();
      final result = await ctrl.login(
        loginRequest,
        forwardedFor,
        realIp,
        request,
      );
      final jsoResponse = _injector.get<DSON>().toJson<LoginResponseDto>(
        result,
      );
      return Response.ok(
        jsonEncode(jsoResponse),
        headers: {'Content-Type': 'application/json'},
      );
    };
    routerAuthController.post(
      '/login',
      pipelineAuthControllerlogin.addHandler(handlerAuthControllerlogin),
    );
    paths['/auth/introspect-token'] = <String, dynamic>{
      ...paths['/auth/introspect-token'] ?? <String, dynamic>{},
      'post': {
        'tags': ['Authentication'],
        'summary': '',
        'description': '',
        'responses': <String, dynamic>{},
        'parameters': <Map<String, dynamic>>[],
        'security': <Map<String, dynamic>>[],
      },
    };

    paths['/auth/introspect-token']['post']['summary'] = 'Token introspection';
    paths['/auth/introspect-token']['post']['description'] =
        'Validates JWT token and returns claims';
    paths['/auth/introspect-token']['post']['responses']['200'] = {
      'description': 'Token validation result',
      'content': <String, dynamic>{},
    };

    paths['/auth/introspect-token']['post']['responses']['200']['content']['application/json'] =
        <String, dynamic>{};

    paths['/auth/introspect-token']['post']['responses']['200']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/IntrospectTokenResponseDto'};

    paths['/auth/introspect-token']['post']['responses']['401'] = {
      'description': 'Invalid API key',
      'content': <String, dynamic>{},
    };

    paths['/auth/introspect-token']['post']['responses']['401']['content']['application/json'] =
        <String, dynamic>{};

    paths['/auth/introspect-token']['post']['responses']['401']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    var pipelineAuthControllerintrospectToken = const Pipeline();
    paths['/auth/introspect-token']['post']['requestBody'] = {
      'content': {
        'application/json': {
          'schema': {'\$ref': '#/components/schemas/IntrospectTokenRequestDto'},
        },
      },
      'required': true,
    };

    final handlerAuthControllerintrospectToken = (Request request) async {
      final bodyString = await request.readAsString();
      final bodyJson = jsonDecode(bodyString) as Map<String, dynamic>;
      final introspectRequest =
          _injector.get<DSON>().fromJson<IntrospectTokenRequestDto>(bodyJson)
              as dynamic;

      if (introspectRequest == null) {
        return Response(
          400,
          body: jsonEncode({
            'error': 'Invalid body: (IntrospectTokenRequestDto)',
          }),
        );
      }

      if (introspectRequest is Validator<IntrospectTokenRequestDto>) {
        final validator = introspectRequest.validate(
          ValidatorBuilder<IntrospectTokenRequestDto>(),
        );
        final resultValidator = validator.validate(
          introspectRequest as IntrospectTokenRequestDto,
        );
        if (!resultValidator.isValid) {
          throw ResponseException<List<Map<String, dynamic>>>(
            400,
            resultValidator.exceptionToJson(),
          );
        }
      }

      final ctrl = _injector.get<AuthController>();
      final result = await ctrl.introspectToken(introspectRequest);
      final jsoResponse = _injector
          .get<DSON>()
          .toJson<IntrospectTokenResponseDto>(result);
      return Response.ok(
        jsonEncode(jsoResponse),
        headers: {'Content-Type': 'application/json'},
      );
    };
    routerAuthController.post(
      '/introspect-token',
      pipelineAuthControllerintrospectToken.addHandler(
        handlerAuthControllerintrospectToken,
      ),
    );
    paths['/auth/change-password'] = <String, dynamic>{
      ...paths['/auth/change-password'] ?? <String, dynamic>{},
      'put': {
        'tags': ['Authentication'],
        'summary': '',
        'description': '',
        'responses': <String, dynamic>{},
        'parameters': <Map<String, dynamic>>[],
        'security': <Map<String, dynamic>>[],
      },
    };

    paths['/auth/change-password']['put']['summary'] = 'Change password';
    paths['/auth/change-password']['put']['description'] =
        'Changes user password with current password verification';
    paths['/auth/change-password']['put']['responses']['200'] = {
      'description': 'Password changed successfully',
      'content': <String, dynamic>{},
    };

    paths['/auth/change-password']['put']['responses']['200']['content']['application/json'] =
        <String, dynamic>{};

    paths['/auth/change-password']['put']['responses']['200']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/SuccessResponseDto'};

    paths['/auth/change-password']['put']['responses']['401'] = {
      'description': 'Invalid authorization or current password',
      'content': <String, dynamic>{},
    };

    paths['/auth/change-password']['put']['responses']['401']['content']['application/json'] =
        <String, dynamic>{};

    paths['/auth/change-password']['put']['responses']['401']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    var pipelineAuthControllerchangePassword = const Pipeline();
    paths['/auth/change-password']['put']['requestBody'] = {
      'content': {
        'application/json': {
          'schema': {'\$ref': '#/components/schemas/ChangePasswordRequestDto'},
        },
      },
      'required': true,
    };

    paths['/auth/change-password']['put']['parameters']?.add({
      'name': 'userId',
      'in': 'query',
      'required': true,
      'schema': {'type': 'string'},
    });

    final handlerAuthControllerchangePassword = (Request request) async {
      final bodyString = await request.readAsString();
      final bodyJson = jsonDecode(bodyString) as Map<String, dynamic>;
      final changeRequest =
          _injector.get<DSON>().fromJson<ChangePasswordRequestDto>(bodyJson)
              as dynamic;

      if (changeRequest == null) {
        return Response(
          400,
          body: jsonEncode({
            'error': 'Invalid body: (ChangePasswordRequestDto)',
          }),
        );
      }

      if (changeRequest is Validator<ChangePasswordRequestDto>) {
        final validator = changeRequest.validate(
          ValidatorBuilder<ChangePasswordRequestDto>(),
        );
        final resultValidator = validator.validate(
          changeRequest as ChangePasswordRequestDto,
        );
        if (!resultValidator.isValid) {
          throw ResponseException<List<Map<String, dynamic>>>(
            400,
            resultValidator.exceptionToJson(),
          );
        }
      }

      if (request.url.queryParameters['userId'] == null) {
        return Response(
          400,
          body: jsonEncode({'error': 'Query param is required (userId)'}),
        );
      }
      final userId = _parse<String>(request.url.queryParameters['userId'])!;

      final forwardedFor = _parse<String?>(request.headers['X-Forwarded-For']);
      final realIp = _parse<String?>(request.headers['X-Real-IP']);
      final ctrl = _injector.get<AuthController>();
      final result = await ctrl.changePassword(
        changeRequest,
        userId,
        forwardedFor,
        realIp,
        request,
      );
      final jsoResponse = _injector.get<DSON>().toJson<SuccessResponseDto>(
        result,
      );
      return Response.ok(
        jsonEncode(jsoResponse),
        headers: {'Content-Type': 'application/json'},
      );
    };
    routerAuthController.put(
      '/change-password',
      pipelineAuthControllerchangePassword.addHandler(
        handlerAuthControllerchangePassword,
      ),
    );
    paths['/auth/forgot-password'] = <String, dynamic>{
      ...paths['/auth/forgot-password'] ?? <String, dynamic>{},
      'post': {
        'tags': ['Authentication'],
        'summary': '',
        'description': '',
        'responses': <String, dynamic>{},
        'parameters': <Map<String, dynamic>>[],
        'security': <Map<String, dynamic>>[],
      },
    };

    paths['/auth/forgot-password']['post']['summary'] = 'Forgot password';
    paths['/auth/forgot-password']['post']['description'] =
        'Initiates password reset process by sending reset email';
    paths['/auth/forgot-password']['post']['responses']['200'] = {
      'description': 'Reset email sent if account exists',
      'content': <String, dynamic>{},
    };

    paths['/auth/forgot-password']['post']['responses']['200']['content']['application/json'] =
        <String, dynamic>{};

    paths['/auth/forgot-password']['post']['responses']['200']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/SuccessResponseDto'};

    var pipelineAuthControllerforgotPassword = const Pipeline();
    paths['/auth/forgot-password']['post']['requestBody'] = {
      'content': {
        'application/json': {
          'schema': {'\$ref': '#/components/schemas/ForgotPasswordRequestDto'},
        },
      },
      'required': true,
    };

    final handlerAuthControllerforgotPassword = (Request request) async {
      final bodyString = await request.readAsString();
      final bodyJson = jsonDecode(bodyString) as Map<String, dynamic>;
      final forgotRequest =
          _injector.get<DSON>().fromJson<ForgotPasswordRequestDto>(bodyJson)
              as dynamic;

      if (forgotRequest == null) {
        return Response(
          400,
          body: jsonEncode({
            'error': 'Invalid body: (ForgotPasswordRequestDto)',
          }),
        );
      }

      if (forgotRequest is Validator<ForgotPasswordRequestDto>) {
        final validator = forgotRequest.validate(
          ValidatorBuilder<ForgotPasswordRequestDto>(),
        );
        final resultValidator = validator.validate(
          forgotRequest as ForgotPasswordRequestDto,
        );
        if (!resultValidator.isValid) {
          throw ResponseException<List<Map<String, dynamic>>>(
            400,
            resultValidator.exceptionToJson(),
          );
        }
      }

      final forwardedFor = _parse<String?>(request.headers['X-Forwarded-For']);
      final realIp = _parse<String?>(request.headers['X-Real-IP']);
      final ctrl = _injector.get<AuthController>();
      final result = await ctrl.forgotPassword(
        forgotRequest,
        forwardedFor,
        realIp,
        request,
      );
      final jsoResponse = _injector.get<DSON>().toJson<SuccessResponseDto>(
        result,
      );
      return Response.ok(
        jsonEncode(jsoResponse),
        headers: {'Content-Type': 'application/json'},
      );
    };
    routerAuthController.post(
      '/forgot-password',
      pipelineAuthControllerforgotPassword.addHandler(
        handlerAuthControllerforgotPassword,
      ),
    );
    paths['/auth/reset-password'] = <String, dynamic>{
      ...paths['/auth/reset-password'] ?? <String, dynamic>{},
      'post': {
        'tags': ['Authentication'],
        'summary': '',
        'description': '',
        'responses': <String, dynamic>{},
        'parameters': <Map<String, dynamic>>[],
        'security': <Map<String, dynamic>>[],
      },
    };

    paths['/auth/reset-password']['post']['summary'] = 'Reset password';
    paths['/auth/reset-password']['post']['description'] =
        'Resets password using valid reset token';
    paths['/auth/reset-password']['post']['responses']['200'] = {
      'description': 'Password reset successfully',
      'content': <String, dynamic>{},
    };

    paths['/auth/reset-password']['post']['responses']['200']['content']['application/json'] =
        <String, dynamic>{};

    paths['/auth/reset-password']['post']['responses']['200']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/SuccessResponseDto'};

    paths['/auth/reset-password']['post']['responses']['400'] = {
      'description': 'Invalid or expired reset token',
      'content': <String, dynamic>{},
    };

    paths['/auth/reset-password']['post']['responses']['400']['content']['application/json'] =
        <String, dynamic>{};

    paths['/auth/reset-password']['post']['responses']['400']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    var pipelineAuthControllerresetPassword = const Pipeline();
    paths['/auth/reset-password']['post']['requestBody'] = {
      'content': {
        'application/json': {
          'schema': {'\$ref': '#/components/schemas/ResetPasswordRequestDto'},
        },
      },
      'required': true,
    };

    final handlerAuthControllerresetPassword = (Request request) async {
      final bodyString = await request.readAsString();
      final bodyJson = jsonDecode(bodyString) as Map<String, dynamic>;
      final resetRequest =
          _injector.get<DSON>().fromJson<ResetPasswordRequestDto>(bodyJson)
              as dynamic;

      if (resetRequest == null) {
        return Response(
          400,
          body: jsonEncode({
            'error': 'Invalid body: (ResetPasswordRequestDto)',
          }),
        );
      }

      if (resetRequest is Validator<ResetPasswordRequestDto>) {
        final validator = resetRequest.validate(
          ValidatorBuilder<ResetPasswordRequestDto>(),
        );
        final resultValidator = validator.validate(
          resetRequest as ResetPasswordRequestDto,
        );
        if (!resultValidator.isValid) {
          throw ResponseException<List<Map<String, dynamic>>>(
            400,
            resultValidator.exceptionToJson(),
          );
        }
      }

      final forwardedFor = _parse<String?>(request.headers['X-Forwarded-For']);
      final realIp = _parse<String?>(request.headers['X-Real-IP']);
      final ctrl = _injector.get<AuthController>();
      final result = await ctrl.resetPassword(
        resetRequest,
        forwardedFor,
        realIp,
        request,
      );
      final jsoResponse = _injector.get<DSON>().toJson<SuccessResponseDto>(
        result,
      );
      return Response.ok(
        jsonEncode(jsoResponse),
        headers: {'Content-Type': 'application/json'},
      );
    };
    routerAuthController.post(
      '/reset-password',
      pipelineAuthControllerresetPassword.addHandler(
        handlerAuthControllerresetPassword,
      ),
    );
    _router.mount('/auth', routerAuthController.call);

    _injector.addLazySingleton(OpenApiConfig.create(paths, apis).call);
    _injector.commit();

    for (final asyncBean in asyncBeans) {
      await asyncBean();
    }
  }

  Future<Response> _handleException(dynamic e) async {
    final controllerAdviceAppControllerAdvice = _injector
        .get<AppControllerAdvice>();
    if (e is ResponseException) {
      return await controllerAdviceAppControllerAdvice.handleResponseException(
        e,
      );
    }

    if (e is BaseError) {
      return controllerAdviceAppControllerAdvice.handleBaseError(e);
    }

    if (e is Exception) {
      return controllerAdviceAppControllerAdvice.handleGeneralExceptions(e);
    }

    return Response.internalServerError(
      body: jsonEncode({'error': 'Internal server error'}),
    );
  }

  PType? _parse<PType>(String? value) {
    if (value == null) {
      return null;
    }

    if (PType == int) {
      return int.parse(value) as PType;
    } else if (PType == double) {
      return double.parse(value) as PType;
    } else if (PType == bool) {
      return bool.parse(value) as PType;
    } else {
      return value as PType;
    }
  }
}

class _DSON extends DSON {
  @override
  (
    Map<Type, FromJsonFunction>,
    Map<Type, ToJsonFunction>,
    Map<Type, ToOpenApiNormalMap>,
  )
  getMaps() {
    final fromJsonMap = <Type, FromJsonFunction>{};
    final toJsonMap = <Type, ToJsonFunction>{};
    final toOpenApiMap = <Type, ToOpenApiNormalMap>{};

    fromJsonMap[IntrospectTokenRequestDto] = (Map<String, dynamic> json) {
      return Function.apply(IntrospectTokenRequestDto.new, [], {
        #token: json['token'],
      });
    };
    toJsonMap[IntrospectTokenRequestDto] = (object) {
      final obj = object as IntrospectTokenRequestDto;
      return {'token': obj.token};
    };
    toOpenApiMap[IntrospectTokenRequestDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "token": {"type": "string"},
      },
      "required": ["token"],
    };

    fromJsonMap[IntrospectTokenResponseDto] = (Map<String, dynamic> json) {
      return Function.apply(IntrospectTokenResponseDto.new, [], {
        #active: json['active'],
        #sub: json['sub'],
        #iss: json['iss'],
        #aud: json['aud'],
        #exp: json['exp'],
        #iat: json['iat'],
        #email: json['email'],
        #role: json['role'],
      });
    };
    toJsonMap[IntrospectTokenResponseDto] = (object) {
      final obj = object as IntrospectTokenResponseDto;
      return {
        'active': obj.active,
        'sub': obj.sub,
        'iss': obj.iss,
        'aud': obj.aud,
        'exp': obj.exp,
        'iat': obj.iat,
        'email': obj.email,
        'role': obj.role,
      };
    };
    toOpenApiMap[IntrospectTokenResponseDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "active": {"type": "boolean"},
        "sub": {"type": "string"},
        "iss": {"type": "string"},
        "aud": {"type": "string"},
        "exp": {"type": "integer"},
        "iat": {"type": "integer"},
        "email": {"type": "string"},
        "role": {"type": "string"},
      },
      "required": ["active"],
    };

    fromJsonMap[RegisterRequestDto] = (Map<String, dynamic> json) {
      return Function.apply(RegisterRequestDto.new, [], {
        #email: json['email'],
        #password: json['password'],
      });
    };
    toJsonMap[RegisterRequestDto] = (object) {
      final obj = object as RegisterRequestDto;
      return {'email': obj.email, 'password': obj.password};
    };
    toOpenApiMap[RegisterRequestDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "email": {"type": "string"},
        "password": {"type": "string"},
      },
      "required": ["email", "password"],
    };

    fromJsonMap[RegisterResponseDto] = (Map<String, dynamic> json) {
      return Function.apply(RegisterResponseDto.new, [], {
        #userId: json['userId'],
        #email: json['email'],
        #role: json['role'],
      });
    };
    toJsonMap[RegisterResponseDto] = (object) {
      final obj = object as RegisterResponseDto;
      return {'userId': obj.userId, 'email': obj.email, 'role': obj.role};
    };
    toOpenApiMap[RegisterResponseDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "userId": {"type": "string"},
        "email": {"type": "string"},
        "role": {"type": "string"},
      },
      "required": ["userId", "email", "role"],
    };

    fromJsonMap[ChangePasswordRequestDto] = (Map<String, dynamic> json) {
      return Function.apply(ChangePasswordRequestDto.new, [], {
        #currentPassword: json['currentPassword'],
        #newPassword: json['newPassword'],
      });
    };
    toJsonMap[ChangePasswordRequestDto] = (object) {
      final obj = object as ChangePasswordRequestDto;
      return {
        'currentPassword': obj.currentPassword,
        'newPassword': obj.newPassword,
      };
    };
    toOpenApiMap[ChangePasswordRequestDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "currentPassword": {"type": "string"},
        "newPassword": {"type": "string"},
      },
      "required": ["currentPassword", "newPassword"],
    };

    fromJsonMap[ForgotPasswordRequestDto] = (Map<String, dynamic> json) {
      return Function.apply(ForgotPasswordRequestDto.new, [], {
        #email: json['email'],
      });
    };
    toJsonMap[ForgotPasswordRequestDto] = (object) {
      final obj = object as ForgotPasswordRequestDto;
      return {'email': obj.email};
    };
    toOpenApiMap[ForgotPasswordRequestDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "email": {"type": "string"},
      },
      "required": ["email"],
    };

    fromJsonMap[ResetPasswordRequestDto] = (Map<String, dynamic> json) {
      return Function.apply(ResetPasswordRequestDto.new, [], {
        #resetToken: json['resetToken'],
        #newPassword: json['newPassword'],
      });
    };
    toJsonMap[ResetPasswordRequestDto] = (object) {
      final obj = object as ResetPasswordRequestDto;
      return {'resetToken': obj.resetToken, 'newPassword': obj.newPassword};
    };
    toOpenApiMap[ResetPasswordRequestDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "resetToken": {"type": "string"},
        "newPassword": {"type": "string"},
      },
      "required": ["resetToken", "newPassword"],
    };

    fromJsonMap[SuccessResponseDto] = (Map<String, dynamic> json) {
      return Function.apply(SuccessResponseDto.new, [], {
        #message: json['message'],
      });
    };
    toJsonMap[SuccessResponseDto] = (object) {
      final obj = object as SuccessResponseDto;
      return {'message': obj.message};
    };
    toOpenApiMap[SuccessResponseDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "message": {"type": "string"},
      },
      "required": ["message"],
    };

    fromJsonMap[ErrorDto] = (Map<String, dynamic> json) {
      return Function.apply(ErrorDto.new, [], {
        #message: json['message'],
        #status: json['status'],
        #error: json['error'],
      });
    };
    toJsonMap[ErrorDto] = (object) {
      final obj = object as ErrorDto;
      return {
        'message': obj.message,
        'status': obj.status,
        'timestamp': toJson<DateTime>(obj.timestamp),
        'error': obj.error,
      };
    };
    toOpenApiMap[ErrorDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "message": {"type": "string"},
        "status": {"type": "string"},
        "timestamp": {r"$ref": "#/components/schemas/DateTime"},
        "error": {"type": "string"},
      },
      "required": ["message", "status", "timestamp", "error"],
    };

    fromJsonMap[LoginRequestDto] = (Map<String, dynamic> json) {
      return Function.apply(LoginRequestDto.new, [], {
        #email: json['email'],
        #password: json['password'],
      });
    };
    toJsonMap[LoginRequestDto] = (object) {
      final obj = object as LoginRequestDto;
      return {'email': obj.email, 'password': obj.password};
    };
    toOpenApiMap[LoginRequestDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "email": {"type": "string"},
        "password": {"type": "string"},
      },
      "required": ["email", "password"],
    };

    fromJsonMap[LoginResponseDto] = (Map<String, dynamic> json) {
      return Function.apply(LoginResponseDto.new, [], {
        #accessToken: json['accessToken'],
        #tokenType: json['tokenType'],
        #expiresIn: json['expiresIn'],
        #userId: json['userId'],
        #email: json['email'],
        #role: json['role'],
      });
    };
    toJsonMap[LoginResponseDto] = (object) {
      final obj = object as LoginResponseDto;
      return {
        'accessToken': obj.accessToken,
        'tokenType': obj.tokenType,
        'expiresIn': obj.expiresIn,
        'userId': obj.userId,
        'email': obj.email,
        'role': obj.role,
      };
    };
    toOpenApiMap[LoginResponseDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "accessToken": {"type": "string"},
        "tokenType": {"type": "string"},
        "expiresIn": {"type": "integer"},
        "userId": {"type": "string"},
        "email": {"type": "string"},
        "role": {"type": "string"},
      },
      "required": [
        "accessToken",
        "tokenType",
        "expiresIn",
        "userId",
        "email",
        "role",
      ],
    };

    return (fromJsonMap, toJsonMap, toOpenApiMap);
  }
}
