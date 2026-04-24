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

class $MaintenanceItemsTable extends MaintenanceItems
    with TableInfo<$MaintenanceItemsTable, MaintenanceItemRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceItemsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _carProfileIdMeta = const VerificationMeta(
    'carProfileId',
  );
  @override
  late final GeneratedColumn<int> carProfileId = GeneratedColumn<int>(
    'car_profile_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES car_profiles (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MaintenanceScheduleType, String>
  scheduleType =
      GeneratedColumn<String>(
        'schedule_type',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<MaintenanceScheduleType>(
        $MaintenanceItemsTable.$converterscheduleType,
      );
  static const VerificationMeta _intervalValueMeta = const VerificationMeta(
    'intervalValue',
  );
  @override
  late final GeneratedColumn<int> intervalValue = GeneratedColumn<int>(
    'interval_value',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  @override
  late final GeneratedColumnWithTypeConverter<MaintenanceTimeUnit?, String>
  timeUnit =
      GeneratedColumn<String>(
        'time_unit',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<MaintenanceTimeUnit?>(
        $MaintenanceItemsTable.$convertertimeUnit,
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
    carProfileId,
    description,
    scheduleType,
    intervalValue,
    timeUnit,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_items';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceItemRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('car_profile_id')) {
      context.handle(
        _carProfileIdMeta,
        carProfileId.isAcceptableOrUnknown(
          data['car_profile_id']!,
          _carProfileIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_carProfileIdMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_descriptionMeta);
    }
    if (data.containsKey('interval_value')) {
      context.handle(
        _intervalValueMeta,
        intervalValue.isAcceptableOrUnknown(
          data['interval_value']!,
          _intervalValueMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_intervalValueMeta);
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
  MaintenanceItemRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceItemRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      carProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}car_profile_id'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      )!,
      scheduleType: $MaintenanceItemsTable.$converterscheduleType.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}schedule_type'],
        )!,
      ),
      intervalValue: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}interval_value'],
      )!,
      timeUnit: $MaintenanceItemsTable.$convertertimeUnit.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}time_unit'],
        ),
      ),
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
  $MaintenanceItemsTable createAlias(String alias) {
    return $MaintenanceItemsTable(attachedDatabase, alias);
  }

  static TypeConverter<MaintenanceScheduleType, String> $converterscheduleType =
      const MaintenanceScheduleTypeConverter();
  static TypeConverter<MaintenanceTimeUnit?, String?> $convertertimeUnit =
      const NullableMaintenanceTimeUnitConverter();
}

class MaintenanceItemRecord extends DataClass
    implements Insertable<MaintenanceItemRecord> {
  final int id;
  final int carProfileId;
  final String description;
  final MaintenanceScheduleType scheduleType;
  final int intervalValue;
  final MaintenanceTimeUnit? timeUnit;
  final DateTime createdAt;
  final DateTime updatedAt;
  const MaintenanceItemRecord({
    required this.id,
    required this.carProfileId,
    required this.description,
    required this.scheduleType,
    required this.intervalValue,
    this.timeUnit,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['car_profile_id'] = Variable<int>(carProfileId);
    map['description'] = Variable<String>(description);
    {
      map['schedule_type'] = Variable<String>(
        $MaintenanceItemsTable.$converterscheduleType.toSql(scheduleType),
      );
    }
    map['interval_value'] = Variable<int>(intervalValue);
    if (!nullToAbsent || timeUnit != null) {
      map['time_unit'] = Variable<String>(
        $MaintenanceItemsTable.$convertertimeUnit.toSql(timeUnit),
      );
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  MaintenanceItemsCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceItemsCompanion(
      id: Value(id),
      carProfileId: Value(carProfileId),
      description: Value(description),
      scheduleType: Value(scheduleType),
      intervalValue: Value(intervalValue),
      timeUnit: timeUnit == null && nullToAbsent
          ? const Value.absent()
          : Value(timeUnit),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory MaintenanceItemRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceItemRecord(
      id: serializer.fromJson<int>(json['id']),
      carProfileId: serializer.fromJson<int>(json['carProfileId']),
      description: serializer.fromJson<String>(json['description']),
      scheduleType: serializer.fromJson<MaintenanceScheduleType>(
        json['scheduleType'],
      ),
      intervalValue: serializer.fromJson<int>(json['intervalValue']),
      timeUnit: serializer.fromJson<MaintenanceTimeUnit?>(json['timeUnit']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime>(json['updatedAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'carProfileId': serializer.toJson<int>(carProfileId),
      'description': serializer.toJson<String>(description),
      'scheduleType': serializer.toJson<MaintenanceScheduleType>(scheduleType),
      'intervalValue': serializer.toJson<int>(intervalValue),
      'timeUnit': serializer.toJson<MaintenanceTimeUnit?>(timeUnit),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  MaintenanceItemRecord copyWith({
    int? id,
    int? carProfileId,
    String? description,
    MaintenanceScheduleType? scheduleType,
    int? intervalValue,
    Value<MaintenanceTimeUnit?> timeUnit = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => MaintenanceItemRecord(
    id: id ?? this.id,
    carProfileId: carProfileId ?? this.carProfileId,
    description: description ?? this.description,
    scheduleType: scheduleType ?? this.scheduleType,
    intervalValue: intervalValue ?? this.intervalValue,
    timeUnit: timeUnit.present ? timeUnit.value : this.timeUnit,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  MaintenanceItemRecord copyWithCompanion(MaintenanceItemsCompanion data) {
    return MaintenanceItemRecord(
      id: data.id.present ? data.id.value : this.id,
      carProfileId: data.carProfileId.present
          ? data.carProfileId.value
          : this.carProfileId,
      description: data.description.present
          ? data.description.value
          : this.description,
      scheduleType: data.scheduleType.present
          ? data.scheduleType.value
          : this.scheduleType,
      intervalValue: data.intervalValue.present
          ? data.intervalValue.value
          : this.intervalValue,
      timeUnit: data.timeUnit.present ? data.timeUnit.value : this.timeUnit,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceItemRecord(')
          ..write('id: $id, ')
          ..write('carProfileId: $carProfileId, ')
          ..write('description: $description, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('intervalValue: $intervalValue, ')
          ..write('timeUnit: $timeUnit, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    carProfileId,
    description,
    scheduleType,
    intervalValue,
    timeUnit,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceItemRecord &&
          other.id == this.id &&
          other.carProfileId == this.carProfileId &&
          other.description == this.description &&
          other.scheduleType == this.scheduleType &&
          other.intervalValue == this.intervalValue &&
          other.timeUnit == this.timeUnit &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class MaintenanceItemsCompanion extends UpdateCompanion<MaintenanceItemRecord> {
  final Value<int> id;
  final Value<int> carProfileId;
  final Value<String> description;
  final Value<MaintenanceScheduleType> scheduleType;
  final Value<int> intervalValue;
  final Value<MaintenanceTimeUnit?> timeUnit;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const MaintenanceItemsCompanion({
    this.id = const Value.absent(),
    this.carProfileId = const Value.absent(),
    this.description = const Value.absent(),
    this.scheduleType = const Value.absent(),
    this.intervalValue = const Value.absent(),
    this.timeUnit = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  MaintenanceItemsCompanion.insert({
    this.id = const Value.absent(),
    required int carProfileId,
    required String description,
    required MaintenanceScheduleType scheduleType,
    required int intervalValue,
    this.timeUnit = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : carProfileId = Value(carProfileId),
       description = Value(description),
       scheduleType = Value(scheduleType),
       intervalValue = Value(intervalValue),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<MaintenanceItemRecord> custom({
    Expression<int>? id,
    Expression<int>? carProfileId,
    Expression<String>? description,
    Expression<String>? scheduleType,
    Expression<int>? intervalValue,
    Expression<String>? timeUnit,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (carProfileId != null) 'car_profile_id': carProfileId,
      if (description != null) 'description': description,
      if (scheduleType != null) 'schedule_type': scheduleType,
      if (intervalValue != null) 'interval_value': intervalValue,
      if (timeUnit != null) 'time_unit': timeUnit,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  MaintenanceItemsCompanion copyWith({
    Value<int>? id,
    Value<int>? carProfileId,
    Value<String>? description,
    Value<MaintenanceScheduleType>? scheduleType,
    Value<int>? intervalValue,
    Value<MaintenanceTimeUnit?>? timeUnit,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return MaintenanceItemsCompanion(
      id: id ?? this.id,
      carProfileId: carProfileId ?? this.carProfileId,
      description: description ?? this.description,
      scheduleType: scheduleType ?? this.scheduleType,
      intervalValue: intervalValue ?? this.intervalValue,
      timeUnit: timeUnit ?? this.timeUnit,
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
    if (carProfileId.present) {
      map['car_profile_id'] = Variable<int>(carProfileId.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (scheduleType.present) {
      map['schedule_type'] = Variable<String>(
        $MaintenanceItemsTable.$converterscheduleType.toSql(scheduleType.value),
      );
    }
    if (intervalValue.present) {
      map['interval_value'] = Variable<int>(intervalValue.value);
    }
    if (timeUnit.present) {
      map['time_unit'] = Variable<String>(
        $MaintenanceItemsTable.$convertertimeUnit.toSql(timeUnit.value),
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
    return (StringBuffer('MaintenanceItemsCompanion(')
          ..write('id: $id, ')
          ..write('carProfileId: $carProfileId, ')
          ..write('description: $description, ')
          ..write('scheduleType: $scheduleType, ')
          ..write('intervalValue: $intervalValue, ')
          ..write('timeUnit: $timeUnit, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $MaintenanceLogsTable extends MaintenanceLogs
    with TableInfo<$MaintenanceLogsTable, MaintenanceLogRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $MaintenanceLogsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _maintenanceItemIdMeta = const VerificationMeta(
    'maintenanceItemId',
  );
  @override
  late final GeneratedColumn<int> maintenanceItemId = GeneratedColumn<int>(
    'maintenance_item_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES maintenance_items (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _performedAtMeta = const VerificationMeta(
    'performedAt',
  );
  @override
  late final GeneratedColumn<DateTime> performedAt = GeneratedColumn<DateTime>(
    'performed_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mileageMeta = const VerificationMeta(
    'mileage',
  );
  @override
  late final GeneratedColumn<int> mileage = GeneratedColumn<int>(
    'mileage',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _noteMeta = const VerificationMeta('note');
  @override
  late final GeneratedColumn<String> note = GeneratedColumn<String>(
    'note',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
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
  @override
  List<GeneratedColumn> get $columns => [
    id,
    maintenanceItemId,
    performedAt,
    mileage,
    note,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'maintenance_logs';
  @override
  VerificationContext validateIntegrity(
    Insertable<MaintenanceLogRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('maintenance_item_id')) {
      context.handle(
        _maintenanceItemIdMeta,
        maintenanceItemId.isAcceptableOrUnknown(
          data['maintenance_item_id']!,
          _maintenanceItemIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_maintenanceItemIdMeta);
    }
    if (data.containsKey('performed_at')) {
      context.handle(
        _performedAtMeta,
        performedAt.isAcceptableOrUnknown(
          data['performed_at']!,
          _performedAtMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_performedAtMeta);
    }
    if (data.containsKey('mileage')) {
      context.handle(
        _mileageMeta,
        mileage.isAcceptableOrUnknown(data['mileage']!, _mileageMeta),
      );
    } else if (isInserting) {
      context.missing(_mileageMeta);
    }
    if (data.containsKey('note')) {
      context.handle(
        _noteMeta,
        note.isAcceptableOrUnknown(data['note']!, _noteMeta),
      );
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  MaintenanceLogRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return MaintenanceLogRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      maintenanceItemId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}maintenance_item_id'],
      )!,
      performedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}performed_at'],
      )!,
      mileage: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}mileage'],
      )!,
      note: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}note'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $MaintenanceLogsTable createAlias(String alias) {
    return $MaintenanceLogsTable(attachedDatabase, alias);
  }
}

class MaintenanceLogRecord extends DataClass
    implements Insertable<MaintenanceLogRecord> {
  final int id;
  final int maintenanceItemId;
  final DateTime performedAt;
  final int mileage;
  final String? note;
  final DateTime createdAt;
  const MaintenanceLogRecord({
    required this.id,
    required this.maintenanceItemId,
    required this.performedAt,
    required this.mileage,
    this.note,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['maintenance_item_id'] = Variable<int>(maintenanceItemId);
    map['performed_at'] = Variable<DateTime>(performedAt);
    map['mileage'] = Variable<int>(mileage);
    if (!nullToAbsent || note != null) {
      map['note'] = Variable<String>(note);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  MaintenanceLogsCompanion toCompanion(bool nullToAbsent) {
    return MaintenanceLogsCompanion(
      id: Value(id),
      maintenanceItemId: Value(maintenanceItemId),
      performedAt: Value(performedAt),
      mileage: Value(mileage),
      note: note == null && nullToAbsent ? const Value.absent() : Value(note),
      createdAt: Value(createdAt),
    );
  }

  factory MaintenanceLogRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return MaintenanceLogRecord(
      id: serializer.fromJson<int>(json['id']),
      maintenanceItemId: serializer.fromJson<int>(json['maintenanceItemId']),
      performedAt: serializer.fromJson<DateTime>(json['performedAt']),
      mileage: serializer.fromJson<int>(json['mileage']),
      note: serializer.fromJson<String?>(json['note']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'maintenanceItemId': serializer.toJson<int>(maintenanceItemId),
      'performedAt': serializer.toJson<DateTime>(performedAt),
      'mileage': serializer.toJson<int>(mileage),
      'note': serializer.toJson<String?>(note),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  MaintenanceLogRecord copyWith({
    int? id,
    int? maintenanceItemId,
    DateTime? performedAt,
    int? mileage,
    Value<String?> note = const Value.absent(),
    DateTime? createdAt,
  }) => MaintenanceLogRecord(
    id: id ?? this.id,
    maintenanceItemId: maintenanceItemId ?? this.maintenanceItemId,
    performedAt: performedAt ?? this.performedAt,
    mileage: mileage ?? this.mileage,
    note: note.present ? note.value : this.note,
    createdAt: createdAt ?? this.createdAt,
  );
  MaintenanceLogRecord copyWithCompanion(MaintenanceLogsCompanion data) {
    return MaintenanceLogRecord(
      id: data.id.present ? data.id.value : this.id,
      maintenanceItemId: data.maintenanceItemId.present
          ? data.maintenanceItemId.value
          : this.maintenanceItemId,
      performedAt: data.performedAt.present
          ? data.performedAt.value
          : this.performedAt,
      mileage: data.mileage.present ? data.mileage.value : this.mileage,
      note: data.note.present ? data.note.value : this.note,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceLogRecord(')
          ..write('id: $id, ')
          ..write('maintenanceItemId: $maintenanceItemId, ')
          ..write('performedAt: $performedAt, ')
          ..write('mileage: $mileage, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, maintenanceItemId, performedAt, mileage, note, createdAt);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is MaintenanceLogRecord &&
          other.id == this.id &&
          other.maintenanceItemId == this.maintenanceItemId &&
          other.performedAt == this.performedAt &&
          other.mileage == this.mileage &&
          other.note == this.note &&
          other.createdAt == this.createdAt);
}

class MaintenanceLogsCompanion extends UpdateCompanion<MaintenanceLogRecord> {
  final Value<int> id;
  final Value<int> maintenanceItemId;
  final Value<DateTime> performedAt;
  final Value<int> mileage;
  final Value<String?> note;
  final Value<DateTime> createdAt;
  const MaintenanceLogsCompanion({
    this.id = const Value.absent(),
    this.maintenanceItemId = const Value.absent(),
    this.performedAt = const Value.absent(),
    this.mileage = const Value.absent(),
    this.note = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  MaintenanceLogsCompanion.insert({
    this.id = const Value.absent(),
    required int maintenanceItemId,
    required DateTime performedAt,
    required int mileage,
    this.note = const Value.absent(),
    required DateTime createdAt,
  }) : maintenanceItemId = Value(maintenanceItemId),
       performedAt = Value(performedAt),
       mileage = Value(mileage),
       createdAt = Value(createdAt);
  static Insertable<MaintenanceLogRecord> custom({
    Expression<int>? id,
    Expression<int>? maintenanceItemId,
    Expression<DateTime>? performedAt,
    Expression<int>? mileage,
    Expression<String>? note,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (maintenanceItemId != null) 'maintenance_item_id': maintenanceItemId,
      if (performedAt != null) 'performed_at': performedAt,
      if (mileage != null) 'mileage': mileage,
      if (note != null) 'note': note,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  MaintenanceLogsCompanion copyWith({
    Value<int>? id,
    Value<int>? maintenanceItemId,
    Value<DateTime>? performedAt,
    Value<int>? mileage,
    Value<String?>? note,
    Value<DateTime>? createdAt,
  }) {
    return MaintenanceLogsCompanion(
      id: id ?? this.id,
      maintenanceItemId: maintenanceItemId ?? this.maintenanceItemId,
      performedAt: performedAt ?? this.performedAt,
      mileage: mileage ?? this.mileage,
      note: note ?? this.note,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (maintenanceItemId.present) {
      map['maintenance_item_id'] = Variable<int>(maintenanceItemId.value);
    }
    if (performedAt.present) {
      map['performed_at'] = Variable<DateTime>(performedAt.value);
    }
    if (mileage.present) {
      map['mileage'] = Variable<int>(mileage.value);
    }
    if (note.present) {
      map['note'] = Variable<String>(note.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('MaintenanceLogsCompanion(')
          ..write('id: $id, ')
          ..write('maintenanceItemId: $maintenanceItemId, ')
          ..write('performedAt: $performedAt, ')
          ..write('mileage: $mileage, ')
          ..write('note: $note, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $CarProfilesTable carProfiles = $CarProfilesTable(this);
  late final $MaintenanceItemsTable maintenanceItems = $MaintenanceItemsTable(
    this,
  );
  late final $MaintenanceLogsTable maintenanceLogs = $MaintenanceLogsTable(
    this,
  );
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    carProfiles,
    maintenanceItems,
    maintenanceLogs,
  ];
  @override
  StreamQueryUpdateRules get streamUpdateRules => const StreamQueryUpdateRules([
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'car_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('maintenance_items', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'maintenance_items',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('maintenance_logs', kind: UpdateKind.delete)],
    ),
  ]);
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

final class $$CarProfilesTableReferences
    extends BaseReferences<_$AppDatabase, $CarProfilesTable, CarProfileRecord> {
  $$CarProfilesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $MaintenanceItemsTable,
    List<MaintenanceItemRecord>
  >
  _maintenanceItemsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.maintenanceItems,
    aliasName: $_aliasNameGenerator(
      db.carProfiles.id,
      db.maintenanceItems.carProfileId,
    ),
  );

  $$MaintenanceItemsTableProcessedTableManager get maintenanceItemsRefs {
    final manager = $$MaintenanceItemsTableTableManager(
      $_db,
      $_db.maintenanceItems,
    ).filter((f) => f.carProfileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _maintenanceItemsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

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

  Expression<bool> maintenanceItemsRefs(
    Expression<bool> Function($$MaintenanceItemsTableFilterComposer f) f,
  ) {
    final $$MaintenanceItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenanceItems,
      getReferencedColumn: (t) => t.carProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceItemsTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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

  Expression<T> maintenanceItemsRefs<T extends Object>(
    Expression<T> Function($$MaintenanceItemsTableAnnotationComposer a) f,
  ) {
    final $$MaintenanceItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenanceItems,
      getReferencedColumn: (t) => t.carProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.maintenanceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
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
          (CarProfileRecord, $$CarProfilesTableReferences),
          CarProfileRecord,
          PrefetchHooks Function({bool maintenanceItemsRefs})
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
              .map(
                (e) => (
                  e.readTable(table),
                  $$CarProfilesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({maintenanceItemsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (maintenanceItemsRefs) db.maintenanceItems,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (maintenanceItemsRefs)
                    await $_getPrefetchedData<
                      CarProfileRecord,
                      $CarProfilesTable,
                      MaintenanceItemRecord
                    >(
                      currentTable: table,
                      referencedTable: $$CarProfilesTableReferences
                          ._maintenanceItemsRefsTable(db),
                      managerFromTypedResult: (p0) =>
                          $$CarProfilesTableReferences(
                            db,
                            table,
                            p0,
                          ).maintenanceItemsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where(
                            (e) => e.carProfileId == item.id,
                          ),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
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
      (CarProfileRecord, $$CarProfilesTableReferences),
      CarProfileRecord,
      PrefetchHooks Function({bool maintenanceItemsRefs})
    >;
typedef $$MaintenanceItemsTableCreateCompanionBuilder =
    MaintenanceItemsCompanion Function({
      Value<int> id,
      required int carProfileId,
      required String description,
      required MaintenanceScheduleType scheduleType,
      required int intervalValue,
      Value<MaintenanceTimeUnit?> timeUnit,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$MaintenanceItemsTableUpdateCompanionBuilder =
    MaintenanceItemsCompanion Function({
      Value<int> id,
      Value<int> carProfileId,
      Value<String> description,
      Value<MaintenanceScheduleType> scheduleType,
      Value<int> intervalValue,
      Value<MaintenanceTimeUnit?> timeUnit,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$MaintenanceItemsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MaintenanceItemsTable,
          MaintenanceItemRecord
        > {
  $$MaintenanceItemsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CarProfilesTable _carProfileIdTable(_$AppDatabase db) =>
      db.carProfiles.createAlias(
        $_aliasNameGenerator(
          db.maintenanceItems.carProfileId,
          db.carProfiles.id,
        ),
      );

  $$CarProfilesTableProcessedTableManager get carProfileId {
    final $_column = $_itemColumn<int>('car_profile_id')!;

    final manager = $$CarProfilesTableTableManager(
      $_db,
      $_db.carProfiles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_carProfileIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static MultiTypedResultKey<$MaintenanceLogsTable, List<MaintenanceLogRecord>>
  _maintenanceLogsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.maintenanceLogs,
    aliasName: $_aliasNameGenerator(
      db.maintenanceItems.id,
      db.maintenanceLogs.maintenanceItemId,
    ),
  );

  $$MaintenanceLogsTableProcessedTableManager get maintenanceLogsRefs {
    final manager = $$MaintenanceLogsTableTableManager(
      $_db,
      $_db.maintenanceLogs,
    ).filter((f) => f.maintenanceItemId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _maintenanceLogsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$MaintenanceItemsTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceItemsTable> {
  $$MaintenanceItemsTableFilterComposer({
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

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    MaintenanceScheduleType,
    MaintenanceScheduleType,
    String
  >
  get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<int> get intervalValue => $composableBuilder(
    column: $table.intervalValue,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<
    MaintenanceTimeUnit?,
    MaintenanceTimeUnit,
    String
  >
  get timeUnit => $composableBuilder(
    column: $table.timeUnit,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  $$CarProfilesTableFilterComposer get carProfileId {
    final $$CarProfilesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carProfileId,
      referencedTable: $db.carProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarProfilesTableFilterComposer(
            $db: $db,
            $table: $db.carProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<bool> maintenanceLogsRefs(
    Expression<bool> Function($$MaintenanceLogsTableFilterComposer f) f,
  ) {
    final $$MaintenanceLogsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenanceLogs,
      getReferencedColumn: (t) => t.maintenanceItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceLogsTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaintenanceItemsTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceItemsTable> {
  $$MaintenanceItemsTableOrderingComposer({
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

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get intervalValue => $composableBuilder(
    column: $table.intervalValue,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get timeUnit => $composableBuilder(
    column: $table.timeUnit,
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

  $$CarProfilesTableOrderingComposer get carProfileId {
    final $$CarProfilesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carProfileId,
      referencedTable: $db.carProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarProfilesTableOrderingComposer(
            $db: $db,
            $table: $db.carProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceItemsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceItemsTable> {
  $$MaintenanceItemsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<MaintenanceScheduleType, String>
  get scheduleType => $composableBuilder(
    column: $table.scheduleType,
    builder: (column) => column,
  );

  GeneratedColumn<int> get intervalValue => $composableBuilder(
    column: $table.intervalValue,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<MaintenanceTimeUnit?, String> get timeUnit =>
      $composableBuilder(column: $table.timeUnit, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  $$CarProfilesTableAnnotationComposer get carProfileId {
    final $$CarProfilesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.carProfileId,
      referencedTable: $db.carProfiles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$CarProfilesTableAnnotationComposer(
            $db: $db,
            $table: $db.carProfiles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  Expression<T> maintenanceLogsRefs<T extends Object>(
    Expression<T> Function($$MaintenanceLogsTableAnnotationComposer a) f,
  ) {
    final $$MaintenanceLogsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.maintenanceLogs,
      getReferencedColumn: (t) => t.maintenanceItemId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceLogsTableAnnotationComposer(
            $db: $db,
            $table: $db.maintenanceLogs,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$MaintenanceItemsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceItemsTable,
          MaintenanceItemRecord,
          $$MaintenanceItemsTableFilterComposer,
          $$MaintenanceItemsTableOrderingComposer,
          $$MaintenanceItemsTableAnnotationComposer,
          $$MaintenanceItemsTableCreateCompanionBuilder,
          $$MaintenanceItemsTableUpdateCompanionBuilder,
          (MaintenanceItemRecord, $$MaintenanceItemsTableReferences),
          MaintenanceItemRecord,
          PrefetchHooks Function({bool carProfileId, bool maintenanceLogsRefs})
        > {
  $$MaintenanceItemsTableTableManager(
    _$AppDatabase db,
    $MaintenanceItemsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceItemsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceItemsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenanceItemsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> carProfileId = const Value.absent(),
                Value<String> description = const Value.absent(),
                Value<MaintenanceScheduleType> scheduleType =
                    const Value.absent(),
                Value<int> intervalValue = const Value.absent(),
                Value<MaintenanceTimeUnit?> timeUnit = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => MaintenanceItemsCompanion(
                id: id,
                carProfileId: carProfileId,
                description: description,
                scheduleType: scheduleType,
                intervalValue: intervalValue,
                timeUnit: timeUnit,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int carProfileId,
                required String description,
                required MaintenanceScheduleType scheduleType,
                required int intervalValue,
                Value<MaintenanceTimeUnit?> timeUnit = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => MaintenanceItemsCompanion.insert(
                id: id,
                carProfileId: carProfileId,
                description: description,
                scheduleType: scheduleType,
                intervalValue: intervalValue,
                timeUnit: timeUnit,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MaintenanceItemsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({carProfileId = false, maintenanceLogsRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (maintenanceLogsRefs) db.maintenanceLogs,
                  ],
                  addJoins:
                      <
                        T extends TableManagerState<
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic,
                          dynamic
                        >
                      >(state) {
                        if (carProfileId) {
                          state =
                              state.withJoin(
                                    currentTable: table,
                                    currentColumn: table.carProfileId,
                                    referencedTable:
                                        $$MaintenanceItemsTableReferences
                                            ._carProfileIdTable(db),
                                    referencedColumn:
                                        $$MaintenanceItemsTableReferences
                                            ._carProfileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (maintenanceLogsRefs)
                        await $_getPrefetchedData<
                          MaintenanceItemRecord,
                          $MaintenanceItemsTable,
                          MaintenanceLogRecord
                        >(
                          currentTable: table,
                          referencedTable: $$MaintenanceItemsTableReferences
                              ._maintenanceLogsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$MaintenanceItemsTableReferences(
                                db,
                                table,
                                p0,
                              ).maintenanceLogsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.maintenanceItemId == item.id,
                              ),
                          typedResults: items,
                        ),
                    ];
                  },
                );
              },
        ),
      );
}

typedef $$MaintenanceItemsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceItemsTable,
      MaintenanceItemRecord,
      $$MaintenanceItemsTableFilterComposer,
      $$MaintenanceItemsTableOrderingComposer,
      $$MaintenanceItemsTableAnnotationComposer,
      $$MaintenanceItemsTableCreateCompanionBuilder,
      $$MaintenanceItemsTableUpdateCompanionBuilder,
      (MaintenanceItemRecord, $$MaintenanceItemsTableReferences),
      MaintenanceItemRecord,
      PrefetchHooks Function({bool carProfileId, bool maintenanceLogsRefs})
    >;
typedef $$MaintenanceLogsTableCreateCompanionBuilder =
    MaintenanceLogsCompanion Function({
      Value<int> id,
      required int maintenanceItemId,
      required DateTime performedAt,
      required int mileage,
      Value<String?> note,
      required DateTime createdAt,
    });
typedef $$MaintenanceLogsTableUpdateCompanionBuilder =
    MaintenanceLogsCompanion Function({
      Value<int> id,
      Value<int> maintenanceItemId,
      Value<DateTime> performedAt,
      Value<int> mileage,
      Value<String?> note,
      Value<DateTime> createdAt,
    });

final class $$MaintenanceLogsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $MaintenanceLogsTable,
          MaintenanceLogRecord
        > {
  $$MaintenanceLogsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $MaintenanceItemsTable _maintenanceItemIdTable(_$AppDatabase db) =>
      db.maintenanceItems.createAlias(
        $_aliasNameGenerator(
          db.maintenanceLogs.maintenanceItemId,
          db.maintenanceItems.id,
        ),
      );

  $$MaintenanceItemsTableProcessedTableManager get maintenanceItemId {
    final $_column = $_itemColumn<int>('maintenance_item_id')!;

    final manager = $$MaintenanceItemsTableTableManager(
      $_db,
      $_db.maintenanceItems,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_maintenanceItemIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$MaintenanceLogsTableFilterComposer
    extends Composer<_$AppDatabase, $MaintenanceLogsTable> {
  $$MaintenanceLogsTableFilterComposer({
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

  ColumnFilters<DateTime> get performedAt => $composableBuilder(
    column: $table.performedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$MaintenanceItemsTableFilterComposer get maintenanceItemId {
    final $$MaintenanceItemsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.maintenanceItemId,
      referencedTable: $db.maintenanceItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceItemsTableFilterComposer(
            $db: $db,
            $table: $db.maintenanceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceLogsTableOrderingComposer
    extends Composer<_$AppDatabase, $MaintenanceLogsTable> {
  $$MaintenanceLogsTableOrderingComposer({
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

  ColumnOrderings<DateTime> get performedAt => $composableBuilder(
    column: $table.performedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get mileage => $composableBuilder(
    column: $table.mileage,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get note => $composableBuilder(
    column: $table.note,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$MaintenanceItemsTableOrderingComposer get maintenanceItemId {
    final $$MaintenanceItemsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.maintenanceItemId,
      referencedTable: $db.maintenanceItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceItemsTableOrderingComposer(
            $db: $db,
            $table: $db.maintenanceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceLogsTableAnnotationComposer
    extends Composer<_$AppDatabase, $MaintenanceLogsTable> {
  $$MaintenanceLogsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get performedAt => $composableBuilder(
    column: $table.performedAt,
    builder: (column) => column,
  );

  GeneratedColumn<int> get mileage =>
      $composableBuilder(column: $table.mileage, builder: (column) => column);

  GeneratedColumn<String> get note =>
      $composableBuilder(column: $table.note, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$MaintenanceItemsTableAnnotationComposer get maintenanceItemId {
    final $$MaintenanceItemsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.maintenanceItemId,
      referencedTable: $db.maintenanceItems,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$MaintenanceItemsTableAnnotationComposer(
            $db: $db,
            $table: $db.maintenanceItems,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$MaintenanceLogsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $MaintenanceLogsTable,
          MaintenanceLogRecord,
          $$MaintenanceLogsTableFilterComposer,
          $$MaintenanceLogsTableOrderingComposer,
          $$MaintenanceLogsTableAnnotationComposer,
          $$MaintenanceLogsTableCreateCompanionBuilder,
          $$MaintenanceLogsTableUpdateCompanionBuilder,
          (MaintenanceLogRecord, $$MaintenanceLogsTableReferences),
          MaintenanceLogRecord,
          PrefetchHooks Function({bool maintenanceItemId})
        > {
  $$MaintenanceLogsTableTableManager(
    _$AppDatabase db,
    $MaintenanceLogsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$MaintenanceLogsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$MaintenanceLogsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$MaintenanceLogsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> maintenanceItemId = const Value.absent(),
                Value<DateTime> performedAt = const Value.absent(),
                Value<int> mileage = const Value.absent(),
                Value<String?> note = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => MaintenanceLogsCompanion(
                id: id,
                maintenanceItemId: maintenanceItemId,
                performedAt: performedAt,
                mileage: mileage,
                note: note,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int maintenanceItemId,
                required DateTime performedAt,
                required int mileage,
                Value<String?> note = const Value.absent(),
                required DateTime createdAt,
              }) => MaintenanceLogsCompanion.insert(
                id: id,
                maintenanceItemId: maintenanceItemId,
                performedAt: performedAt,
                mileage: mileage,
                note: note,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$MaintenanceLogsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({maintenanceItemId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (maintenanceItemId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.maintenanceItemId,
                                referencedTable:
                                    $$MaintenanceLogsTableReferences
                                        ._maintenanceItemIdTable(db),
                                referencedColumn:
                                    $$MaintenanceLogsTableReferences
                                        ._maintenanceItemIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$MaintenanceLogsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $MaintenanceLogsTable,
      MaintenanceLogRecord,
      $$MaintenanceLogsTableFilterComposer,
      $$MaintenanceLogsTableOrderingComposer,
      $$MaintenanceLogsTableAnnotationComposer,
      $$MaintenanceLogsTableCreateCompanionBuilder,
      $$MaintenanceLogsTableUpdateCompanionBuilder,
      (MaintenanceLogRecord, $$MaintenanceLogsTableReferences),
      MaintenanceLogRecord,
      PrefetchHooks Function({bool maintenanceItemId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$CarProfilesTableTableManager get carProfiles =>
      $$CarProfilesTableTableManager(_db, _db.carProfiles);
  $$MaintenanceItemsTableTableManager get maintenanceItems =>
      $$MaintenanceItemsTableTableManager(_db, _db.maintenanceItems);
  $$MaintenanceLogsTableTableManager get maintenanceLogs =>
      $$MaintenanceLogsTableTableManager(_db, _db.maintenanceLogs);
}
