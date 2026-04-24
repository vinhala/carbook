// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $CarProfilesTable extends CarProfiles
    with TableInfo<$CarProfilesTable, CarProfileRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CarProfilesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _makeMeta = const VerificationMeta('make');
  @override
  late final GeneratedColumn<String> make = GeneratedColumn<String>(
    'make',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _modelMeta = const VerificationMeta('model');
  @override
  late final GeneratedColumn<String> model = GeneratedColumn<String>(
    'model',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _engineMeta = const VerificationMeta('engine');
  @override
  late final GeneratedColumn<String> engine = GeneratedColumn<String>(
    'engine',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstRegistrationMonthMeta =
      const VerificationMeta('firstRegistrationMonth');
  @override
  late final GeneratedColumn<DateTime> firstRegistrationMonth =
      GeneratedColumn<DateTime>(
        'first_registration_month',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _vinMeta = const VerificationMeta('vin');
  @override
  late final GeneratedColumn<String> vin = GeneratedColumn<String>(
    'vin',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _currentMileageMeta = const VerificationMeta(
    'currentMileage',
  );
  @override
  late final GeneratedColumn<int> currentMileage = GeneratedColumn<int>(
    'current_mileage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mileageUnitMeta = const VerificationMeta(
    'mileageUnit',
  );
  @override
  late final GeneratedColumn<String> mileageUnit = GeneratedColumn<String>(
    'mileage_unit',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
    defaultValue: const Constant('mi'),
  );
  static const VerificationMeta _photoPathMeta = const VerificationMeta(
    'photoPath',
  );
  @override
  late final GeneratedColumn<String> photoPath = GeneratedColumn<String>(
    'photo_path',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MileageReminderFrequency, String>
  reminderFrequency =
      GeneratedColumn<String>(
        'reminder_frequency',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MileageReminderFrequency>(
        $CarProfilesTable.$converterreminderFrequency,
      );
  static const VerificationMeta _lastMileageUpdatedAtMeta =
      const VerificationMeta('lastMileageUpdatedAt');
  @override
  late final GeneratedColumn<DateTime> lastMileageUpdatedAt =
      GeneratedColumn<DateTime>(
        'last_mileage_updated_at',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
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
    requiredDuringInsert: true,
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
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    make,
    model,
    engine,
    firstRegistrationMonth,
    vin,
    currentMileage,
    mileageUnit,
    photoPath,
    reminderFrequency,
    lastMileageUpdatedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'car_profiles';
  @override
  VerificationContext validateIntegrity(
    Insertable<CarProfileRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('make')) {
      context.handle(
        _makeMeta,
        make.isAcceptableOrUnknown(data['make']!, _makeMeta),
      );
    } else if (isInserting) {
      context.missing(_makeMeta);
    }
    if (data.containsKey('model')) {
      context.handle(
        _modelMeta,
        model.isAcceptableOrUnknown(data['model']!, _modelMeta),
      );
    } else if (isInserting) {
      context.missing(_modelMeta);
    }
    if (data.containsKey('engine')) {
      context.handle(
        _engineMeta,
        engine.isAcceptableOrUnknown(data['engine']!, _engineMeta),
      );
    } else if (isInserting) {
      context.missing(_engineMeta);
    }
    if (data.containsKey('first_registration_month')) {
      context.handle(
        _firstRegistrationMonthMeta,
        firstRegistrationMonth.isAcceptableOrUnknown(
          data['first_registration_month']!,
          _firstRegistrationMonthMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstRegistrationMonthMeta);
    }
    if (data.containsKey('vin')) {
      context.handle(
        _vinMeta,
        vin.isAcceptableOrUnknown(data['vin']!, _vinMeta),
      );
    } else if (isInserting) {
      context.missing(_vinMeta);
    }
    if (data.containsKey('current_mileage')) {
      context.handle(
        _currentMileageMeta,
        currentMileage.isAcceptableOrUnknown(
          data['current_mileage']!,
          _currentMileageMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_currentMileageMeta);
    }
    if (data.containsKey('mileage_unit')) {
      context.handle(
        _mileageUnitMeta,
        mileageUnit.isAcceptableOrUnknown(
          data['mileage_unit']!,
          _mileageUnitMeta,
        ),
      );
    }
    if (data.containsKey('photo_path')) {
      context.handle(
        _photoPathMeta,
        photoPath.isAcceptableOrUnknown(data['photo_path']!, _photoPathMeta),
      );
    }
    if (data.containsKey('last_mileage_updated_at')) {
      context.handle(
        _lastMileageUpdatedAtMeta,
        lastMileageUpdatedAt.isAcceptableOrUnknown(
          data['last_mileage_updated_at']!,
          _lastMileageUpdatedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_lastMileageUpdatedAtMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    } else if (isInserting) {
      context.missing(_updatedAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CarProfileRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return CarProfileRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      make: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}make'],
      )!,
      model: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}model'],
      )!,
      engine: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}engine'],
      )!,
      firstRegistrationMonth: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}first_registration_month'],
      )!,
      vin: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}vin'],
      )!,
      currentMileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}current_mileage'],
      )!,
      mileageUnit: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mileage_unit'],
      )!,
      photoPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}photo_path'],
      ),
      reminderFrequency: $CarProfilesTable.$converterreminderFrequency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}reminder_frequency'],
        )!,
      ),
      lastMileageUpdatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}last_mileage_updated_at'],
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
  $CarProfilesTable createAlias(String alias) {
    return $CarProfilesTable(attachedDatabase, alias);
  }

  static TypeConverter<MileageReminderFrequency, String>
  $converterreminderFrequency = const MileageReminderFrequencyConverter();
}

class CarProfileRecord extends DataClass
    implements Insertable<CarProfileRecord> {
  final int id;
  final String make;
  final String model;
  final String engine;
  final DateTime firstRegistrationMonth;
  final String vin;
  final int currentMileage;
  final String mileageUnit;
  final String? photoPath;
  final MileageReminderFrequency reminderFrequency;
  final DateTime lastMileageUpdatedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const CarProfileRecord({
    required this.id,
    required this.make,
    required this.model,
    required this.engine,
    required this.firstRegistrationMonth,
    required this.vin,
    required this.currentMileage,
    required this.mileageUnit,
    this.photoPath,
    required this.reminderFrequency,
    required this.lastMileageUpdatedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['make'] = Variable<String>(make);
    map['model'] = Variable<String>(model);
    map['engine'] = Variable<String>(engine);
    map['first_registration_month'] = Variable<DateTime>(
      firstRegistrationMonth,
    );
    map['vin'] = Variable<String>(vin);
    map['current_mileage'] = Variable<int>(currentMileage);
    map['mileage_unit'] = Variable<String>(mileageUnit);
    if (!nullToAbsent || photoPath != null) {
      map['photo_path'] = Variable<String>(photoPath);
    }
    {
      map['reminder_frequency'] = Variable<String>(
        $CarProfilesTable.$converterreminderFrequency.toSql(reminderFrequency),
      );
    }
    map['last_mileage_updated_at'] = Variable<DateTime>(lastMileageUpdatedAt);
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  CarProfilesCompanion toCompanion(bool nullToAbsent) {
    return CarProfilesCompanion(
      id: Value(id),
      make: Value(make),
      model: Value(model),
      engine: Value(engine),
      firstRegistrationMonth: Value(firstRegistrationMonth),
      vin: Value(vin),
      currentMileage: Value(currentMileage),
      mileageUnit: Value(mileageUnit),
      photoPath: photoPath == null && nullToAbsent
          ? const Value.absent()
          : Value(photoPath),
      reminderFrequency: Value(reminderFrequency),
      lastMileageUpdatedAt: Value(lastMileageUpdatedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory CarProfileRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CarProfileRecord(
      id: serializer.fromJson<int>(json['id']),
      make: serializer.fromJson<String>(json['make']),
      model: serializer.fromJson<String>(json['model']),
      engine: serializer.fromJson<String>(json['engine']),
      firstRegistrationMonth: serializer.fromJson<DateTime>(
        json['firstRegistrationMonth'],
      ),
      vin: serializer.fromJson<String>(json['vin']),
      currentMileage: serializer.fromJson<int>(json['currentMileage']),
      mileageUnit: serializer.fromJson<String>(json['mileageUnit']),
      photoPath: serializer.fromJson<String?>(json['photoPath']),
      reminderFrequency: serializer.fromJson<MileageReminderFrequency>(
        json['reminderFrequency'],
      ),
      lastMileageUpdatedAt: serializer.fromJson<DateTime>(
        json['lastMileageUpdatedAt'],
      ),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'make': serializer.toJson<String>(make),
      'model': serializer.toJson<String>(model),
      'engine': serializer.toJson<String>(engine),
      'firstRegistrationMonth': serializer.toJson<DateTime>(
        firstRegistrationMonth,
      ),
      'vin': serializer.toJson<String>(vin),
      'currentMileage': serializer.toJson<int>(currentMileage),
      'mileageUnit': serializer.toJson<String>(mileageUnit),
      'photoPath': serializer.toJson<String?>(photoPath),
      'reminderFrequency': serializer.toJson<MileageReminderFrequency>(
        reminderFrequency,
      ),
      'lastMileageUpdatedAt': serializer.toJson<DateTime>(lastMileageUpdatedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  CarProfileRecord copyWith({
    int? id,
    String? make,
    String? model,
    String? engine,
    DateTime? firstRegistrationMonth,
    String? vin,
    int? currentMileage,
    String? mileageUnit,
    Value<String?> photoPath = const Value.absent(),
    MileageReminderFrequency? reminderFrequency,
    DateTime? lastMileageUpdatedAt,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => CarProfileRecord(
    id: id ?? this.id,
    make: make ?? this.make,
    model: model ?? this.model,
    engine: engine ?? this.engine,
    firstRegistrationMonth:
        firstRegistrationMonth ?? this.firstRegistrationMonth,
    vin: vin ?? this.vin,
    currentMileage: currentMileage ?? this.currentMileage,
    mileageUnit: mileageUnit ?? this.mileageUnit,
    photoPath: photoPath.present ? photoPath.value : this.photoPath,
    reminderFrequency: reminderFrequency ?? this.reminderFrequency,
    lastMileageUpdatedAt: lastMileageUpdatedAt ?? this.lastMileageUpdatedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  CarProfileRecord copyWithCompanion(CarProfilesCompanion data) {
    return CarProfileRecord(
      id: data.id.present ? data.id.value : this.id,
      make: data.make.present ? data.make.value : this.make,
      model: data.model.present ? data.model.value : this.model,
      engine: data.engine.present ? data.engine.value : this.engine,
      firstRegistrationMonth: data.firstRegistrationMonth.present
          ? data.firstRegistrationMonth.value
          : this.firstRegistrationMonth,
      vin: data.vin.present ? data.vin.value : this.vin,
      currentMileage: data.currentMileage.present
          ? data.currentMileage.value
          : this.currentMileage,
      mileageUnit: data.mileageUnit.present
          ? data.mileageUnit.value
          : this.mileageUnit,
      photoPath: data.photoPath.present ? data.photoPath.value : this.photoPath,
      reminderFrequency: data.reminderFrequency.present
          ? data.reminderFrequency.value
          : this.reminderFrequency,
      lastMileageUpdatedAt: data.lastMileageUpdatedAt.present
          ? data.lastMileageUpdatedAt.value
          : this.lastMileageUpdatedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('CarProfileRecord(')
          ..write('id: $id, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('engine: $engine, ')
          ..write('firstRegistrationMonth: $firstRegistrationMonth, ')
          ..write('vin: $vin, ')
          ..write('currentMileage: $currentMileage, ')
          ..write('mileageUnit: $mileageUnit, ')
          ..write('photoPath: $photoPath, ')
          ..write('reminderFrequency: $reminderFrequency, ')
          ..write('lastMileageUpdatedAt: $lastMileageUpdatedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    make,
    model,
    engine,
    firstRegistrationMonth,
    vin,
    currentMileage,
    mileageUnit,
    photoPath,
    reminderFrequency,
    lastMileageUpdatedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CarProfileRecord &&
          other.id == this.id &&
          other.make == this.make &&
          other.model == this.model &&
          other.engine == this.engine &&
          other.firstRegistrationMonth == this.firstRegistrationMonth &&
          other.vin == this.vin &&
          other.currentMileage == this.currentMileage &&
          other.mileageUnit == this.mileageUnit &&
          other.photoPath == this.photoPath &&
          other.reminderFrequency == this.reminderFrequency &&
          other.lastMileageUpdatedAt == this.lastMileageUpdatedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class CarProfilesCompanion extends UpdateCompanion<CarProfileRecord> {
  final Value<int> id;
  final Value<String> make;
  final Value<String> model;
  final Value<String> engine;
  final Value<DateTime> firstRegistrationMonth;
  final Value<String> vin;
  final Value<int> currentMileage;
  final Value<String> mileageUnit;
  final Value<String?> photoPath;
  final Value<MileageReminderFrequency> reminderFrequency;
  final Value<DateTime> lastMileageUpdatedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const CarProfilesCompanion({
    this.id = const Value.absent(),
    this.make = const Value.absent(),
    this.model = const Value.absent(),
    this.engine = const Value.absent(),
    this.firstRegistrationMonth = const Value.absent(),
    this.vin = const Value.absent(),
    this.currentMileage = const Value.absent(),
    this.mileageUnit = const Value.absent(),
    this.photoPath = const Value.absent(),
    this.reminderFrequency = const Value.absent(),
    this.lastMileageUpdatedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  CarProfilesCompanion.insert({
    this.id = const Value.absent(),
    required String make,
    required String model,
    required String engine,
    required DateTime firstRegistrationMonth,
    required String vin,
    required int currentMileage,
    this.mileageUnit = const Value.absent(),
    this.photoPath = const Value.absent(),
    required MileageReminderFrequency reminderFrequency,
    required DateTime lastMileageUpdatedAt,
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : make = Value(make),
       model = Value(model),
       engine = Value(engine),
       firstRegistrationMonth = Value(firstRegistrationMonth),
       vin = Value(vin),
       currentMileage = Value(currentMileage),
       reminderFrequency = Value(reminderFrequency),
       lastMileageUpdatedAt = Value(lastMileageUpdatedAt),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<CarProfileRecord> custom({
    Expression<int>? id,
    Expression<String>? make,
    Expression<String>? model,
    Expression<String>? engine,
    Expression<DateTime>? firstRegistrationMonth,
    Expression<String>? vin,
    Expression<int>? currentMileage,
    Expression<String>? mileageUnit,
    Expression<String>? photoPath,
    Expression<String>? reminderFrequency,
    Expression<DateTime>? lastMileageUpdatedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (make != null) 'make': make,
      if (model != null) 'model': model,
      if (engine != null) 'engine': engine,
      if (firstRegistrationMonth != null)
        'first_registration_month': firstRegistrationMonth,
      if (vin != null) 'vin': vin,
      if (currentMileage != null) 'current_mileage': currentMileage,
      if (mileageUnit != null) 'mileage_unit': mileageUnit,
      if (photoPath != null) 'photo_path': photoPath,
      if (reminderFrequency != null) 'reminder_frequency': reminderFrequency,
      if (lastMileageUpdatedAt != null)
        'last_mileage_updated_at': lastMileageUpdatedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  CarProfilesCompanion copyWith({
    Value<int>? id,
    Value<String>? make,
    Value<String>? model,
    Value<String>? engine,
    Value<DateTime>? firstRegistrationMonth,
    Value<String>? vin,
    Value<int>? currentMileage,
    Value<String>? mileageUnit,
    Value<String?>? photoPath,
    Value<MileageReminderFrequency>? reminderFrequency,
    Value<DateTime>? lastMileageUpdatedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return CarProfilesCompanion(
      id: id ?? this.id,
      make: make ?? this.make,
      model: model ?? this.model,
      engine: engine ?? this.engine,
      firstRegistrationMonth:
          firstRegistrationMonth ?? this.firstRegistrationMonth,
      vin: vin ?? this.vin,
      currentMileage: currentMileage ?? this.currentMileage,
      mileageUnit: mileageUnit ?? this.mileageUnit,
      photoPath: photoPath ?? this.photoPath,
      reminderFrequency: reminderFrequency ?? this.reminderFrequency,
      lastMileageUpdatedAt: lastMileageUpdatedAt ?? this.lastMileageUpdatedAt,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (make.present) {
      map['make'] = Variable<String>(make.value);
    }
    if (model.present) {
      map['model'] = Variable<String>(model.value);
    }
    if (engine.present) {
      map['engine'] = Variable<String>(engine.value);
    }
    if (firstRegistrationMonth.present) {
      map['first_registration_month'] = Variable<DateTime>(
        firstRegistrationMonth.value,
      );
    }
    if (vin.present) {
      map['vin'] = Variable<String>(vin.value);
    }
    if (currentMileage.present) {
      map['current_mileage'] = Variable<int>(currentMileage.value);
    }
    if (mileageUnit.present) {
      map['mileage_unit'] = Variable<String>(mileageUnit.value);
    }
    if (photoPath.present) {
      map['photo_path'] = Variable<String>(photoPath.value);
    }
    if (reminderFrequency.present) {
      map['reminder_frequency'] = Variable<String>(
        $CarProfilesTable.$converterreminderFrequency.toSql(
          reminderFrequency.value,
        ),
      );
    }
    if (lastMileageUpdatedAt.present) {
      map['last_mileage_updated_at'] = Variable<DateTime>(
        lastMileageUpdatedAt.value,
      );
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CarProfilesCompanion(')
          ..write('id: $id, ')
          ..write('make: $make, ')
          ..write('model: $model, ')
          ..write('engine: $engine, ')
          ..write('firstRegistrationMonth: $firstRegistrationMonth, ')
          ..write('vin: $vin, ')
          ..write('currentMileage: $currentMileage, ')
          ..write('mileageUnit: $mileageUnit, ')
          ..write('photoPath: $photoPath, ')
          ..write('reminderFrequency: $reminderFrequency, ')
          ..write('lastMileageUpdatedAt: $lastMileageUpdatedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CarProfilesTable carProfiles = $CarProfilesTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [carProfiles];
}

typedef $$CarProfilesTableCreateCompanionBuilder =
    CarProfilesCompanion Function({
      Value<int> id,
      required String make,
      required String model,
      required String engine,
      required DateTime firstRegistrationMonth,
      required String vin,
      required int currentMileage,
      Value<String> mileageUnit,
      Value<String?> photoPath,
      required MileageReminderFrequency reminderFrequency,
      required DateTime lastMileageUpdatedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$CarProfilesTableUpdateCompanionBuilder =
    CarProfilesCompanion Function({
      Value<int> id,
      Value<String> make,
      Value<String> model,
      Value<String> engine,
      Value<DateTime> firstRegistrationMonth,
      Value<String> vin,
      Value<int> currentMileage,
      Value<String> mileageUnit,
      Value<String?> photoPath,
      Value<MileageReminderFrequency> reminderFrequency,
      Value<DateTime> lastMileageUpdatedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

class $$CarProfilesTableFilterComposer
    extends Composer<_$AppDatabase, $CarProfilesTable> {
  $$CarProfilesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get engine => $composableBuilder(
    column: $table.engine,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get firstRegistrationMonth => $composableBuilder(
    column: $table.firstRegistrationMonth,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get vin => $composableBuilder(
    column: $table.vin,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get currentMileage => $composableBuilder(
    column: $table.currentMileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mileageUnit => $composableBuilder(
    column: $table.mileageUnit,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    MileageReminderFrequency,
    MileageReminderFrequency,
    String
  >
  get reminderFrequency => $composableBuilder(
    column: $table.reminderFrequency,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get lastMileageUpdatedAt => $composableBuilder(
    column: $table.lastMileageUpdatedAt,
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

class $$CarProfilesTableOrderingComposer
    extends Composer<_$AppDatabase, $CarProfilesTable> {
  $$CarProfilesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get make => $composableBuilder(
    column: $table.make,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get model => $composableBuilder(
    column: $table.model,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get engine => $composableBuilder(
    column: $table.engine,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get firstRegistrationMonth => $composableBuilder(
    column: $table.firstRegistrationMonth,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get vin => $composableBuilder(
    column: $table.vin,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get currentMileage => $composableBuilder(
    column: $table.currentMileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mileageUnit => $composableBuilder(
    column: $table.mileageUnit,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get photoPath => $composableBuilder(
    column: $table.photoPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get reminderFrequency => $composableBuilder(
    column: $table.reminderFrequency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get lastMileageUpdatedAt => $composableBuilder(
    column: $table.lastMileageUpdatedAt,
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

class $$CarProfilesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CarProfilesTable> {
  $$CarProfilesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get make =>
      $composableBuilder(column: $table.make, builder: (column) => column);

  GeneratedColumn<String> get model =>
      $composableBuilder(column: $table.model, builder: (column) => column);

  GeneratedColumn<String> get engine =>
      $composableBuilder(column: $table.engine, builder: (column) => column);

  GeneratedColumn<DateTime> get firstRegistrationMonth => $composableBuilder(
    column: $table.firstRegistrationMonth,
    builder: (column) => column,
  );

  GeneratedColumn<String> get vin =>
      $composableBuilder(column: $table.vin, builder: (column) => column);

  GeneratedColumn<int> get currentMileage => $composableBuilder(
    column: $table.currentMileage,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mileageUnit => $composableBuilder(
    column: $table.mileageUnit,
    builder: (column) => column,
  );

  GeneratedColumn<String> get photoPath =>
      $composableBuilder(column: $table.photoPath, builder: (column) => column);

  GeneratedColumnWithTypeConverter<MileageReminderFrequency, String>
  get reminderFrequency => $composableBuilder(
    column: $table.reminderFrequency,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get lastMileageUpdatedAt => $composableBuilder(
    column: $table.lastMileageUpdatedAt,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);
}

class $$CarProfilesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CarProfilesTable,
          CarProfileRecord,
          $$CarProfilesTableFilterComposer,
          $$CarProfilesTableOrderingComposer,
          $$CarProfilesTableAnnotationComposer,
          $$CarProfilesTableCreateCompanionBuilder,
          $$CarProfilesTableUpdateCompanionBuilder,
          (
            CarProfileRecord,
            BaseReferences<_$AppDatabase, $CarProfilesTable, CarProfileRecord>,
          ),
          CarProfileRecord,
          PrefetchHooks Function()
        > {
  $$CarProfilesTableTableManager(_$AppDatabase db, $CarProfilesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CarProfilesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CarProfilesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CarProfilesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<String> make = const Value.absent(),
                Value<String> model = const Value.absent(),
                Value<String> engine = const Value.absent(),
                Value<DateTime> firstRegistrationMonth = const Value.absent(),
                Value<String> vin = const Value.absent(),
                Value<int> currentMileage = const Value.absent(),
                Value<String> mileageUnit = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                Value<MileageReminderFrequency> reminderFrequency =
                    const Value.absent(),
                Value<DateTime> lastMileageUpdatedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => CarProfilesCompanion(
                id: id,
                make: make,
                model: model,
                engine: engine,
                firstRegistrationMonth: firstRegistrationMonth,
                vin: vin,
                currentMileage: currentMileage,
                mileageUnit: mileageUnit,
                photoPath: photoPath,
                reminderFrequency: reminderFrequency,
                lastMileageUpdatedAt: lastMileageUpdatedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required String make,
                required String model,
                required String engine,
                required DateTime firstRegistrationMonth,
                required String vin,
                required int currentMileage,
                Value<String> mileageUnit = const Value.absent(),
                Value<String?> photoPath = const Value.absent(),
                required MileageReminderFrequency reminderFrequency,
                required DateTime lastMileageUpdatedAt,
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => CarProfilesCompanion.insert(
                id: id,
                make: make,
                model: model,
                engine: engine,
                firstRegistrationMonth: firstRegistrationMonth,
                vin: vin,
                currentMileage: currentMileage,
                mileageUnit: mileageUnit,
                photoPath: photoPath,
                reminderFrequency: reminderFrequency,
                lastMileageUpdatedAt: lastMileageUpdatedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$CarProfilesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CarProfilesTable,
      CarProfileRecord,
      $$CarProfilesTableFilterComposer,
      $$CarProfilesTableOrderingComposer,
      $$CarProfilesTableAnnotationComposer,
      $$CarProfilesTableCreateCompanionBuilder,
      $$CarProfilesTableUpdateCompanionBuilder,
      (
        CarProfileRecord,
        BaseReferences<_$AppDatabase, $CarProfilesTable, CarProfileRecord>,
      ),
      CarProfileRecord,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CarProfilesTableTableManager get carProfiles =>
      $$CarProfilesTableTableManager(_db, _db.carProfiles);
}
