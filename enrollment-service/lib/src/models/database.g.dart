// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $EnrollmentRequestsTable extends EnrollmentRequests
    with TableInfo<$EnrollmentRequestsTable, EnrollmentRequest> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EnrollmentRequestsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _enrollmentIdMeta = const VerificationMeta(
    'enrollmentId',
  );
  @override
  late final GeneratedColumn<String> enrollmentId = GeneratedColumn<String>(
    'enrollment_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _traineeUserIdMeta = const VerificationMeta(
    'traineeUserId',
  );
  @override
  late final GeneratedColumn<String> traineeUserId = GeneratedColumn<String>(
    'trainee_user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseOfferingIdMeta = const VerificationMeta(
    'courseOfferingId',
  );
  @override
  late final GeneratedColumn<String> courseOfferingId = GeneratedColumn<String>(
    'course_offering_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    check:
        () => status.isIn([
          'PENDING_APPROVAL',
          'APPROVED',
          'REJECTED',
          'CANCELLED_BY_TRAINEE',
          'CANCELLED_BY_SYSTEM',
          'COMPLETED',
        ]),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _requestDateMeta = const VerificationMeta(
    'requestDate',
  );
  @override
  late final GeneratedColumn<PgDateTime> requestDate =
      GeneratedColumn<PgDateTime>(
        'request_date',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        defaultValue: now(),
      );
  static const VerificationMeta _decisionDateMeta = const VerificationMeta(
    'decisionDate',
  );
  @override
  late final GeneratedColumn<PgDateTime> decisionDate =
      GeneratedColumn<PgDateTime>(
        'decision_date',
        aliasedName,
        true,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _managerUserIdMeta = const VerificationMeta(
    'managerUserId',
  );
  @override
  late final GeneratedColumn<String> managerUserId = GeneratedColumn<String>(
    'manager_user_id',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _rejectionReasonMeta = const VerificationMeta(
    'rejectionReason',
  );
  @override
  late final GeneratedColumn<String> rejectionReason = GeneratedColumn<String>(
    'rejection_reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<PgDateTime> updatedAt =
      GeneratedColumn<PgDateTime>(
        'updated_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        defaultValue: now(),
      );
  static const VerificationMeta _notesMeta = const VerificationMeta('notes');
  @override
  late final GeneratedColumn<String> notes = GeneratedColumn<String>(
    'notes',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    enrollmentId,
    traineeUserId,
    courseOfferingId,
    status,
    requestDate,
    decisionDate,
    managerUserId,
    rejectionReason,
    updatedAt,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'enrollment_requests';
  @override
  VerificationContext validateIntegrity(
    Insertable<EnrollmentRequest> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('enrollment_id')) {
      context.handle(
        _enrollmentIdMeta,
        enrollmentId.isAcceptableOrUnknown(
          data['enrollment_id']!,
          _enrollmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_enrollmentIdMeta);
    }
    if (data.containsKey('trainee_user_id')) {
      context.handle(
        _traineeUserIdMeta,
        traineeUserId.isAcceptableOrUnknown(
          data['trainee_user_id']!,
          _traineeUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_traineeUserIdMeta);
    }
    if (data.containsKey('course_offering_id')) {
      context.handle(
        _courseOfferingIdMeta,
        courseOfferingId.isAcceptableOrUnknown(
          data['course_offering_id']!,
          _courseOfferingIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_courseOfferingIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('request_date')) {
      context.handle(
        _requestDateMeta,
        requestDate.isAcceptableOrUnknown(
          data['request_date']!,
          _requestDateMeta,
        ),
      );
    }
    if (data.containsKey('decision_date')) {
      context.handle(
        _decisionDateMeta,
        decisionDate.isAcceptableOrUnknown(
          data['decision_date']!,
          _decisionDateMeta,
        ),
      );
    }
    if (data.containsKey('manager_user_id')) {
      context.handle(
        _managerUserIdMeta,
        managerUserId.isAcceptableOrUnknown(
          data['manager_user_id']!,
          _managerUserIdMeta,
        ),
      );
    }
    if (data.containsKey('rejection_reason')) {
      context.handle(
        _rejectionReasonMeta,
        rejectionReason.isAcceptableOrUnknown(
          data['rejection_reason']!,
          _rejectionReasonMeta,
        ),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('notes')) {
      context.handle(
        _notesMeta,
        notes.isAcceptableOrUnknown(data['notes']!, _notesMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {enrollmentId};
  @override
  EnrollmentRequest map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EnrollmentRequest(
      enrollmentId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}enrollment_id'],
          )!,
      traineeUserId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}trainee_user_id'],
          )!,
      courseOfferingId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}course_offering_id'],
          )!,
      status:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}status'],
          )!,
      requestDate:
          attachedDatabase.typeMapping.read(
            PgTypes.timestampWithTimezone,
            data['${effectivePrefix}request_date'],
          )!,
      decisionDate: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}decision_date'],
      ),
      managerUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}manager_user_id'],
      ),
      rejectionReason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}rejection_reason'],
      ),
      updatedAt:
          attachedDatabase.typeMapping.read(
            PgTypes.timestampWithTimezone,
            data['${effectivePrefix}updated_at'],
          )!,
      notes: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}notes'],
      ),
    );
  }

  @override
  $EnrollmentRequestsTable createAlias(String alias) {
    return $EnrollmentRequestsTable(attachedDatabase, alias);
  }
}

class EnrollmentRequest extends DataClass
    implements Insertable<EnrollmentRequest> {
  /// Primary key - unique enrollment request identifier
  final String enrollmentId;

  /// ID of the trainee/student user
  final String traineeUserId;

  /// Foreign key to CourseOffering(id) in Course Service
  final String courseOfferingId;

  /// Enrollment status enum
  final String status;

  /// Timestamp when the enrollment request was created
  final PgDateTime requestDate;

  /// Timestamp when the enrollment decision was made (nullable)
  final PgDateTime? decisionDate;

  /// ID of the manager who made the decision (nullable)
  /// Foreign key to User(id) in Identity/Auth Service
  final String? managerUserId;

  /// Reason for rejection if status is REJECTED (nullable)
  final String? rejectionReason;

  /// Timestamp when the enrollment record was last updated
  final PgDateTime updatedAt;

  /// Additional notes about the enrollment (nullable)
  final String? notes;
  const EnrollmentRequest({
    required this.enrollmentId,
    required this.traineeUserId,
    required this.courseOfferingId,
    required this.status,
    required this.requestDate,
    this.decisionDate,
    this.managerUserId,
    this.rejectionReason,
    required this.updatedAt,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['enrollment_id'] = Variable<String>(enrollmentId);
    map['trainee_user_id'] = Variable<String>(traineeUserId);
    map['course_offering_id'] = Variable<String>(courseOfferingId);
    map['status'] = Variable<String>(status);
    map['request_date'] = Variable<PgDateTime>(
      requestDate,
      PgTypes.timestampWithTimezone,
    );
    if (!nullToAbsent || decisionDate != null) {
      map['decision_date'] = Variable<PgDateTime>(
        decisionDate,
        PgTypes.timestampWithTimezone,
      );
    }
    if (!nullToAbsent || managerUserId != null) {
      map['manager_user_id'] = Variable<String>(managerUserId);
    }
    if (!nullToAbsent || rejectionReason != null) {
      map['rejection_reason'] = Variable<String>(rejectionReason);
    }
    map['updated_at'] = Variable<PgDateTime>(
      updatedAt,
      PgTypes.timestampWithTimezone,
    );
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  EnrollmentRequestsCompanion toCompanion(bool nullToAbsent) {
    return EnrollmentRequestsCompanion(
      enrollmentId: Value(enrollmentId),
      traineeUserId: Value(traineeUserId),
      courseOfferingId: Value(courseOfferingId),
      status: Value(status),
      requestDate: Value(requestDate),
      decisionDate:
          decisionDate == null && nullToAbsent
              ? const Value.absent()
              : Value(decisionDate),
      managerUserId:
          managerUserId == null && nullToAbsent
              ? const Value.absent()
              : Value(managerUserId),
      rejectionReason:
          rejectionReason == null && nullToAbsent
              ? const Value.absent()
              : Value(rejectionReason),
      updatedAt: Value(updatedAt),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory EnrollmentRequest.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EnrollmentRequest(
      enrollmentId: serializer.fromJson<String>(json['enrollmentId']),
      traineeUserId: serializer.fromJson<String>(json['traineeUserId']),
      courseOfferingId: serializer.fromJson<String>(json['courseOfferingId']),
      status: serializer.fromJson<String>(json['status']),
      requestDate: serializer.fromJson<PgDateTime>(json['requestDate']),
      decisionDate: serializer.fromJson<PgDateTime?>(json['decisionDate']),
      managerUserId: serializer.fromJson<String?>(json['managerUserId']),
      rejectionReason: serializer.fromJson<String?>(json['rejectionReason']),
      updatedAt: serializer.fromJson<PgDateTime>(json['updatedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'enrollmentId': serializer.toJson<String>(enrollmentId),
      'traineeUserId': serializer.toJson<String>(traineeUserId),
      'courseOfferingId': serializer.toJson<String>(courseOfferingId),
      'status': serializer.toJson<String>(status),
      'requestDate': serializer.toJson<PgDateTime>(requestDate),
      'decisionDate': serializer.toJson<PgDateTime?>(decisionDate),
      'managerUserId': serializer.toJson<String?>(managerUserId),
      'rejectionReason': serializer.toJson<String?>(rejectionReason),
      'updatedAt': serializer.toJson<PgDateTime>(updatedAt),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  EnrollmentRequest copyWith({
    String? enrollmentId,
    String? traineeUserId,
    String? courseOfferingId,
    String? status,
    PgDateTime? requestDate,
    Value<PgDateTime?> decisionDate = const Value.absent(),
    Value<String?> managerUserId = const Value.absent(),
    Value<String?> rejectionReason = const Value.absent(),
    PgDateTime? updatedAt,
    Value<String?> notes = const Value.absent(),
  }) => EnrollmentRequest(
    enrollmentId: enrollmentId ?? this.enrollmentId,
    traineeUserId: traineeUserId ?? this.traineeUserId,
    courseOfferingId: courseOfferingId ?? this.courseOfferingId,
    status: status ?? this.status,
    requestDate: requestDate ?? this.requestDate,
    decisionDate: decisionDate.present ? decisionDate.value : this.decisionDate,
    managerUserId:
        managerUserId.present ? managerUserId.value : this.managerUserId,
    rejectionReason:
        rejectionReason.present ? rejectionReason.value : this.rejectionReason,
    updatedAt: updatedAt ?? this.updatedAt,
    notes: notes.present ? notes.value : this.notes,
  );
  EnrollmentRequest copyWithCompanion(EnrollmentRequestsCompanion data) {
    return EnrollmentRequest(
      enrollmentId:
          data.enrollmentId.present
              ? data.enrollmentId.value
              : this.enrollmentId,
      traineeUserId:
          data.traineeUserId.present
              ? data.traineeUserId.value
              : this.traineeUserId,
      courseOfferingId:
          data.courseOfferingId.present
              ? data.courseOfferingId.value
              : this.courseOfferingId,
      status: data.status.present ? data.status.value : this.status,
      requestDate:
          data.requestDate.present ? data.requestDate.value : this.requestDate,
      decisionDate:
          data.decisionDate.present
              ? data.decisionDate.value
              : this.decisionDate,
      managerUserId:
          data.managerUserId.present
              ? data.managerUserId.value
              : this.managerUserId,
      rejectionReason:
          data.rejectionReason.present
              ? data.rejectionReason.value
              : this.rejectionReason,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EnrollmentRequest(')
          ..write('enrollmentId: $enrollmentId, ')
          ..write('traineeUserId: $traineeUserId, ')
          ..write('courseOfferingId: $courseOfferingId, ')
          ..write('status: $status, ')
          ..write('requestDate: $requestDate, ')
          ..write('decisionDate: $decisionDate, ')
          ..write('managerUserId: $managerUserId, ')
          ..write('rejectionReason: $rejectionReason, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    enrollmentId,
    traineeUserId,
    courseOfferingId,
    status,
    requestDate,
    decisionDate,
    managerUserId,
    rejectionReason,
    updatedAt,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EnrollmentRequest &&
          other.enrollmentId == this.enrollmentId &&
          other.traineeUserId == this.traineeUserId &&
          other.courseOfferingId == this.courseOfferingId &&
          other.status == this.status &&
          other.requestDate == this.requestDate &&
          other.decisionDate == this.decisionDate &&
          other.managerUserId == this.managerUserId &&
          other.rejectionReason == this.rejectionReason &&
          other.updatedAt == this.updatedAt &&
          other.notes == this.notes);
}

class EnrollmentRequestsCompanion extends UpdateCompanion<EnrollmentRequest> {
  final Value<String> enrollmentId;
  final Value<String> traineeUserId;
  final Value<String> courseOfferingId;
  final Value<String> status;
  final Value<PgDateTime> requestDate;
  final Value<PgDateTime?> decisionDate;
  final Value<String?> managerUserId;
  final Value<String?> rejectionReason;
  final Value<PgDateTime> updatedAt;
  final Value<String?> notes;
  final Value<int> rowid;
  const EnrollmentRequestsCompanion({
    this.enrollmentId = const Value.absent(),
    this.traineeUserId = const Value.absent(),
    this.courseOfferingId = const Value.absent(),
    this.status = const Value.absent(),
    this.requestDate = const Value.absent(),
    this.decisionDate = const Value.absent(),
    this.managerUserId = const Value.absent(),
    this.rejectionReason = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EnrollmentRequestsCompanion.insert({
    required String enrollmentId,
    required String traineeUserId,
    required String courseOfferingId,
    required String status,
    this.requestDate = const Value.absent(),
    this.decisionDate = const Value.absent(),
    this.managerUserId = const Value.absent(),
    this.rejectionReason = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : enrollmentId = Value(enrollmentId),
       traineeUserId = Value(traineeUserId),
       courseOfferingId = Value(courseOfferingId),
       status = Value(status);
  static Insertable<EnrollmentRequest> custom({
    Expression<String>? enrollmentId,
    Expression<String>? traineeUserId,
    Expression<String>? courseOfferingId,
    Expression<String>? status,
    Expression<PgDateTime>? requestDate,
    Expression<PgDateTime>? decisionDate,
    Expression<String>? managerUserId,
    Expression<String>? rejectionReason,
    Expression<PgDateTime>? updatedAt,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (enrollmentId != null) 'enrollment_id': enrollmentId,
      if (traineeUserId != null) 'trainee_user_id': traineeUserId,
      if (courseOfferingId != null) 'course_offering_id': courseOfferingId,
      if (status != null) 'status': status,
      if (requestDate != null) 'request_date': requestDate,
      if (decisionDate != null) 'decision_date': decisionDate,
      if (managerUserId != null) 'manager_user_id': managerUserId,
      if (rejectionReason != null) 'rejection_reason': rejectionReason,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EnrollmentRequestsCompanion copyWith({
    Value<String>? enrollmentId,
    Value<String>? traineeUserId,
    Value<String>? courseOfferingId,
    Value<String>? status,
    Value<PgDateTime>? requestDate,
    Value<PgDateTime?>? decisionDate,
    Value<String?>? managerUserId,
    Value<String?>? rejectionReason,
    Value<PgDateTime>? updatedAt,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return EnrollmentRequestsCompanion(
      enrollmentId: enrollmentId ?? this.enrollmentId,
      traineeUserId: traineeUserId ?? this.traineeUserId,
      courseOfferingId: courseOfferingId ?? this.courseOfferingId,
      status: status ?? this.status,
      requestDate: requestDate ?? this.requestDate,
      decisionDate: decisionDate ?? this.decisionDate,
      managerUserId: managerUserId ?? this.managerUserId,
      rejectionReason: rejectionReason ?? this.rejectionReason,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (enrollmentId.present) {
      map['enrollment_id'] = Variable<String>(enrollmentId.value);
    }
    if (traineeUserId.present) {
      map['trainee_user_id'] = Variable<String>(traineeUserId.value);
    }
    if (courseOfferingId.present) {
      map['course_offering_id'] = Variable<String>(courseOfferingId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (requestDate.present) {
      map['request_date'] = Variable<PgDateTime>(
        requestDate.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (decisionDate.present) {
      map['decision_date'] = Variable<PgDateTime>(
        decisionDate.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (managerUserId.present) {
      map['manager_user_id'] = Variable<String>(managerUserId.value);
    }
    if (rejectionReason.present) {
      map['rejection_reason'] = Variable<String>(rejectionReason.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<PgDateTime>(
        updatedAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (notes.present) {
      map['notes'] = Variable<String>(notes.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EnrollmentRequestsCompanion(')
          ..write('enrollmentId: $enrollmentId, ')
          ..write('traineeUserId: $traineeUserId, ')
          ..write('courseOfferingId: $courseOfferingId, ')
          ..write('status: $status, ')
          ..write('requestDate: $requestDate, ')
          ..write('decisionDate: $decisionDate, ')
          ..write('managerUserId: $managerUserId, ')
          ..write('rejectionReason: $rejectionReason, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $EnrollmentStatusHistoriesTable extends EnrollmentStatusHistories
    with TableInfo<$EnrollmentStatusHistoriesTable, EnrollmentStatusHistory> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $EnrollmentStatusHistoriesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _historyIdMeta = const VerificationMeta(
    'historyId',
  );
  @override
  late final GeneratedColumn<String> historyId = GeneratedColumn<String>(
    'history_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _enrollmentIdMeta = const VerificationMeta(
    'enrollmentId',
  );
  @override
  late final GeneratedColumn<String> enrollmentId = GeneratedColumn<String>(
    'enrollment_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _oldStatusMeta = const VerificationMeta(
    'oldStatus',
  );
  @override
  late final GeneratedColumn<String> oldStatus = GeneratedColumn<String>(
    'old_status',
    aliasedName,
    false,
    check:
        () => oldStatus.isIn([
          'PENDING_APPROVAL',
          'APPROVED',
          'REJECTED',
          'CANCELLED_BY_TRAINEE',
          'CANCELLED_BY_SYSTEM',
          'COMPLETED',
        ]),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _newStatusMeta = const VerificationMeta(
    'newStatus',
  );
  @override
  late final GeneratedColumn<String> newStatus = GeneratedColumn<String>(
    'new_status',
    aliasedName,
    false,
    check:
        () => newStatus.isIn([
          'PENDING_APPROVAL',
          'APPROVED',
          'REJECTED',
          'CANCELLED_BY_TRAINEE',
          'CANCELLED_BY_SYSTEM',
          'COMPLETED',
        ]),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _changedAtMeta = const VerificationMeta(
    'changedAt',
  );
  @override
  late final GeneratedColumn<PgDateTime> changedAt =
      GeneratedColumn<PgDateTime>(
        'changed_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        defaultValue: now(),
      );
  static const VerificationMeta _changedByUserIdMeta = const VerificationMeta(
    'changedByUserId',
  );
  @override
  late final GeneratedColumn<String> changedByUserId = GeneratedColumn<String>(
    'changed_by_user_id',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _reasonMeta = const VerificationMeta('reason');
  @override
  late final GeneratedColumn<String> reason = GeneratedColumn<String>(
    'reason',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    historyId,
    enrollmentId,
    oldStatus,
    newStatus,
    changedAt,
    changedByUserId,
    reason,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'enrollment_status_histories';
  @override
  VerificationContext validateIntegrity(
    Insertable<EnrollmentStatusHistory> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('history_id')) {
      context.handle(
        _historyIdMeta,
        historyId.isAcceptableOrUnknown(data['history_id']!, _historyIdMeta),
      );
    } else if (isInserting) {
      context.missing(_historyIdMeta);
    }
    if (data.containsKey('enrollment_id')) {
      context.handle(
        _enrollmentIdMeta,
        enrollmentId.isAcceptableOrUnknown(
          data['enrollment_id']!,
          _enrollmentIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_enrollmentIdMeta);
    }
    if (data.containsKey('old_status')) {
      context.handle(
        _oldStatusMeta,
        oldStatus.isAcceptableOrUnknown(data['old_status']!, _oldStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_oldStatusMeta);
    }
    if (data.containsKey('new_status')) {
      context.handle(
        _newStatusMeta,
        newStatus.isAcceptableOrUnknown(data['new_status']!, _newStatusMeta),
      );
    } else if (isInserting) {
      context.missing(_newStatusMeta);
    }
    if (data.containsKey('changed_at')) {
      context.handle(
        _changedAtMeta,
        changedAt.isAcceptableOrUnknown(data['changed_at']!, _changedAtMeta),
      );
    }
    if (data.containsKey('changed_by_user_id')) {
      context.handle(
        _changedByUserIdMeta,
        changedByUserId.isAcceptableOrUnknown(
          data['changed_by_user_id']!,
          _changedByUserIdMeta,
        ),
      );
    }
    if (data.containsKey('reason')) {
      context.handle(
        _reasonMeta,
        reason.isAcceptableOrUnknown(data['reason']!, _reasonMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {historyId};
  @override
  EnrollmentStatusHistory map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return EnrollmentStatusHistory(
      historyId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}history_id'],
          )!,
      enrollmentId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}enrollment_id'],
          )!,
      oldStatus:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}old_status'],
          )!,
      newStatus:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}new_status'],
          )!,
      changedAt:
          attachedDatabase.typeMapping.read(
            PgTypes.timestampWithTimezone,
            data['${effectivePrefix}changed_at'],
          )!,
      changedByUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}changed_by_user_id'],
      ),
      reason: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}reason'],
      ),
    );
  }

  @override
  $EnrollmentStatusHistoriesTable createAlias(String alias) {
    return $EnrollmentStatusHistoriesTable(attachedDatabase, alias);
  }
}

class EnrollmentStatusHistory extends DataClass
    implements Insertable<EnrollmentStatusHistory> {
  /// Primary key - unique history record identifier
  final String historyId;

  /// Foreign key to EnrollmentRequest.enrollmentId
  final String enrollmentId;

  /// Previous status before the change
  final String oldStatus;

  /// New status after the change
  final String newStatus;

  /// Timestamp when the status change occurred
  final PgDateTime changedAt;

  /// ID of the user who made the change (nullable)
  /// Can be the trainee, manager, or system
  /// Foreign key to User(id) in Identity/Auth Service
  final String? changedByUserId;

  /// Reason for the status change (nullable)
  /// Examples: 'Aprovado pelo gestor', 'Cancelado pelo formando', 'Pré-requisitos não atendidos'
  final String? reason;
  const EnrollmentStatusHistory({
    required this.historyId,
    required this.enrollmentId,
    required this.oldStatus,
    required this.newStatus,
    required this.changedAt,
    this.changedByUserId,
    this.reason,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['history_id'] = Variable<String>(historyId);
    map['enrollment_id'] = Variable<String>(enrollmentId);
    map['old_status'] = Variable<String>(oldStatus);
    map['new_status'] = Variable<String>(newStatus);
    map['changed_at'] = Variable<PgDateTime>(
      changedAt,
      PgTypes.timestampWithTimezone,
    );
    if (!nullToAbsent || changedByUserId != null) {
      map['changed_by_user_id'] = Variable<String>(changedByUserId);
    }
    if (!nullToAbsent || reason != null) {
      map['reason'] = Variable<String>(reason);
    }
    return map;
  }

  EnrollmentStatusHistoriesCompanion toCompanion(bool nullToAbsent) {
    return EnrollmentStatusHistoriesCompanion(
      historyId: Value(historyId),
      enrollmentId: Value(enrollmentId),
      oldStatus: Value(oldStatus),
      newStatus: Value(newStatus),
      changedAt: Value(changedAt),
      changedByUserId:
          changedByUserId == null && nullToAbsent
              ? const Value.absent()
              : Value(changedByUserId),
      reason:
          reason == null && nullToAbsent ? const Value.absent() : Value(reason),
    );
  }

  factory EnrollmentStatusHistory.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return EnrollmentStatusHistory(
      historyId: serializer.fromJson<String>(json['historyId']),
      enrollmentId: serializer.fromJson<String>(json['enrollmentId']),
      oldStatus: serializer.fromJson<String>(json['oldStatus']),
      newStatus: serializer.fromJson<String>(json['newStatus']),
      changedAt: serializer.fromJson<PgDateTime>(json['changedAt']),
      changedByUserId: serializer.fromJson<String?>(json['changedByUserId']),
      reason: serializer.fromJson<String?>(json['reason']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'historyId': serializer.toJson<String>(historyId),
      'enrollmentId': serializer.toJson<String>(enrollmentId),
      'oldStatus': serializer.toJson<String>(oldStatus),
      'newStatus': serializer.toJson<String>(newStatus),
      'changedAt': serializer.toJson<PgDateTime>(changedAt),
      'changedByUserId': serializer.toJson<String?>(changedByUserId),
      'reason': serializer.toJson<String?>(reason),
    };
  }

  EnrollmentStatusHistory copyWith({
    String? historyId,
    String? enrollmentId,
    String? oldStatus,
    String? newStatus,
    PgDateTime? changedAt,
    Value<String?> changedByUserId = const Value.absent(),
    Value<String?> reason = const Value.absent(),
  }) => EnrollmentStatusHistory(
    historyId: historyId ?? this.historyId,
    enrollmentId: enrollmentId ?? this.enrollmentId,
    oldStatus: oldStatus ?? this.oldStatus,
    newStatus: newStatus ?? this.newStatus,
    changedAt: changedAt ?? this.changedAt,
    changedByUserId:
        changedByUserId.present ? changedByUserId.value : this.changedByUserId,
    reason: reason.present ? reason.value : this.reason,
  );
  EnrollmentStatusHistory copyWithCompanion(
    EnrollmentStatusHistoriesCompanion data,
  ) {
    return EnrollmentStatusHistory(
      historyId: data.historyId.present ? data.historyId.value : this.historyId,
      enrollmentId:
          data.enrollmentId.present
              ? data.enrollmentId.value
              : this.enrollmentId,
      oldStatus: data.oldStatus.present ? data.oldStatus.value : this.oldStatus,
      newStatus: data.newStatus.present ? data.newStatus.value : this.newStatus,
      changedAt: data.changedAt.present ? data.changedAt.value : this.changedAt,
      changedByUserId:
          data.changedByUserId.present
              ? data.changedByUserId.value
              : this.changedByUserId,
      reason: data.reason.present ? data.reason.value : this.reason,
    );
  }

  @override
  String toString() {
    return (StringBuffer('EnrollmentStatusHistory(')
          ..write('historyId: $historyId, ')
          ..write('enrollmentId: $enrollmentId, ')
          ..write('oldStatus: $oldStatus, ')
          ..write('newStatus: $newStatus, ')
          ..write('changedAt: $changedAt, ')
          ..write('changedByUserId: $changedByUserId, ')
          ..write('reason: $reason')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    historyId,
    enrollmentId,
    oldStatus,
    newStatus,
    changedAt,
    changedByUserId,
    reason,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is EnrollmentStatusHistory &&
          other.historyId == this.historyId &&
          other.enrollmentId == this.enrollmentId &&
          other.oldStatus == this.oldStatus &&
          other.newStatus == this.newStatus &&
          other.changedAt == this.changedAt &&
          other.changedByUserId == this.changedByUserId &&
          other.reason == this.reason);
}

class EnrollmentStatusHistoriesCompanion
    extends UpdateCompanion<EnrollmentStatusHistory> {
  final Value<String> historyId;
  final Value<String> enrollmentId;
  final Value<String> oldStatus;
  final Value<String> newStatus;
  final Value<PgDateTime> changedAt;
  final Value<String?> changedByUserId;
  final Value<String?> reason;
  final Value<int> rowid;
  const EnrollmentStatusHistoriesCompanion({
    this.historyId = const Value.absent(),
    this.enrollmentId = const Value.absent(),
    this.oldStatus = const Value.absent(),
    this.newStatus = const Value.absent(),
    this.changedAt = const Value.absent(),
    this.changedByUserId = const Value.absent(),
    this.reason = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  EnrollmentStatusHistoriesCompanion.insert({
    required String historyId,
    required String enrollmentId,
    required String oldStatus,
    required String newStatus,
    this.changedAt = const Value.absent(),
    this.changedByUserId = const Value.absent(),
    this.reason = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : historyId = Value(historyId),
       enrollmentId = Value(enrollmentId),
       oldStatus = Value(oldStatus),
       newStatus = Value(newStatus);
  static Insertable<EnrollmentStatusHistory> custom({
    Expression<String>? historyId,
    Expression<String>? enrollmentId,
    Expression<String>? oldStatus,
    Expression<String>? newStatus,
    Expression<PgDateTime>? changedAt,
    Expression<String>? changedByUserId,
    Expression<String>? reason,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (historyId != null) 'history_id': historyId,
      if (enrollmentId != null) 'enrollment_id': enrollmentId,
      if (oldStatus != null) 'old_status': oldStatus,
      if (newStatus != null) 'new_status': newStatus,
      if (changedAt != null) 'changed_at': changedAt,
      if (changedByUserId != null) 'changed_by_user_id': changedByUserId,
      if (reason != null) 'reason': reason,
      if (rowid != null) 'rowid': rowid,
    });
  }

  EnrollmentStatusHistoriesCompanion copyWith({
    Value<String>? historyId,
    Value<String>? enrollmentId,
    Value<String>? oldStatus,
    Value<String>? newStatus,
    Value<PgDateTime>? changedAt,
    Value<String?>? changedByUserId,
    Value<String?>? reason,
    Value<int>? rowid,
  }) {
    return EnrollmentStatusHistoriesCompanion(
      historyId: historyId ?? this.historyId,
      enrollmentId: enrollmentId ?? this.enrollmentId,
      oldStatus: oldStatus ?? this.oldStatus,
      newStatus: newStatus ?? this.newStatus,
      changedAt: changedAt ?? this.changedAt,
      changedByUserId: changedByUserId ?? this.changedByUserId,
      reason: reason ?? this.reason,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (historyId.present) {
      map['history_id'] = Variable<String>(historyId.value);
    }
    if (enrollmentId.present) {
      map['enrollment_id'] = Variable<String>(enrollmentId.value);
    }
    if (oldStatus.present) {
      map['old_status'] = Variable<String>(oldStatus.value);
    }
    if (newStatus.present) {
      map['new_status'] = Variable<String>(newStatus.value);
    }
    if (changedAt.present) {
      map['changed_at'] = Variable<PgDateTime>(
        changedAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (changedByUserId.present) {
      map['changed_by_user_id'] = Variable<String>(changedByUserId.value);
    }
    if (reason.present) {
      map['reason'] = Variable<String>(reason.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('EnrollmentStatusHistoriesCompanion(')
          ..write('historyId: $historyId, ')
          ..write('enrollmentId: $enrollmentId, ')
          ..write('oldStatus: $oldStatus, ')
          ..write('newStatus: $newStatus, ')
          ..write('changedAt: $changedAt, ')
          ..write('changedByUserId: $changedByUserId, ')
          ..write('reason: $reason, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$EnrollmentDatabase extends GeneratedDatabase {
  _$EnrollmentDatabase(QueryExecutor e) : super(e);
  $EnrollmentDatabaseManager get managers => $EnrollmentDatabaseManager(this);
  late final $EnrollmentRequestsTable enrollmentRequests =
      $EnrollmentRequestsTable(this);
  late final $EnrollmentStatusHistoriesTable enrollmentStatusHistories =
      $EnrollmentStatusHistoriesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    enrollmentRequests,
    enrollmentStatusHistories,
  ];
}

typedef $$EnrollmentRequestsTableCreateCompanionBuilder =
    EnrollmentRequestsCompanion Function({
      required String enrollmentId,
      required String traineeUserId,
      required String courseOfferingId,
      required String status,
      Value<PgDateTime> requestDate,
      Value<PgDateTime?> decisionDate,
      Value<String?> managerUserId,
      Value<String?> rejectionReason,
      Value<PgDateTime> updatedAt,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$EnrollmentRequestsTableUpdateCompanionBuilder =
    EnrollmentRequestsCompanion Function({
      Value<String> enrollmentId,
      Value<String> traineeUserId,
      Value<String> courseOfferingId,
      Value<String> status,
      Value<PgDateTime> requestDate,
      Value<PgDateTime?> decisionDate,
      Value<String?> managerUserId,
      Value<String?> rejectionReason,
      Value<PgDateTime> updatedAt,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$EnrollmentRequestsTableFilterComposer
    extends Composer<_$EnrollmentDatabase, $EnrollmentRequestsTable> {
  $$EnrollmentRequestsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get enrollmentId => $composableBuilder(
    column: $table.enrollmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get traineeUserId => $composableBuilder(
    column: $table.traineeUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseOfferingId => $composableBuilder(
    column: $table.courseOfferingId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get requestDate => $composableBuilder(
    column: $table.requestDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get decisionDate => $composableBuilder(
    column: $table.decisionDate,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get managerUserId => $composableBuilder(
    column: $table.managerUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EnrollmentRequestsTableOrderingComposer
    extends Composer<_$EnrollmentDatabase, $EnrollmentRequestsTable> {
  $$EnrollmentRequestsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get enrollmentId => $composableBuilder(
    column: $table.enrollmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get traineeUserId => $composableBuilder(
    column: $table.traineeUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseOfferingId => $composableBuilder(
    column: $table.courseOfferingId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get requestDate => $composableBuilder(
    column: $table.requestDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get decisionDate => $composableBuilder(
    column: $table.decisionDate,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get managerUserId => $composableBuilder(
    column: $table.managerUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get notes => $composableBuilder(
    column: $table.notes,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EnrollmentRequestsTableAnnotationComposer
    extends Composer<_$EnrollmentDatabase, $EnrollmentRequestsTable> {
  $$EnrollmentRequestsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get enrollmentId => $composableBuilder(
    column: $table.enrollmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get traineeUserId => $composableBuilder(
    column: $table.traineeUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseOfferingId => $composableBuilder(
    column: $table.courseOfferingId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<PgDateTime> get requestDate => $composableBuilder(
    column: $table.requestDate,
    builder: (column) => column,
  );

  GeneratedColumn<PgDateTime> get decisionDate => $composableBuilder(
    column: $table.decisionDate,
    builder: (column) => column,
  );

  GeneratedColumn<String> get managerUserId => $composableBuilder(
    column: $table.managerUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get rejectionReason => $composableBuilder(
    column: $table.rejectionReason,
    builder: (column) => column,
  );

  GeneratedColumn<PgDateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$EnrollmentRequestsTableTableManager
    extends
        RootTableManager<
          _$EnrollmentDatabase,
          $EnrollmentRequestsTable,
          EnrollmentRequest,
          $$EnrollmentRequestsTableFilterComposer,
          $$EnrollmentRequestsTableOrderingComposer,
          $$EnrollmentRequestsTableAnnotationComposer,
          $$EnrollmentRequestsTableCreateCompanionBuilder,
          $$EnrollmentRequestsTableUpdateCompanionBuilder,
          (
            EnrollmentRequest,
            BaseReferences<
              _$EnrollmentDatabase,
              $EnrollmentRequestsTable,
              EnrollmentRequest
            >,
          ),
          EnrollmentRequest,
          PrefetchHooks Function()
        > {
  $$EnrollmentRequestsTableTableManager(
    _$EnrollmentDatabase db,
    $EnrollmentRequestsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$EnrollmentRequestsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$EnrollmentRequestsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$EnrollmentRequestsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> enrollmentId = const Value.absent(),
                Value<String> traineeUserId = const Value.absent(),
                Value<String> courseOfferingId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<PgDateTime> requestDate = const Value.absent(),
                Value<PgDateTime?> decisionDate = const Value.absent(),
                Value<String?> managerUserId = const Value.absent(),
                Value<String?> rejectionReason = const Value.absent(),
                Value<PgDateTime> updatedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EnrollmentRequestsCompanion(
                enrollmentId: enrollmentId,
                traineeUserId: traineeUserId,
                courseOfferingId: courseOfferingId,
                status: status,
                requestDate: requestDate,
                decisionDate: decisionDate,
                managerUserId: managerUserId,
                rejectionReason: rejectionReason,
                updatedAt: updatedAt,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String enrollmentId,
                required String traineeUserId,
                required String courseOfferingId,
                required String status,
                Value<PgDateTime> requestDate = const Value.absent(),
                Value<PgDateTime?> decisionDate = const Value.absent(),
                Value<String?> managerUserId = const Value.absent(),
                Value<String?> rejectionReason = const Value.absent(),
                Value<PgDateTime> updatedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EnrollmentRequestsCompanion.insert(
                enrollmentId: enrollmentId,
                traineeUserId: traineeUserId,
                courseOfferingId: courseOfferingId,
                status: status,
                requestDate: requestDate,
                decisionDate: decisionDate,
                managerUserId: managerUserId,
                rejectionReason: rejectionReason,
                updatedAt: updatedAt,
                notes: notes,
                rowid: rowid,
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

typedef $$EnrollmentRequestsTableProcessedTableManager =
    ProcessedTableManager<
      _$EnrollmentDatabase,
      $EnrollmentRequestsTable,
      EnrollmentRequest,
      $$EnrollmentRequestsTableFilterComposer,
      $$EnrollmentRequestsTableOrderingComposer,
      $$EnrollmentRequestsTableAnnotationComposer,
      $$EnrollmentRequestsTableCreateCompanionBuilder,
      $$EnrollmentRequestsTableUpdateCompanionBuilder,
      (
        EnrollmentRequest,
        BaseReferences<
          _$EnrollmentDatabase,
          $EnrollmentRequestsTable,
          EnrollmentRequest
        >,
      ),
      EnrollmentRequest,
      PrefetchHooks Function()
    >;
typedef $$EnrollmentStatusHistoriesTableCreateCompanionBuilder =
    EnrollmentStatusHistoriesCompanion Function({
      required String historyId,
      required String enrollmentId,
      required String oldStatus,
      required String newStatus,
      Value<PgDateTime> changedAt,
      Value<String?> changedByUserId,
      Value<String?> reason,
      Value<int> rowid,
    });
typedef $$EnrollmentStatusHistoriesTableUpdateCompanionBuilder =
    EnrollmentStatusHistoriesCompanion Function({
      Value<String> historyId,
      Value<String> enrollmentId,
      Value<String> oldStatus,
      Value<String> newStatus,
      Value<PgDateTime> changedAt,
      Value<String?> changedByUserId,
      Value<String?> reason,
      Value<int> rowid,
    });

class $$EnrollmentStatusHistoriesTableFilterComposer
    extends Composer<_$EnrollmentDatabase, $EnrollmentStatusHistoriesTable> {
  $$EnrollmentStatusHistoriesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get historyId => $composableBuilder(
    column: $table.historyId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get enrollmentId => $composableBuilder(
    column: $table.enrollmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get oldStatus => $composableBuilder(
    column: $table.oldStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get newStatus => $composableBuilder(
    column: $table.newStatus,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get changedByUserId => $composableBuilder(
    column: $table.changedByUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnFilters(column),
  );
}

class $$EnrollmentStatusHistoriesTableOrderingComposer
    extends Composer<_$EnrollmentDatabase, $EnrollmentStatusHistoriesTable> {
  $$EnrollmentStatusHistoriesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get historyId => $composableBuilder(
    column: $table.historyId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get enrollmentId => $composableBuilder(
    column: $table.enrollmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get oldStatus => $composableBuilder(
    column: $table.oldStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get newStatus => $composableBuilder(
    column: $table.newStatus,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get changedAt => $composableBuilder(
    column: $table.changedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get changedByUserId => $composableBuilder(
    column: $table.changedByUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reason => $composableBuilder(
    column: $table.reason,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$EnrollmentStatusHistoriesTableAnnotationComposer
    extends Composer<_$EnrollmentDatabase, $EnrollmentStatusHistoriesTable> {
  $$EnrollmentStatusHistoriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get historyId =>
      $composableBuilder(column: $table.historyId, builder: (column) => column);

  GeneratedColumn<String> get enrollmentId => $composableBuilder(
    column: $table.enrollmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get oldStatus =>
      $composableBuilder(column: $table.oldStatus, builder: (column) => column);

  GeneratedColumn<String> get newStatus =>
      $composableBuilder(column: $table.newStatus, builder: (column) => column);

  GeneratedColumn<PgDateTime> get changedAt =>
      $composableBuilder(column: $table.changedAt, builder: (column) => column);

  GeneratedColumn<String> get changedByUserId => $composableBuilder(
    column: $table.changedByUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get reason =>
      $composableBuilder(column: $table.reason, builder: (column) => column);
}

class $$EnrollmentStatusHistoriesTableTableManager
    extends
        RootTableManager<
          _$EnrollmentDatabase,
          $EnrollmentStatusHistoriesTable,
          EnrollmentStatusHistory,
          $$EnrollmentStatusHistoriesTableFilterComposer,
          $$EnrollmentStatusHistoriesTableOrderingComposer,
          $$EnrollmentStatusHistoriesTableAnnotationComposer,
          $$EnrollmentStatusHistoriesTableCreateCompanionBuilder,
          $$EnrollmentStatusHistoriesTableUpdateCompanionBuilder,
          (
            EnrollmentStatusHistory,
            BaseReferences<
              _$EnrollmentDatabase,
              $EnrollmentStatusHistoriesTable,
              EnrollmentStatusHistory
            >,
          ),
          EnrollmentStatusHistory,
          PrefetchHooks Function()
        > {
  $$EnrollmentStatusHistoriesTableTableManager(
    _$EnrollmentDatabase db,
    $EnrollmentStatusHistoriesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$EnrollmentStatusHistoriesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$EnrollmentStatusHistoriesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$EnrollmentStatusHistoriesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> historyId = const Value.absent(),
                Value<String> enrollmentId = const Value.absent(),
                Value<String> oldStatus = const Value.absent(),
                Value<String> newStatus = const Value.absent(),
                Value<PgDateTime> changedAt = const Value.absent(),
                Value<String?> changedByUserId = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EnrollmentStatusHistoriesCompanion(
                historyId: historyId,
                enrollmentId: enrollmentId,
                oldStatus: oldStatus,
                newStatus: newStatus,
                changedAt: changedAt,
                changedByUserId: changedByUserId,
                reason: reason,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String historyId,
                required String enrollmentId,
                required String oldStatus,
                required String newStatus,
                Value<PgDateTime> changedAt = const Value.absent(),
                Value<String?> changedByUserId = const Value.absent(),
                Value<String?> reason = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => EnrollmentStatusHistoriesCompanion.insert(
                historyId: historyId,
                enrollmentId: enrollmentId,
                oldStatus: oldStatus,
                newStatus: newStatus,
                changedAt: changedAt,
                changedByUserId: changedByUserId,
                reason: reason,
                rowid: rowid,
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

typedef $$EnrollmentStatusHistoriesTableProcessedTableManager =
    ProcessedTableManager<
      _$EnrollmentDatabase,
      $EnrollmentStatusHistoriesTable,
      EnrollmentStatusHistory,
      $$EnrollmentStatusHistoriesTableFilterComposer,
      $$EnrollmentStatusHistoriesTableOrderingComposer,
      $$EnrollmentStatusHistoriesTableAnnotationComposer,
      $$EnrollmentStatusHistoriesTableCreateCompanionBuilder,
      $$EnrollmentStatusHistoriesTableUpdateCompanionBuilder,
      (
        EnrollmentStatusHistory,
        BaseReferences<
          _$EnrollmentDatabase,
          $EnrollmentStatusHistoriesTable,
          EnrollmentStatusHistory
        >,
      ),
      EnrollmentStatusHistory,
      PrefetchHooks Function()
    >;

class $EnrollmentDatabaseManager {
  final _$EnrollmentDatabase _db;
  $EnrollmentDatabaseManager(this._db);
  $$EnrollmentRequestsTableTableManager get enrollmentRequests =>
      $$EnrollmentRequestsTableTableManager(_db, _db.enrollmentRequests);
  $$EnrollmentStatusHistoriesTableTableManager get enrollmentStatusHistories =>
      $$EnrollmentStatusHistoriesTableTableManager(
        _db,
        _db.enrollmentStatusHistories,
      );
}
