// GENERATED CODE - DO NOT MODIFY BY HAND
// Aggregated Vaden application file
// ignore_for_file: prefer_function_declarations_over_variables, implementation_imports

import 'dart:convert';
import 'dart:io';
import 'package:vaden/vaden.dart';

import 'package:certificate_service/config/app_controller_advice.dart';
import 'package:certificate_service/src/errors/base_error.dart' show BaseError;
import 'package:certificate_service/config/middlewares/token_decode_middleware.dart';
import 'package:certificate_service/config/app_warnup.dart';
import 'package:certificate_service/config/openapi/openapi_configuration.dart';
import 'package:certificate_service/config/openapi/openapi_controller.dart';
import 'package:certificate_service/config/app_configuration.dart';
import 'package:certificate_service/src/providers/storage_service_provider.dart';
import 'package:certificate_service/src/utils/date_time_parse.dart';
import 'package:certificate_service/src/models/database.dart';
import 'package:certificate_service/src/dtos/error_dto.dart';
import 'package:certificate_service/src/services/event_publisher.dart';
import 'package:certificate_service/src/repositories/template_repository.dart';
import 'package:certificate_service/src/dtos/template_dtos.dart';
import 'package:certificate_service/src/services/template_management_service.dart';
import 'package:certificate_service/src/controllers/certificate_controller.dart';
import 'package:certificate_service/src/providers/amqp_provider.dart';
import 'package:certificate_service/src/dtos/enrollment_event_dto.dart';
import 'package:certificate_service/src/services/enrollment_event_processor.dart';
import 'package:certificate_service/src/services/certificate_issuance_service.dart';
import 'package:certificate_service/src/repositories/issued_certificate_repository.dart';
import 'package:certificate_service/src/controllers/enrollment_event_listener.dart';

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

    final configurationStorageServiceProvider = StorageServiceProvider();

    _injector.addLazySingleton(
      configurationStorageServiceProvider.storageConfig,
    );
    _injector.addLazySingleton(
      configurationStorageServiceProvider.objectStorageService,
    );
    _injector.addLazySingleton(
      configurationStorageServiceProvider.certificateStorageService,
    );
    _injector.addLazySingleton(
      configurationStorageServiceProvider.storageInitializationService,
    );

    _injector.addLazySingleton(CertificateDatabaseAccess.new);

    _injector.addLazySingleton(EventPublisher.new);

    _injector.addLazySingleton(TemplateRepository.new);

    _injector.addLazySingleton(TemplateManagementService.new);

    _injector.addLazySingleton(CertificateController.new);
    apis.add(
      const Api(
        tag: 'Certificate Management',
        description:
            'Handles certificate template management, including creation, updating, and deletion',
      ),
    );
    final routerCertificateController = Router();
    paths['/certificates/templates'] = <String, dynamic>{
      ...paths['/certificates/templates'] ?? <String, dynamic>{},
      'get': {
        'tags': ['Certificate Management'],
        'summary': '',
        'description': '',
        'responses': <String, dynamic>{},
        'parameters': <Map<String, dynamic>>[],
        'security': <Map<String, dynamic>>[],
      },
    };

    paths['/certificates/templates']['get']['security'] = [
      {'bearer': []},
    ];
    paths['/certificates/templates']['get']['summary'] =
        'List certificate templates';
    paths['/certificates/templates']['get']['description'] =
        'Lists certificate templates with optional filtering and pagination. Requires Gestor role.';
    paths['/certificates/templates']['get']['responses']['200'] = {
      'description': 'Templates retrieved successfully',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates']['get']['responses']['200']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates']['get']['responses']['200']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ListTemplatesResponseDto'};

    paths['/certificates/templates']['get']['responses']['400'] = {
      'description': 'Invalid input parameters',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates']['get']['responses']['400']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates']['get']['responses']['400']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/templates']['get']['responses']['401'] = {
      'description': 'Token JWT ausente ou inválido',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates']['get']['responses']['401']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates']['get']['responses']['401']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/templates']['get']['responses']['403'] = {
      'description': 'Usuário não é gestor',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates']['get']['responses']['403']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates']['get']['responses']['403']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/templates']['get']['responses']['500'] = {
      'description': 'Ocorreu um erro interno ao processar sua solicitação',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates']['get']['responses']['500']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates']['get']['responses']['500']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    var pipelineCertificateControllerlistTemplates = const Pipeline();
    pipelineCertificateControllerlistTemplates =
        pipelineCertificateControllerlistTemplates.addMiddleware((
          Handler inner,
        ) {
          return (Request request) async {
            final guard = _injector.get<TokenDecodeMiddleware>();
            return await guard.handler(request, inner);
          };
        });
    paths['/certificates/templates']['get']['parameters']?.add({
      'name': 'courseId',
      'in': 'query',
      'required': false,
      'schema': {'type': 'string'},
    });

    paths['/certificates/templates']['get']['parameters']?.add({
      'name': 'isActive',
      'in': 'query',
      'required': false,
      'schema': {'type': 'string'},
    });

    paths['/certificates/templates']['get']['parameters']?.add({
      'name': 'page',
      'in': 'query',
      'required': false,
      'schema': {'type': 'string'},
    });

    paths['/certificates/templates']['get']['parameters']?.add({
      'name': 'limit',
      'in': 'query',
      'required': false,
      'schema': {'type': 'string'},
    });

    final handlerCertificateControllerlistTemplates = (Request request) async {
      final courseId = _parse<String?>(request.url.queryParameters['courseId']);
      final isActive = _parse<bool?>(request.url.queryParameters['isActive']);
      final page = _parse<int?>(request.url.queryParameters['page']);
      final limit = _parse<int?>(request.url.queryParameters['limit']);
      final ctrl = _injector.get<CertificateController>();
      final result = await ctrl.listTemplates(
        courseId,
        isActive,
        page,
        limit,
        request,
      );
      final jsoResponse = _injector
          .get<DSON>()
          .toJson<ListTemplatesResponseDto>(result);
      return Response.ok(
        jsonEncode(jsoResponse),
        headers: {'Content-Type': 'application/json'},
      );
    };
    routerCertificateController.get(
      '/templates',
      pipelineCertificateControllerlistTemplates.addHandler(
        handlerCertificateControllerlistTemplates,
      ),
    );
    paths['/certificates/templates'] = <String, dynamic>{
      ...paths['/certificates/templates'] ?? <String, dynamic>{},
      'post': {
        'tags': ['Certificate Management'],
        'summary': '',
        'description': '',
        'responses': <String, dynamic>{},
        'parameters': <Map<String, dynamic>>[],
        'security': <Map<String, dynamic>>[],
      },
    };

    paths['/certificates/templates']['post']['security'] = [
      {'bearer': []},
    ];
    paths['/certificates/templates']['post']['summary'] =
        'Create certificate template';
    paths['/certificates/templates']['post']['description'] =
        'Creates a new certificate template with PDF file upload. Requires Gestor role.';
    paths['/certificates/templates']['post']['responses']['201'] = {
      'description': 'Template created successfully',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates']['post']['responses']['201']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates']['post']['responses']['201']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/TemplateOperationResponseDto'};

    paths['/certificates/templates']['post']['responses']['400'] = {
      'description': 'Invalid input parameters or file',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates']['post']['responses']['400']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates']['post']['responses']['400']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/templates']['post']['responses']['401'] = {
      'description': 'Token JWT ausente ou inválido',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates']['post']['responses']['401']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates']['post']['responses']['401']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/templates']['post']['responses']['403'] = {
      'description': 'Usuário não é gestor',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates']['post']['responses']['403']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates']['post']['responses']['403']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/templates']['post']['responses']['409'] = {
      'description': 'Já existe um template cadastrado para o curso',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates']['post']['responses']['409']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates']['post']['responses']['409']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/templates']['post']['responses']['500'] = {
      'description': 'Ocorreu um erro interno ao processar sua solicitação',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates']['post']['responses']['500']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates']['post']['responses']['500']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    var pipelineCertificateControllercreateTemplate = const Pipeline();
    pipelineCertificateControllercreateTemplate =
        pipelineCertificateControllercreateTemplate.addMiddleware((
          Handler inner,
        ) {
          return (Request request) async {
            final guard = _injector.get<TokenDecodeMiddleware>();
            return await guard.handler(request, inner);
          };
        });
    paths['/certificates/templates']['post']['parameters']?.add({
      'name': 'courseId',
      'in': 'query',
      'required': true,
      'schema': {'type': 'string'},
    });

    paths['/certificates/templates']['post']['parameters']?.add({
      'name': 'templateName',
      'in': 'query',
      'required': true,
      'schema': {'type': 'string'},
    });

    final handlerCertificateControllercreateTemplate = (Request request) async {
      if (request.url.queryParameters['courseId'] == null) {
        return Response(
          400,
          body: jsonEncode({'error': 'Query param is required (courseId)'}),
        );
      }
      final courseId = _parse<String>(request.url.queryParameters['courseId'])!;

      if (request.url.queryParameters['templateName'] == null) {
        return Response(
          400,
          body: jsonEncode({'error': 'Query param is required (templateName)'}),
        );
      }
      final templateName = _parse<String>(
        request.url.queryParameters['templateName'],
      )!;

      final ctrl = _injector.get<CertificateController>();
      final result = await ctrl.createTemplate(request, courseId, templateName);
      final jsoResponse = _injector
          .get<DSON>()
          .toJson<TemplateOperationResponseDto>(result);
      return Response.ok(
        jsonEncode(jsoResponse),
        headers: {'Content-Type': 'application/json'},
      );
    };
    routerCertificateController.post(
      '/templates',
      pipelineCertificateControllercreateTemplate.addHandler(
        handlerCertificateControllercreateTemplate,
      ),
    );
    paths['/certificates/templates/{templateId}'] = <String, dynamic>{
      ...paths['/certificates/templates/{templateId}'] ?? <String, dynamic>{},
      'put': {
        'tags': ['Certificate Management'],
        'summary': '',
        'description': '',
        'responses': <String, dynamic>{},
        'parameters': <Map<String, dynamic>>[],
        'security': <Map<String, dynamic>>[],
      },
    };

    paths['/certificates/templates/{templateId}']['put']['security'] = [
      {'bearer': []},
    ];
    paths['/certificates/templates/{templateId}']['put']['summary'] =
        'Update certificate template';
    paths['/certificates/templates/{templateId}']['put']['description'] =
        'Updates an existing certificate template with new name and/or PDF file. Requires Gestor role.';
    paths['/certificates/templates/{templateId}']['put']['responses']['200'] = {
      'description': 'Template updated successfully',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates/{templateId}']['put']['responses']['200']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates/{templateId}']['put']['responses']['200']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/TemplateOperationResponseDto'};

    paths['/certificates/templates/{templateId}']['put']['responses']['400'] = {
      'description': 'Invalid input parameters or file',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates/{templateId}']['put']['responses']['400']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates/{templateId}']['put']['responses']['400']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/templates/{templateId}']['put']['responses']['401'] = {
      'description': 'Token JWT ausente ou inválido',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates/{templateId}']['put']['responses']['401']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates/{templateId}']['put']['responses']['401']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/templates/{templateId}']['put']['responses']['403'] = {
      'description': 'Usuário não é gestor',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates/{templateId}']['put']['responses']['403']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates/{templateId}']['put']['responses']['403']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/templates/{templateId}']['put']['responses']['404'] = {
      'description': 'Template não encontrado',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates/{templateId}']['put']['responses']['404']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates/{templateId}']['put']['responses']['404']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/templates/{templateId}']['put']['responses']['500'] = {
      'description': 'Ocorreu um erro interno ao processar sua solicitação',
      'content': <String, dynamic>{},
    };

    paths['/certificates/templates/{templateId}']['put']['responses']['500']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates/{templateId}']['put']['responses']['500']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    var pipelineCertificateControllerupdateTemplate = const Pipeline();
    pipelineCertificateControllerupdateTemplate =
        pipelineCertificateControllerupdateTemplate.addMiddleware((
          Handler inner,
        ) {
          return (Request request) async {
            final guard = _injector.get<TokenDecodeMiddleware>();
            return await guard.handler(request, inner);
          };
        });
    paths['/certificates/templates/{templateId}']['put']['parameters']?.add({
      'name': 'templateId',
      'in': 'path',
      'required': true,
      'schema': {'type': 'string'},
    });

    paths['/certificates/templates/{templateId}']['put']['parameters']?.add({
      'name': 'templateName',
      'in': 'query',
      'required': true,
      'schema': {'type': 'string'},
    });

    final handlerCertificateControllerupdateTemplate = (Request request) async {
      if (request.params['templateId'] == null) {
        return Response(
          400,
          body: jsonEncode({'error': 'Path Param is required (templateId)'}),
        );
      }
      final templateId = _parse<String>(request.params['templateId'])!;

      if (request.url.queryParameters['templateName'] == null) {
        return Response(
          400,
          body: jsonEncode({'error': 'Query param is required (templateName)'}),
        );
      }
      final templateName = _parse<String>(
        request.url.queryParameters['templateName'],
      )!;

      final ctrl = _injector.get<CertificateController>();
      final result = await ctrl.updateTemplate(
        templateId,
        templateName,
        request,
      );
      final jsoResponse = _injector
          .get<DSON>()
          .toJson<TemplateOperationResponseDto>(result);
      return Response.ok(
        jsonEncode(jsoResponse),
        headers: {'Content-Type': 'application/json'},
      );
    };
    routerCertificateController.put(
      '/templates/{templateId}',
      pipelineCertificateControllerupdateTemplate.addHandler(
        handlerCertificateControllerupdateTemplate,
      ),
    );
    paths['/certificates/templates/{templateId}'] = <String, dynamic>{
      ...paths['/certificates/templates/{templateId}'] ?? <String, dynamic>{},
      'delete': {
        'tags': ['Certificate Management'],
        'summary': '',
        'description': '',
        'responses': <String, dynamic>{},
        'parameters': <Map<String, dynamic>>[],
        'security': <Map<String, dynamic>>[],
      },
    };

    paths['/certificates/templates/{templateId}']['delete']['security'] = [
      {'bearer': []},
    ];
    paths['/certificates/templates/{templateId}']['delete']['summary'] =
        'Delete certificate template';
    paths['/certificates/templates/{templateId}']['delete']['description'] =
        'Deletes an existing certificate template from storage and database. Requires Gestor role.';
    paths['/certificates/templates/{templateId}']['delete']['responses']['204'] =
        {
          'description': 'Template deleted successfully',
          'content': <String, dynamic>{},
        };

    paths['/certificates/templates/{templateId}']['delete']['responses']['401'] =
        {
          'description': 'Token JWT ausente ou inválido',
          'content': <String, dynamic>{},
        };

    paths['/certificates/templates/{templateId}']['delete']['responses']['401']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates/{templateId}']['delete']['responses']['401']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/templates/{templateId}']['delete']['responses']['403'] =
        {'description': 'Usuário não é gestor', 'content': <String, dynamic>{}};

    paths['/certificates/templates/{templateId}']['delete']['responses']['403']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates/{templateId}']['delete']['responses']['403']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/templates/{templateId}']['delete']['responses']['404'] =
        {
          'description': 'Template não encontrado',
          'content': <String, dynamic>{},
        };

    paths['/certificates/templates/{templateId}']['delete']['responses']['404']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates/{templateId}']['delete']['responses']['404']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/templates/{templateId}']['delete']['responses']['500'] =
        {
          'description': 'Ocorreu um erro interno ao processar sua solicitação',
          'content': <String, dynamic>{},
        };

    paths['/certificates/templates/{templateId}']['delete']['responses']['500']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/templates/{templateId}']['delete']['responses']['500']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    var pipelineCertificateControllerdeleteTemplate = const Pipeline();
    pipelineCertificateControllerdeleteTemplate =
        pipelineCertificateControllerdeleteTemplate.addMiddleware((
          Handler inner,
        ) {
          return (Request request) async {
            final guard = _injector.get<TokenDecodeMiddleware>();
            return await guard.handler(request, inner);
          };
        });
    paths['/certificates/templates/{templateId}']['delete']['parameters']?.add({
      'name': 'templateId',
      'in': 'path',
      'required': true,
      'schema': {'type': 'string'},
    });

    final handlerCertificateControllerdeleteTemplate = (Request request) async {
      if (request.params['templateId'] == null) {
        return Response(
          400,
          body: jsonEncode({'error': 'Path Param is required (templateId)'}),
        );
      }
      final templateId = _parse<String>(request.params['templateId'])!;

      final ctrl = _injector.get<CertificateController>();
      final result = await ctrl.deleteTemplate(templateId, request);
      final jsoResponse = _injector.get<DSON>().toJson<void>(result);
      return Response.ok(
        jsonEncode(jsoResponse),
        headers: {'Content-Type': 'application/json'},
      );
    };
    routerCertificateController.delete(
      '/templates/{templateId}',
      pipelineCertificateControllerdeleteTemplate.addHandler(
        handlerCertificateControllerdeleteTemplate,
      ),
    );
    _router.mount('/certificates', routerCertificateController.call);

    _injector.addLazySingleton(AmqpProvider.new);

    _injector.addLazySingleton(EnrollmentEventProcessor.new);

    _injector.addLazySingleton(CertificateIssuanceService.new);

    _injector.addLazySingleton(IssuedCertificateRepository.new);

    _injector.addLazySingleton(EnrollmentEventListener.new);

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

    fromJsonMap[ListTemplatesRequestDto] = (Map<String, dynamic> json) {
      return Function.apply(ListTemplatesRequestDto.new, [], {
        #courseId: json['courseId'],
        #isActive: json['isActive'],
        if (json.containsKey('page')) #page: json['page'],
        if (json.containsKey('limit')) #limit: json['limit'],
        #userId: json['userId'],
        #email: json['email'],
        #role: json['role'],
      });
    };
    toJsonMap[ListTemplatesRequestDto] = (object) {
      final obj = object as ListTemplatesRequestDto;
      return {
        'courseId': obj.courseId,
        'isActive': obj.isActive,
        'page': obj.page,
        'limit': obj.limit,
        'userId': obj.userId,
        'email': obj.email,
        'role': obj.role,
      };
    };
    toOpenApiMap[ListTemplatesRequestDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "courseId": {"type": "string"},
        "isActive": {"type": "boolean"},
        "page": {"type": "integer"},
        "limit": {"type": "integer"},
        "userId": {"type": "string"},
        "email": {"type": "string"},
        "role": {"type": "string"},
      },
      "required": [],
    };

    fromJsonMap[TemplateDto] = (Map<String, dynamic> json) {
      return Function.apply(TemplateDto.new, [], {
        #templateId: json['templateId'],
        #courseId: json['courseId'],
        #templateName: json['templateName'],
        #templateBlobUrl: json['templateBlobUrl'],
        #uploadedByUserId: json['uploadedByUserId'],
        #createdAt: DateTimeParse().fromJson(json['createdAt']),
        #updatedAt: DateTimeParse().fromJson(json['updatedAt']),
      });
    };
    toJsonMap[TemplateDto] = (object) {
      final obj = object as TemplateDto;
      return {
        'templateId': obj.templateId,
        'courseId': obj.courseId,
        'templateName': obj.templateName,
        'templateBlobUrl': obj.templateBlobUrl,
        'uploadedByUserId': obj.uploadedByUserId,
        'createdAt': DateTimeParse().toJson(obj.createdAt),
        'updatedAt': DateTimeParse().toJson(obj.updatedAt),
      };
    };
    toOpenApiMap[TemplateDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "templateId": {"type": "string"},
        "courseId": {"type": "string"},
        "templateName": {"type": "string"},
        "templateBlobUrl": {"type": "string"},
        "uploadedByUserId": {"type": "string"},
        "createdAt": {"type": "string"},
        "updatedAt": {"type": "string"},
      },
      "required": [
        "templateId",
        "courseId",
        "templateName",
        "templateBlobUrl",
        "uploadedByUserId",
        "createdAt",
        "updatedAt",
      ],
    };

    fromJsonMap[PaginationDto] = (Map<String, dynamic> json) {
      return Function.apply(PaginationDto.new, [], {
        #currentPage: json['currentPage'],
        #pageSize: json['pageSize'],
        #totalItems: json['totalItems'],
        #totalPages: json['totalPages'],
      });
    };
    toJsonMap[PaginationDto] = (object) {
      final obj = object as PaginationDto;
      return {
        'currentPage': obj.currentPage,
        'pageSize': obj.pageSize,
        'totalItems': obj.totalItems,
        'totalPages': obj.totalPages,
      };
    };
    toOpenApiMap[PaginationDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "currentPage": {"type": "integer"},
        "pageSize": {"type": "integer"},
        "totalItems": {"type": "integer"},
        "totalPages": {"type": "integer"},
      },
      "required": ["currentPage", "pageSize", "totalItems", "totalPages"],
    };

    fromJsonMap[ListTemplatesResponseDto] = (Map<String, dynamic> json) {
      return Function.apply(ListTemplatesResponseDto.new, [], {
        #pagination: fromJson<PaginationDto>(json['pagination']),
        #data: fromJsonList<TemplateDto>(json['data']),
      });
    };
    toJsonMap[ListTemplatesResponseDto] = (object) {
      final obj = object as ListTemplatesResponseDto;
      return {
        'pagination': toJson<PaginationDto>(obj.pagination),
        'data': toJsonList<TemplateDto>(obj.data),
      };
    };
    toOpenApiMap[ListTemplatesResponseDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "pagination": {r"$ref": "#/components/schemas/PaginationDto"},
        "data": {
          "type": "array",
          "items": {r"$ref": "#/components/schemas/TemplateDto"},
        },
      },
      "required": ["pagination", "data"],
    };

    fromJsonMap[TemplateOperationResponseDto] = (Map<String, dynamic> json) {
      return Function.apply(TemplateOperationResponseDto.new, [], {
        #templateId: json['templateId'],
        #courseId: json['courseId'],
        #templateName: json['templateName'],
        #templateBlobUrl: json['templateBlobUrl'],
        #uploadedByUserId: json['uploadedByUserId'],
        #createdAt: DateTimeParse().fromJson(json['createdAt']),
        #updatedAt: DateTimeParse().fromJson(json['updatedAt']),
      });
    };
    toJsonMap[TemplateOperationResponseDto] = (object) {
      final obj = object as TemplateOperationResponseDto;
      return {
        'templateId': obj.templateId,
        'courseId': obj.courseId,
        'templateName': obj.templateName,
        'templateBlobUrl': obj.templateBlobUrl,
        'uploadedByUserId': obj.uploadedByUserId,
        'createdAt': DateTimeParse().toJson(obj.createdAt),
        'updatedAt': DateTimeParse().toJson(obj.updatedAt),
      };
    };
    toOpenApiMap[TemplateOperationResponseDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "templateId": {"type": "string"},
        "courseId": {"type": "string"},
        "templateName": {"type": "string"},
        "templateBlobUrl": {"type": "string"},
        "uploadedByUserId": {"type": "string"},
        "createdAt": {"type": "string"},
        "updatedAt": {"type": "string"},
      },
      "required": [
        "templateId",
        "courseId",
        "templateName",
        "templateBlobUrl",
        "uploadedByUserId",
        "createdAt",
        "updatedAt",
      ],
    };

    fromJsonMap[EnrollmentEventDto] = (Map<String, dynamic> json) {
      return Function.apply(EnrollmentEventDto.new, [], {
        #traineeUserId: json['traineeUserId'],
        #enrollmentId: json['enrollmentId'],
        #courseId: json['courseId'],
        #timestamp: json['timestamp'],
      });
    };
    toJsonMap[EnrollmentEventDto] = (object) {
      final obj = object as EnrollmentEventDto;
      return {
        'traineeUserId': obj.traineeUserId,
        'enrollmentId': obj.enrollmentId,
        'courseId': obj.courseId,
        'timestamp': obj.timestamp,
      };
    };
    toOpenApiMap[EnrollmentEventDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "traineeUserId": {"type": "string"},
        "enrollmentId": {"type": "string"},
        "courseId": {"type": "string"},
        "timestamp": {"type": "string"},
      },
      "required": ["traineeUserId", "enrollmentId", "courseId", "timestamp"],
    };

    return (fromJsonMap, toJsonMap, toOpenApiMap);
  }
}
