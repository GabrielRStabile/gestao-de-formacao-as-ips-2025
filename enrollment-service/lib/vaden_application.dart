// GENERATED CODE - DO NOT MODIFY BY HAND
// Aggregated Vaden application file
// ignore_for_file: prefer_function_declarations_over_variables, implementation_imports

import 'dart:convert';
import 'dart:io';
import 'package:vaden/vaden.dart';

import 'package:enrollment_service/config/app_controller_advice.dart';
import 'package:enrollment_service/src/errors/base_error.dart' show BaseError;
import 'package:enrollment_service/config/middlewares/token_decode_middleware.dart';
import 'package:enrollment_service/config/app_warnup.dart';
import 'package:enrollment_service/config/openapi/openapi_configuration.dart';
import 'package:enrollment_service/config/openapi/openapi_controller.dart';
import 'package:enrollment_service/config/app_configuration.dart';
import 'package:enrollment_service/src/providers/amqp_provider.dart';
import 'package:enrollment_service/src/utils/date_time_parse.dart';
import 'package:enrollment_service/src/utils/verification_code_generator.dart';
import 'package:enrollment_service/src/models/database.dart';
import 'package:enrollment_service/src/dtos/error_dto.dart';

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

    _injector.addLazySingleton(TokenDecodeMiddleware.new);

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

    _injector.addLazySingleton(AmqpProvider.new);

    _injector.addLazySingleton(VerificationCodeGenerator.new);

    _injector.addLazySingleton(EnrollmentDatabaseAccess.new);

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

    return (fromJsonMap, toJsonMap, toOpenApiMap);
  }
}
