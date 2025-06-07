// GENERATED CODE - DO NOT MODIFY BY HAND
// Aggregated Vaden application file
// ignore_for_file: prefer_function_declarations_over_variables, implementation_imports

import 'dart:convert';
import 'dart:io';
import 'package:vaden/vaden.dart';

import 'package:audit_service/config/app_controller_advice.dart';
import 'package:audit_service/src/errors/base_error.dart' show BaseError;
import 'package:audit_service/config/openapi/openapi_configuration.dart';
import 'package:audit_service/config/openapi/openapi_controller.dart';
import 'package:audit_service/config/app_configuration.dart';
import 'package:audit_service/src/utils/date_time_parse.dart';
import 'package:audit_service/src/repositories/audit_log_repository.dart';
import 'package:audit_service/src/models/database.dart';
import 'package:audit_service/src/dtos/audit_event_dto.dart';
import 'package:audit_service/src/dtos/list_audit_logs_dto.dart';
import 'package:audit_service/src/dtos/error_dto.dart';
import 'package:audit_service/src/controllers/audit_controller.dart';
import 'package:audit_service/src/controllers/audit_event_listener.dart';
import 'package:audit_service/src/services/audit_event_processor.dart';
import 'package:audit_service/src/services/audit_log_service.dart';
import 'package:audit_service/src/providers/amqp_provider.dart';
import 'package:audit_service/config/app_warnup.dart';

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

    _injector.addLazySingleton(AuditLogRepository.new);

    _injector.addLazySingleton(AuditDatabaseAccess.new);

    _injector.addLazySingleton(AuditController.new);
    final routerAuditController = Router();
    var pipelineAuditControllerlistAuditLogs = const Pipeline();
    final handlerAuditControllerlistAuditLogs = (Request request) async {
      final bodyString = await request.readAsString();
      final bodyJson = jsonDecode(bodyString) as Map<String, dynamic>;
      final requestDto =
          _injector.get<DSON>().fromJson<ListAuditLogsRequestDto>(bodyJson)
              as dynamic;

      if (requestDto == null) {
        return Response(
          400,
          body: jsonEncode({
            'error': 'Invalid body: (ListAuditLogsRequestDto)',
          }),
        );
      }

      if (requestDto is Validator<ListAuditLogsRequestDto>) {
        final validator = requestDto.validate(
          ValidatorBuilder<ListAuditLogsRequestDto>(),
        );
        final resultValidator = validator.validate(
          requestDto as ListAuditLogsRequestDto,
        );
        if (!resultValidator.isValid) {
          throw ResponseException<List<Map<String, dynamic>>>(
            400,
            resultValidator.exceptionToJson(),
          );
        }
      }

      final ctrl = _injector.get<AuditController>();
      final result = await ctrl.listAuditLogs(requestDto);
      final jsoResponse = _injector.get<DSON>().toJson<PaginatedAuditLogsDto>(
        result,
      );
      return Response.ok(
        jsonEncode(jsoResponse),
        headers: {'Content-Type': 'application/json'},
      );
    };
    routerAuditController.get(
      '/logs',
      pipelineAuditControllerlistAuditLogs.addHandler(
        handlerAuditControllerlistAuditLogs,
      ),
    );
    _router.mount('/audit', routerAuditController.call);

    _injector.addLazySingleton(AuditEventListener.new);

    _injector.addLazySingleton(AuditEventProcessor.new);

    _injector.addLazySingleton(AuditLogService.new);

    _injector.addLazySingleton(AmqpProvider.new);

    _injector.addBind(
      Bind.withClassName(
        constructor: AppWarnup.new,
        type: BindType.lazySingleton,
        className: 'ApplicationRunner',
      ),
    );

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

    fromJsonMap[AuditEventDto] = (Map<String, dynamic> json) {
      return Function.apply(AuditEventDto.new, [], {
        #eventId: json['eventId'],
        #eventTimestamp: DateTimeParse().fromJson(json['eventTimestamp']),
        #sourceService: json['sourceService'],
        #eventType: json['eventType'],
        #userId: json['userId'],
        #targetEntityId: json['targetEntityId'],
        #targetEntityType: json['targetEntityType'],
        #ipAddress: json['ipAddress'],
        #details: json['details'],
      });
    };
    toJsonMap[AuditEventDto] = (object) {
      final obj = object as AuditEventDto;
      return {
        'eventId': obj.eventId,
        'eventTimestamp': DateTimeParse().toJson(obj.eventTimestamp),
        'sourceService': obj.sourceService,
        'eventType': obj.eventType,
        'userId': obj.userId,
        'targetEntityId': obj.targetEntityId,
        'targetEntityType': obj.targetEntityType,
        'ipAddress': obj.ipAddress,
        'details': obj.details,
      };
    };
    toOpenApiMap[AuditEventDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "eventId": {"type": "string"},
        "eventTimestamp": {"type": "string"},
        "sourceService": {"type": "string"},
        "eventType": {"type": "string"},
        "userId": {"type": "string"},
        "targetEntityId": {"type": "string"},
        "targetEntityType": {"type": "string"},
        "ipAddress": {"type": "string"},
        "details": {
          "type": "object",
          "properties": {
            "key": {"type": "object"},
          },
        },
      },
      "required": ["eventId", "eventTimestamp", "sourceService", "eventType"],
    };

    fromJsonMap[ListAuditLogsRequestDto] = (Map<String, dynamic> json) {
      return Function.apply(ListAuditLogsRequestDto.new, [], {
        if (json.containsKey('page')) #page: json['page'],
        if (json.containsKey('limit')) #limit: json['limit'],
        if (json.containsKey('sortBy')) #sortBy: json['sortBy'],
        if (json.containsKey('sortOrder')) #sortOrder: json['sortOrder'],
        #startDate: DateTimeParse().fromJson(json['startDate']),
        #endDate: DateTimeParse().fromJson(json['endDate']),
        #userId: json['userId'],
        #sourceService: json['sourceService'],
        #eventType: json['eventType'],
        #targetEntityId: json['targetEntityId'],
        #targetEntityType: json['targetEntityType'],
        #ipAddress: json['ipAddress'],
      });
    };
    toJsonMap[ListAuditLogsRequestDto] = (object) {
      final obj = object as ListAuditLogsRequestDto;
      return {
        'page': obj.page,
        'limit': obj.limit,
        'sortBy': obj.sortBy,
        'sortOrder': obj.sortOrder,
        'startDate': DateTimeParse().toJson(obj.startDate),
        'endDate': DateTimeParse().toJson(obj.endDate),
        'userId': obj.userId,
        'sourceService': obj.sourceService,
        'eventType': obj.eventType,
        'targetEntityId': obj.targetEntityId,
        'targetEntityType': obj.targetEntityType,
        'ipAddress': obj.ipAddress,
      };
    };
    toOpenApiMap[ListAuditLogsRequestDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "page": {"type": "integer"},
        "limit": {"type": "integer"},
        "sortBy": {"type": "string"},
        "sortOrder": {"type": "string"},
        "startDate": {"type": "string"},
        "endDate": {"type": "string"},
        "userId": {"type": "string"},
        "sourceService": {"type": "string"},
        "eventType": {"type": "string"},
        "targetEntityId": {"type": "string"},
        "targetEntityType": {"type": "string"},
        "ipAddress": {"type": "string"},
      },
      "required": ["page", "limit", "sortBy", "sortOrder"],
    };

    fromJsonMap[PaginatedAuditLogsDto] = (Map<String, dynamic> json) {
      return Function.apply(PaginatedAuditLogsDto.new, [], {
        #pagination: fromJson<PaginationDto>(json['pagination']),
        #data: fromJsonList<AuditLogResponseDto>(json['data']),
      });
    };
    toJsonMap[PaginatedAuditLogsDto] = (object) {
      final obj = object as PaginatedAuditLogsDto;
      return {
        'pagination': toJson<PaginationDto>(obj.pagination),
        'data': toJsonList<AuditLogResponseDto>(obj.data),
      };
    };
    toOpenApiMap[PaginatedAuditLogsDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "pagination": {r"$ref": "#/components/schemas/PaginationDto"},
        "data": {
          "type": "array",
          "items": {r"$ref": "#/components/schemas/AuditLogResponseDto"},
        },
      },
      "required": ["pagination", "data"],
    };

    fromJsonMap[AuditLogResponseDto] = (Map<String, dynamic> json) {
      return Function.apply(AuditLogResponseDto.new, [], {
        #logId: json['logId'],
        #eventTimestamp: DateTimeParse().fromJson(json['eventTimestamp']),
        #sourceService: json['sourceService'],
        #eventType: json['eventType'],
        #userId: json['userId'],
        #targetEntityId: json['targetEntityId'],
        #targetEntityType: json['targetEntityType'],
        #ipAddress: json['ipAddress'],
        #details: json['details'],
        #createdAt: DateTimeParse().fromJson(json['createdAt']),
      });
    };
    toJsonMap[AuditLogResponseDto] = (object) {
      final obj = object as AuditLogResponseDto;
      return {
        'logId': obj.logId,
        'eventTimestamp': DateTimeParse().toJson(obj.eventTimestamp),
        'sourceService': obj.sourceService,
        'eventType': obj.eventType,
        'userId': obj.userId,
        'targetEntityId': obj.targetEntityId,
        'targetEntityType': obj.targetEntityType,
        'ipAddress': obj.ipAddress,
        'details': obj.details,
        'createdAt': DateTimeParse().toJson(obj.createdAt),
      };
    };
    toOpenApiMap[AuditLogResponseDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "logId": {"type": "integer"},
        "eventTimestamp": {"type": "string"},
        "sourceService": {"type": "string"},
        "eventType": {"type": "string"},
        "userId": {"type": "string"},
        "targetEntityId": {"type": "string"},
        "targetEntityType": {"type": "string"},
        "ipAddress": {"type": "string"},
        "details": {
          "type": "object",
          "properties": {
            "key": {"type": "object"},
          },
        },
        "createdAt": {"type": "string"},
      },
      "required": [
        "logId",
        "eventTimestamp",
        "sourceService",
        "eventType",
        "createdAt",
      ],
    };

    fromJsonMap[PaginationDto] = (Map<String, dynamic> json) {
      return Function.apply(PaginationDto.new, [], {
        #currentPage: json['currentPage'],
        #pageSize: json['pageSize'],
        #totalItems: json['totalItems'],
        #totalPages: json['totalPages'],
        #hasNext: json['hasNext'],
        #hasPrevious: json['hasPrevious'],
      });
    };
    toJsonMap[PaginationDto] = (object) {
      final obj = object as PaginationDto;
      return {
        'currentPage': obj.currentPage,
        'pageSize': obj.pageSize,
        'totalItems': obj.totalItems,
        'totalPages': obj.totalPages,
        'hasNext': obj.hasNext,
        'hasPrevious': obj.hasPrevious,
      };
    };
    toOpenApiMap[PaginationDto] = {
      "type": "object",
      "properties": <String, dynamic>{
        "currentPage": {"type": "integer"},
        "pageSize": {"type": "integer"},
        "totalItems": {"type": "integer"},
        "totalPages": {"type": "integer"},
        "hasNext": {"type": "boolean"},
        "hasPrevious": {"type": "boolean"},
      },
      "required": [
        "currentPage",
        "pageSize",
        "totalItems",
        "totalPages",
        "hasNext",
        "hasPrevious",
      ],
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
