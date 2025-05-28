// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $AuditLogEntriesTable extends AuditLogEntries
    with TableInfo<$AuditLogEntriesTable, AuditLogEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $AuditLogEntriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _logIdMeta = const VerificationMeta('logId');
  @override
  late final GeneratedColumn<BigInt> logId = GeneratedColumn<BigInt>(
    'log_id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.bigInt,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _eventTimestampMeta = const VerificationMeta(
    'eventTimestamp',
  );
  @override
  late final GeneratedColumn<PgDateTime> eventTimestamp =
      GeneratedColumn<PgDateTime>(
        'event_timestamp',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _sourceServiceMeta = const VerificationMeta(
    'sourceService',
  );
  @override
  late final GeneratedColumn<String> sourceService = GeneratedColumn<String>(
    'source_service',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _eventTypeMeta = const VerificationMeta(
    'eventType',
  );
  @override
  late final GeneratedColumn<String> eventType = GeneratedColumn<String>(
    'event_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetEntityIdMeta = const VerificationMeta(
    'targetEntityId',
  );
  @override
  late final GeneratedColumn<String> targetEntityId = GeneratedColumn<String>(
    'target_entity_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _targetEntityTypeMeta = const VerificationMeta(
    'targetEntityType',
  );
  @override
  late final GeneratedColumn<String> targetEntityType = GeneratedColumn<String>(
    'target_entity_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ipAddressMeta = const VerificationMeta(
    'ipAddress',
  );
  @override
  late final GeneratedColumn<String> ipAddress = GeneratedColumn<String>(
    'ip_address',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _detailsMeta = const VerificationMeta(
    'details',
  );
  @override
  late final GeneratedColumn<Object> details = GeneratedColumn<Object>(
    'details',
    aliasedName,
    true,
    type: PgTypes.jsonb,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<PgDateTime> createdAt =
      GeneratedColumn<PgDateTime>(
        'created_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        defaultValue: now(),
      );
  @override
  List<GeneratedColumn> get $columns => [
    logId,
    eventTimestamp,
    sourceService,
    eventType,
    userId,
    targetEntityId,
    targetEntityType,
    ipAddress,
    details,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'audit_log_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<AuditLogEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('log_id')) {
      context.handle(
        _logIdMeta,
        logId.isAcceptableOrUnknown(data['log_id']!, _logIdMeta),
      );
    }
    if (data.containsKey('event_timestamp')) {
      context.handle(
        _eventTimestampMeta,
        eventTimestamp.isAcceptableOrUnknown(
          data['event_timestamp']!,
          _eventTimestampMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_eventTimestampMeta);
    }
    if (data.containsKey('source_service')) {
      context.handle(
        _sourceServiceMeta,
        sourceService.isAcceptableOrUnknown(
          data['source_service']!,
          _sourceServiceMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_sourceServiceMeta);
    }
    if (data.containsKey('event_type')) {
      context.handle(
        _eventTypeMeta,
        eventType.isAcceptableOrUnknown(data['event_type']!, _eventTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_eventTypeMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    }
    if (data.containsKey('target_entity_id')) {
      context.handle(
        _targetEntityIdMeta,
        targetEntityId.isAcceptableOrUnknown(
          data['target_entity_id']!,
          _targetEntityIdMeta,
        ),
      );
    }
    if (data.containsKey('target_entity_type')) {
      context.handle(
        _targetEntityTypeMeta,
        targetEntityType.isAcceptableOrUnknown(
          data['target_entity_type']!,
          _targetEntityTypeMeta,
        ),
      );
    }
    if (data.containsKey('ip_address')) {
      context.handle(
        _ipAddressMeta,
        ipAddress.isAcceptableOrUnknown(data['ip_address']!, _ipAddressMeta),
      );
    }
    if (data.containsKey('details')) {
      context.handle(
        _detailsMeta,
        details.isAcceptableOrUnknown(data['details']!, _detailsMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {logId};
  @override
  AuditLogEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return AuditLogEntry(
      logId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bigInt,
            data['${effectivePrefix}log_id'],
          )!,
      eventTimestamp:
          attachedDatabase.typeMapping.read(
            PgTypes.timestampWithTimezone,
            data['${effectivePrefix}event_timestamp'],
          )!,
      sourceService:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}source_service'],
          )!,
      eventType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}event_type'],
          )!,
      userId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}user_id'],
      ),
      targetEntityId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_entity_id'],
      ),
      targetEntityType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}target_entity_type'],
      ),
      ipAddress: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ip_address'],
      ),
      details: attachedDatabase.typeMapping.read(
        PgTypes.jsonb,
        data['${effectivePrefix}details'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            PgTypes.timestampWithTimezone,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $AuditLogEntriesTable createAlias(String alias) {
    return $AuditLogEntriesTable(attachedDatabase, alias);
  }
}

class AuditLogEntry extends DataClass implements Insertable<AuditLogEntry> {
  /// Primary key - auto-incrementing unique identifier
  final BigInt logId;

  /// Timestamp when the audited event occurred
  final PgDateTime eventTimestamp;

  /// Name of the service that generated the audit event
  final String sourceService;

  /// Type of event that was audited (CREATE, UPDATE, DELETE, etc.)
  final String eventType;

  /// ID of the user who performed the action (optional)
  final String? userId;

  /// ID of the entity that was affected by the action (optional)
  final String? targetEntityId;

  /// Type of the entity that was affected (optional)
  final String? targetEntityType;

  /// IP address from which the action was performed (optional)
  final String? ipAddress;

  /// Additional event details stored as JSONB (optional)
  final Object? details;

  /// Timestamp when the audit log entry was created in the database
  final PgDateTime createdAt;
  const AuditLogEntry({
    required this.logId,
    required this.eventTimestamp,
    required this.sourceService,
    required this.eventType,
    this.userId,
    this.targetEntityId,
    this.targetEntityType,
    this.ipAddress,
    this.details,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['log_id'] = Variable<BigInt>(logId);
    map['event_timestamp'] = Variable<PgDateTime>(
      eventTimestamp,
      PgTypes.timestampWithTimezone,
    );
    map['source_service'] = Variable<String>(sourceService);
    map['event_type'] = Variable<String>(eventType);
    if (!nullToAbsent || userId != null) {
      map['user_id'] = Variable<String>(userId);
    }
    if (!nullToAbsent || targetEntityId != null) {
      map['target_entity_id'] = Variable<String>(targetEntityId);
    }
    if (!nullToAbsent || targetEntityType != null) {
      map['target_entity_type'] = Variable<String>(targetEntityType);
    }
    if (!nullToAbsent || ipAddress != null) {
      map['ip_address'] = Variable<String>(ipAddress);
    }
    if (!nullToAbsent || details != null) {
      map['details'] = Variable<Object>(details, PgTypes.jsonb);
    }
    map['created_at'] = Variable<PgDateTime>(
      createdAt,
      PgTypes.timestampWithTimezone,
    );
    return map;
  }

  AuditLogEntriesCompanion toCompanion(bool nullToAbsent) {
    return AuditLogEntriesCompanion(
      logId: Value(logId),
      eventTimestamp: Value(eventTimestamp),
      sourceService: Value(sourceService),
      eventType: Value(eventType),
      userId:
          userId == null && nullToAbsent ? const Value.absent() : Value(userId),
      targetEntityId:
          targetEntityId == null && nullToAbsent
              ? const Value.absent()
              : Value(targetEntityId),
      targetEntityType:
          targetEntityType == null && nullToAbsent
              ? const Value.absent()
              : Value(targetEntityType),
      ipAddress:
          ipAddress == null && nullToAbsent
              ? const Value.absent()
              : Value(ipAddress),
      details:
          details == null && nullToAbsent
              ? const Value.absent()
              : Value(details),
      createdAt: Value(createdAt),
    );
  }

  factory AuditLogEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return AuditLogEntry(
      logId: serializer.fromJson<BigInt>(json['logId']),
      eventTimestamp: serializer.fromJson<PgDateTime>(json['eventTimestamp']),
      sourceService: serializer.fromJson<String>(json['sourceService']),
      eventType: serializer.fromJson<String>(json['eventType']),
      userId: serializer.fromJson<String?>(json['userId']),
      targetEntityId: serializer.fromJson<String?>(json['targetEntityId']),
      targetEntityType: serializer.fromJson<String?>(json['targetEntityType']),
      ipAddress: serializer.fromJson<String?>(json['ipAddress']),
      details: serializer.fromJson<Object?>(json['details']),
      createdAt: serializer.fromJson<PgDateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'logId': serializer.toJson<BigInt>(logId),
      'eventTimestamp': serializer.toJson<PgDateTime>(eventTimestamp),
      'sourceService': serializer.toJson<String>(sourceService),
      'eventType': serializer.toJson<String>(eventType),
      'userId': serializer.toJson<String?>(userId),
      'targetEntityId': serializer.toJson<String?>(targetEntityId),
      'targetEntityType': serializer.toJson<String?>(targetEntityType),
      'ipAddress': serializer.toJson<String?>(ipAddress),
      'details': serializer.toJson<Object?>(details),
      'createdAt': serializer.toJson<PgDateTime>(createdAt),
    };
  }

  AuditLogEntry copyWith({
    BigInt? logId,
    PgDateTime? eventTimestamp,
    String? sourceService,
    String? eventType,
    Value<String?> userId = const Value.absent(),
    Value<String?> targetEntityId = const Value.absent(),
    Value<String?> targetEntityType = const Value.absent(),
    Value<String?> ipAddress = const Value.absent(),
    Value<Object?> details = const Value.absent(),
    PgDateTime? createdAt,
  }) => AuditLogEntry(
    logId: logId ?? this.logId,
    eventTimestamp: eventTimestamp ?? this.eventTimestamp,
    sourceService: sourceService ?? this.sourceService,
    eventType: eventType ?? this.eventType,
    userId: userId.present ? userId.value : this.userId,
    targetEntityId:
        targetEntityId.present ? targetEntityId.value : this.targetEntityId,
    targetEntityType:
        targetEntityType.present
            ? targetEntityType.value
            : this.targetEntityType,
    ipAddress: ipAddress.present ? ipAddress.value : this.ipAddress,
    details: details.present ? details.value : this.details,
    createdAt: createdAt ?? this.createdAt,
  );
  AuditLogEntry copyWithCompanion(AuditLogEntriesCompanion data) {
    return AuditLogEntry(
      logId: data.logId.present ? data.logId.value : this.logId,
      eventTimestamp:
          data.eventTimestamp.present
              ? data.eventTimestamp.value
              : this.eventTimestamp,
      sourceService:
          data.sourceService.present
              ? data.sourceService.value
              : this.sourceService,
      eventType: data.eventType.present ? data.eventType.value : this.eventType,
      userId: data.userId.present ? data.userId.value : this.userId,
      targetEntityId:
          data.targetEntityId.present
              ? data.targetEntityId.value
              : this.targetEntityId,
      targetEntityType:
          data.targetEntityType.present
              ? data.targetEntityType.value
              : this.targetEntityType,
      ipAddress: data.ipAddress.present ? data.ipAddress.value : this.ipAddress,
      details: data.details.present ? data.details.value : this.details,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogEntry(')
          ..write('logId: $logId, ')
          ..write('eventTimestamp: $eventTimestamp, ')
          ..write('sourceService: $sourceService, ')
          ..write('eventType: $eventType, ')
          ..write('userId: $userId, ')
          ..write('targetEntityId: $targetEntityId, ')
          ..write('targetEntityType: $targetEntityType, ')
          ..write('ipAddress: $ipAddress, ')
          ..write('details: $details, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    logId,
    eventTimestamp,
    sourceService,
    eventType,
    userId,
    targetEntityId,
    targetEntityType,
    ipAddress,
    details,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is AuditLogEntry &&
          other.logId == this.logId &&
          other.eventTimestamp == this.eventTimestamp &&
          other.sourceService == this.sourceService &&
          other.eventType == this.eventType &&
          other.userId == this.userId &&
          other.targetEntityId == this.targetEntityId &&
          other.targetEntityType == this.targetEntityType &&
          other.ipAddress == this.ipAddress &&
          other.details == this.details &&
          other.createdAt == this.createdAt);
}

class AuditLogEntriesCompanion extends UpdateCompanion<AuditLogEntry> {
  final Value<BigInt> logId;
  final Value<PgDateTime> eventTimestamp;
  final Value<String> sourceService;
  final Value<String> eventType;
  final Value<String?> userId;
  final Value<String?> targetEntityId;
  final Value<String?> targetEntityType;
  final Value<String?> ipAddress;
  final Value<Object?> details;
  final Value<PgDateTime> createdAt;
  const AuditLogEntriesCompanion({
    this.logId = const Value.absent(),
    this.eventTimestamp = const Value.absent(),
    this.sourceService = const Value.absent(),
    this.eventType = const Value.absent(),
    this.userId = const Value.absent(),
    this.targetEntityId = const Value.absent(),
    this.targetEntityType = const Value.absent(),
    this.ipAddress = const Value.absent(),
    this.details = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  AuditLogEntriesCompanion.insert({
    this.logId = const Value.absent(),
    required PgDateTime eventTimestamp,
    required String sourceService,
    required String eventType,
    this.userId = const Value.absent(),
    this.targetEntityId = const Value.absent(),
    this.targetEntityType = const Value.absent(),
    this.ipAddress = const Value.absent(),
    this.details = const Value.absent(),
    this.createdAt = const Value.absent(),
  }) : eventTimestamp = Value(eventTimestamp),
       sourceService = Value(sourceService),
       eventType = Value(eventType);
  static Insertable<AuditLogEntry> custom({
    Expression<BigInt>? logId,
    Expression<PgDateTime>? eventTimestamp,
    Expression<String>? sourceService,
    Expression<String>? eventType,
    Expression<String>? userId,
    Expression<String>? targetEntityId,
    Expression<String>? targetEntityType,
    Expression<String>? ipAddress,
    Expression<Object>? details,
    Expression<PgDateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (logId != null) 'log_id': logId,
      if (eventTimestamp != null) 'event_timestamp': eventTimestamp,
      if (sourceService != null) 'source_service': sourceService,
      if (eventType != null) 'event_type': eventType,
      if (userId != null) 'user_id': userId,
      if (targetEntityId != null) 'target_entity_id': targetEntityId,
      if (targetEntityType != null) 'target_entity_type': targetEntityType,
      if (ipAddress != null) 'ip_address': ipAddress,
      if (details != null) 'details': details,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  AuditLogEntriesCompanion copyWith({
    Value<BigInt>? logId,
    Value<PgDateTime>? eventTimestamp,
    Value<String>? sourceService,
    Value<String>? eventType,
    Value<String?>? userId,
    Value<String?>? targetEntityId,
    Value<String?>? targetEntityType,
    Value<String?>? ipAddress,
    Value<Object?>? details,
    Value<PgDateTime>? createdAt,
  }) {
    return AuditLogEntriesCompanion(
      logId: logId ?? this.logId,
      eventTimestamp: eventTimestamp ?? this.eventTimestamp,
      sourceService: sourceService ?? this.sourceService,
      eventType: eventType ?? this.eventType,
      userId: userId ?? this.userId,
      targetEntityId: targetEntityId ?? this.targetEntityId,
      targetEntityType: targetEntityType ?? this.targetEntityType,
      ipAddress: ipAddress ?? this.ipAddress,
      details: details ?? this.details,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (logId.present) {
      map['log_id'] = Variable<BigInt>(logId.value);
    }
    if (eventTimestamp.present) {
      map['event_timestamp'] = Variable<PgDateTime>(
        eventTimestamp.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (sourceService.present) {
      map['source_service'] = Variable<String>(sourceService.value);
    }
    if (eventType.present) {
      map['event_type'] = Variable<String>(eventType.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (targetEntityId.present) {
      map['target_entity_id'] = Variable<String>(targetEntityId.value);
    }
    if (targetEntityType.present) {
      map['target_entity_type'] = Variable<String>(targetEntityType.value);
    }
    if (ipAddress.present) {
      map['ip_address'] = Variable<String>(ipAddress.value);
    }
    if (details.present) {
      map['details'] = Variable<Object>(details.value, PgTypes.jsonb);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<PgDateTime>(
        createdAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('AuditLogEntriesCompanion(')
          ..write('logId: $logId, ')
          ..write('eventTimestamp: $eventTimestamp, ')
          ..write('sourceService: $sourceService, ')
          ..write('eventType: $eventType, ')
          ..write('userId: $userId, ')
          ..write('targetEntityId: $targetEntityId, ')
          ..write('targetEntityType: $targetEntityType, ')
          ..write('ipAddress: $ipAddress, ')
          ..write('details: $details, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AuditDatabase extends GeneratedDatabase {
  _$AuditDatabase(QueryExecutor e) : super(e);
  $AuditDatabaseManager get managers => $AuditDatabaseManager(this);
  late final $AuditLogEntriesTable auditLogEntries = $AuditLogEntriesTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [auditLogEntries];
}

typedef $$AuditLogEntriesTableCreateCompanionBuilder =
    AuditLogEntriesCompanion Function({
      Value<BigInt> logId,
      required PgDateTime eventTimestamp,
      required String sourceService,
      required String eventType,
      Value<String?> userId,
      Value<String?> targetEntityId,
      Value<String?> targetEntityType,
      Value<String?> ipAddress,
      Value<Object?> details,
      Value<PgDateTime> createdAt,
    });
typedef $$AuditLogEntriesTableUpdateCompanionBuilder =
    AuditLogEntriesCompanion Function({
      Value<BigInt> logId,
      Value<PgDateTime> eventTimestamp,
      Value<String> sourceService,
      Value<String> eventType,
      Value<String?> userId,
      Value<String?> targetEntityId,
      Value<String?> targetEntityType,
      Value<String?> ipAddress,
      Value<Object?> details,
      Value<PgDateTime> createdAt,
    });

class $$AuditLogEntriesTableFilterComposer
    extends Composer<_$AuditDatabase, $AuditLogEntriesTable> {
  $$AuditLogEntriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<BigInt> get logId => $composableBuilder(
    column: $table.logId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get eventTimestamp => $composableBuilder(
    column: $table.eventTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get sourceService => $composableBuilder(
    column: $table.sourceService,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetEntityId => $composableBuilder(
    column: $table.targetEntityId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get targetEntityType => $composableBuilder(
    column: $table.targetEntityType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ipAddress => $composableBuilder(
    column: $table.ipAddress,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Object> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$AuditLogEntriesTableOrderingComposer
    extends Composer<_$AuditDatabase, $AuditLogEntriesTable> {
  $$AuditLogEntriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<BigInt> get logId => $composableBuilder(
    column: $table.logId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get eventTimestamp => $composableBuilder(
    column: $table.eventTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get sourceService => $composableBuilder(
    column: $table.sourceService,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get eventType => $composableBuilder(
    column: $table.eventType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetEntityId => $composableBuilder(
    column: $table.targetEntityId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get targetEntityType => $composableBuilder(
    column: $table.targetEntityType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ipAddress => $composableBuilder(
    column: $table.ipAddress,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Object> get details => $composableBuilder(
    column: $table.details,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$AuditLogEntriesTableAnnotationComposer
    extends Composer<_$AuditDatabase, $AuditLogEntriesTable> {
  $$AuditLogEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<BigInt> get logId =>
      $composableBuilder(column: $table.logId, builder: (column) => column);

  GeneratedColumn<PgDateTime> get eventTimestamp => $composableBuilder(
    column: $table.eventTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get sourceService => $composableBuilder(
    column: $table.sourceService,
    builder: (column) => column,
  );

  GeneratedColumn<String> get eventType =>
      $composableBuilder(column: $table.eventType, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get targetEntityId => $composableBuilder(
    column: $table.targetEntityId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get targetEntityType => $composableBuilder(
    column: $table.targetEntityType,
    builder: (column) => column,
  );

  GeneratedColumn<String> get ipAddress =>
      $composableBuilder(column: $table.ipAddress, builder: (column) => column);

  GeneratedColumn<Object> get details =>
      $composableBuilder(column: $table.details, builder: (column) => column);

  GeneratedColumn<PgDateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$AuditLogEntriesTableTableManager
    extends
        RootTableManager<
          _$AuditDatabase,
          $AuditLogEntriesTable,
          AuditLogEntry,
          $$AuditLogEntriesTableFilterComposer,
          $$AuditLogEntriesTableOrderingComposer,
          $$AuditLogEntriesTableAnnotationComposer,
          $$AuditLogEntriesTableCreateCompanionBuilder,
          $$AuditLogEntriesTableUpdateCompanionBuilder,
          (
            AuditLogEntry,
            BaseReferences<
              _$AuditDatabase,
              $AuditLogEntriesTable,
              AuditLogEntry
            >,
          ),
          AuditLogEntry,
          PrefetchHooks Function()
        > {
  $$AuditLogEntriesTableTableManager(
    _$AuditDatabase db,
    $AuditLogEntriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () =>
                  $$AuditLogEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$AuditLogEntriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$AuditLogEntriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<BigInt> logId = const Value.absent(),
                Value<PgDateTime> eventTimestamp = const Value.absent(),
                Value<String> sourceService = const Value.absent(),
                Value<String> eventType = const Value.absent(),
                Value<String?> userId = const Value.absent(),
                Value<String?> targetEntityId = const Value.absent(),
                Value<String?> targetEntityType = const Value.absent(),
                Value<String?> ipAddress = const Value.absent(),
                Value<Object?> details = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
              }) => AuditLogEntriesCompanion(
                logId: logId,
                eventTimestamp: eventTimestamp,
                sourceService: sourceService,
                eventType: eventType,
                userId: userId,
                targetEntityId: targetEntityId,
                targetEntityType: targetEntityType,
                ipAddress: ipAddress,
                details: details,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<BigInt> logId = const Value.absent(),
                required PgDateTime eventTimestamp,
                required String sourceService,
                required String eventType,
                Value<String?> userId = const Value.absent(),
                Value<String?> targetEntityId = const Value.absent(),
                Value<String?> targetEntityType = const Value.absent(),
                Value<String?> ipAddress = const Value.absent(),
                Value<Object?> details = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
              }) => AuditLogEntriesCompanion.insert(
                logId: logId,
                eventTimestamp: eventTimestamp,
                sourceService: sourceService,
                eventType: eventType,
                userId: userId,
                targetEntityId: targetEntityId,
                targetEntityType: targetEntityType,
                ipAddress: ipAddress,
                details: details,
                createdAt: createdAt,
              ),
          withReferenceMapper:
              (p0) =>
                  p0
                      .map(
                        (e) => (
                          e.readTable(table),
                          BaseReferences(db, table, e),
                        ),
                      )
                      .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$AuditLogEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AuditDatabase,
      $AuditLogEntriesTable,
      AuditLogEntry,
      $$AuditLogEntriesTableFilterComposer,
      $$AuditLogEntriesTableOrderingComposer,
      $$AuditLogEntriesTableAnnotationComposer,
      $$AuditLogEntriesTableCreateCompanionBuilder,
      $$AuditLogEntriesTableUpdateCompanionBuilder,
      (
        AuditLogEntry,
        BaseReferences<_$AuditDatabase, $AuditLogEntriesTable, AuditLogEntry>,
      ),
      AuditLogEntry,
      PrefetchHooks Function()
    >;

class $AuditDatabaseManager {
  final _$AuditDatabase _db;
  $AuditDatabaseManager(this._db);
  $$AuditLogEntriesTableTableManager get auditLogEntries =>
      $$AuditLogEntriesTableTableManager(_db, _db.auditLogEntries);
}
