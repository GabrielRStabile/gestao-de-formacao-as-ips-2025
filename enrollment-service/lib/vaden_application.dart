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
import 'package:enrollment_service/src/repositories/enrollment_request_repository.dart';
import 'package:enrollment_service/src/repositories/enrollment_status_history_repository.dart';
import 'package:enrollment_service/src/models/database.dart';
import 'package:enrollment_service/src/dtos/enrollment_request_dto.dart';
import 'package:enrollment_service/src/dtos/error_dto.dart';
import 'package:enrollment_service/src/controllers/enrollment_controller.dart';
import 'package:enrollment_service/src/services/enrollment_service.dart';

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

    _injector.addLazySingleton(EnrollmentRequestRepository.new);

    _injector.addLazySingleton(EnrollmentStatusHistoryRepository.new);

    _injector.addLazySingleton(EnrollmentDatabaseAccess.new);

    _injector.addLazySingleton(EnrollmentController.new);
    apis.add(
      const Api(
        tag: 'Enrollment Management',
        description: 'Handles enrollment request registration and management',
      ),
    );
    final routerEnrollmentController = Router();
    paths['/enrollments/register'] = <String, dynamic>{
      ...paths['/enrollments/register'] ?? <String, dynamic>{},
      'post': {
        'tags': ['Enrollment Management'],
        'summary': '',
        'description': '',
        'responses': <String, dynamic>{},
        'parameters': <Map<String, dynamic>>[],
        'security': <Map<String, dynamic>>[],
      },
    };

    paths['/enrollments/register']['post']['security'] = [
      {'bearer': []},
    ];
    paths['/enrollments/register']['post']['summary'] =
        'Register for course offering';
    paths['/enrollments/register']['post']['description'] =
        'Creates a new enrollment request for a course offering. Requires formando role.';
    paths['/enrollments/register']['post']['responses']['201'] = {
      'description': 'Enrollment request created successfully',
      'content': <String, dynamic>{},
    };

    paths['/enrollments/register']['post']['responses']['201']['content']['application/json'] =
        <String, dynamic>{};

    paths['/enrollments/register']['post']['responses']['201']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/EnrollmentRequestResponseDto'};

    paths['/enrollments/register']['post']['responses']['400'] = {
      'description': 'Invalid input parameters',
      'content': <String, dynamic>{},
    };

    paths['/enrollments/register']['post']['responses']['400']['content']['application/json'] =
        <String, dynamic>{};

    paths['/enrollments/register']['post']['responses']['400']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/enrollments/register']['post']['responses']['401'] = {
      'description': 'Token JWT ausente ou inválido',
      'content': <String, dynamic>{},
    };

    paths['/enrollments/register']['post']['responses']['401']['content']['application/json'] =
        <String, dynamic>{};

    paths['/enrollments/register']['post']['responses']['401']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/enrollments/register']['post']['responses']['403'] = {
      'description': 'Usuário não é formando',
      'content': <String, dynamic>{},
    };

    paths['/enrollments/register']['post']['responses']['403']['content']['application/json'] =
        <String, dynamic>{};

    paths['/enrollments/register']['post']['responses']['403']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/enrollments/register']['post']['responses']['409'] = {
      'description': 'Já existe inscrição para este curso',
      'content': <String, dynamic>{},
    };

    paths['/enrollments/register']['post']['responses']['409']['content']['application/json'] =
        <String, dynamic>{};

    paths['/enrollments/register']['post']['responses']['409']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/enrollments/register']['post']['responses']['500'] = {
      'description': 'Ocorreu um erro interno ao processar sua solicitação',
      'content': <String, dynamic>{},
    };

    paths['/enrollments/register']['post']['responses']['500']['content']['application/json'] =
        <String, dynamic>{};

    paths['/enrollments/register']['post']['responses']['500']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    var pipelineEnrollmentControllerregisterEnrollment = const Pipeline();
    pipelineEnrollmentControllerregisterEnrollment =
        pipelineEnrollmentControllerregisterEnrollment.addMiddleware((
          Handler inner,
        ) {
          return (Request request) async {
            final guard = _injector.get<TokenDecodeMiddleware>();
            return await guard.handler(request, inner);
          };
        });
    paths['/enrollments/register']['post']['requestBody'] = {
      'content': {
        'application/json': {
          'schema': {
            '\$ref': '#/components/schemas/EnrollmentRequestCreateDto',
          },
        },
      },
      'required': true,
    };

    final handlerEnrollmentControllerregisterEnrollment =
        (Request request) async {
          final bodyString = await request.readAsString();
          final bodyJson = jsonDecode(bodyString) as Map<String, dynamic>;
          final createDto =
              _injector.get<DSON>().fromJson<EnrollmentRequestCreateDto>(
                    bodyJson,
                  )
                  as dynamic;

          if (createDto == null) {
            return Response(
              400,
              body: jsonEncode({
                'error': 'Invalid body: (EnrollmentRequestCreateDto)',
              }),
            );
          }

          if (createDto is Validator<EnrollmentRequestCreateDto>) {
            final validator = createDto.validate(
              ValidatorBuilder<EnrollmentRequestCreateDto>(),
            );
            final resultValidator = validator.validate(
              createDto as EnrollmentRequestCreateDto,
            );
            if (!resultValidator.isValid) {
              throw ResponseException<List<Map<String, dynamic>>>(
                400,
                resultValidator.exceptionToJson(),
              );
            }
          }

          final ctrl = _injector.get<EnrollmentController>();
          final result = await ctrl.registerEnrollment(createDto, request);
          final jsoResponse = _injector
              .get<DSON>()
              .toJson<EnrollmentRequestResponseDto>(result);
          return Response.ok(
            jsonEncode(jsoResponse),
            headers: {'Content-Type': 'application/json'},
          );
        };
    routerEnrollmentController.post(
      '/register',
      pipelineEnrollmentControllerregisterEnrollment.addHandler(
        handlerEnrollmentControllerregisterEnrollment,
      ),
    );
    _router.mount('/enrollments', routerEnrollmentController.call);

    _injector.addLazySingleton(EnrollmentService.new);

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

    fromJsonMap[EnrollmentRequestCreateDto] = (Map<String, dynamic> json) {
      return Function.apply(EnrollmentRequestCreateDto.new, [], {
        #courseOfferingId: json['courseOfferingId'],
        #notes: json['notes'],
      });
    };
    toJsonMap[EnrollmentRequestCreateDto] = (object) {
      final obj = object as EnrollmentRequestCreateDto;
      return {'courseOfferingId': obj.courseOfferingId, 'notes': obj.notes};
    };
    toOpenApiMap[EnrollmentRequestCreateDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "courseOfferingId": {"type": "string"},
        "notes": {"type": "string"},
      },
      "required": ["courseOfferingId"],
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

    return (fromJsonMap, toJsonMap, toOpenApiMap);
  }
}
