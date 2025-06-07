// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $UserAuthDataTable extends UserAuthData
    with TableInfo<$UserAuthDataTable, UserAuthDataEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $UserAuthDataTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _emailMeta = const VerificationMeta('email');
  @override
  late final GeneratedColumn<String> email = GeneratedColumn<String>(
    'email',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _roleMeta = const VerificationMeta('role');
  @override
  late final GeneratedColumn<String> role = GeneratedColumn<String>(
    'role',
    aliasedName,
    false,
    check: () => role.isIn(['formando', 'formador', 'gestor']),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _hashedPasswordMeta = const VerificationMeta(
    'hashedPassword',
  );
  @override
  late final GeneratedColumn<String> hashedPassword = GeneratedColumn<String>(
    'hashed_password',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isActiveMeta = const VerificationMeta(
    'isActive',
  );
  @override
  late final GeneratedColumn<bool> isActive = GeneratedColumn<bool>(
    'is_active',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultValue: const Constant(true),
  );
  static const VerificationMeta _passwordLastChangedAtMeta =
      const VerificationMeta('passwordLastChangedAt');
  @override
  late final GeneratedColumn<PgDateTime> passwordLastChangedAt =
      GeneratedColumn<PgDateTime>(
        'password_last_changed_at',
        aliasedName,
        true,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _failedLoginAttemptsMeta =
      const VerificationMeta('failedLoginAttempts');
  @override
  late final GeneratedColumn<int> failedLoginAttempts = GeneratedColumn<int>(
    'failed_login_attempts',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(0),
  );
  static const VerificationMeta _accountLockedUntilMeta =
      const VerificationMeta('accountLockedUntil');
  @override
  late final GeneratedColumn<PgDateTime> accountLockedUntil =
      GeneratedColumn<PgDateTime>(
        'account_locked_until',
        aliasedName,
        true,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _lastLoginAttemptAtMeta =
      const VerificationMeta('lastLoginAttemptAt');
  @override
  late final GeneratedColumn<PgDateTime> lastLoginAttemptAt =
      GeneratedColumn<PgDateTime>(
        'last_login_attempt_at',
        aliasedName,
        true,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _emailVerifiedAtMeta = const VerificationMeta(
    'emailVerifiedAt',
  );
  @override
  late final GeneratedColumn<PgDateTime> emailVerifiedAt =
      GeneratedColumn<PgDateTime>(
        'email_verified_at',
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
  @override
  List<GeneratedColumn> get $columns => [
    userId,
    email,
    role,
    hashedPassword,
    isActive,
    passwordLastChangedAt,
    failedLoginAttempts,
    accountLockedUntil,
    lastLoginAttemptAt,
    emailVerifiedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'user_auth_data';
  @override
  VerificationContext validateIntegrity(
    Insertable<UserAuthDataEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('email')) {
      context.handle(
        _emailMeta,
        email.isAcceptableOrUnknown(data['email']!, _emailMeta),
      );
    } else if (isInserting) {
      context.missing(_emailMeta);
    }
    if (data.containsKey('role')) {
      context.handle(
        _roleMeta,
        role.isAcceptableOrUnknown(data['role']!, _roleMeta),
      );
    } else if (isInserting) {
      context.missing(_roleMeta);
    }
    if (data.containsKey('hashed_password')) {
      context.handle(
        _hashedPasswordMeta,
        hashedPassword.isAcceptableOrUnknown(
          data['hashed_password']!,
          _hashedPasswordMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_hashedPasswordMeta);
    }
    if (data.containsKey('is_active')) {
      context.handle(
        _isActiveMeta,
        isActive.isAcceptableOrUnknown(data['is_active']!, _isActiveMeta),
      );
    }
    if (data.containsKey('password_last_changed_at')) {
      context.handle(
        _passwordLastChangedAtMeta,
        passwordLastChangedAt.isAcceptableOrUnknown(
          data['password_last_changed_at']!,
          _passwordLastChangedAtMeta,
        ),
      );
    }
    if (data.containsKey('failed_login_attempts')) {
      context.handle(
        _failedLoginAttemptsMeta,
        failedLoginAttempts.isAcceptableOrUnknown(
          data['failed_login_attempts']!,
          _failedLoginAttemptsMeta,
        ),
      );
    }
    if (data.containsKey('account_locked_until')) {
      context.handle(
        _accountLockedUntilMeta,
        accountLockedUntil.isAcceptableOrUnknown(
          data['account_locked_until']!,
          _accountLockedUntilMeta,
        ),
      );
    }
    if (data.containsKey('last_login_attempt_at')) {
      context.handle(
        _lastLoginAttemptAtMeta,
        lastLoginAttemptAt.isAcceptableOrUnknown(
          data['last_login_attempt_at']!,
          _lastLoginAttemptAtMeta,
        ),
      );
    }
    if (data.containsKey('email_verified_at')) {
      context.handle(
        _emailVerifiedAtMeta,
        emailVerifiedAt.isAcceptableOrUnknown(
          data['email_verified_at']!,
          _emailVerifiedAtMeta,
        ),
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
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {userId};
  @override
  UserAuthDataEntry map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return UserAuthDataEntry(
      userId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}user_id'],
          )!,
      email:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}email'],
          )!,
      role:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}role'],
          )!,
      hashedPassword:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}hashed_password'],
          )!,
      isActive:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_active'],
          )!,
      passwordLastChangedAt: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}password_last_changed_at'],
      ),
      failedLoginAttempts:
          attachedDatabase.typeMapping.read(
            DriftSqlType.int,
            data['${effectivePrefix}failed_login_attempts'],
          )!,
      accountLockedUntil: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}account_locked_until'],
      ),
      lastLoginAttemptAt: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}last_login_attempt_at'],
      ),
      emailVerifiedAt: attachedDatabase.typeMapping.read(
        PgTypes.timestampWithTimezone,
        data['${effectivePrefix}email_verified_at'],
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
    );
  }

  @override
  $UserAuthDataTable createAlias(String alias) {
    return $UserAuthDataTable(attachedDatabase, alias);
  }
}

class UserAuthDataEntry extends DataClass
    implements Insertable<UserAuthDataEntry> {
  /// Primary key - unique user identifier
  final String userId;

  /// User email address - must be unique
  final String email;

  /// User role in the system
  final String role;

  /// Hashed password (BCrypt hash)
  final String hashedPassword;

  /// Account active status
  final bool isActive;

  /// Timestamp of last password change
  final PgDateTime? passwordLastChangedAt;

  /// Number of consecutive failed login attempts
  final int failedLoginAttempts;

  /// Timestamp until which account is locked (nullable)
  final PgDateTime? accountLockedUntil;

  /// Timestamp of last login attempt (nullable)
  final PgDateTime? lastLoginAttemptAt;

  /// Timestamp when email was verified (nullable)
  final PgDateTime? emailVerifiedAt;

  /// Record creation timestamp
  final PgDateTime createdAt;

  /// Record last update timestamp
  final PgDateTime updatedAt;
  const UserAuthDataEntry({
    required this.userId,
    required this.email,
    required this.role,
    required this.hashedPassword,
    required this.isActive,
    this.passwordLastChangedAt,
    required this.failedLoginAttempts,
    this.accountLockedUntil,
    this.lastLoginAttemptAt,
    this.emailVerifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['user_id'] = Variable<String>(userId);
    map['email'] = Variable<String>(email);
    map['role'] = Variable<String>(role);
    map['hashed_password'] = Variable<String>(hashedPassword);
    map['is_active'] = Variable<bool>(isActive);
    if (!nullToAbsent || passwordLastChangedAt != null) {
      map['password_last_changed_at'] = Variable<PgDateTime>(
        passwordLastChangedAt,
        PgTypes.timestampWithTimezone,
      );
    }
    map['failed_login_attempts'] = Variable<int>(failedLoginAttempts);
    if (!nullToAbsent || accountLockedUntil != null) {
      map['account_locked_until'] = Variable<PgDateTime>(
        accountLockedUntil,
        PgTypes.timestampWithTimezone,
      );
    }
    if (!nullToAbsent || lastLoginAttemptAt != null) {
      map['last_login_attempt_at'] = Variable<PgDateTime>(
        lastLoginAttemptAt,
        PgTypes.timestampWithTimezone,
      );
    }
    if (!nullToAbsent || emailVerifiedAt != null) {
      map['email_verified_at'] = Variable<PgDateTime>(
        emailVerifiedAt,
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
    return map;
  }

  UserAuthDataCompanion toCompanion(bool nullToAbsent) {
    return UserAuthDataCompanion(
      userId: Value(userId),
      email: Value(email),
      role: Value(role),
      hashedPassword: Value(hashedPassword),
      isActive: Value(isActive),
      passwordLastChangedAt:
          passwordLastChangedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(passwordLastChangedAt),
      failedLoginAttempts: Value(failedLoginAttempts),
      accountLockedUntil:
          accountLockedUntil == null && nullToAbsent
              ? const Value.absent()
              : Value(accountLockedUntil),
      lastLoginAttemptAt:
          lastLoginAttemptAt == null && nullToAbsent
              ? const Value.absent()
              : Value(lastLoginAttemptAt),
      emailVerifiedAt:
          emailVerifiedAt == null && nullToAbsent
              ? const Value.absent()
              : Value(emailVerifiedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory UserAuthDataEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return UserAuthDataEntry(
      userId: serializer.fromJson<String>(json['userId']),
      email: serializer.fromJson<String>(json['email']),
      role: serializer.fromJson<String>(json['role']),
      hashedPassword: serializer.fromJson<String>(json['hashedPassword']),
      isActive: serializer.fromJson<bool>(json['isActive']),
      passwordLastChangedAt: serializer.fromJson<PgDateTime?>(
        json['passwordLastChangedAt'],
      ),
      failedLoginAttempts: serializer.fromJson<int>(
        json['failedLoginAttempts'],
      ),
      accountLockedUntil: serializer.fromJson<PgDateTime?>(
        json['accountLockedUntil'],
      ),
      lastLoginAttemptAt: serializer.fromJson<PgDateTime?>(
        json['lastLoginAttemptAt'],
      ),
      emailVerifiedAt: serializer.fromJson<PgDateTime?>(
        json['emailVerifiedAt'],
      ),
      createdAt: serializer.fromJson<PgDateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<PgDateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'userId': serializer.toJson<String>(userId),
      'email': serializer.toJson<String>(email),
      'role': serializer.toJson<String>(role),
      'hashedPassword': serializer.toJson<String>(hashedPassword),
      'isActive': serializer.toJson<bool>(isActive),
      'passwordLastChangedAt': serializer.toJson<PgDateTime?>(
        passwordLastChangedAt,
      ),
      'failedLoginAttempts': serializer.toJson<int>(failedLoginAttempts),
      'accountLockedUntil': serializer.toJson<PgDateTime?>(accountLockedUntil),
      'lastLoginAttemptAt': serializer.toJson<PgDateTime?>(lastLoginAttemptAt),
      'emailVerifiedAt': serializer.toJson<PgDateTime?>(emailVerifiedAt),
      'createdAt': serializer.toJson<PgDateTime>(createdAt),
      'updatedAt': serializer.toJson<PgDateTime>(updatedAt),
    };
  }

  UserAuthDataEntry copyWith({
    String? userId,
    String? email,
    String? role,
    String? hashedPassword,
    bool? isActive,
    Value<PgDateTime?> passwordLastChangedAt = const Value.absent(),
    int? failedLoginAttempts,
    Value<PgDateTime?> accountLockedUntil = const Value.absent(),
    Value<PgDateTime?> lastLoginAttemptAt = const Value.absent(),
    Value<PgDateTime?> emailVerifiedAt = const Value.absent(),
    PgDateTime? createdAt,
    PgDateTime? updatedAt,
  }) => UserAuthDataEntry(
    userId: userId ?? this.userId,
    email: email ?? this.email,
    role: role ?? this.role,
    hashedPassword: hashedPassword ?? this.hashedPassword,
    isActive: isActive ?? this.isActive,
    passwordLastChangedAt:
        passwordLastChangedAt.present
            ? passwordLastChangedAt.value
            : this.passwordLastChangedAt,
    failedLoginAttempts: failedLoginAttempts ?? this.failedLoginAttempts,
    accountLockedUntil:
        accountLockedUntil.present
            ? accountLockedUntil.value
            : this.accountLockedUntil,
    lastLoginAttemptAt:
        lastLoginAttemptAt.present
            ? lastLoginAttemptAt.value
            : this.lastLoginAttemptAt,
    emailVerifiedAt:
        emailVerifiedAt.present ? emailVerifiedAt.value : this.emailVerifiedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  UserAuthDataEntry copyWithCompanion(UserAuthDataCompanion data) {
    return UserAuthDataEntry(
      userId: data.userId.present ? data.userId.value : this.userId,
      email: data.email.present ? data.email.value : this.email,
      role: data.role.present ? data.role.value : this.role,
      hashedPassword:
          data.hashedPassword.present
              ? data.hashedPassword.value
              : this.hashedPassword,
      isActive: data.isActive.present ? data.isActive.value : this.isActive,
      passwordLastChangedAt:
          data.passwordLastChangedAt.present
              ? data.passwordLastChangedAt.value
              : this.passwordLastChangedAt,
      failedLoginAttempts:
          data.failedLoginAttempts.present
              ? data.failedLoginAttempts.value
              : this.failedLoginAttempts,
      accountLockedUntil:
          data.accountLockedUntil.present
              ? data.accountLockedUntil.value
              : this.accountLockedUntil,
      lastLoginAttemptAt:
          data.lastLoginAttemptAt.present
              ? data.lastLoginAttemptAt.value
              : this.lastLoginAttemptAt,
      emailVerifiedAt:
          data.emailVerifiedAt.present
              ? data.emailVerifiedAt.value
              : this.emailVerifiedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('UserAuthDataEntry(')
          ..write('userId: $userId, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('hashedPassword: $hashedPassword, ')
          ..write('isActive: $isActive, ')
          ..write('passwordLastChangedAt: $passwordLastChangedAt, ')
          ..write('failedLoginAttempts: $failedLoginAttempts, ')
          ..write('accountLockedUntil: $accountLockedUntil, ')
          ..write('lastLoginAttemptAt: $lastLoginAttemptAt, ')
          ..write('emailVerifiedAt: $emailVerifiedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    userId,
    email,
    role,
    hashedPassword,
    isActive,
    passwordLastChangedAt,
    failedLoginAttempts,
    accountLockedUntil,
    lastLoginAttemptAt,
    emailVerifiedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserAuthDataEntry &&
          other.userId == this.userId &&
          other.email == this.email &&
          other.role == this.role &&
          other.hashedPassword == this.hashedPassword &&
          other.isActive == this.isActive &&
          other.passwordLastChangedAt == this.passwordLastChangedAt &&
          other.failedLoginAttempts == this.failedLoginAttempts &&
          other.accountLockedUntil == this.accountLockedUntil &&
          other.lastLoginAttemptAt == this.lastLoginAttemptAt &&
          other.emailVerifiedAt == this.emailVerifiedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class UserAuthDataCompanion extends UpdateCompanion<UserAuthDataEntry> {
  final Value<String> userId;
  final Value<String> email;
  final Value<String> role;
  final Value<String> hashedPassword;
  final Value<bool> isActive;
  final Value<PgDateTime?> passwordLastChangedAt;
  final Value<int> failedLoginAttempts;
  final Value<PgDateTime?> accountLockedUntil;
  final Value<PgDateTime?> lastLoginAttemptAt;
  final Value<PgDateTime?> emailVerifiedAt;
  final Value<PgDateTime> createdAt;
  final Value<PgDateTime> updatedAt;
  final Value<int> rowid;
  const UserAuthDataCompanion({
    this.userId = const Value.absent(),
    this.email = const Value.absent(),
    this.role = const Value.absent(),
    this.hashedPassword = const Value.absent(),
    this.isActive = const Value.absent(),
    this.passwordLastChangedAt = const Value.absent(),
    this.failedLoginAttempts = const Value.absent(),
    this.accountLockedUntil = const Value.absent(),
    this.lastLoginAttemptAt = const Value.absent(),
    this.emailVerifiedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  UserAuthDataCompanion.insert({
    required String userId,
    required String email,
    required String role,
    required String hashedPassword,
    this.isActive = const Value.absent(),
    this.passwordLastChangedAt = const Value.absent(),
    this.failedLoginAttempts = const Value.absent(),
    this.accountLockedUntil = const Value.absent(),
    this.lastLoginAttemptAt = const Value.absent(),
    this.emailVerifiedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : userId = Value(userId),
       email = Value(email),
       role = Value(role),
       hashedPassword = Value(hashedPassword);
  static Insertable<UserAuthDataEntry> custom({
    Expression<String>? userId,
    Expression<String>? email,
    Expression<String>? role,
    Expression<String>? hashedPassword,
    Expression<bool>? isActive,
    Expression<PgDateTime>? passwordLastChangedAt,
    Expression<int>? failedLoginAttempts,
    Expression<PgDateTime>? accountLockedUntil,
    Expression<PgDateTime>? lastLoginAttemptAt,
    Expression<PgDateTime>? emailVerifiedAt,
    Expression<PgDateTime>? createdAt,
    Expression<PgDateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (userId != null) 'user_id': userId,
      if (email != null) 'email': email,
      if (role != null) 'role': role,
      if (hashedPassword != null) 'hashed_password': hashedPassword,
      if (isActive != null) 'is_active': isActive,
      if (passwordLastChangedAt != null)
        'password_last_changed_at': passwordLastChangedAt,
      if (failedLoginAttempts != null)
        'failed_login_attempts': failedLoginAttempts,
      if (accountLockedUntil != null)
        'account_locked_until': accountLockedUntil,
      if (lastLoginAttemptAt != null)
        'last_login_attempt_at': lastLoginAttemptAt,
      if (emailVerifiedAt != null) 'email_verified_at': emailVerifiedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  UserAuthDataCompanion copyWith({
    Value<String>? userId,
    Value<String>? email,
    Value<String>? role,
    Value<String>? hashedPassword,
    Value<bool>? isActive,
    Value<PgDateTime?>? passwordLastChangedAt,
    Value<int>? failedLoginAttempts,
    Value<PgDateTime?>? accountLockedUntil,
    Value<PgDateTime?>? lastLoginAttemptAt,
    Value<PgDateTime?>? emailVerifiedAt,
    Value<PgDateTime>? createdAt,
    Value<PgDateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return UserAuthDataCompanion(
      userId: userId ?? this.userId,
      email: email ?? this.email,
      role: role ?? this.role,
      hashedPassword: hashedPassword ?? this.hashedPassword,
      isActive: isActive ?? this.isActive,
      passwordLastChangedAt:
          passwordLastChangedAt ?? this.passwordLastChangedAt,
      failedLoginAttempts: failedLoginAttempts ?? this.failedLoginAttempts,
      accountLockedUntil: accountLockedUntil ?? this.accountLockedUntil,
      lastLoginAttemptAt: lastLoginAttemptAt ?? this.lastLoginAttemptAt,
      emailVerifiedAt: emailVerifiedAt ?? this.emailVerifiedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (email.present) {
      map['email'] = Variable<String>(email.value);
    }
    if (role.present) {
      map['role'] = Variable<String>(role.value);
    }
    if (hashedPassword.present) {
      map['hashed_password'] = Variable<String>(hashedPassword.value);
    }
    if (isActive.present) {
      map['is_active'] = Variable<bool>(isActive.value);
    }
    if (passwordLastChangedAt.present) {
      map['password_last_changed_at'] = Variable<PgDateTime>(
        passwordLastChangedAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (failedLoginAttempts.present) {
      map['failed_login_attempts'] = Variable<int>(failedLoginAttempts.value);
    }
    if (accountLockedUntil.present) {
      map['account_locked_until'] = Variable<PgDateTime>(
        accountLockedUntil.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (lastLoginAttemptAt.present) {
      map['last_login_attempt_at'] = Variable<PgDateTime>(
        lastLoginAttemptAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (emailVerifiedAt.present) {
      map['email_verified_at'] = Variable<PgDateTime>(
        emailVerifiedAt.value,
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
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('UserAuthDataCompanion(')
          ..write('userId: $userId, ')
          ..write('email: $email, ')
          ..write('role: $role, ')
          ..write('hashedPassword: $hashedPassword, ')
          ..write('isActive: $isActive, ')
          ..write('passwordLastChangedAt: $passwordLastChangedAt, ')
          ..write('failedLoginAttempts: $failedLoginAttempts, ')
          ..write('accountLockedUntil: $accountLockedUntil, ')
          ..write('lastLoginAttemptAt: $lastLoginAttemptAt, ')
          ..write('emailVerifiedAt: $emailVerifiedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $PasswordResetTokensTable extends PasswordResetTokens
    with TableInfo<$PasswordResetTokensTable, PasswordResetTokenEntry> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $PasswordResetTokensTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _tokenMeta = const VerificationMeta('token');
  @override
  late final GeneratedColumn<String> token = GeneratedColumn<String>(
    'token',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _userIdMeta = const VerificationMeta('userId');
  @override
  late final GeneratedColumn<String> userId = GeneratedColumn<String>(
    'user_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _expiresAtMeta = const VerificationMeta(
    'expiresAt',
  );
  @override
  late final GeneratedColumn<PgDateTime> expiresAt =
      GeneratedColumn<PgDateTime>(
        'expires_at',
        aliasedName,
        false,
        type: PgTypes.timestampWithTimezone,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _isUsedMeta = const VerificationMeta('isUsed');
  @override
  late final GeneratedColumn<bool> isUsed = GeneratedColumn<bool>(
    'is_used',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultValue: const Constant(false),
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
    token,
    userId,
    expiresAt,
    isUsed,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'password_reset_tokens';
  @override
  VerificationContext validateIntegrity(
    Insertable<PasswordResetTokenEntry> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('token')) {
      context.handle(
        _tokenMeta,
        token.isAcceptableOrUnknown(data['token']!, _tokenMeta),
      );
    } else if (isInserting) {
      context.missing(_tokenMeta);
    }
    if (data.containsKey('user_id')) {
      context.handle(
        _userIdMeta,
        userId.isAcceptableOrUnknown(data['user_id']!, _userIdMeta),
      );
    } else if (isInserting) {
      context.missing(_userIdMeta);
    }
    if (data.containsKey('expires_at')) {
      context.handle(
        _expiresAtMeta,
        expiresAt.isAcceptableOrUnknown(data['expires_at']!, _expiresAtMeta),
      );
    } else if (isInserting) {
      context.missing(_expiresAtMeta);
    }
    if (data.containsKey('is_used')) {
      context.handle(
        _isUsedMeta,
        isUsed.isAcceptableOrUnknown(data['is_used']!, _isUsedMeta),
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
  Set<GeneratedColumn> get $primaryKey => {token};
  @override
  PasswordResetTokenEntry map(
    Map<String, dynamic> data, {
    String? tablePrefix,
  }) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return PasswordResetTokenEntry(
      token:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}token'],
          )!,
      userId:
          attachedDatabase.typeMapping.read(
            DriftSqlType.string,
            data['${effectivePrefix}user_id'],
          )!,
      expiresAt:
          attachedDatabase.typeMapping.read(
            PgTypes.timestampWithTimezone,
            data['${effectivePrefix}expires_at'],
          )!,
      isUsed:
          attachedDatabase.typeMapping.read(
            DriftSqlType.bool,
            data['${effectivePrefix}is_used'],
          )!,
      createdAt:
          attachedDatabase.typeMapping.read(
            PgTypes.timestampWithTimezone,
            data['${effectivePrefix}created_at'],
          )!,
    );
  }

  @override
  $PasswordResetTokensTable createAlias(String alias) {
    return $PasswordResetTokensTable(attachedDatabase, alias);
  }
}

class PasswordResetTokenEntry extends DataClass
    implements Insertable<PasswordResetTokenEntry> {
  /// Unique token identifier
  final String token;

  /// Associated user ID
  final String userId;

  /// Token expiration timestamp
  final PgDateTime expiresAt;

  /// Whether token has been used
  final bool isUsed;

  /// Token creation timestamp
  final PgDateTime createdAt;
  const PasswordResetTokenEntry({
    required this.token,
    required this.userId,
    required this.expiresAt,
    required this.isUsed,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['token'] = Variable<String>(token);
    map['user_id'] = Variable<String>(userId);
    map['expires_at'] = Variable<PgDateTime>(
      expiresAt,
      PgTypes.timestampWithTimezone,
    );
    map['is_used'] = Variable<bool>(isUsed);
    map['created_at'] = Variable<PgDateTime>(
      createdAt,
      PgTypes.timestampWithTimezone,
    );
    return map;
  }

  PasswordResetTokensCompanion toCompanion(bool nullToAbsent) {
    return PasswordResetTokensCompanion(
      token: Value(token),
      userId: Value(userId),
      expiresAt: Value(expiresAt),
      isUsed: Value(isUsed),
      createdAt: Value(createdAt),
    );
  }

  factory PasswordResetTokenEntry.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return PasswordResetTokenEntry(
      token: serializer.fromJson<String>(json['token']),
      userId: serializer.fromJson<String>(json['userId']),
      expiresAt: serializer.fromJson<PgDateTime>(json['expiresAt']),
      isUsed: serializer.fromJson<bool>(json['isUsed']),
      createdAt: serializer.fromJson<PgDateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'token': serializer.toJson<String>(token),
      'userId': serializer.toJson<String>(userId),
      'expiresAt': serializer.toJson<PgDateTime>(expiresAt),
      'isUsed': serializer.toJson<bool>(isUsed),
      'createdAt': serializer.toJson<PgDateTime>(createdAt),
    };
  }

  PasswordResetTokenEntry copyWith({
    String? token,
    String? userId,
    PgDateTime? expiresAt,
    bool? isUsed,
    PgDateTime? createdAt,
  }) => PasswordResetTokenEntry(
    token: token ?? this.token,
    userId: userId ?? this.userId,
    expiresAt: expiresAt ?? this.expiresAt,
    isUsed: isUsed ?? this.isUsed,
    createdAt: createdAt ?? this.createdAt,
  );
  PasswordResetTokenEntry copyWithCompanion(PasswordResetTokensCompanion data) {
    return PasswordResetTokenEntry(
      token: data.token.present ? data.token.value : this.token,
      userId: data.userId.present ? data.userId.value : this.userId,
      expiresAt: data.expiresAt.present ? data.expiresAt.value : this.expiresAt,
      isUsed: data.isUsed.present ? data.isUsed.value : this.isUsed,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('PasswordResetTokenEntry(')
          ..write('token: $token, ')
          ..write('userId: $userId, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('isUsed: $isUsed, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(token, userId, expiresAt, isUsed, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is PasswordResetTokenEntry &&
          other.token == this.token &&
          other.userId == this.userId &&
          other.expiresAt == this.expiresAt &&
          other.isUsed == this.isUsed &&
          other.createdAt == this.createdAt);
}

class PasswordResetTokensCompanion
    extends UpdateCompanion<PasswordResetTokenEntry> {
  final Value<String> token;
  final Value<String> userId;
  final Value<PgDateTime> expiresAt;
  final Value<bool> isUsed;
  final Value<PgDateTime> createdAt;
  final Value<int> rowid;
  const PasswordResetTokensCompanion({
    this.token = const Value.absent(),
    this.userId = const Value.absent(),
    this.expiresAt = const Value.absent(),
    this.isUsed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  PasswordResetTokensCompanion.insert({
    required String token,
    required String userId,
    required PgDateTime expiresAt,
    this.isUsed = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : token = Value(token),
       userId = Value(userId),
       expiresAt = Value(expiresAt);
  static Insertable<PasswordResetTokenEntry> custom({
    Expression<String>? token,
    Expression<String>? userId,
    Expression<PgDateTime>? expiresAt,
    Expression<bool>? isUsed,
    Expression<PgDateTime>? createdAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (token != null) 'token': token,
      if (userId != null) 'user_id': userId,
      if (expiresAt != null) 'expires_at': expiresAt,
      if (isUsed != null) 'is_used': isUsed,
      if (createdAt != null) 'created_at': createdAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  PasswordResetTokensCompanion copyWith({
    Value<String>? token,
    Value<String>? userId,
    Value<PgDateTime>? expiresAt,
    Value<bool>? isUsed,
    Value<PgDateTime>? createdAt,
    Value<int>? rowid,
  }) {
    return PasswordResetTokensCompanion(
      token: token ?? this.token,
      userId: userId ?? this.userId,
      expiresAt: expiresAt ?? this.expiresAt,
      isUsed: isUsed ?? this.isUsed,
      createdAt: createdAt ?? this.createdAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (token.present) {
      map['token'] = Variable<String>(token.value);
    }
    if (userId.present) {
      map['user_id'] = Variable<String>(userId.value);
    }
    if (expiresAt.present) {
      map['expires_at'] = Variable<PgDateTime>(
        expiresAt.value,
        PgTypes.timestampWithTimezone,
      );
    }
    if (isUsed.present) {
      map['is_used'] = Variable<bool>(isUsed.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<PgDateTime>(
        createdAt.value,
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
    return (StringBuffer('PasswordResetTokensCompanion(')
          ..write('token: $token, ')
          ..write('userId: $userId, ')
          ..write('expiresAt: $expiresAt, ')
          ..write('isUsed: $isUsed, ')
          ..write('createdAt: $createdAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AuthDatabase extends GeneratedDatabase {
  _$AuthDatabase(QueryExecutor e) : super(e);
  $AuthDatabaseManager get managers => $AuthDatabaseManager(this);
  late final $UserAuthDataTable userAuthData = $UserAuthDataTable(this);
  late final $PasswordResetTokensTable passwordResetTokens =
      $PasswordResetTokensTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    userAuthData,
    passwordResetTokens,
  ];
}

typedef $$UserAuthDataTableCreateCompanionBuilder =
    UserAuthDataCompanion Function({
      required String userId,
      required String email,
      required String role,
      required String hashedPassword,
      Value<bool> isActive,
      Value<PgDateTime?> passwordLastChangedAt,
      Value<int> failedLoginAttempts,
      Value<PgDateTime?> accountLockedUntil,
      Value<PgDateTime?> lastLoginAttemptAt,
      Value<PgDateTime?> emailVerifiedAt,
      Value<PgDateTime> createdAt,
      Value<PgDateTime> updatedAt,
      Value<int> rowid,
    });
typedef $$UserAuthDataTableUpdateCompanionBuilder =
    UserAuthDataCompanion Function({
      Value<String> userId,
      Value<String> email,
      Value<String> role,
      Value<String> hashedPassword,
      Value<bool> isActive,
      Value<PgDateTime?> passwordLastChangedAt,
      Value<int> failedLoginAttempts,
      Value<PgDateTime?> accountLockedUntil,
      Value<PgDateTime?> lastLoginAttemptAt,
      Value<PgDateTime?> emailVerifiedAt,
      Value<PgDateTime> createdAt,
      Value<PgDateTime> updatedAt,
      Value<int> rowid,
    });

class $$UserAuthDataTableFilterComposer
    extends Composer<_$AuthDatabase, $UserAuthDataTable> {
  $$UserAuthDataTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get hashedPassword => $composableBuilder(
    column: $table.hashedPassword,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get passwordLastChangedAt => $composableBuilder(
    column: $table.passwordLastChangedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get failedLoginAttempts => $composableBuilder(
    column: $table.failedLoginAttempts,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get accountLockedUntil => $composableBuilder(
    column: $table.accountLockedUntil,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get lastLoginAttemptAt => $composableBuilder(
    column: $table.lastLoginAttemptAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get emailVerifiedAt => $composableBuilder(
    column: $table.emailVerifiedAt,
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

class $$UserAuthDataTableOrderingComposer
    extends Composer<_$AuthDatabase, $UserAuthDataTable> {
  $$UserAuthDataTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get email => $composableBuilder(
    column: $table.email,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get role => $composableBuilder(
    column: $table.role,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get hashedPassword => $composableBuilder(
    column: $table.hashedPassword,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isActive => $composableBuilder(
    column: $table.isActive,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get passwordLastChangedAt => $composableBuilder(
    column: $table.passwordLastChangedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get failedLoginAttempts => $composableBuilder(
    column: $table.failedLoginAttempts,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get accountLockedUntil => $composableBuilder(
    column: $table.accountLockedUntil,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get lastLoginAttemptAt => $composableBuilder(
    column: $table.lastLoginAttemptAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get emailVerifiedAt => $composableBuilder(
    column: $table.emailVerifiedAt,
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

class $$UserAuthDataTableAnnotationComposer
    extends Composer<_$AuthDatabase, $UserAuthDataTable> {
  $$UserAuthDataTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<String> get email =>
      $composableBuilder(column: $table.email, builder: (column) => column);

  GeneratedColumn<String> get role =>
      $composableBuilder(column: $table.role, builder: (column) => column);

  GeneratedColumn<String> get hashedPassword => $composableBuilder(
    column: $table.hashedPassword,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isActive =>
      $composableBuilder(column: $table.isActive, builder: (column) => column);

  GeneratedColumn<PgDateTime> get passwordLastChangedAt => $composableBuilder(
    column: $table.passwordLastChangedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get failedLoginAttempts => $composableBuilder(
    column: $table.failedLoginAttempts,
    builder: (column) => column,
  );

  GeneratedColumn<PgDateTime> get accountLockedUntil => $composableBuilder(
    column: $table.accountLockedUntil,
    builder: (column) => column,
  );

  GeneratedColumn<PgDateTime> get lastLoginAttemptAt => $composableBuilder(
    column: $table.lastLoginAttemptAt,
    builder: (column) => column,
  );

  GeneratedColumn<PgDateTime> get emailVerifiedAt => $composableBuilder(
    column: $table.emailVerifiedAt,
    builder: (column) => column,
  );

  GeneratedColumn<PgDateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<PgDateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$UserAuthDataTableTableManager
    extends
        RootTableManager<
          _$AuthDatabase,
          $UserAuthDataTable,
          UserAuthDataEntry,
          $$UserAuthDataTableFilterComposer,
          $$UserAuthDataTableOrderingComposer,
          $$UserAuthDataTableAnnotationComposer,
          $$UserAuthDataTableCreateCompanionBuilder,
          $$UserAuthDataTableUpdateCompanionBuilder,
          (
            UserAuthDataEntry,
            BaseReferences<
              _$AuthDatabase,
              $UserAuthDataTable,
              UserAuthDataEntry
            >,
          ),
          UserAuthDataEntry,
          PrefetchHooks Function()
        > {
  $$UserAuthDataTableTableManager(_$AuthDatabase db, $UserAuthDataTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$UserAuthDataTableFilterComposer($db: db, $table: table),
          createOrderingComposer:
              () => $$UserAuthDataTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer:
              () =>
                  $$UserAuthDataTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> userId = const Value.absent(),
                Value<String> email = const Value.absent(),
                Value<String> role = const Value.absent(),
                Value<String> hashedPassword = const Value.absent(),
                Value<bool> isActive = const Value.absent(),
                Value<PgDateTime?> passwordLastChangedAt = const Value.absent(),
                Value<int> failedLoginAttempts = const Value.absent(),
                Value<PgDateTime?> accountLockedUntil = const Value.absent(),
                Value<PgDateTime?> lastLoginAttemptAt = const Value.absent(),
                Value<PgDateTime?> emailVerifiedAt = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                Value<PgDateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserAuthDataCompanion(
                userId: userId,
                email: email,
                role: role,
                hashedPassword: hashedPassword,
                isActive: isActive,
                passwordLastChangedAt: passwordLastChangedAt,
                failedLoginAttempts: failedLoginAttempts,
                accountLockedUntil: accountLockedUntil,
                lastLoginAttemptAt: lastLoginAttemptAt,
                emailVerifiedAt: emailVerifiedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String userId,
                required String email,
                required String role,
                required String hashedPassword,
                Value<bool> isActive = const Value.absent(),
                Value<PgDateTime?> passwordLastChangedAt = const Value.absent(),
                Value<int> failedLoginAttempts = const Value.absent(),
                Value<PgDateTime?> accountLockedUntil = const Value.absent(),
                Value<PgDateTime?> lastLoginAttemptAt = const Value.absent(),
                Value<PgDateTime?> emailVerifiedAt = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                Value<PgDateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => UserAuthDataCompanion.insert(
                userId: userId,
                email: email,
                role: role,
                hashedPassword: hashedPassword,
                isActive: isActive,
                passwordLastChangedAt: passwordLastChangedAt,
                failedLoginAttempts: failedLoginAttempts,
                accountLockedUntil: accountLockedUntil,
                lastLoginAttemptAt: lastLoginAttemptAt,
                emailVerifiedAt: emailVerifiedAt,
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

typedef $$UserAuthDataTableProcessedTableManager =
    ProcessedTableManager<
      _$AuthDatabase,
      $UserAuthDataTable,
      UserAuthDataEntry,
      $$UserAuthDataTableFilterComposer,
      $$UserAuthDataTableOrderingComposer,
      $$UserAuthDataTableAnnotationComposer,
      $$UserAuthDataTableCreateCompanionBuilder,
      $$UserAuthDataTableUpdateCompanionBuilder,
      (
        UserAuthDataEntry,
        BaseReferences<_$AuthDatabase, $UserAuthDataTable, UserAuthDataEntry>,
      ),
      UserAuthDataEntry,
      PrefetchHooks Function()
    >;
typedef $$PasswordResetTokensTableCreateCompanionBuilder =
    PasswordResetTokensCompanion Function({
      required String token,
      required String userId,
      required PgDateTime expiresAt,
      Value<bool> isUsed,
      Value<PgDateTime> createdAt,
      Value<int> rowid,
    });
typedef $$PasswordResetTokensTableUpdateCompanionBuilder =
    PasswordResetTokensCompanion Function({
      Value<String> token,
      Value<String> userId,
      Value<PgDateTime> expiresAt,
      Value<bool> isUsed,
      Value<PgDateTime> createdAt,
      Value<int> rowid,
    });

class $$PasswordResetTokensTableFilterComposer
    extends Composer<_$AuthDatabase, $PasswordResetTokensTable> {
  $$PasswordResetTokensTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isUsed => $composableBuilder(
    column: $table.isUsed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$PasswordResetTokensTableOrderingComposer
    extends Composer<_$AuthDatabase, $PasswordResetTokensTable> {
  $$PasswordResetTokensTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get token => $composableBuilder(
    column: $table.token,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get userId => $composableBuilder(
    column: $table.userId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get expiresAt => $composableBuilder(
    column: $table.expiresAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isUsed => $composableBuilder(
    column: $table.isUsed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<PgDateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$PasswordResetTokensTableAnnotationComposer
    extends Composer<_$AuthDatabase, $PasswordResetTokensTable> {
  $$PasswordResetTokensTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get token =>
      $composableBuilder(column: $table.token, builder: (column) => column);

  GeneratedColumn<String> get userId =>
      $composableBuilder(column: $table.userId, builder: (column) => column);

  GeneratedColumn<PgDateTime> get expiresAt =>
      $composableBuilder(column: $table.expiresAt, builder: (column) => column);

  GeneratedColumn<bool> get isUsed =>
      $composableBuilder(column: $table.isUsed, builder: (column) => column);

  GeneratedColumn<PgDateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);
}

class $$PasswordResetTokensTableTableManager
    extends
        RootTableManager<
          _$AuthDatabase,
          $PasswordResetTokensTable,
          PasswordResetTokenEntry,
          $$PasswordResetTokensTableFilterComposer,
          $$PasswordResetTokensTableOrderingComposer,
          $$PasswordResetTokensTableAnnotationComposer,
          $$PasswordResetTokensTableCreateCompanionBuilder,
          $$PasswordResetTokensTableUpdateCompanionBuilder,
          (
            PasswordResetTokenEntry,
            BaseReferences<
              _$AuthDatabase,
              $PasswordResetTokensTable,
              PasswordResetTokenEntry
            >,
          ),
          PasswordResetTokenEntry,
          PrefetchHooks Function()
        > {
  $$PasswordResetTokensTableTableManager(
    _$AuthDatabase db,
    $PasswordResetTokensTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer:
              () => $$PasswordResetTokensTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer:
              () => $$PasswordResetTokensTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer:
              () => $$PasswordResetTokensTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> token = const Value.absent(),
                Value<String> userId = const Value.absent(),
                Value<PgDateTime> expiresAt = const Value.absent(),
                Value<bool> isUsed = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PasswordResetTokensCompanion(
                token: token,
                userId: userId,
                expiresAt: expiresAt,
                isUsed: isUsed,
                createdAt: createdAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String token,
                required String userId,
                required PgDateTime expiresAt,
                Value<bool> isUsed = const Value.absent(),
                Value<PgDateTime> createdAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => PasswordResetTokensCompanion.insert(
                token: token,
                userId: userId,
                expiresAt: expiresAt,
                isUsed: isUsed,
                createdAt: createdAt,
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

typedef $$PasswordResetTokensTableProcessedTableManager =
    ProcessedTableManager<
      _$AuthDatabase,
      $PasswordResetTokensTable,
      PasswordResetTokenEntry,
      $$PasswordResetTokensTableFilterComposer,
      $$PasswordResetTokensTableOrderingComposer,
      $$PasswordResetTokensTableAnnotationComposer,
      $$PasswordResetTokensTableCreateCompanionBuilder,
      $$PasswordResetTokensTableUpdateCompanionBuilder,
      (
        PasswordResetTokenEntry,
        BaseReferences<
          _$AuthDatabase,
          $PasswordResetTokensTable,
          PasswordResetTokenEntry
        >,
      ),
      PasswordResetTokenEntry,
      PrefetchHooks Function()
    >;

class $AuthDatabaseManager {
  final _$AuthDatabase _db;
  $AuthDatabaseManager(this._db);
  $$UserAuthDataTableTableManager get userAuthData =>
      $$UserAuthDataTableTableManager(_db, _db.userAuthData);
  $$PasswordResetTokensTableTableManager get passwordResetTokens =>
      $$PasswordResetTokensTableTableManager(_db, _db.passwordResetTokens);
}
