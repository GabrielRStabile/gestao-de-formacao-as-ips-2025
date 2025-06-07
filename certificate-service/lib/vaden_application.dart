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
import 'package:certificate_service/src/dtos/issued_certificate_dtos.dart';
import 'package:certificate_service/src/services/issued_certificate_service.dart';

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
    paths['/certificates/issued-certificates/pending-approval'] =
        <String, dynamic>{
          ...paths['/certificates/issued-certificates/pending-approval'] ??
              <String, dynamic>{},
          'get': {
            'tags': ['Certificate Management'],
            'summary': '',
            'description': '',
            'responses': <String, dynamic>{},
            'parameters': <Map<String, dynamic>>[],
            'security': <Map<String, dynamic>>[],
          },
        };

    paths['/certificates/issued-certificates/pending-approval']['get']['security'] =
        [
          {'bearer': []},
        ];
    paths['/certificates/issued-certificates/pending-approval']['get']['summary'] =
        'List pending approval certificates';
    paths['/certificates/issued-certificates/pending-approval']['get']['description'] =
        'Lists certificates that are pending approval for emission. Requires Formador role.';
    paths['/certificates/issued-certificates/pending-approval']['get']['responses']['200'] =
        {
          'description': 'Pending certificates retrieved successfully',
          'content': <String, dynamic>{},
        };

    paths['/certificates/issued-certificates/pending-approval']['get']['responses']['200']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/issued-certificates/pending-approval']['get']['responses']['200']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ListPendingCertificatesResponseDto'};

    paths['/certificates/issued-certificates/pending-approval']['get']['responses']['400'] =
        {
          'description': 'Invalid input parameters',
          'content': <String, dynamic>{},
        };

    paths['/certificates/issued-certificates/pending-approval']['get']['responses']['400']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/issued-certificates/pending-approval']['get']['responses']['400']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/issued-certificates/pending-approval']['get']['responses']['401'] =
        {
          'description': 'Token JWT ausente ou inválido',
          'content': <String, dynamic>{},
        };

    paths['/certificates/issued-certificates/pending-approval']['get']['responses']['401']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/issued-certificates/pending-approval']['get']['responses']['401']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/issued-certificates/pending-approval']['get']['responses']['403'] =
        {
          'description': 'Usuário não é formador',
          'content': <String, dynamic>{},
        };

    paths['/certificates/issued-certificates/pending-approval']['get']['responses']['403']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/issued-certificates/pending-approval']['get']['responses']['403']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/issued-certificates/pending-approval']['get']['responses']['500'] =
        {
          'description': 'Ocorreu um erro interno ao processar sua solicitação',
          'content': <String, dynamic>{},
        };

    paths['/certificates/issued-certificates/pending-approval']['get']['responses']['500']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/issued-certificates/pending-approval']['get']['responses']['500']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    var pipelineCertificateControllerlistPendingCertificates = const Pipeline();
    pipelineCertificateControllerlistPendingCertificates =
        pipelineCertificateControllerlistPendingCertificates.addMiddleware((
          Handler inner,
        ) {
          return (Request request) async {
            final guard = _injector.get<TokenDecodeMiddleware>();
            return await guard.handler(request, inner);
          };
        });
    paths['/certificates/issued-certificates/pending-approval']['get']['parameters']
        ?.add({
          'name': 'courseId',
          'in': 'query',
          'required': false,
          'schema': {'type': 'string'},
        });

    paths['/certificates/issued-certificates/pending-approval']['get']['parameters']
        ?.add({
          'name': 'page',
          'in': 'query',
          'required': false,
          'schema': {'type': 'string'},
        });

    paths['/certificates/issued-certificates/pending-approval']['get']['parameters']
        ?.add({
          'name': 'limit',
          'in': 'query',
          'required': false,
          'schema': {'type': 'string'},
        });

    final handlerCertificateControllerlistPendingCertificates =
        (Request request) async {
          final courseId = _parse<String?>(
            request.url.queryParameters['courseId'],
          );
          final page = _parse<int?>(request.url.queryParameters['page']);
          final limit = _parse<int?>(request.url.queryParameters['limit']);
          final ctrl = _injector.get<CertificateController>();
          final result = await ctrl.listPendingCertificates(
            courseId,
            page,
            limit,
            request,
          );
          final jsoResponse = _injector
              .get<DSON>()
              .toJson<ListPendingCertificatesResponseDto>(result);
          return Response.ok(
            jsonEncode(jsoResponse),
            headers: {'Content-Type': 'application/json'},
          );
        };
    routerCertificateController.get(
      '/issued-certificates/pending-approval',
      pipelineCertificateControllerlistPendingCertificates.addHandler(
        handlerCertificateControllerlistPendingCertificates,
      ),
    );
    paths['/certificates/issued-certificates/{certificateId}/approve'] =
        <String, dynamic>{
          ...paths['/certificates/issued-certificates/{certificateId}/approve'] ??
              <String, dynamic>{},
          'post': {
            'tags': ['Certificate Management'],
            'summary': '',
            'description': '',
            'responses': <String, dynamic>{},
            'parameters': <Map<String, dynamic>>[],
            'security': <Map<String, dynamic>>[],
          },
        };

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['security'] =
        [
          {'bearer': []},
        ];
    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['summary'] =
        'Approve certificate for emission';
    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['description'] =
        'Approves a pending certificate for emission. Requires Formador role.';
    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['200'] =
        {
          'description': 'Certificate approved successfully',
          'content': <String, dynamic>{},
        };

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['200']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['200']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/CertificateApprovalResponseDto'};

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['400'] =
        {
          'description': 'Invalid certificate status or parameters',
          'content': <String, dynamic>{},
        };

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['400']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['400']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['401'] =
        {
          'description': 'Token JWT ausente ou inválido',
          'content': <String, dynamic>{},
        };

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['401']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['401']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['403'] =
        {
          'description': 'Usuário não é formador',
          'content': <String, dynamic>{},
        };

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['403']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['403']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['404'] =
        {
          'description': 'Certificado não encontrado',
          'content': <String, dynamic>{},
        };

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['404']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['404']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['500'] =
        {
          'description': 'Ocorreu um erro interno ao processar sua solicitação',
          'content': <String, dynamic>{},
        };

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['500']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['responses']['500']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    var pipelineCertificateControllerapproveCertificate = const Pipeline();
    pipelineCertificateControllerapproveCertificate =
        pipelineCertificateControllerapproveCertificate.addMiddleware((
          Handler inner,
        ) {
          return (Request request) async {
            final guard = _injector.get<TokenDecodeMiddleware>();
            return await guard.handler(request, inner);
          };
        });
    paths['/certificates/issued-certificates/{certificateId}/approve']['post']['parameters']
        ?.add({
          'name': 'certificateId',
          'in': 'path',
          'required': true,
          'schema': {'type': 'string'},
        });

    final handlerCertificateControllerapproveCertificate =
        (Request request) async {
          if (request.params['certificateId'] == null) {
            return Response(
              400,
              body: jsonEncode({
                'error': 'Path Param is required (certificateId)',
              }),
            );
          }
          final certificateId = _parse<String>(
            request.params['certificateId'],
          )!;

          final ctrl = _injector.get<CertificateController>();
          final result = await ctrl.approveCertificate(certificateId, request);
          final jsoResponse = _injector
              .get<DSON>()
              .toJson<CertificateApprovalResponseDto>(result);
          return Response.ok(
            jsonEncode(jsoResponse),
            headers: {'Content-Type': 'application/json'},
          );
        };
    routerCertificateController.post(
      '/issued-certificates/{certificateId}/approve',
      pipelineCertificateControllerapproveCertificate.addHandler(
        handlerCertificateControllerapproveCertificate,
      ),
    );
    paths['/certificates/my-certificates'] = <String, dynamic>{
      ...paths['/certificates/my-certificates'] ?? <String, dynamic>{},
      'get': {
        'tags': ['Certificate Management'],
        'summary': '',
        'description': '',
        'responses': <String, dynamic>{},
        'parameters': <Map<String, dynamic>>[],
        'security': <Map<String, dynamic>>[],
      },
    };

    paths['/certificates/my-certificates']['get']['security'] = [
      {'bearer': []},
    ];
    paths['/certificates/my-certificates']['get']['summary'] =
        'List my certificates';
    paths['/certificates/my-certificates']['get']['description'] =
        'Lists certificates for the authenticated formando user with optional filtering and pagination. Requires Formando role.';
    paths['/certificates/my-certificates']['get']['responses']['200'] = {
      'description': 'Certificates retrieved successfully',
      'content': <String, dynamic>{},
    };

    paths['/certificates/my-certificates']['get']['responses']['200']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/my-certificates']['get']['responses']['200']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ListMyCertificatesResponseDto'};

    paths['/certificates/my-certificates']['get']['responses']['400'] = {
      'description': 'Invalid input parameters',
      'content': <String, dynamic>{},
    };

    paths['/certificates/my-certificates']['get']['responses']['400']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/my-certificates']['get']['responses']['400']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/my-certificates']['get']['responses']['401'] = {
      'description': 'Token JWT ausente ou inválido',
      'content': <String, dynamic>{},
    };

    paths['/certificates/my-certificates']['get']['responses']['401']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/my-certificates']['get']['responses']['401']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/my-certificates']['get']['responses']['403'] = {
      'description': 'Usuário não é formando',
      'content': <String, dynamic>{},
    };

    paths['/certificates/my-certificates']['get']['responses']['403']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/my-certificates']['get']['responses']['403']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/my-certificates']['get']['responses']['500'] = {
      'description': 'Ocorreu um erro interno ao processar sua solicitação',
      'content': <String, dynamic>{},
    };

    paths['/certificates/my-certificates']['get']['responses']['500']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/my-certificates']['get']['responses']['500']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    var pipelineCertificateControllerlistMyCertificates = const Pipeline();
    pipelineCertificateControllerlistMyCertificates =
        pipelineCertificateControllerlistMyCertificates.addMiddleware((
          Handler inner,
        ) {
          return (Request request) async {
            final guard = _injector.get<TokenDecodeMiddleware>();
            return await guard.handler(request, inner);
          };
        });
    paths['/certificates/my-certificates']['get']['parameters']?.add({
      'name': 'courseId',
      'in': 'query',
      'required': false,
      'schema': {'type': 'string'},
    });

    paths['/certificates/my-certificates']['get']['parameters']?.add({
      'name': 'page',
      'in': 'query',
      'required': false,
      'schema': {'type': 'string'},
    });

    paths['/certificates/my-certificates']['get']['parameters']?.add({
      'name': 'limit',
      'in': 'query',
      'required': false,
      'schema': {'type': 'string'},
    });

    final handlerCertificateControllerlistMyCertificates =
        (Request request) async {
          final courseId = _parse<String?>(
            request.url.queryParameters['courseId'],
          );
          final page = _parse<int?>(request.url.queryParameters['page']);
          final limit = _parse<int?>(request.url.queryParameters['limit']);
          final ctrl = _injector.get<CertificateController>();
          final result = await ctrl.listMyCertificates(
            courseId,
            page,
            limit,
            request,
          );
          final jsoResponse = _injector
              .get<DSON>()
              .toJson<ListMyCertificatesResponseDto>(result);
          return Response.ok(
            jsonEncode(jsoResponse),
            headers: {'Content-Type': 'application/json'},
          );
        };
    routerCertificateController.get(
      '/my-certificates',
      pipelineCertificateControllerlistMyCertificates.addHandler(
        handlerCertificateControllerlistMyCertificates,
      ),
    );
    paths['/certificates/my-certificates/{certificateId}/download'] =
        <String, dynamic>{
          ...paths['/certificates/my-certificates/{certificateId}/download'] ??
              <String, dynamic>{},
          'get': {
            'tags': ['Certificate Management'],
            'summary': '',
            'description': '',
            'responses': <String, dynamic>{},
            'parameters': <Map<String, dynamic>>[],
            'security': <Map<String, dynamic>>[],
          },
        };

    paths['/certificates/my-certificates/{certificateId}/download']['get']['security'] =
        [
          {'bearer': []},
        ];
    paths['/certificates/my-certificates/{certificateId}/download']['get']['summary'] =
        'Download my certificate';
    paths['/certificates/my-certificates/{certificateId}/download']['get']['description'] =
        'Downloads a certificate for the authenticated formando user. Returns a redirect to the certificate blob URL. Requires Formando role.';
    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['302'] =
        {
          'description': 'Redirect to certificate download URL',
          'content': <String, dynamic>{},
        };

    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['400'] =
        {
          'description': 'Invalid certificate ID',
          'content': <String, dynamic>{},
        };

    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['400']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['400']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['401'] =
        {
          'description': 'Token JWT ausente ou inválido',
          'content': <String, dynamic>{},
        };

    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['401']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['401']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['403'] =
        {
          'description':
              'Formando tentando baixar certificado de outro formando',
          'content': <String, dynamic>{},
        };

    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['403']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['403']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['404'] = {
      'description':
          'CertificateId não encontrado, certificateId não tem blobUrl (não foi emitido), certificateId não foi aprovado pelo formador',
      'content': <String, dynamic>{},
    };

    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['404']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['404']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['500'] =
        {
          'description': 'Ocorreu um erro interno ao processar sua solicitação',
          'content': <String, dynamic>{},
        };

    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['500']['content']['application/json'] =
        <String, dynamic>{};

    paths['/certificates/my-certificates/{certificateId}/download']['get']['responses']['500']['content']['application/json']['schema'] =
        {'\$ref': '#/components/schemas/ErrorDto'};

    var pipelineCertificateControllerdownloadCertificate = const Pipeline();
    pipelineCertificateControllerdownloadCertificate =
        pipelineCertificateControllerdownloadCertificate.addMiddleware((
          Handler inner,
        ) {
          return (Request request) async {
            final guard = _injector.get<TokenDecodeMiddleware>();
            return await guard.handler(request, inner);
          };
        });
    paths['/certificates/my-certificates/{certificateId}/download']['get']['parameters']
        ?.add({
          'name': 'certificateId',
          'in': 'path',
          'required': true,
          'schema': {'type': 'string'},
        });

    final handlerCertificateControllerdownloadCertificate =
        (Request request) async {
          if (request.params['certificateId'] == null) {
            return Response(
              400,
              body: jsonEncode({
                'error': 'Path Param is required (certificateId)',
              }),
            );
          }
          final certificateId = _parse<String>(
            request.params['certificateId'],
          )!;

          final ctrl = _injector.get<CertificateController>();
          final result = await ctrl.downloadCertificate(certificateId, request);
          return result;
        };
    routerCertificateController.get(
      '/my-certificates/{certificateId}/download',
      pipelineCertificateControllerdownloadCertificate.addHandler(
        handlerCertificateControllerdownloadCertificate,
      ),
    );
    _router.mount('/certificates', routerCertificateController.call);

    _injector.addLazySingleton(AmqpProvider.new);

    _injector.addLazySingleton(EnrollmentEventProcessor.new);

    _injector.addLazySingleton(CertificateIssuanceService.new);

    _injector.addLazySingleton(IssuedCertificateRepository.new);

    _injector.addLazySingleton(EnrollmentEventListener.new);

    _injector.addLazySingleton(IssuedCertificateService.new);

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

    fromJsonMap[ListPendingCertificatesRequestDto] =
        (Map<String, dynamic> json) {
          return Function.apply(ListPendingCertificatesRequestDto.new, [], {
            #courseId: json['courseId'],
            #page: json['page'],
            #limit: json['limit'],
            #userId: json['userId'],
            #email: json['email'],
            #role: json['role'],
          });
        };
    toJsonMap[ListPendingCertificatesRequestDto] = (object) {
      final obj = object as ListPendingCertificatesRequestDto;
      return {
        'courseId': obj.courseId,
        'page': obj.page,
        'limit': obj.limit,
        'userId': obj.userId,
        'email': obj.email,
        'role': obj.role,
      };
    };
    toOpenApiMap[ListPendingCertificatesRequestDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "courseId": {"type": "string"},
        "page": {"type": "integer"},
        "limit": {"type": "integer"},
        "userId": {"type": "string"},
        "email": {"type": "string"},
        "role": {"type": "string"},
      },
      "required": ["page", "limit"],
    };

    fromJsonMap[IssuedCertificateDto] = (Map<String, dynamic> json) {
      return Function.apply(IssuedCertificateDto.new, [], {
        #certificateId: json['certificateId'],
        #traineeUserId: json['traineeUserId'],
        #enrollmentId: json['enrollmentId'],
        #courseId: json['courseId'],
        #status: json['status'],
        #emissionApprovedByUserId: json['emissionApprovedByUserId'],
        #certificateBlobUrl: json['certificateBlobUrl'],
        #verificationCode: json['verificationCode'],
        #createdAt: fromJson<DateTime>(json['createdAt']),
        #emissionApprovedAt: json['emissionApprovedAt'] == null
            ? null
            : fromJson<DateTime?>(json['emissionApprovedAt']),
        #issuedAt: json['issuedAt'] == null
            ? null
            : fromJson<DateTime?>(json['issuedAt']),
        #updatedAt: fromJson<DateTime>(json['updatedAt']),
      });
    };
    toJsonMap[IssuedCertificateDto] = (object) {
      final obj = object as IssuedCertificateDto;
      return {
        'certificateId': obj.certificateId,
        'traineeUserId': obj.traineeUserId,
        'enrollmentId': obj.enrollmentId,
        'courseId': obj.courseId,
        'status': obj.status,
        'emissionApprovedByUserId': obj.emissionApprovedByUserId,
        'certificateBlobUrl': obj.certificateBlobUrl,
        'verificationCode': obj.verificationCode,
        'createdAt': toJson<DateTime>(obj.createdAt),
        'emissionApprovedAt': obj.emissionApprovedAt == null
            ? null
            : toJson<DateTime?>(obj.emissionApprovedAt!),
        'issuedAt': obj.issuedAt == null
            ? null
            : toJson<DateTime?>(obj.issuedAt!),
        'updatedAt': toJson<DateTime>(obj.updatedAt),
      };
    };
    toOpenApiMap[IssuedCertificateDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "certificateId": {"type": "string"},
        "traineeUserId": {"type": "string"},
        "enrollmentId": {"type": "string"},
        "courseId": {"type": "string"},
        "status": {"type": "string"},
        "emissionApprovedByUserId": {"type": "string"},
        "certificateBlobUrl": {"type": "string"},
        "verificationCode": {"type": "string"},
        "createdAt": {r"$ref": "#/components/schemas/DateTime"},
        "emissionApprovedAt": {r"$ref": "#/components/schemas/DateTime?"},
        "issuedAt": {r"$ref": "#/components/schemas/DateTime?"},
        "updatedAt": {r"$ref": "#/components/schemas/DateTime"},
      },
      "required": [
        "certificateId",
        "traineeUserId",
        "enrollmentId",
        "courseId",
        "status",
        "createdAt",
        "updatedAt",
      ],
    };

    fromJsonMap[ListPendingCertificatesResponseDto] =
        (Map<String, dynamic> json) {
          return Function.apply(ListPendingCertificatesResponseDto.new, [], {
            #certificates: fromJsonList<IssuedCertificateDto>(
              json['certificates'],
            ),
            #pagination: fromJson<CertificatePaginationDto>(json['pagination']),
          });
        };
    toJsonMap[ListPendingCertificatesResponseDto] = (object) {
      final obj = object as ListPendingCertificatesResponseDto;
      return {
        'certificates': toJsonList<IssuedCertificateDto>(obj.certificates),
        'pagination': toJson<CertificatePaginationDto>(obj.pagination),
      };
    };
    toOpenApiMap[ListPendingCertificatesResponseDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "certificates": {
          "type": "array",
          "items": {r"$ref": "#/components/schemas/IssuedCertificateDto"},
        },
        "pagination": {
          r"$ref": "#/components/schemas/CertificatePaginationDto",
        },
      },
      "required": ["certificates", "pagination"],
    };

    fromJsonMap[CertificatePaginationDto] = (Map<String, dynamic> json) {
      return Function.apply(CertificatePaginationDto.new, [], {
        #currentPage: json['currentPage'],
        #itemsPerPage: json['itemsPerPage'],
        #totalItems: json['totalItems'],
        #totalPages: json['totalPages'],
        #hasNextPage: json['hasNextPage'],
        #hasPreviousPage: json['hasPreviousPage'],
      });
    };
    toJsonMap[CertificatePaginationDto] = (object) {
      final obj = object as CertificatePaginationDto;
      return {
        'currentPage': obj.currentPage,
        'itemsPerPage': obj.itemsPerPage,
        'totalItems': obj.totalItems,
        'totalPages': obj.totalPages,
        'hasNextPage': obj.hasNextPage,
        'hasPreviousPage': obj.hasPreviousPage,
      };
    };
    toOpenApiMap[CertificatePaginationDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "currentPage": {"type": "integer"},
        "itemsPerPage": {"type": "integer"},
        "totalItems": {"type": "integer"},
        "totalPages": {"type": "integer"},
        "hasNextPage": {"type": "boolean"},
        "hasPreviousPage": {"type": "boolean"},
      },
      "required": [
        "currentPage",
        "itemsPerPage",
        "totalItems",
        "totalPages",
        "hasNextPage",
        "hasPreviousPage",
      ],
    };

    fromJsonMap[ApproveCertificateRequestDto] = (Map<String, dynamic> json) {
      return Function.apply(ApproveCertificateRequestDto.new, [], {
        #userId: json['userId'],
        #email: json['email'],
        #role: json['role'],
      });
    };
    toJsonMap[ApproveCertificateRequestDto] = (object) {
      final obj = object as ApproveCertificateRequestDto;
      return {'userId': obj.userId, 'email': obj.email, 'role': obj.role};
    };
    toOpenApiMap[ApproveCertificateRequestDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "userId": {"type": "string"},
        "email": {"type": "string"},
        "role": {"type": "string"},
      },
      "required": [],
    };

    fromJsonMap[CertificateApprovalResponseDto] = (Map<String, dynamic> json) {
      return Function.apply(CertificateApprovalResponseDto.new, [], {
        #certificateId: json['certificateId'],
        #status: json['status'],
        #message: json['message'],
      });
    };
    toJsonMap[CertificateApprovalResponseDto] = (object) {
      final obj = object as CertificateApprovalResponseDto;
      return {
        'certificateId': obj.certificateId,
        'status': obj.status,
        'message': obj.message,
      };
    };
    toOpenApiMap[CertificateApprovalResponseDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "certificateId": {"type": "string"},
        "status": {"type": "string"},
        "message": {"type": "string"},
      },
      "required": ["certificateId", "status", "message"],
    };

    fromJsonMap[ListMyCertificatesRequestDto] = (Map<String, dynamic> json) {
      return Function.apply(ListMyCertificatesRequestDto.new, [], {
        #courseId: json['courseId'],
        #page: json['page'],
        #limit: json['limit'],
        #userId: json['userId'],
        #email: json['email'],
        #role: json['role'],
      });
    };
    toJsonMap[ListMyCertificatesRequestDto] = (object) {
      final obj = object as ListMyCertificatesRequestDto;
      return {
        'courseId': obj.courseId,
        'page': obj.page,
        'limit': obj.limit,
        'userId': obj.userId,
        'email': obj.email,
        'role': obj.role,
      };
    };
    toOpenApiMap[ListMyCertificatesRequestDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "courseId": {"type": "string"},
        "page": {"type": "integer"},
        "limit": {"type": "integer"},
        "userId": {"type": "string"},
        "email": {"type": "string"},
        "role": {"type": "string"},
      },
      "required": ["page", "limit"],
    };

    fromJsonMap[MyCertificateDto] = (Map<String, dynamic> json) {
      return Function.apply(MyCertificateDto.new, [], {
        #certificateId: json['certificateId'],
        #courseId: json['courseId'],
        #courseName: json['courseName'],
        #status: json['status'],
        #certificateBlobUrl: json['certificateBlobUrl'],
        #verificationCode: json['verificationCode'],
        #issuedAt: json['issuedAt'] == null
            ? null
            : fromJson<DateTime?>(json['issuedAt']),
        #expiresAt: json['expiresAt'] == null
            ? null
            : fromJson<DateTime?>(json['expiresAt']),
        #updatedAt: fromJson<DateTime>(json['updatedAt']),
      });
    };
    toJsonMap[MyCertificateDto] = (object) {
      final obj = object as MyCertificateDto;
      return {
        'certificateId': obj.certificateId,
        'courseId': obj.courseId,
        'courseName': obj.courseName,
        'status': obj.status,
        'certificateBlobUrl': obj.certificateBlobUrl,
        'verificationCode': obj.verificationCode,
        'issuedAt': obj.issuedAt == null
            ? null
            : toJson<DateTime?>(obj.issuedAt!),
        'expiresAt': obj.expiresAt == null
            ? null
            : toJson<DateTime?>(obj.expiresAt!),
        'updatedAt': toJson<DateTime>(obj.updatedAt),
      };
    };
    toOpenApiMap[MyCertificateDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "certificateId": {"type": "string"},
        "courseId": {"type": "string"},
        "courseName": {"type": "string"},
        "status": {"type": "string"},
        "certificateBlobUrl": {"type": "string"},
        "verificationCode": {"type": "string"},
        "issuedAt": {r"$ref": "#/components/schemas/DateTime?"},
        "expiresAt": {r"$ref": "#/components/schemas/DateTime?"},
        "updatedAt": {r"$ref": "#/components/schemas/DateTime"},
      },
      "required": ["certificateId", "courseId", "status", "updatedAt"],
    };

    fromJsonMap[ListMyCertificatesResponseDto] = (Map<String, dynamic> json) {
      return Function.apply(ListMyCertificatesResponseDto.new, [], {
        #certificates: fromJsonList<MyCertificateDto>(json['certificates']),
        #pagination: fromJson<CertificatePaginationDto>(json['pagination']),
      });
    };
    toJsonMap[ListMyCertificatesResponseDto] = (object) {
      final obj = object as ListMyCertificatesResponseDto;
      return {
        'certificates': toJsonList<MyCertificateDto>(obj.certificates),
        'pagination': toJson<CertificatePaginationDto>(obj.pagination),
      };
    };
    toOpenApiMap[ListMyCertificatesResponseDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "certificates": {
          "type": "array",
          "items": {r"$ref": "#/components/schemas/MyCertificateDto"},
        },
        "pagination": {
          r"$ref": "#/components/schemas/CertificatePaginationDto",
        },
      },
      "required": ["certificates", "pagination"],
    };

    fromJsonMap[DownloadCertificateRequestDto] = (Map<String, dynamic> json) {
      return Function.apply(DownloadCertificateRequestDto.new, [], {
        #certificateId: json['certificateId'],
        #userId: json['userId'],
        #email: json['email'],
        #role: json['role'],
      });
    };
    toJsonMap[DownloadCertificateRequestDto] = (object) {
      final obj = object as DownloadCertificateRequestDto;
      return {
        'certificateId': obj.certificateId,
        'userId': obj.userId,
        'email': obj.email,
        'role': obj.role,
      };
    };
    toOpenApiMap[DownloadCertificateRequestDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "certificateId": {"type": "string"},
        "userId": {"type": "string"},
        "email": {"type": "string"},
        "role": {"type": "string"},
      },
      "required": ["certificateId"],
    };

    fromJsonMap[CertificateDownloadResponseDto] = (Map<String, dynamic> json) {
      return Function.apply(CertificateDownloadResponseDto.new, [], {
        #downloadUrl: json['downloadUrl'],
        #certificateId: json['certificateId'],
        #message: json['message'],
      });
    };
    toJsonMap[CertificateDownloadResponseDto] = (object) {
      final obj = object as CertificateDownloadResponseDto;
      return {
        'downloadUrl': obj.downloadUrl,
        'certificateId': obj.certificateId,
        'message': obj.message,
      };
    };
    toOpenApiMap[CertificateDownloadResponseDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "downloadUrl": {"type": "string"},
        "certificateId": {"type": "string"},
        "message": {"type": "string"},
      },
      "required": ["downloadUrl", "certificateId", "message"],
    };

    return (fromJsonMap, toJsonMap, toOpenApiMap);
  }
}
