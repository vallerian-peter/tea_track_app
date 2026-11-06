// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $FarmersTable extends Farmers with TableInfo<$FarmersTable, FarmerData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $FarmersTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _memberNumberMeta = const VerificationMeta(
    'memberNumber',
  );
  @override
  late final GeneratedColumn<String> memberNumber = GeneratedColumn<String>(
    'member_number',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways('UNIQUE'),
  );
  static const VerificationMeta _fullNameMeta = const VerificationMeta(
    'fullName',
  );
  @override
  late final GeneratedColumn<String> fullName = GeneratedColumn<String>(
    'full_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _phoneNumberMeta = const VerificationMeta(
    'phoneNumber',
  );
  @override
  late final GeneratedColumn<String> phoneNumber = GeneratedColumn<String>(
    'phone_number',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _nationalIdMeta = const VerificationMeta(
    'nationalId',
  );
  @override
  late final GeneratedColumn<String> nationalId = GeneratedColumn<String>(
    'national_id',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _collectionCentreMeta = const VerificationMeta(
    'collectionCentre',
  );
  @override
  late final GeneratedColumn<String> collectionCentre = GeneratedColumn<String>(
    'collection_centre',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _isSyncedMeta = const VerificationMeta(
    'isSynced',
  );
  @override
  late final GeneratedColumn<bool> isSynced = GeneratedColumn<bool>(
    'is_synced',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_synced" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    memberNumber,
    fullName,
    phoneNumber,
    nationalId,
    collectionCentre,
    isSynced,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'farmers';
  @override
  VerificationContext validateIntegrity(
    Insertable<FarmerData> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('member_number')) {
      context.handle(
        _memberNumberMeta,
        memberNumber.isAcceptableOrUnknown(
          data['member_number']!,
          _memberNumberMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_memberNumberMeta);
    }
    if (data.containsKey('full_name')) {
      context.handle(
        _fullNameMeta,
        fullName.isAcceptableOrUnknown(data['full_name']!, _fullNameMeta),
      );
    } else if (isInserting) {
      context.missing(_fullNameMeta);
    }
    if (data.containsKey('phone_number')) {
      context.handle(
        _phoneNumberMeta,
        phoneNumber.isAcceptableOrUnknown(
          data['phone_number']!,
          _phoneNumberMeta,
        ),
      );
    }
    if (data.containsKey('national_id')) {
      context.handle(
        _nationalIdMeta,
        nationalId.isAcceptableOrUnknown(data['national_id']!, _nationalIdMeta),
      );
    }
    if (data.containsKey('collection_centre')) {
      context.handle(
        _collectionCentreMeta,
        collectionCentre.isAcceptableOrUnknown(
          data['collection_centre']!,
          _collectionCentreMeta,
        ),
      );
    }
    if (data.containsKey('is_synced')) {
      context.handle(
        _isSyncedMeta,
        isSynced.isAcceptableOrUnknown(data['is_synced']!, _isSyncedMeta),
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
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  FarmerData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return FarmerData(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      memberNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}member_number'],
      )!,
      fullName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}full_name'],
      )!,
      phoneNumber: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}phone_number'],
      ),
      nationalId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}national_id'],
      ),
      collectionCentre: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}collection_centre'],
      ),
      isSynced: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_synced'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      )!,
    );
  }

  @override
  $FarmersTable createAlias(String alias) {
    return $FarmersTable(attachedDatabase, alias);
  }
}

class FarmerData extends DataClass implements Insertable<FarmerData> {
  final String id;
  final String memberNumber;
  final String fullName;
  final String? phoneNumber;
  final String? nationalId;
  final String? collectionCentre;
  final bool isSynced;
  final DateTime createdAt;
  final DateTime updatedAt;
  const FarmerData({
    required this.id,
    required this.memberNumber,
    required this.fullName,
    this.phoneNumber,
    this.nationalId,
    this.collectionCentre,
    required this.isSynced,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['member_number'] = Variable<String>(memberNumber);
    map['full_name'] = Variable<String>(fullName);
    if (!nullToAbsent || phoneNumber != null) {
      map['phone_number'] = Variable<String>(phoneNumber);
    }
    if (!nullToAbsent || nationalId != null) {
      map['national_id'] = Variable<String>(nationalId);
    }
    if (!nullToAbsent || collectionCentre != null) {
      map['collection_centre'] = Variable<String>(collectionCentre);
    }
    map['is_synced'] = Variable<bool>(isSynced);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  FarmersCompanion toCompanion(bool nullToAbsent) {
    return FarmersCompanion(
      id: Value(id),
      memberNumber: Value(memberNumber),
      fullName: Value(fullName),
      phoneNumber: phoneNumber == null && nullToAbsent
          ? const Value.absent()
          : Value(phoneNumber),
      nationalId: nationalId == null && nullToAbsent
          ? const Value.absent()
          : Value(nationalId),
      collectionCentre: collectionCentre == null && nullToAbsent
          ? const Value.absent()
          : Value(collectionCentre),
      isSynced: Value(isSynced),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory FarmerData.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return FarmerData(
      id: serializer.fromJson<String>(json['id']),
      memberNumber: serializer.fromJson<String>(json['memberNumber']),
      fullName: serializer.fromJson<String>(json['fullName']),
      phoneNumber: serializer.fromJson<String?>(json['phoneNumber']),
      nationalId: serializer.fromJson<String?>(json['nationalId']),
      collectionCentre: serializer.fromJson<String?>(json['collectionCentre']),
      isSynced: serializer.fromJson<bool>(json['isSynced']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'memberNumber': serializer.toJson<String>(memberNumber),
      'fullName': serializer.toJson<String>(fullName),
      'phoneNumber': serializer.toJson<String?>(phoneNumber),
      'nationalId': serializer.toJson<String?>(nationalId),
      'collectionCentre': serializer.toJson<String?>(collectionCentre),
      'isSynced': serializer.toJson<bool>(isSynced),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  FarmerData copyWith({
    String? id,
    String? memberNumber,
    String? fullName,
    Value<String?> phoneNumber = const Value.absent(),
    Value<String?> nationalId = const Value.absent(),
    Value<String?> collectionCentre = const Value.absent(),
    bool? isSynced,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => FarmerData(
    id: id ?? this.id,
    memberNumber: memberNumber ?? this.memberNumber,
    fullName: fullName ?? this.fullName,
    phoneNumber: phoneNumber.present ? phoneNumber.value : this.phoneNumber,
    nationalId: nationalId.present ? nationalId.value : this.nationalId,
    collectionCentre: collectionCentre.present
        ? collectionCentre.value
        : this.collectionCentre,
    isSynced: isSynced ?? this.isSynced,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  FarmerData copyWithCompanion(FarmersCompanion data) {
    return FarmerData(
      id: data.id.present ? data.id.value : this.id,
      memberNumber: data.memberNumber.present
          ? data.memberNumber.value
          : this.memberNumber,
      fullName: data.fullName.present ? data.fullName.value : this.fullName,
      phoneNumber: data.phoneNumber.present
          ? data.phoneNumber.value
          : this.phoneNumber,
      nationalId: data.nationalId.present
          ? data.nationalId.value
          : this.nationalId,
      collectionCentre: data.collectionCentre.present
          ? data.collectionCentre.value
          : this.collectionCentre,
      isSynced: data.isSynced.present ? data.isSynced.value : this.isSynced,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('FarmerData(')
          ..write('id: $id, ')
          ..write('memberNumber: $memberNumber, ')
          ..write('fullName: $fullName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('nationalId: $nationalId, ')
          ..write('collectionCentre: $collectionCentre, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    memberNumber,
    fullName,
    phoneNumber,
    nationalId,
    collectionCentre,
    isSynced,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is FarmerData &&
          other.id == this.id &&
          other.memberNumber == this.memberNumber &&
          other.fullName == this.fullName &&
          other.phoneNumber == this.phoneNumber &&
          other.nationalId == this.nationalId &&
          other.collectionCentre == this.collectionCentre &&
          other.isSynced == this.isSynced &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class FarmersCompanion extends UpdateCompanion<FarmerData> {
  final Value<String> id;
  final Value<String> memberNumber;
  final Value<String> fullName;
  final Value<String?> phoneNumber;
  final Value<String?> nationalId;
  final Value<String?> collectionCentre;
  final Value<bool> isSynced;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  final Value<int> rowid;
  const FarmersCompanion({
    this.id = const Value.absent(),
    this.memberNumber = const Value.absent(),
    this.fullName = const Value.absent(),
    this.phoneNumber = const Value.absent(),
    this.nationalId = const Value.absent(),
    this.collectionCentre = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  FarmersCompanion.insert({
    required String id,
    required String memberNumber,
    required String fullName,
    this.phoneNumber = const Value.absent(),
    this.nationalId = const Value.absent(),
    this.collectionCentre = const Value.absent(),
    this.isSynced = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       memberNumber = Value(memberNumber),
       fullName = Value(fullName);
  static Insertable<FarmerData> custom({
    Expression<String>? id,
    Expression<String>? memberNumber,
    Expression<String>? fullName,
    Expression<String>? phoneNumber,
    Expression<String>? nationalId,
    Expression<String>? collectionCentre,
    Expression<bool>? isSynced,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (memberNumber != null) 'member_number': memberNumber,
      if (fullName != null) 'full_name': fullName,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (nationalId != null) 'national_id': nationalId,
      if (collectionCentre != null) 'collection_centre': collectionCentre,
      if (isSynced != null) 'is_synced': isSynced,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (rowid != null) 'rowid': rowid,
    });
  }

  FarmersCompanion copyWith({
    Value<String>? id,
    Value<String>? memberNumber,
    Value<String>? fullName,
    Value<String?>? phoneNumber,
    Value<String?>? nationalId,
    Value<String?>? collectionCentre,
    Value<bool>? isSynced,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
    Value<int>? rowid,
  }) {
    return FarmersCompanion(
      id: id ?? this.id,
      memberNumber: memberNumber ?? this.memberNumber,
      fullName: fullName ?? this.fullName,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      nationalId: nationalId ?? this.nationalId,
      collectionCentre: collectionCentre ?? this.collectionCentre,
      isSynced: isSynced ?? this.isSynced,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (memberNumber.present) {
      map['member_number'] = Variable<String>(memberNumber.value);
    }
    if (fullName.present) {
      map['full_name'] = Variable<String>(fullName.value);
    }
    if (phoneNumber.present) {
      map['phone_number'] = Variable<String>(phoneNumber.value);
    }
    if (nationalId.present) {
      map['national_id'] = Variable<String>(nationalId.value);
    }
    if (collectionCentre.present) {
      map['collection_centre'] = Variable<String>(collectionCentre.value);
    }
    if (isSynced.present) {
      map['is_synced'] = Variable<bool>(isSynced.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('FarmersCompanion(')
          ..write('id: $id, ')
          ..write('memberNumber: $memberNumber, ')
          ..write('fullName: $fullName, ')
          ..write('phoneNumber: $phoneNumber, ')
          ..write('nationalId: $nationalId, ')
          ..write('collectionCentre: $collectionCentre, ')
          ..write('isSynced: $isSynced, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $FarmersTable farmers = $FarmersTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [farmers];
}

typedef $$FarmersTableCreateCompanionBuilder = FarmersCompanion Function({
  required String id,
  required String memberNumber,
  required String fullName,
  Value<String?> phoneNumber,
  Value<String?> nationalId,
  Value<String?> collectionCentre,
  Value<bool> isSynced,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});
typedef $$FarmersTableUpdateCompanionBuilder = FarmersCompanion Function({
  Value<String> id,
  Value<String> memberNumber,
  Value<String> fullName,
  Value<String?> phoneNumber,
  Value<String?> nationalId,
  Value<String?> collectionCentre,
  Value<bool> isSynced,
  Value<DateTime> createdAt,
  Value<DateTime> updatedAt,
  Value<int> rowid,
});

class $$FarmersTableFilterComposer
    extends Composer<_$AppDatabase, $FarmersTable> {
  $$FarmersTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get memberNumber => $composableBuilder(
    column: $table.memberNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get collectionCentre => $composableBuilder(
    column: $table.collectionCentre,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );
}

class $$FarmersTableOrderingComposer
    extends Composer<_$AppDatabase, $FarmersTable> {
  $$FarmersTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get memberNumber => $composableBuilder(
    column: $table.memberNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fullName => $composableBuilder(
    column: $table.fullName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get collectionCentre => $composableBuilder(
    column: $table.collectionCentre,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isSynced => $composableBuilder(
    column: $table.isSynced,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$FarmersTableAnnotationComposer
    extends Composer<_$AppDatabase, $FarmersTable> {
  $$FarmersTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get memberNumber => $composableBuilder(
    column: $table.memberNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get fullName =>
      $composableBuilder(column: $table.fullName, builder: (column) => column);

  GeneratedColumn<String> get phoneNumber => $composableBuilder(
    column: $table.phoneNumber,
    builder: (column) => column,
  );

  GeneratedColumn<String> get nationalId => $composableBuilder(
    column: $table.nationalId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get collectionCentre => $composableBuilder(
    column: $table.collectionCentre,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isSynced =>
      $composableBuilder(column: $table.isSynced, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$FarmersTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $FarmersTable,
          FarmerData,
          $$FarmersTableFilterComposer,
          $$FarmersTableOrderingComposer,
          $$FarmersTableAnnotationComposer,
          $$FarmersTableCreateCompanionBuilder,
          $$FarmersTableUpdateCompanionBuilder,
          (
            FarmerData,
            BaseReferences<_$AppDatabase, $FarmersTable, FarmerData>,
          ),
          FarmerData,
          PrefetchHooks Function()
        > {
  $$FarmersTableTableManager(_$AppDatabase db, $FarmersTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$FarmersTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$FarmersTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$FarmersTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> memberNumber = const Value.absent(),
                Value<String> fullName = const Value.absent(),
                Value<String?> phoneNumber = const Value.absent(),
                Value<String?> nationalId = const Value.absent(),
                Value<String?> collectionCentre = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FarmersCompanion(
                id: id,
                memberNumber: memberNumber,
                fullName: fullName,
                phoneNumber: phoneNumber,
                nationalId: nationalId,
                collectionCentre: collectionCentre,
                isSynced: isSynced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String memberNumber,
                required String fullName,
                Value<String?> phoneNumber = const Value.absent(),
                Value<String?> nationalId = const Value.absent(),
                Value<String?> collectionCentre = const Value.absent(),
                Value<bool> isSynced = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => FarmersCompanion.insert(
                id: id,
                memberNumber: memberNumber,
                fullName: fullName,
                phoneNumber: phoneNumber,
                nationalId: nationalId,
                collectionCentre: collectionCentre,
                isSynced: isSynced,
                createdAt: createdAt,
                updatedAt: updatedAt,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$FarmersTable, FarmerData>(table),
                  BaseReferences<_$AppDatabase, $FarmersTable, FarmerData>(
                    db,
                    table,
                    e,
                  ),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$FarmersTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $FarmersTable,
      FarmerData,
      $$FarmersTableFilterComposer,
      $$FarmersTableOrderingComposer,
      $$FarmersTableAnnotationComposer,
      $$FarmersTableCreateCompanionBuilder,
      $$FarmersTableUpdateCompanionBuilder,
      (FarmerData, BaseReferences<_$AppDatabase, $FarmersTable, FarmerData>),
      FarmerData,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$FarmersTableTableManager get farmers =>
      $$FarmersTableTableManager(_db, _db.farmers);
}
