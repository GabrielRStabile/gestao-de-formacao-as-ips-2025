// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $CertificateTemplatesTable extends CertificateTemplates
    with TableInfo<$CertificateTemplatesTable, CertificateTemplate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CertificateTemplatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _templateIdMeta = const VerificationMeta(
    'templateId',
  );
  @override
  late final GeneratedColumn<String> templateId = GeneratedColumn<String>(
    'template_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _courseIdMeta = const VerificationMeta(
    'courseId',
  );
  @override
  late final GeneratedColumn<String> courseId = GeneratedColumn<String>(
    'course_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateNameMeta = const VerificationMeta(
    'templateName',
  );
  @override
  late final GeneratedColumn<String> templateName = GeneratedColumn<String>(
    'template_name',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 255,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _templateBlobUrlMeta = const VerificationMeta(
    'templateBlobUrl',
  );
  @override
  late final GeneratedColumn<String> templateBlobUrl = GeneratedColumn<String>(
    'template_blob_url',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 1000,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _uploadedByUserIdMeta = const VerificationMeta(
    'uploadedByUserId',
  );
  @override
  late final GeneratedColumn<String> uploadedByUserId = GeneratedColumn<String>(
    'uploaded_by_user_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
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
  @override
  List<GeneratedColumn> get $columns => [
    templateId,
    courseId,
    templateName,
    templateBlobUrl,
    uploadedByUserId,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'certificate_templates';
  @override
  VerificationContext validateIntegrity(
    Insertable<CertificateTemplate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('template_id')) {
      context.handle(
        _templateIdMeta,
        templateId.isAcceptableOrUnknown(data['template_id']!, _templateIdMeta),
      );
    } else if (isInserting) {
      context.missing(_templateIdMeta);
    }
    if (data.containsKey('course_id')) {
      context.handle(
        _courseIdMeta,
        courseId.isAcceptableOrUnknown(data['course_id']!, _courseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_courseIdMeta);
    }
    if (data.containsKey('template_name')) {
      context.handle(
        _templateNameMeta,
        templateName.isAcceptableOrUnknown(
          data['template_name']!,
          _templateNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_templateNameMeta);
    }
    if (data.containsKey('template_blob_url')) {
      context.handle(
        _templateBlobUrlMeta,
        templateBlobUrl.isAcceptableOrUnknown(
          data['template_blob_url']!,
          _templateBlobUrlMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_templateBlobUrlMeta);
    }
    if (data.containsKey('uploaded_by_user_id')) {
      context.handle(
        _uploadedByUserIdMeta,
        uploadedByUserId.isAcceptableOrUnknown(
          data['uploaded_by_user_id']!,
          _uploadedByUserIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_uploadedByUserIdMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {templateId};
  @override
  CertificateTemplate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CertificateTemplate(
      templateId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}template_id'],
          )!,
      courseId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}course_id'],
          )!,
      templateName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}template_name'],
          )!,
      templateBlobUrl:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}template_blob_url'],
          )!,
      uploadedByUserId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}uploaded_by_user_id'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            PgTypes.timestampWithTimezone,
            data['${effectivePrefix}created_at'],
          )!,
      updatedAt:
          attachedDatabase.typeMapping.read(
            PgTypes.timestampWithTimezone,
            data['${effectivePrefix}updated_at'],
          )!,
    );
  }

  @override
  $CertificateTemplatesTable createAlias(String alias) {
    return $CertificateTemplatesTable(attachedDatabase, alias);
  }
}

class CertificateTemplate extends DataClass
    implements Insertable<CertificateTemplate> {
  /// Primary key - unique template identifier
  final String templateId;

  /// Course identifier that this template belongs to
  final String courseId;

  /// Name of the template
  final String templateName;

  /// URL/Key for PDF template stored in Azure Blob Storage
  final String templateBlobUrl;

  /// ID of the user who uploaded this template
  final String uploadedByUserId;

  /// Timestamp when the template was created
  final PgDateTime createdAt;

  /// Timestamp when the template was last updated
  final PgDateTime updatedAt;
  const CertificateTemplate({
    required this.templateId,
    required this.courseId,
    required this.templateName,
    required this.templateBlobUrl,
    required this.uploadedByUserId,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['template_id'] = Variable<String>(templateId);
    map['course_id'] = Variable<String>(courseId);
    map['template_name'] = Variable<String>(templateName);
    map['template_blob_url'] = Variable<String>(templateBlobUrl);
    map['uploaded_by_user_id'] = Variable<String>(uploadedByUserId);
    map['created_at'] = Variable<PgDateTime>(
      createdAt,
      PgTypes.timestampWithTimezone,
    );
    map['updated_at'] = Variable<PgDateTime>(
      updatedAt,
      PgTypes.timestampWithTimezone,
    );
    return map;
  }

  CertificateTemplatesCompanion toCompanion(bool nullToAbsent) {
    return CertificateTemplatesCompanion(
      templateId: Value(templateId),
      courseId: Value(courseId),
      templateName: Value(templateName),
      templateBlobUrl: Value(templateBlobUrl),
      uploadedByUserId: Value(uploadedByUserId),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CertificateTemplate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CertificateTemplate(
      templateId: serializer.fromJson<String>(json['templateId']),
      courseId: serializer.fromJson<String>(json['courseId']),
      templateName: serializer.fromJson<String>(json['templateName']),
      templateBlobUrl: serializer.fromJson<String>(json['templateBlobUrl']),
      uploadedByUserId: serializer.fromJson<String>(json['uploadedByUserId']),
      createdAt: serializer.fromJson<PgDateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<PgDateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'templateId': serializer.toJson<String>(templateId),
      'courseId': serializer.toJson<String>(courseId),
      'templateName': serializer.toJson<String>(templateName),
      'templateBlobUrl': serializer.toJson<String>(templateBlobUrl),
      'uploadedByUserId': serializer.toJson<String>(uploadedByUserId),
      'createdAt': serializer.toJson<PgDateTime>(createdAt),
      'updatedAt': serializer.toJson<PgDateTime>(updatedAt),
    };
  }

  CertificateTemplate copyWith({
    String? templateId,
    String? courseId,
    String? templateName,
    String? templateBlobUrl,
    String? uploadedByUserId,
    PgDateTime? createdAt,
    PgDateTime? updatedAt,
  }) => CertificateTemplate(
    templateId: templateId ?? this.templateId,
    courseId: courseId ?? this.courseId,
    templateName: templateName ?? this.templateName,
    templateBlobUrl: templateBlobUrl ?? this.templateBlobUrl,
    uploadedByUserId: uploadedByUserId ?? this.uploadedByUserId,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CertificateTemplate copyWithCompanion(CertificateTemplatesCompanion data) {
    return CertificateTemplate(
      templateId:
          data.templateId.present ? data.templateId.value : this.templateId,
      courseId: data.courseId.present ? data.courseId.value : this.courseId,
      templateName:
          data.templateName.present
              ? data.templateName.value
              : this.templateName,
      templateBlobUrl:
          data.templateBlobUrl.present
              ? data.templateBlobUrl.value
              : this.templateBlobUrl,
      uploadedByUserId:
          data.uploadedByUserId.present
              ? data.uploadedByUserId.value
              : this.uploadedByUserId,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CertificateTemplate(')
          ..write('templateId: $templateId, ')
          ..write('courseId: $courseId, ')
          ..write('templateName: $templateName, ')
          ..write('templateBlobUrl: $templateBlobUrl, ')
          ..write('uploadedByUserId: $uploadedByUserId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    templateId,
    courseId,
    templateName,
    templateBlobUrl,
    uploadedByUserId,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CertificateTemplate &&
          other.templateId == this.templateId &&
          other.courseId == this.courseId &&
          other.templateName == this.templateName &&
          other.templateBlobUrl == this.templateBlobUrl &&
          other.uploadedByUserId == this.uploadedByUserId &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CertificateTemplatesCompanion
    extends UpdateCompanion<CertificateTemplate> {
  final Value<String> templateId;
  final Value<String> courseId;
  final Value<String> templateName;
  final Value<String> templateBlobUrl;
  final Value<String> uploadedByUserId;
  final Value<PgDateTime> createdAt;
  final Value<PgDateTime> updatedAt;
  final Value<int> rowid;
  const CertificateTemplatesCompanion({
    this.templateId = const Value.absent(),
    this.courseId = const Value.absent(),
    this.templateName = const Value.absent(),
    this.templateBlobUrl = const Value.absent(),
    this.uploadedByUserId = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CertificateTemplatesCompanion.insert({
    required String templateId,
    required String courseId,
    required String templateName,
    required String templateBlobUrl,
    required String uploadedByUserId,
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : templateId = Value(templateId),
       courseId = Value(courseId),
       templateName = Value(templateName),
       templateBlobUrl = Value(templateBlobUrl),
       uploadedByUserId = Value(uploadedByUserId);
  static Insertable<CertificateTemplate> custom({
    Expression<String>? templateId,
    Expression<String>? courseId,
    Expression<String>? templateName,
    Expression<String>? templateBlobUrl,
    Expression<String>? uploadedByUserId,
    Expression<PgDateTime>? createdAt,
    Expression<PgDateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (templateId != null) 'template_id': templateId,
      if (courseId != null) 'course_id': courseId,
      if (templateName != null) 'template_name': templateName,
      if (templateBlobUrl != null) 'template_blob_url': templateBlobUrl,
      if (uploadedByUserId != null) 'uploaded_by_user_id': uploadedByUserId,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CertificateTemplatesCompanion copyWith({
    Value<String>? templateId,
    Value<String>? courseId,
    Value<String>? templateName,
    Value<String>? templateBlobUrl,
    Value<String>? uploadedByUserId,
    Value<PgDateTime>? createdAt,
    Value<PgDateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return CertificateTemplatesCompanion(
      templateId: templateId ?? this.templateId,
      courseId: courseId ?? this.courseId,
      templateName: templateName ?? this.templateName,
      templateBlobUrl: templateBlobUrl ?? this.templateBlobUrl,
      uploadedByUserId: uploadedByUserId ?? this.uploadedByUserId,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (templateId.present) {
      map['template_id'] = Variable<String>(templateId.value);
    }
    if (courseId.present) {
      map['course_id'] = Variable<String>(courseId.value);
    }
    if (templateName.present) {
      map['template_name'] = Variable<String>(templateName.value);
    }
    if (templateBlobUrl.present) {
      map['template_blob_url'] = Variable<String>(templateBlobUrl.value);
    }
    if (uploadedByUserId.present) {
      map['uploaded_by_user_id'] = Variable<String>(uploadedByUserId.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<PgDateTime>(
        createdAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<PgDateTime>(
        updatedAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CertificateTemplatesCompanion(')
          ..write('templateId: $templateId, ')
          ..write('courseId: $courseId, ')
          ..write('templateName: $templateName, ')
          ..write('templateBlobUrl: $templateBlobUrl, ')
          ..write('uploadedByUserId: $uploadedByUserId, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $IssuedCertificatesTable extends IssuedCertificates
    with TableInfo<$IssuedCertificatesTable, IssuedCertificate> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $IssuedCertificatesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _certificateIdMeta = const VerificationMeta(
    'certificateId',
  );
  @override
  late final GeneratedColumn<String> certificateId = GeneratedColumn<String>(
    'certificate_id',
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
  static const VerificationMeta _courseIdMeta = const VerificationMeta(
    'courseId',
  );
  @override
  late final GeneratedColumn<String> courseId = GeneratedColumn<String>(
    'course_id',
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
          'PENDING_TEMPLATE',
          'APPROVED_FOR_EMISSION',
          'GENERATING',
          'ISSUED',
          'GENERATION_FAILED',
          'REVOKED',
        ]),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emissionApprovedAtMeta =
      const VerificationMeta('emissionApprovedAt');
  @override
  late final GeneratedColumn<PgDateTime> emissionApprovedAt =
      GeneratedColumn<PgDateTime>(
        'emission_approved_at',
        aliasedName,
        true,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _emissionApprovedByUserIdMeta =
      const VerificationMeta('emissionApprovedByUserId');
  @override
  late final GeneratedColumn<String> emissionApprovedByUserId =
      GeneratedColumn<String>(
        'emission_approved_by_user_id',
        aliasedName,
        true,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 100,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _issuedAtMeta = const VerificationMeta(
    'issuedAt',
  );
  @override
  late final GeneratedColumn<PgDateTime> issuedAt = GeneratedColumn<PgDateTime>(
    'issued_at',
    aliasedName,
    true,
    type: PgTypes.timestampWithTimezone,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _certificateBlobUrlMeta =
      const VerificationMeta('certificateBlobUrl');
  @override
  late final GeneratedColumn<String> certificateBlobUrl =
      GeneratedColumn<String>(
        'certificate_blob_url',
        aliasedName,
        true,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 1000,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _verificationCodeMeta = const VerificationMeta(
    'verificationCode',
  );
  @override
  late final GeneratedColumn<String> verificationCode = GeneratedColumn<String>(
    'verification_code',
    aliasedName,
    true,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<PgDateTime> expiresAt =
      GeneratedColumn<PgDateTime>(
        'expires_at',
        aliasedName,
        true,
        type: PgTypes.timestampWithTimezone,
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
    certificateId,
    traineeUserId,
    enrollmentId,
    courseId,
    status,
    emissionApprovedAt,
    emissionApprovedByUserId,
    issuedAt,
    certificateBlobUrl,
    verificationCode,
    expiresAt,
    createdAt,
    updatedAt,
    notes,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'issued_certificates';
  @override
  VerificationContext validateIntegrity(
    Insertable<IssuedCertificate> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('certificate_id')) {
      context.handle(
        _certificateIdMeta,
        certificateId.isAcceptableOrUnknown(
          data['certificate_id']!,
          _certificateIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_certificateIdMeta);
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
    if (data.containsKey('course_id')) {
      context.handle(
        _courseIdMeta,
        courseId.isAcceptableOrUnknown(data['course_id']!, _courseIdMeta),
      );
    } else if (isInserting) {
      context.missing(_courseIdMeta);
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('emission_approved_at')) {
      context.handle(
        _emissionApprovedAtMeta,
        emissionApprovedAt.isAcceptableOrUnknown(
          data['emission_approved_at']!,
          _emissionApprovedAtMeta,
        ),
      );
    }
    if (data.containsKey('emission_approved_by_user_id')) {
      context.handle(
        _emissionApprovedByUserIdMeta,
        emissionApprovedByUserId.isAcceptableOrUnknown(
          data['emission_approved_by_user_id']!,
          _emissionApprovedByUserIdMeta,
        ),
      );
    }
    if (data.containsKey('issued_at')) {
      context.handle(
        _issuedAtMeta,
        issuedAt.isAcceptableOrUnknown(data['issued_at']!, _issuedAtMeta),
      );
    }
    if (data.containsKey('certificate_blob_url')) {
      context.handle(
        _certificateBlobUrlMeta,
        certificateBlobUrl.isAcceptableOrUnknown(
          data['certificate_blob_url']!,
          _certificateBlobUrlMeta,
        ),
      );
    }
    if (data.containsKey('verification_code')) {
      context.handle(
        _verificationCodeMeta,
        verificationCode.isAcceptableOrUnknown(
          data['verification_code']!,
          _verificationCodeMeta,
        ),
      );
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
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
  Set<GeneratedColumn> get $primaryKey => {certificateId};
  @override
  IssuedCertificate map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return IssuedCertificate(
      certificateId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}certificate_id'],
          )!,
      traineeUserId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}trainee_user_id'],
          )!,
      enrollmentId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}enrollment_id'],
          )!,
      courseId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}course_id'],
          )!,
      status:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}status'],
          )!,
      emissionApprovedAt: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}emission_approved_at'],
      ),
      emissionApprovedByUserId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}emission_approved_by_user_id'],
      ),
      issuedAt: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}issued_at'],
      ),
      certificateBlobUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}certificate_blob_url'],
      ),
      verificationCode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}verification_code'],
      ),
      expiresAt: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}expires_at'],
      ),
      createdAt:
          attachedDatabase.typeMapping.read(
            PgTypes.timestampWithTimezone,
            data['${effectivePrefix}created_at'],
          )!,
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
  $IssuedCertificatesTable createAlias(String alias) {
    return $IssuedCertificatesTable(attachedDatabase, alias);
  }
}

class IssuedCertificate extends DataClass
    implements Insertable<IssuedCertificate> {
  /// Primary key - unique certificate identifier
  final String certificateId;

  /// ID of the trainee/student user
  final String traineeUserId;

  /// Foreign key to CourseOffering(id) in Course Service
  final String enrollmentId;

  /// Foreign key to Course(id) in Course Service
  final String courseId;

  /// Certificate status enum
  final String status;

  /// Timestamp when emission was approved (nullable)
  final PgDateTime? emissionApprovedAt;

  /// ID of user who approved emission (nullable)
  final String? emissionApprovedByUserId;

  /// Timestamp when certificate was issued (nullable)
  final PgDateTime? issuedAt;

  /// URL/Key for PDF certificate in Azure Blob Storage (nullable)
  final String? certificateBlobUrl;

  /// Unique verification code for the certificate (nullable)
  final String? verificationCode;

  /// Certificate expiration date (nullable)
  final PgDateTime? expiresAt;

  /// Timestamp when the certificate record was created
  final PgDateTime createdAt;

  /// Timestamp when the certificate record was last updated
  final PgDateTime updatedAt;

  /// Additional notes about the certificate (nullable)
  final String? notes;
  const IssuedCertificate({
    required this.certificateId,
    required this.traineeUserId,
    required this.enrollmentId,
    required this.courseId,
    required this.status,
    this.emissionApprovedAt,
    this.emissionApprovedByUserId,
    this.issuedAt,
    this.certificateBlobUrl,
    this.verificationCode,
    this.expiresAt,
    required this.createdAt,
    required this.updatedAt,
    this.notes,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['certificate_id'] = Variable<String>(certificateId);
    map['trainee_user_id'] = Variable<String>(traineeUserId);
    map['enrollment_id'] = Variable<String>(enrollmentId);
    map['course_id'] = Variable<String>(courseId);
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || emissionApprovedAt != null) {
      map['emission_approved_at'] = Variable<PgDateTime>(
        emissionApprovedAt,
        PgTypes.timestampWithTimezone,
      );
    }
    if (!nullToAbsent || emissionApprovedByUserId != null) {
      map['emission_approved_by_user_id'] = Variable<String>(
        emissionApprovedByUserId,
      );
    }
    if (!nullToAbsent || issuedAt != null) {
      map['issued_at'] = Variable<PgDateTime>(
        issuedAt,
        PgTypes.timestampWithTimezone,
      );
    }
    if (!nullToAbsent || certificateBlobUrl != null) {
      map['certificate_blob_url'] = Variable<String>(certificateBlobUrl);
    }
    if (!nullToAbsent || verificationCode != null) {
      map['verification_code'] = Variable<String>(verificationCode);
    }
    if (!nullToAbsent || expiresAt != null) {
      map['expires_at'] = Variable<PgDateTime>(
        expiresAt,
        PgTypes.timestampWithTimezone,
      );
    }
    map['created_at'] = Variable<PgDateTime>(
      createdAt,
      PgTypes.timestampWithTimezone,
    );
    map['updated_at'] = Variable<PgDateTime>(
      updatedAt,
      PgTypes.timestampWithTimezone,
    );
    if (!nullToAbsent || notes != null) {
      map['notes'] = Variable<String>(notes);
    }
    return map;
  }

  IssuedCertificatesCompanion toCompanion(bool nullToAbsent) {
    return IssuedCertificatesCompanion(
      certificateId: Value(certificateId),
      traineeUserId: Value(traineeUserId),
      enrollmentId: Value(enrollmentId),
      courseId: Value(courseId),
      status: Value(status),
      emissionApprovedAt:
          emissionApprovedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(emissionApprovedAt),
      emissionApprovedByUserId:
          emissionApprovedByUserId == null && nullToAbsent
              ? const Value.absent()
              : Value(emissionApprovedByUserId),
      issuedAt:
          issuedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(issuedAt),
      certificateBlobUrl:
          certificateBlobUrl == null && nullToAbsent
              ? const Value.absent()
              : Value(certificateBlobUrl),
      verificationCode:
          verificationCode == null && nullToAbsent
              ? const Value.absent()
              : Value(verificationCode),
      expiresAt:
          expiresAt == null && nullToAbsent
              ? const Value.absent()
              : Value(expiresAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
      notes:
          notes == null && nullToAbsent ? const Value.absent() : Value(notes),
    );
  }

  factory IssuedCertificate.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return IssuedCertificate(
      certificateId: serializer.fromJson<String>(json['certificateId']),
      traineeUserId: serializer.fromJson<String>(json['traineeUserId']),
      enrollmentId: serializer.fromJson<String>(json['enrollmentId']),
      courseId: serializer.fromJson<String>(json['courseId']),
      status: serializer.fromJson<String>(json['status']),
      emissionApprovedAt: serializer.fromJson<PgDateTime?>(
        json['emissionApprovedAt'],
      ),
      emissionApprovedByUserId: serializer.fromJson<String?>(
        json['emissionApprovedByUserId'],
      ),
      issuedAt: serializer.fromJson<PgDateTime?>(json['issuedAt']),
      certificateBlobUrl: serializer.fromJson<String?>(
        json['certificateBlobUrl'],
      ),
      verificationCode: serializer.fromJson<String?>(json['verificationCode']),
      expiresAt: serializer.fromJson<PgDateTime?>(json['expiresAt']),
      createdAt: serializer.fromJson<PgDateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<PgDateTime>(json['updatedAt']),
      notes: serializer.fromJson<String?>(json['notes']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'certificateId': serializer.toJson<String>(certificateId),
      'traineeUserId': serializer.toJson<String>(traineeUserId),
      'enrollmentId': serializer.toJson<String>(enrollmentId),
      'courseId': serializer.toJson<String>(courseId),
      'status': serializer.toJson<String>(status),
      'emissionApprovedAt': serializer.toJson<PgDateTime?>(emissionApprovedAt),
      'emissionApprovedByUserId': serializer.toJson<String?>(
        emissionApprovedByUserId,
      ),
      'issuedAt': serializer.toJson<PgDateTime?>(issuedAt),
      'certificateBlobUrl': serializer.toJson<String?>(certificateBlobUrl),
      'verificationCode': serializer.toJson<String?>(verificationCode),
      'expiresAt': serializer.toJson<PgDateTime?>(expiresAt),
      'createdAt': serializer.toJson<PgDateTime>(createdAt),
      'updatedAt': serializer.toJson<PgDateTime>(updatedAt),
      'notes': serializer.toJson<String?>(notes),
    };
  }

  IssuedCertificate copyWith({
    String? certificateId,
    String? traineeUserId,
    String? enrollmentId,
    String? courseId,
    String? status,
    Value<PgDateTime?> emissionApprovedAt = const Value.absent(),
    Value<String?> emissionApprovedByUserId = const Value.absent(),
    Value<PgDateTime?> issuedAt = const Value.absent(),
    Value<String?> certificateBlobUrl = const Value.absent(),
    Value<String?> verificationCode = const Value.absent(),
    Value<PgDateTime?> expiresAt = const Value.absent(),
    PgDateTime? createdAt,
    PgDateTime? updatedAt,
    Value<String?> notes = const Value.absent(),
  }) => IssuedCertificate(
    certificateId: certificateId ?? this.certificateId,
    traineeUserId: traineeUserId ?? this.traineeUserId,
    enrollmentId: enrollmentId ?? this.enrollmentId,
    courseId: courseId ?? this.courseId,
    status: status ?? this.status,
    emissionApprovedAt:
        emissionApprovedAt.present
            ? emissionApprovedAt.value
            : this.emissionApprovedAt,
    emissionApprovedByUserId:
        emissionApprovedByUserId.present
            ? emissionApprovedByUserId.value
            : this.emissionApprovedByUserId,
    issuedAt: issuedAt.present ? issuedAt.value : this.issuedAt,
    certificateBlobUrl:
        certificateBlobUrl.present
            ? certificateBlobUrl.value
            : this.certificateBlobUrl,
    verificationCode:
        verificationCode.present
            ? verificationCode.value
            : this.verificationCode,
    expiresAt: expiresAt.present ? expiresAt.value : this.expiresAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
    notes: notes.present ? notes.value : this.notes,
  );
  IssuedCertificate copyWithCompanion(IssuedCertificatesCompanion data) {
    return IssuedCertificate(
      certificateId:
          data.certificateId.present
              ? data.certificateId.value
              : this.certificateId,
      traineeUserId:
          data.traineeUserId.present
              ? data.traineeUserId.value
              : this.traineeUserId,
      enrollmentId:
          data.enrollmentId.present
              ? data.enrollmentId.value
              : this.enrollmentId,
      courseId: data.courseId.present ? data.courseId.value : this.courseId,
      status: data.status.present ? data.status.value : this.status,
      emissionApprovedAt:
          data.emissionApprovedAt.present
              ? data.emissionApprovedAt.value
              : this.emissionApprovedAt,
      emissionApprovedByUserId:
          data.emissionApprovedByUserId.present
              ? data.emissionApprovedByUserId.value
              : this.emissionApprovedByUserId,
      issuedAt: data.issuedAt.present ? data.issuedAt.value : this.issuedAt,
      certificateBlobUrl:
          data.certificateBlobUrl.present
              ? data.certificateBlobUrl.value
              : this.certificateBlobUrl,
      verificationCode:
          data.verificationCode.present
              ? data.verificationCode.value
              : this.verificationCode,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      notes: data.notes.present ? data.notes.value : this.notes,
    );
  }

  @override
  String toString() {
    return (StringBuffer('IssuedCertificate(')
          ..write('certificateId: $certificateId, ')
          ..write('traineeUserId: $traineeUserId, ')
          ..write('enrollmentId: $enrollmentId, ')
          ..write('courseId: $courseId, ')
          ..write('status: $status, ')
          ..write('emissionApprovedAt: $emissionApprovedAt, ')
          ..write('emissionApprovedByUserId: $emissionApprovedByUserId, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('certificateBlobUrl: $certificateBlobUrl, ')
          ..write('verificationCode: $verificationCode, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('notes: $notes')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    certificateId,
    traineeUserId,
    enrollmentId,
    courseId,
    status,
    emissionApprovedAt,
    emissionApprovedByUserId,
    issuedAt,
    certificateBlobUrl,
    verificationCode,
    expiresAt,
    createdAt,
    updatedAt,
    notes,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is IssuedCertificate &&
          other.certificateId == this.certificateId &&
          other.traineeUserId == this.traineeUserId &&
          other.enrollmentId == this.enrollmentId &&
          other.courseId == this.courseId &&
          other.status == this.status &&
          other.emissionApprovedAt == this.emissionApprovedAt &&
          other.emissionApprovedByUserId == this.emissionApprovedByUserId &&
          other.issuedAt == this.issuedAt &&
          other.certificateBlobUrl == this.certificateBlobUrl &&
          other.verificationCode == this.verificationCode &&
          other.expiresAt == this.expiresAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.notes == this.notes);
}

class IssuedCertificatesCompanion extends UpdateCompanion<IssuedCertificate> {
  final Value<String> certificateId;
  final Value<String> traineeUserId;
  final Value<String> enrollmentId;
  final Value<String> courseId;
  final Value<String> status;
  final Value<PgDateTime?> emissionApprovedAt;
  final Value<String?> emissionApprovedByUserId;
  final Value<PgDateTime?> issuedAt;
  final Value<String?> certificateBlobUrl;
  final Value<String?> verificationCode;
  final Value<PgDateTime?> expiresAt;
  final Value<PgDateTime> createdAt;
  final Value<PgDateTime> updatedAt;
  final Value<String?> notes;
  final Value<int> rowid;
  const IssuedCertificatesCompanion({
    this.certificateId = const Value.absent(),
    this.traineeUserId = const Value.absent(),
    this.enrollmentId = const Value.absent(),
    this.courseId = const Value.absent(),
    this.status = const Value.absent(),
    this.emissionApprovedAt = const Value.absent(),
    this.emissionApprovedByUserId = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.certificateBlobUrl = const Value.absent(),
    this.verificationCode = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  IssuedCertificatesCompanion.insert({
    required String certificateId,
    required String traineeUserId,
    required String enrollmentId,
    required String courseId,
    required String status,
    this.emissionApprovedAt = const Value.absent(),
    this.emissionApprovedByUserId = const Value.absent(),
    this.issuedAt = const Value.absent(),
    this.certificateBlobUrl = const Value.absent(),
    this.verificationCode = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.notes = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : certificateId = Value(certificateId),
       traineeUserId = Value(traineeUserId),
       enrollmentId = Value(enrollmentId),
       courseId = Value(courseId),
       status = Value(status);
  static Insertable<IssuedCertificate> custom({
    Expression<String>? certificateId,
    Expression<String>? traineeUserId,
    Expression<String>? enrollmentId,
    Expression<String>? courseId,
    Expression<String>? status,
    Expression<PgDateTime>? emissionApprovedAt,
    Expression<String>? emissionApprovedByUserId,
    Expression<PgDateTime>? issuedAt,
    Expression<String>? certificateBlobUrl,
    Expression<String>? verificationCode,
    Expression<PgDateTime>? expiresAt,
    Expression<PgDateTime>? createdAt,
    Expression<PgDateTime>? updatedAt,
    Expression<String>? notes,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (certificateId != null) 'certificate_id': certificateId,
      if (traineeUserId != null) 'trainee_user_id': traineeUserId,
      if (enrollmentId != null) 'enrollment_id': enrollmentId,
      if (courseId != null) 'course_id': courseId,
      if (status != null) 'status': status,
      if (emissionApprovedAt != null)
        'emission_approved_at': emissionApprovedAt,
      if (emissionApprovedByUserId != null)
        'emission_approved_by_user_id': emissionApprovedByUserId,
      if (issuedAt != null) 'issued_at': issuedAt,
      if (certificateBlobUrl != null)
        'certificate_blob_url': certificateBlobUrl,
      if (verificationCode != null) 'verification_code': verificationCode,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (notes != null) 'notes': notes,
      if (rowid != null) 'rowid': rowid,
    });
  }

  IssuedCertificatesCompanion copyWith({
    Value<String>? certificateId,
    Value<String>? traineeUserId,
    Value<String>? enrollmentId,
    Value<String>? courseId,
    Value<String>? status,
    Value<PgDateTime?>? emissionApprovedAt,
    Value<String?>? emissionApprovedByUserId,
    Value<PgDateTime?>? issuedAt,
    Value<String?>? certificateBlobUrl,
    Value<String?>? verificationCode,
    Value<PgDateTime?>? expiresAt,
    Value<PgDateTime>? createdAt,
    Value<PgDateTime>? updatedAt,
    Value<String?>? notes,
    Value<int>? rowid,
  }) {
    return IssuedCertificatesCompanion(
      certificateId: certificateId ?? this.certificateId,
      traineeUserId: traineeUserId ?? this.traineeUserId,
      enrollmentId: enrollmentId ?? this.enrollmentId,
      courseId: courseId ?? this.courseId,
      status: status ?? this.status,
      emissionApprovedAt: emissionApprovedAt ?? this.emissionApprovedAt,
      emissionApprovedByUserId:
          emissionApprovedByUserId ?? this.emissionApprovedByUserId,
      issuedAt: issuedAt ?? this.issuedAt,
      certificateBlobUrl: certificateBlobUrl ?? this.certificateBlobUrl,
      verificationCode: verificationCode ?? this.verificationCode,
      expiresAt: expiresAt ?? this.expiresAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      notes: notes ?? this.notes,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (certificateId.present) {
      map['certificate_id'] = Variable<String>(certificateId.value);
    }
    if (traineeUserId.present) {
      map['trainee_user_id'] = Variable<String>(traineeUserId.value);
    }
    if (enrollmentId.present) {
      map['enrollment_id'] = Variable<String>(enrollmentId.value);
    }
    if (courseId.present) {
      map['course_id'] = Variable<String>(courseId.value);
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (emissionApprovedAt.present) {
      map['emission_approved_at'] = Variable<PgDateTime>(
        emissionApprovedAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (emissionApprovedByUserId.present) {
      map['emission_approved_by_user_id'] = Variable<String>(
        emissionApprovedByUserId.value,
      );
    }
    if (issuedAt.present) {
      map['issued_at'] = Variable<PgDateTime>(
        issuedAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (certificateBlobUrl.present) {
      map['certificate_blob_url'] = Variable<String>(certificateBlobUrl.value);
    }
    if (verificationCode.present) {
      map['verification_code'] = Variable<String>(verificationCode.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<PgDateTime>(
        expiresAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<PgDateTime>(
        createdAt.value,
        PgTypes.timestampWithTimezone,
      );
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
    return (StringBuffer('IssuedCertificatesCompanion(')
          ..write('certificateId: $certificateId, ')
          ..write('traineeUserId: $traineeUserId, ')
          ..write('enrollmentId: $enrollmentId, ')
          ..write('courseId: $courseId, ')
          ..write('status: $status, ')
          ..write('emissionApprovedAt: $emissionApprovedAt, ')
          ..write('emissionApprovedByUserId: $emissionApprovedByUserId, ')
          ..write('issuedAt: $issuedAt, ')
          ..write('certificateBlobUrl: $certificateBlobUrl, ')
          ..write('verificationCode: $verificationCode, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('notes: $notes, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ExternalCertificationLogsTable extends ExternalCertificationLogs
    with TableInfo<$ExternalCertificationLogsTable, ExternalCertificationLog> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ExternalCertificationLogsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _logIdMeta = const VerificationMeta('logId');
  @override
  late final GeneratedColumn<String> logId = GeneratedColumn<String>(
    'log_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _certificateIdMeta = const VerificationMeta(
    'certificateId',
  );
  @override
  late final GeneratedColumn<String> certificateId = GeneratedColumn<String>(
    'certificate_id',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _externalSystemNameMeta =
      const VerificationMeta('externalSystemName');
  @override
  late final GeneratedColumn<String> externalSystemName =
      GeneratedColumn<String>(
        'external_system_name',
        aliasedName,
        false,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 255,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _actionTypeMeta = const VerificationMeta(
    'actionType',
  );
  @override
  late final GeneratedColumn<String> actionType = GeneratedColumn<String>(
    'action_type',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _actionTimestampMeta = const VerificationMeta(
    'actionTimestamp',
  );
  @override
  late final GeneratedColumn<PgDateTime> actionTimestamp =
      GeneratedColumn<PgDateTime>(
        'action_timestamp',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
        defaultValue: now(),
      );
  static const VerificationMeta _statusMeta = const VerificationMeta('status');
  @override
  late final GeneratedColumn<String> status = GeneratedColumn<String>(
    'status',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 100,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _externalReferenceIdMeta =
      const VerificationMeta('externalReferenceId');
  @override
  late final GeneratedColumn<String> externalReferenceId =
      GeneratedColumn<String>(
        'external_reference_id',
        aliasedName,
        true,
        additionalChecks: GeneratedColumn.checkTextLength(
          minTextLength: 1,
          maxTextLength: 255,
        ),
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _responseDetailsMeta = const VerificationMeta(
    'responseDetails',
  );
  @override
  late final GeneratedColumn<String> responseDetails = GeneratedColumn<String>(
    'response_details',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    logId,
    certificateId,
    externalSystemName,
    actionType,
    actionTimestamp,
    status,
    externalReferenceId,
    responseDetails,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'external_certification_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<ExternalCertificationLog> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('log_id')) {
      context.handle(
        _logIdMeta,
        logId.isAcceptableOrUnknown(data['log_id']!, _logIdMeta),
      );
    } else if (isInserting) {
      context.missing(_logIdMeta);
    }
    if (data.containsKey('certificate_id')) {
      context.handle(
        _certificateIdMeta,
        certificateId.isAcceptableOrUnknown(
          data['certificate_id']!,
          _certificateIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_certificateIdMeta);
    }
    if (data.containsKey('external_system_name')) {
      context.handle(
        _externalSystemNameMeta,
        externalSystemName.isAcceptableOrUnknown(
          data['external_system_name']!,
          _externalSystemNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_externalSystemNameMeta);
    }
    if (data.containsKey('action_type')) {
      context.handle(
        _actionTypeMeta,
        actionType.isAcceptableOrUnknown(data['action_type']!, _actionTypeMeta),
      );
    } else if (isInserting) {
      context.missing(_actionTypeMeta);
    }
    if (data.containsKey('action_timestamp')) {
      context.handle(
        _actionTimestampMeta,
        actionTimestamp.isAcceptableOrUnknown(
          data['action_timestamp']!,
          _actionTimestampMeta,
        ),
      );
    }
    if (data.containsKey('status')) {
      context.handle(
        _statusMeta,
        status.isAcceptableOrUnknown(data['status']!, _statusMeta),
      );
    } else if (isInserting) {
      context.missing(_statusMeta);
    }
    if (data.containsKey('external_reference_id')) {
      context.handle(
        _externalReferenceIdMeta,
        externalReferenceId.isAcceptableOrUnknown(
          data['external_reference_id']!,
          _externalReferenceIdMeta,
        ),
      );
    }
    if (data.containsKey('response_details')) {
      context.handle(
        _responseDetailsMeta,
        responseDetails.isAcceptableOrUnknown(
          data['response_details']!,
          _responseDetailsMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {logId};
  @override
  ExternalCertificationLog map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ExternalCertificationLog(
      logId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}log_id'],
          )!,
      certificateId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}certificate_id'],
          )!,
      externalSystemName:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}external_system_name'],
          )!,
      actionType:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}action_type'],
          )!,
      actionTimestamp:
          attachedDatabase.typeMapping.read(
            PgTypes.timestampWithTimezone,
            data['${effectivePrefix}action_timestamp'],
          )!,
      status:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}status'],
          )!,
      externalReferenceId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}external_reference_id'],
      ),
      responseDetails: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}response_details'],
      ),
    );
  }

  @override
  $ExternalCertificationLogsTable createAlias(String alias) {
    return $ExternalCertificationLogsTable(attachedDatabase, alias);
  }
}

class ExternalCertificationLog extends DataClass
    implements Insertable<ExternalCertificationLog> {
  /// Primary key - unique log identifier
  final String logId;

  /// Foreign key to IssuedCertificate
  final String certificateId;

  /// Name of the external system
  final String externalSystemName;

  /// Type of action performed
  final String actionType;

  /// Timestamp when the action was performed
  final PgDateTime actionTimestamp;

  /// Status of the action
  final String status;

  /// External reference ID from the external system (nullable)
  final String? externalReferenceId;

  /// Response details from the external system (nullable)
  final String? responseDetails;
  const ExternalCertificationLog({
    required this.logId,
    required this.certificateId,
    required this.externalSystemName,
    required this.actionType,
    required this.actionTimestamp,
    required this.status,
    this.externalReferenceId,
    this.responseDetails,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['log_id'] = Variable<String>(logId);
    map['certificate_id'] = Variable<String>(certificateId);
    map['external_system_name'] = Variable<String>(externalSystemName);
    map['action_type'] = Variable<String>(actionType);
    map['action_timestamp'] = Variable<PgDateTime>(
      actionTimestamp,
      PgTypes.timestampWithTimezone,
    );
    map['status'] = Variable<String>(status);
    if (!nullToAbsent || externalReferenceId != null) {
      map['external_reference_id'] = Variable<String>(externalReferenceId);
    }
    if (!nullToAbsent || responseDetails != null) {
      map['response_details'] = Variable<String>(responseDetails);
    }
    return map;
  }

  ExternalCertificationLogsCompanion toCompanion(bool nullToAbsent) {
    return ExternalCertificationLogsCompanion(
      logId: Value(logId),
      certificateId: Value(certificateId),
      externalSystemName: Value(externalSystemName),
      actionType: Value(actionType),
      actionTimestamp: Value(actionTimestamp),
      status: Value(status),
      externalReferenceId:
          externalReferenceId == null && nullToAbsent
              ? const Value.absent()
              : Value(externalReferenceId),
      responseDetails:
          responseDetails == null && nullToAbsent
              ? const Value.absent()
              : Value(responseDetails),
    );
  }

  factory ExternalCertificationLog.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ExternalCertificationLog(
      logId: serializer.fromJson<String>(json['logId']),
      certificateId: serializer.fromJson<String>(json['certificateId']),
      externalSystemName: serializer.fromJson<String>(
        json['externalSystemName'],
      ),
      actionType: serializer.fromJson<String>(json['actionType']),
      actionTimestamp: serializer.fromJson<PgDateTime>(json['actionTimestamp']),
      status: serializer.fromJson<String>(json['status']),
      externalReferenceId: serializer.fromJson<String?>(
        json['externalReferenceId'],
      ),
      responseDetails: serializer.fromJson<String?>(json['responseDetails']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'logId': serializer.toJson<String>(logId),
      'certificateId': serializer.toJson<String>(certificateId),
      'externalSystemName': serializer.toJson<String>(externalSystemName),
      'actionType': serializer.toJson<String>(actionType),
      'actionTimestamp': serializer.toJson<PgDateTime>(actionTimestamp),
      'status': serializer.toJson<String>(status),
      'externalReferenceId': serializer.toJson<String?>(externalReferenceId),
      'responseDetails': serializer.toJson<String?>(responseDetails),
    };
  }

  ExternalCertificationLog copyWith({
    String? logId,
    String? certificateId,
    String? externalSystemName,
    String? actionType,
    PgDateTime? actionTimestamp,
    String? status,
    Value<String?> externalReferenceId = const Value.absent(),
    Value<String?> responseDetails = const Value.absent(),
  }) => ExternalCertificationLog(
    logId: logId ?? this.logId,
    certificateId: certificateId ?? this.certificateId,
    externalSystemName: externalSystemName ?? this.externalSystemName,
    actionType: actionType ?? this.actionType,
    actionTimestamp: actionTimestamp ?? this.actionTimestamp,
    status: status ?? this.status,
    externalReferenceId:
        externalReferenceId.present
            ? externalReferenceId.value
            : this.externalReferenceId,
    responseDetails:
        responseDetails.present ? responseDetails.value : this.responseDetails,
  );
  ExternalCertificationLog copyWithCompanion(
    ExternalCertificationLogsCompanion data,
  ) {
    return ExternalCertificationLog(
      logId: data.logId.present ? data.logId.value : this.logId,
      certificateId:
          data.certificateId.present
              ? data.certificateId.value
              : this.certificateId,
      externalSystemName:
          data.externalSystemName.present
              ? data.externalSystemName.value
              : this.externalSystemName,
      actionType:
          data.actionType.present ? data.actionType.value : this.actionType,
      actionTimestamp:
          data.actionTimestamp.present
              ? data.actionTimestamp.value
              : this.actionTimestamp,
      status: data.status.present ? data.status.value : this.status,
      externalReferenceId:
          data.externalReferenceId.present
              ? data.externalReferenceId.value
              : this.externalReferenceId,
      responseDetails:
          data.responseDetails.present
              ? data.responseDetails.value
              : this.responseDetails,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ExternalCertificationLog(')
          ..write('logId: $logId, ')
          ..write('certificateId: $certificateId, ')
          ..write('externalSystemName: $externalSystemName, ')
          ..write('actionType: $actionType, ')
          ..write('actionTimestamp: $actionTimestamp, ')
          ..write('status: $status, ')
          ..write('externalReferenceId: $externalReferenceId, ')
          ..write('responseDetails: $responseDetails')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    logId,
    certificateId,
    externalSystemName,
    actionType,
    actionTimestamp,
    status,
    externalReferenceId,
    responseDetails,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ExternalCertificationLog &&
          other.logId == this.logId &&
          other.certificateId == this.certificateId &&
          other.externalSystemName == this.externalSystemName &&
          other.actionType == this.actionType &&
          other.actionTimestamp == this.actionTimestamp &&
          other.status == this.status &&
          other.externalReferenceId == this.externalReferenceId &&
          other.responseDetails == this.responseDetails);
}

class ExternalCertificationLogsCompanion
    extends UpdateCompanion<ExternalCertificationLog> {
  final Value<String> logId;
  final Value<String> certificateId;
  final Value<String> externalSystemName;
  final Value<String> actionType;
  final Value<PgDateTime> actionTimestamp;
  final Value<String> status;
  final Value<String?> externalReferenceId;
  final Value<String?> responseDetails;
  final Value<int> rowid;
  const ExternalCertificationLogsCompanion({
    this.logId = const Value.absent(),
    this.certificateId = const Value.absent(),
    this.externalSystemName = const Value.absent(),
    this.actionType = const Value.absent(),
    this.actionTimestamp = const Value.absent(),
    this.status = const Value.absent(),
    this.externalReferenceId = const Value.absent(),
    this.responseDetails = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ExternalCertificationLogsCompanion.insert({
    required String logId,
    required String certificateId,
    required String externalSystemName,
    required String actionType,
    this.actionTimestamp = const Value.absent(),
    required String status,
    this.externalReferenceId = const Value.absent(),
    this.responseDetails = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : logId = Value(logId),
       certificateId = Value(certificateId),
       externalSystemName = Value(externalSystemName),
       actionType = Value(actionType),
       status = Value(status);
  static Insertable<ExternalCertificationLog> custom({
    Expression<String>? logId,
    Expression<String>? certificateId,
    Expression<String>? externalSystemName,
    Expression<String>? actionType,
    Expression<PgDateTime>? actionTimestamp,
    Expression<String>? status,
    Expression<String>? externalReferenceId,
    Expression<String>? responseDetails,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (logId != null) 'log_id': logId,
      if (certificateId != null) 'certificate_id': certificateId,
      if (externalSystemName != null)
        'external_system_name': externalSystemName,
      if (actionType != null) 'action_type': actionType,
      if (actionTimestamp != null) 'action_timestamp': actionTimestamp,
      if (status != null) 'status': status,
      if (externalReferenceId != null)
        'external_reference_id': externalReferenceId,
      if (responseDetails != null) 'response_details': responseDetails,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ExternalCertificationLogsCompanion copyWith({
    Value<String>? logId,
    Value<String>? certificateId,
    Value<String>? externalSystemName,
    Value<String>? actionType,
    Value<PgDateTime>? actionTimestamp,
    Value<String>? status,
    Value<String?>? externalReferenceId,
    Value<String?>? responseDetails,
    Value<int>? rowid,
  }) {
    return ExternalCertificationLogsCompanion(
      logId: logId ?? this.logId,
      certificateId: certificateId ?? this.certificateId,
      externalSystemName: externalSystemName ?? this.externalSystemName,
      actionType: actionType ?? this.actionType,
      actionTimestamp: actionTimestamp ?? this.actionTimestamp,
      status: status ?? this.status,
      externalReferenceId: externalReferenceId ?? this.externalReferenceId,
      responseDetails: responseDetails ?? this.responseDetails,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (logId.present) {
      map['log_id'] = Variable<String>(logId.value);
    }
    if (certificateId.present) {
      map['certificate_id'] = Variable<String>(certificateId.value);
    }
    if (externalSystemName.present) {
      map['external_system_name'] = Variable<String>(externalSystemName.value);
    }
    if (actionType.present) {
      map['action_type'] = Variable<String>(actionType.value);
    }
    if (actionTimestamp.present) {
      map['action_timestamp'] = Variable<PgDateTime>(
        actionTimestamp.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (status.present) {
      map['status'] = Variable<String>(status.value);
    }
    if (externalReferenceId.present) {
      map['external_reference_id'] = Variable<String>(
        externalReferenceId.value,
      );
    }
    if (responseDetails.present) {
      map['response_details'] = Variable<String>(responseDetails.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ExternalCertificationLogsCompanion(')
          ..write('logId: $logId, ')
          ..write('certificateId: $certificateId, ')
          ..write('externalSystemName: $externalSystemName, ')
          ..write('actionType: $actionType, ')
          ..write('actionTimestamp: $actionTimestamp, ')
          ..write('status: $status, ')
          ..write('externalReferenceId: $externalReferenceId, ')
          ..write('responseDetails: $responseDetails, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$CertificateDatabase extends GeneratedDatabase {
  _$CertificateDatabase(QueryExecutor e) : super(e);
  $CertificateDatabaseManager get managers => $CertificateDatabaseManager(this);
  late final $CertificateTemplatesTable certificateTemplates =
      $CertificateTemplatesTable(this);
  late final $IssuedCertificatesTable issuedCertificates =
      $IssuedCertificatesTable(this);
  late final $ExternalCertificationLogsTable externalCertificationLogs =
      $ExternalCertificationLogsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    certificateTemplates,
    issuedCertificates,
    externalCertificationLogs,
  ];
}

typedef $$CertificateTemplatesTableCreateCompanionBuilder =
    CertificateTemplatesCompanion Function({
      required String templateId,
      required String courseId,
      required String templateName,
      required String templateBlobUrl,
      required String uploadedByUserId,
      Value<PgDateTime> createdAt,
      Value<PgDateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$CertificateTemplatesTableUpdateCompanionBuilder =
    CertificateTemplatesCompanion Function({
      Value<String> templateId,
      Value<String> courseId,
      Value<String> templateName,
      Value<String> templateBlobUrl,
      Value<String> uploadedByUserId,
      Value<PgDateTime> createdAt,
      Value<PgDateTime> updatedAt,
      Value<int> rowid,
    });

class $$CertificateTemplatesTableFilterComposer
    extends Composer<_$CertificateDatabase, $CertificateTemplatesTable> {
  $$CertificateTemplatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseId => $composableBuilder(
    column: $table.courseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateName => $composableBuilder(
    column: $table.templateName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get templateBlobUrl => $composableBuilder(
    column: $table.templateBlobUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get uploadedByUserId => $composableBuilder(
    column: $table.uploadedByUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CertificateTemplatesTableOrderingComposer
    extends Composer<_$CertificateDatabase, $CertificateTemplatesTable> {
  $$CertificateTemplatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseId => $composableBuilder(
    column: $table.courseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateName => $composableBuilder(
    column: $table.templateName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get templateBlobUrl => $composableBuilder(
    column: $table.templateBlobUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get uploadedByUserId => $composableBuilder(
    column: $table.uploadedByUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CertificateTemplatesTableAnnotationComposer
    extends Composer<_$CertificateDatabase, $CertificateTemplatesTable> {
  $$CertificateTemplatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get templateId => $composableBuilder(
    column: $table.templateId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseId =>
      $composableBuilder(column: $table.courseId, builder: (column) => column);

  GeneratedColumn<String> get templateName => $composableBuilder(
    column: $table.templateName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get templateBlobUrl => $composableBuilder(
    column: $table.templateBlobUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get uploadedByUserId => $composableBuilder(
    column: $table.uploadedByUserId,
    builder: (column) => column,
  );

  GeneratedColumn<PgDateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<PgDateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CertificateTemplatesTableTableManager
    extends
        RootTableManager<
          _$CertificateDatabase,
          $CertificateTemplatesTable,
          CertificateTemplate,
          $$CertificateTemplatesTableFilterComposer,
          $$CertificateTemplatesTableOrderingComposer,
          $$CertificateTemplatesTableAnnotationComposer,
          $$CertificateTemplatesTableCreateCompanionBuilder,
          $$CertificateTemplatesTableUpdateCompanionBuilder,
          (
            CertificateTemplate,
            BaseReferences<
              _$CertificateDatabase,
              $CertificateTemplatesTable,
              CertificateTemplate
            >,
          ),
          CertificateTemplate,
          PrefetchHooks Function()
        > {
  $$CertificateTemplatesTableTableManager(
    _$CertificateDatabase db,
    $CertificateTemplatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$CertificateTemplatesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$CertificateTemplatesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$CertificateTemplatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> templateId = const Value.absent(),
                Value<String> courseId = const Value.absent(),
                Value<String> templateName = const Value.absent(),
                Value<String> templateBlobUrl = const Value.absent(),
                Value<String> uploadedByUserId = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                Value<PgDateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CertificateTemplatesCompanion(
                templateId: templateId,
                courseId: courseId,
                templateName: templateName,
                templateBlobUrl: templateBlobUrl,
                uploadedByUserId: uploadedByUserId,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String templateId,
                required String courseId,
                required String templateName,
                required String templateBlobUrl,
                required String uploadedByUserId,
                Value<PgDateTime> createdAt = const Value.absent(),
                Value<PgDateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CertificateTemplatesCompanion.insert(
                templateId: templateId,
                courseId: courseId,
                templateName: templateName,
                templateBlobUrl: templateBlobUrl,
                uploadedByUserId: uploadedByUserId,
                createdAt: createdAt,
                updatedAt: updatedAt,
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

typedef $$CertificateTemplatesTableProcessedTableManager =
    ProcessedTableManager<
      _$CertificateDatabase,
      $CertificateTemplatesTable,
      CertificateTemplate,
      $$CertificateTemplatesTableFilterComposer,
      $$CertificateTemplatesTableOrderingComposer,
      $$CertificateTemplatesTableAnnotationComposer,
      $$CertificateTemplatesTableCreateCompanionBuilder,
      $$CertificateTemplatesTableUpdateCompanionBuilder,
      (
        CertificateTemplate,
        BaseReferences<
          _$CertificateDatabase,
          $CertificateTemplatesTable,
          CertificateTemplate
        >,
      ),
      CertificateTemplate,
      PrefetchHooks Function()
    >;
typedef $$IssuedCertificatesTableCreateCompanionBuilder =
    IssuedCertificatesCompanion Function({
      required String certificateId,
      required String traineeUserId,
      required String enrollmentId,
      required String courseId,
      required String status,
      Value<PgDateTime?> emissionApprovedAt,
      Value<String?> emissionApprovedByUserId,
      Value<PgDateTime?> issuedAt,
      Value<String?> certificateBlobUrl,
      Value<String?> verificationCode,
      Value<PgDateTime?> expiresAt,
      Value<PgDateTime> createdAt,
      Value<PgDateTime> updatedAt,
      Value<String?> notes,
      Value<int> rowid,
    });
typedef $$IssuedCertificatesTableUpdateCompanionBuilder =
    IssuedCertificatesCompanion Function({
      Value<String> certificateId,
      Value<String> traineeUserId,
      Value<String> enrollmentId,
      Value<String> courseId,
      Value<String> status,
      Value<PgDateTime?> emissionApprovedAt,
      Value<String?> emissionApprovedByUserId,
      Value<PgDateTime?> issuedAt,
      Value<String?> certificateBlobUrl,
      Value<String?> verificationCode,
      Value<PgDateTime?> expiresAt,
      Value<PgDateTime> createdAt,
      Value<PgDateTime> updatedAt,
      Value<String?> notes,
      Value<int> rowid,
    });

class $$IssuedCertificatesTableFilterComposer
    extends Composer<_$CertificateDatabase, $IssuedCertificatesTable> {
  $$IssuedCertificatesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get certificateId => $composableBuilder(
    column: $table.certificateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get traineeUserId => $composableBuilder(
    column: $table.traineeUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get enrollmentId => $composableBuilder(
    column: $table.enrollmentId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get courseId => $composableBuilder(
    column: $table.courseId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get emissionApprovedAt => $composableBuilder(
    column: $table.emissionApprovedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get emissionApprovedByUserId => $composableBuilder(
    column: $table.emissionApprovedByUserId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get certificateBlobUrl => $composableBuilder(
    column: $table.certificateBlobUrl,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get verificationCode => $composableBuilder(
    column: $table.verificationCode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
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

class $$IssuedCertificatesTableOrderingComposer
    extends Composer<_$CertificateDatabase, $IssuedCertificatesTable> {
  $$IssuedCertificatesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get certificateId => $composableBuilder(
    column: $table.certificateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get traineeUserId => $composableBuilder(
    column: $table.traineeUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get enrollmentId => $composableBuilder(
    column: $table.enrollmentId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get courseId => $composableBuilder(
    column: $table.courseId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get emissionApprovedAt => $composableBuilder(
    column: $table.emissionApprovedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get emissionApprovedByUserId => $composableBuilder(
    column: $table.emissionApprovedByUserId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get issuedAt => $composableBuilder(
    column: $table.issuedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get certificateBlobUrl => $composableBuilder(
    column: $table.certificateBlobUrl,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get verificationCode => $composableBuilder(
    column: $table.verificationCode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
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

class $$IssuedCertificatesTableAnnotationComposer
    extends Composer<_$CertificateDatabase, $IssuedCertificatesTable> {
  $$IssuedCertificatesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get certificateId => $composableBuilder(
    column: $table.certificateId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get traineeUserId => $composableBuilder(
    column: $table.traineeUserId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get enrollmentId => $composableBuilder(
    column: $table.enrollmentId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get courseId =>
      $composableBuilder(column: $table.courseId, builder: (column) => column);

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<PgDateTime> get emissionApprovedAt => $composableBuilder(
    column: $table.emissionApprovedAt,
    builder: (column) => column,
  );

  GeneratedColumn<String> get emissionApprovedByUserId => $composableBuilder(
    column: $table.emissionApprovedByUserId,
    builder: (column) => column,
  );

  GeneratedColumn<PgDateTime> get issuedAt =>
      $composableBuilder(column: $table.issuedAt, builder: (column) => column);

  GeneratedColumn<String> get certificateBlobUrl => $composableBuilder(
    column: $table.certificateBlobUrl,
    builder: (column) => column,
  );

  GeneratedColumn<String> get verificationCode => $composableBuilder(
    column: $table.verificationCode,
    builder: (column) => column,
  );

  GeneratedColumn<PgDateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<PgDateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<PgDateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get notes =>
      $composableBuilder(column: $table.notes, builder: (column) => column);
}

class $$IssuedCertificatesTableTableManager
    extends
        RootTableManager<
          _$CertificateDatabase,
          $IssuedCertificatesTable,
          IssuedCertificate,
          $$IssuedCertificatesTableFilterComposer,
          $$IssuedCertificatesTableOrderingComposer,
          $$IssuedCertificatesTableAnnotationComposer,
          $$IssuedCertificatesTableCreateCompanionBuilder,
          $$IssuedCertificatesTableUpdateCompanionBuilder,
          (
            IssuedCertificate,
            BaseReferences<
              _$CertificateDatabase,
              $IssuedCertificatesTable,
              IssuedCertificate
            >,
          ),
          IssuedCertificate,
          PrefetchHooks Function()
        > {
  $$IssuedCertificatesTableTableManager(
    _$CertificateDatabase db,
    $IssuedCertificatesTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$IssuedCertificatesTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$IssuedCertificatesTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$IssuedCertificatesTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> certificateId = const Value.absent(),
                Value<String> traineeUserId = const Value.absent(),
                Value<String> enrollmentId = const Value.absent(),
                Value<String> courseId = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<PgDateTime?> emissionApprovedAt = const Value.absent(),
                Value<String?> emissionApprovedByUserId = const Value.absent(),
                Value<PgDateTime?> issuedAt = const Value.absent(),
                Value<String?> certificateBlobUrl = const Value.absent(),
                Value<String?> verificationCode = const Value.absent(),
                Value<PgDateTime?> expiresAt = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                Value<PgDateTime> updatedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IssuedCertificatesCompanion(
                certificateId: certificateId,
                traineeUserId: traineeUserId,
                enrollmentId: enrollmentId,
                courseId: courseId,
                status: status,
                emissionApprovedAt: emissionApprovedAt,
                emissionApprovedByUserId: emissionApprovedByUserId,
                issuedAt: issuedAt,
                certificateBlobUrl: certificateBlobUrl,
                verificationCode: verificationCode,
                expiresAt: expiresAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                notes: notes,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String certificateId,
                required String traineeUserId,
                required String enrollmentId,
                required String courseId,
                required String status,
                Value<PgDateTime?> emissionApprovedAt = const Value.absent(),
                Value<String?> emissionApprovedByUserId = const Value.absent(),
                Value<PgDateTime?> issuedAt = const Value.absent(),
                Value<String?> certificateBlobUrl = const Value.absent(),
                Value<String?> verificationCode = const Value.absent(),
                Value<PgDateTime?> expiresAt = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                Value<PgDateTime> updatedAt = const Value.absent(),
                Value<String?> notes = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => IssuedCertificatesCompanion.insert(
                certificateId: certificateId,
                traineeUserId: traineeUserId,
                enrollmentId: enrollmentId,
                courseId: courseId,
                status: status,
                emissionApprovedAt: emissionApprovedAt,
                emissionApprovedByUserId: emissionApprovedByUserId,
                issuedAt: issuedAt,
                certificateBlobUrl: certificateBlobUrl,
                verificationCode: verificationCode,
                expiresAt: expiresAt,
                createdAt: createdAt,
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

typedef $$IssuedCertificatesTableProcessedTableManager =
    ProcessedTableManager<
      _$CertificateDatabase,
      $IssuedCertificatesTable,
      IssuedCertificate,
      $$IssuedCertificatesTableFilterComposer,
      $$IssuedCertificatesTableOrderingComposer,
      $$IssuedCertificatesTableAnnotationComposer,
      $$IssuedCertificatesTableCreateCompanionBuilder,
      $$IssuedCertificatesTableUpdateCompanionBuilder,
      (
        IssuedCertificate,
        BaseReferences<
          _$CertificateDatabase,
          $IssuedCertificatesTable,
          IssuedCertificate
        >,
      ),
      IssuedCertificate,
      PrefetchHooks Function()
    >;
typedef $$ExternalCertificationLogsTableCreateCompanionBuilder =
    ExternalCertificationLogsCompanion Function({
      required String logId,
      required String certificateId,
      required String externalSystemName,
      required String actionType,
      Value<PgDateTime> actionTimestamp,
      required String status,
      Value<String?> externalReferenceId,
      Value<String?> responseDetails,
      Value<int> rowid,
    });
typedef $$ExternalCertificationLogsTableUpdateCompanionBuilder =
    ExternalCertificationLogsCompanion Function({
      Value<String> logId,
      Value<String> certificateId,
      Value<String> externalSystemName,
      Value<String> actionType,
      Value<PgDateTime> actionTimestamp,
      Value<String> status,
      Value<String?> externalReferenceId,
      Value<String?> responseDetails,
      Value<int> rowid,
    });

class $$ExternalCertificationLogsTableFilterComposer
    extends Composer<_$CertificateDatabase, $ExternalCertificationLogsTable> {
  $$ExternalCertificationLogsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get logId => $composableBuilder(
    column: $table.logId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get certificateId => $composableBuilder(
    column: $table.certificateId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalSystemName => $composableBuilder(
    column: $table.externalSystemName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get actionTimestamp => $composableBuilder(
    column: $table.actionTimestamp,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get externalReferenceId => $composableBuilder(
    column: $table.externalReferenceId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get responseDetails => $composableBuilder(
    column: $table.responseDetails,
    builder: (column) => ColumnFilters(column),
  );
}

class $$ExternalCertificationLogsTableOrderingComposer
    extends Composer<_$CertificateDatabase, $ExternalCertificationLogsTable> {
  $$ExternalCertificationLogsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get logId => $composableBuilder(
    column: $table.logId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get certificateId => $composableBuilder(
    column: $table.certificateId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalSystemName => $composableBuilder(
    column: $table.externalSystemName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get actionTimestamp => $composableBuilder(
    column: $table.actionTimestamp,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get externalReferenceId => $composableBuilder(
    column: $table.externalReferenceId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get responseDetails => $composableBuilder(
    column: $table.responseDetails,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ExternalCertificationLogsTableAnnotationComposer
    extends Composer<_$CertificateDatabase, $ExternalCertificationLogsTable> {
  $$ExternalCertificationLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get logId =>
      $composableBuilder(column: $table.logId, builder: (column) => column);

  GeneratedColumn<String> get certificateId => $composableBuilder(
    column: $table.certificateId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get externalSystemName => $composableBuilder(
    column: $table.externalSystemName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get actionType => $composableBuilder(
    column: $table.actionType,
    builder: (column) => column,
  );

  GeneratedColumn<PgDateTime> get actionTimestamp => $composableBuilder(
    column: $table.actionTimestamp,
    builder: (column) => column,
  );

  GeneratedColumn<String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<String> get externalReferenceId => $composableBuilder(
    column: $table.externalReferenceId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get responseDetails => $composableBuilder(
    column: $table.responseDetails,
    builder: (column) => column,
  );
}

class $$ExternalCertificationLogsTableTableManager
    extends
        RootTableManager<
          _$CertificateDatabase,
          $ExternalCertificationLogsTable,
          ExternalCertificationLog,
          $$ExternalCertificationLogsTableFilterComposer,
          $$ExternalCertificationLogsTableOrderingComposer,
          $$ExternalCertificationLogsTableAnnotationComposer,
          $$ExternalCertificationLogsTableCreateCompanionBuilder,
          $$ExternalCertificationLogsTableUpdateCompanionBuilder,
          (
            ExternalCertificationLog,
            BaseReferences<
              _$CertificateDatabase,
              $ExternalCertificationLogsTable,
              ExternalCertificationLog
            >,
          ),
          ExternalCertificationLog,
          PrefetchHooks Function()
        > {
  $$ExternalCertificationLogsTableTableManager(
    _$CertificateDatabase db,
    $ExternalCertificationLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$ExternalCertificationLogsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$ExternalCertificationLogsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$ExternalCertificationLogsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> logId = const Value.absent(),
                Value<String> certificateId = const Value.absent(),
                Value<String> externalSystemName = const Value.absent(),
                Value<String> actionType = const Value.absent(),
                Value<PgDateTime> actionTimestamp = const Value.absent(),
                Value<String> status = const Value.absent(),
                Value<String?> externalReferenceId = const Value.absent(),
                Value<String?> responseDetails = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExternalCertificationLogsCompanion(
                logId: logId,
                certificateId: certificateId,
                externalSystemName: externalSystemName,
                actionType: actionType,
                actionTimestamp: actionTimestamp,
                status: status,
                externalReferenceId: externalReferenceId,
                responseDetails: responseDetails,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String logId,
                required String certificateId,
                required String externalSystemName,
                required String actionType,
                Value<PgDateTime> actionTimestamp = const Value.absent(),
                required String status,
                Value<String?> externalReferenceId = const Value.absent(),
                Value<String?> responseDetails = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ExternalCertificationLogsCompanion.insert(
                logId: logId,
                certificateId: certificateId,
                externalSystemName: externalSystemName,
                actionType: actionType,
                actionTimestamp: actionTimestamp,
                status: status,
                externalReferenceId: externalReferenceId,
                responseDetails: responseDetails,
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

typedef $$ExternalCertificationLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$CertificateDatabase,
      $ExternalCertificationLogsTable,
      ExternalCertificationLog,
      $$ExternalCertificationLogsTableFilterComposer,
      $$ExternalCertificationLogsTableOrderingComposer,
      $$ExternalCertificationLogsTableAnnotationComposer,
      $$ExternalCertificationLogsTableCreateCompanionBuilder,
      $$ExternalCertificationLogsTableUpdateCompanionBuilder,
      (
        ExternalCertificationLog,
        BaseReferences<
          _$CertificateDatabase,
          $ExternalCertificationLogsTable,
          ExternalCertificationLog
        >,
      ),
      ExternalCertificationLog,
      PrefetchHooks Function()
    >;

class $CertificateDatabaseManager {
  final _$CertificateDatabase _db;
  $CertificateDatabaseManager(this._db);
  $$CertificateTemplatesTableTableManager get certificateTemplates =>
      $$CertificateTemplatesTableTableManager(_db, _db.certificateTemplates);
  $$IssuedCertificatesTableTableManager get issuedCertificates =>
      $$IssuedCertificatesTableTableManager(_db, _db.issuedCertificates);
  $$ExternalCertificationLogsTableTableManager get externalCertificationLogs =>
      $$ExternalCertificationLogsTableTableManager(
        _db,
        _db.externalCertificationLogs,
      );
}
