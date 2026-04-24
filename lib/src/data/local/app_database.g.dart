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

class $RepairEntriesTable extends RepairEntries
    with TableInfo<$RepairEntriesTable, RepairEntryRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepairEntriesTable(this.attachedDatabase, [this._alias]);
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
  @override
  late final GeneratedColumnWithTypeConverter<RepairStatus, String> status =
      GeneratedColumn<String>(
        'status',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<RepairStatus>($RepairEntriesTable.$converterstatus);
  static const VerificationMeta _isModificationMeta = const VerificationMeta(
    'isModification',
  );
  @override
  late final GeneratedColumn<bool> isModification = GeneratedColumn<bool>(
    'is_modification',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_modification" IN (0, 1))',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RepairArea, String> area =
      GeneratedColumn<String>(
        'area',
        aliasedName,
        false,
        type: DriftSqlType.string,
        requiredDuringInsert: true,
      ).withConverter<RepairArea>($RepairEntriesTable.$converterarea);
  @override
  late final GeneratedColumnWithTypeConverter<RepairUrgency?, String> urgency =
      GeneratedColumn<String>(
        'urgency',
        aliasedName,
        true,
        type: DriftSqlType.string,
        requiredDuringInsert: false,
      ).withConverter<RepairUrgency?>($RepairEntriesTable.$converterurgency);
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _descriptionMeta = const VerificationMeta(
    'description',
  );
  @override
  late final GeneratedColumn<String> description = GeneratedColumn<String>(
    'description',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _completedAtMeta = const VerificationMeta(
    'completedAt',
  );
  @override
  late final GeneratedColumn<DateTime> completedAt = GeneratedColumn<DateTime>(
    'completed_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
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
    status,
    isModification,
    area,
    urgency,
    title,
    description,
    completedAt,
    createdAt,
    updatedAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repair_entries';
  @override
  VerificationContext validateIntegrity(
    Insertable<RepairEntryRecord> instance, {
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
    if (data.containsKey('is_modification')) {
      context.handle(
        _isModificationMeta,
        isModification.isAcceptableOrUnknown(
          data['is_modification']!,
          _isModificationMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_isModificationMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('description')) {
      context.handle(
        _descriptionMeta,
        description.isAcceptableOrUnknown(
          data['description']!,
          _descriptionMeta,
        ),
      );
    }
    if (data.containsKey('completed_at')) {
      context.handle(
        _completedAtMeta,
        completedAt.isAcceptableOrUnknown(
          data['completed_at']!,
          _completedAtMeta,
        ),
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
  RepairEntryRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepairEntryRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      carProfileId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}car_profile_id'],
      )!,
      status: $RepairEntriesTable.$converterstatus.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}status'],
        )!,
      ),
      isModification: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_modification'],
      )!,
      area: $RepairEntriesTable.$converterarea.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}area'],
        )!,
      ),
      urgency: $RepairEntriesTable.$converterurgency.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}urgency'],
        ),
      ),
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      description: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}description'],
      ),
      completedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}completed_at'],
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
  $RepairEntriesTable createAlias(String alias) {
    return $RepairEntriesTable(attachedDatabase, alias);
  }

  static TypeConverter<RepairStatus, String> $converterstatus =
      const RepairStatusConverter();
  static TypeConverter<RepairArea, String> $converterarea =
      const RepairAreaConverter();
  static TypeConverter<RepairUrgency?, String?> $converterurgency =
      const NullableRepairUrgencyConverter();
}

class RepairEntryRecord extends DataClass
    implements Insertable<RepairEntryRecord> {
  final int id;
  final int carProfileId;
  final RepairStatus status;
  final bool isModification;
  final RepairArea area;
  final RepairUrgency? urgency;
  final String title;
  final String? description;
  final DateTime? completedAt;
  final DateTime createdAt;
  final DateTime updatedAt;
  const RepairEntryRecord({
    required this.id,
    required this.carProfileId,
    required this.status,
    required this.isModification,
    required this.area,
    this.urgency,
    required this.title,
    this.description,
    this.completedAt,
    required this.createdAt,
    required this.updatedAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['car_profile_id'] = Variable<int>(carProfileId);
    {
      map['status'] = Variable<String>(
        $RepairEntriesTable.$converterstatus.toSql(status),
      );
    }
    map['is_modification'] = Variable<bool>(isModification);
    {
      map['area'] = Variable<String>(
        $RepairEntriesTable.$converterarea.toSql(area),
      );
    }
    if (!nullToAbsent || urgency != null) {
      map['urgency'] = Variable<String>(
        $RepairEntriesTable.$converterurgency.toSql(urgency),
      );
    }
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || description != null) {
      map['description'] = Variable<String>(description);
    }
    if (!nullToAbsent || completedAt != null) {
      map['completed_at'] = Variable<DateTime>(completedAt);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    map['updated_at'] = Variable<DateTime>(updatedAt);
    return map;
  }

  RepairEntriesCompanion toCompanion(bool nullToAbsent) {
    return RepairEntriesCompanion(
      id: Value(id),
      carProfileId: Value(carProfileId),
      status: Value(status),
      isModification: Value(isModification),
      area: Value(area),
      urgency: urgency == null && nullToAbsent
          ? const Value.absent()
          : Value(urgency),
      title: Value(title),
      description: description == null && nullToAbsent
          ? const Value.absent()
          : Value(description),
      completedAt: completedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(completedAt),
      createdAt: Value(createdAt),
      updatedAt: Value(updatedAt),
    );
  }

  factory RepairEntryRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepairEntryRecord(
      id: serializer.fromJson<int>(json['id']),
      carProfileId: serializer.fromJson<int>(json['carProfileId']),
      status: serializer.fromJson<RepairStatus>(json['status']),
      isModification: serializer.fromJson<bool>(json['isModification']),
      area: serializer.fromJson<RepairArea>(json['area']),
      urgency: serializer.fromJson<RepairUrgency?>(json['urgency']),
      title: serializer.fromJson<String>(json['title']),
      description: serializer.fromJson<String?>(json['description']),
      completedAt: serializer.fromJson<DateTime?>(json['completedAt']),
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
      'status': serializer.toJson<RepairStatus>(status),
      'isModification': serializer.toJson<bool>(isModification),
      'area': serializer.toJson<RepairArea>(area),
      'urgency': serializer.toJson<RepairUrgency?>(urgency),
      'title': serializer.toJson<String>(title),
      'description': serializer.toJson<String?>(description),
      'completedAt': serializer.toJson<DateTime?>(completedAt),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime>(updatedAt),
    };
  }

  RepairEntryRecord copyWith({
    int? id,
    int? carProfileId,
    RepairStatus? status,
    bool? isModification,
    RepairArea? area,
    Value<RepairUrgency?> urgency = const Value.absent(),
    String? title,
    Value<String?> description = const Value.absent(),
    Value<DateTime?> completedAt = const Value.absent(),
    DateTime? createdAt,
    DateTime? updatedAt,
  }) => RepairEntryRecord(
    id: id ?? this.id,
    carProfileId: carProfileId ?? this.carProfileId,
    status: status ?? this.status,
    isModification: isModification ?? this.isModification,
    area: area ?? this.area,
    urgency: urgency.present ? urgency.value : this.urgency,
    title: title ?? this.title,
    description: description.present ? description.value : this.description,
    completedAt: completedAt.present ? completedAt.value : this.completedAt,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt ?? this.updatedAt,
  );
  RepairEntryRecord copyWithCompanion(RepairEntriesCompanion data) {
    return RepairEntryRecord(
      id: data.id.present ? data.id.value : this.id,
      carProfileId: data.carProfileId.present
          ? data.carProfileId.value
          : this.carProfileId,
      status: data.status.present ? data.status.value : this.status,
      isModification: data.isModification.present
          ? data.isModification.value
          : this.isModification,
      area: data.area.present ? data.area.value : this.area,
      urgency: data.urgency.present ? data.urgency.value : this.urgency,
      title: data.title.present ? data.title.value : this.title,
      description: data.description.present
          ? data.description.value
          : this.description,
      completedAt: data.completedAt.present
          ? data.completedAt.value
          : this.completedAt,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepairEntryRecord(')
          ..write('id: $id, ')
          ..write('carProfileId: $carProfileId, ')
          ..write('status: $status, ')
          ..write('isModification: $isModification, ')
          ..write('area: $area, ')
          ..write('urgency: $urgency, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    carProfileId,
    status,
    isModification,
    area,
    urgency,
    title,
    description,
    completedAt,
    createdAt,
    updatedAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepairEntryRecord &&
          other.id == this.id &&
          other.carProfileId == this.carProfileId &&
          other.status == this.status &&
          other.isModification == this.isModification &&
          other.area == this.area &&
          other.urgency == this.urgency &&
          other.title == this.title &&
          other.description == this.description &&
          other.completedAt == this.completedAt &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt);
}

class RepairEntriesCompanion extends UpdateCompanion<RepairEntryRecord> {
  final Value<int> id;
  final Value<int> carProfileId;
  final Value<RepairStatus> status;
  final Value<bool> isModification;
  final Value<RepairArea> area;
  final Value<RepairUrgency?> urgency;
  final Value<String> title;
  final Value<String?> description;
  final Value<DateTime?> completedAt;
  final Value<DateTime> createdAt;
  final Value<DateTime> updatedAt;
  const RepairEntriesCompanion({
    this.id = const Value.absent(),
    this.carProfileId = const Value.absent(),
    this.status = const Value.absent(),
    this.isModification = const Value.absent(),
    this.area = const Value.absent(),
    this.urgency = const Value.absent(),
    this.title = const Value.absent(),
    this.description = const Value.absent(),
    this.completedAt = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
  });
  RepairEntriesCompanion.insert({
    this.id = const Value.absent(),
    required int carProfileId,
    required RepairStatus status,
    required bool isModification,
    required RepairArea area,
    this.urgency = const Value.absent(),
    required String title,
    this.description = const Value.absent(),
    this.completedAt = const Value.absent(),
    required DateTime createdAt,
    required DateTime updatedAt,
  }) : carProfileId = Value(carProfileId),
       status = Value(status),
       isModification = Value(isModification),
       area = Value(area),
       title = Value(title),
       createdAt = Value(createdAt),
       updatedAt = Value(updatedAt);
  static Insertable<RepairEntryRecord> custom({
    Expression<int>? id,
    Expression<int>? carProfileId,
    Expression<String>? status,
    Expression<bool>? isModification,
    Expression<String>? area,
    Expression<String>? urgency,
    Expression<String>? title,
    Expression<String>? description,
    Expression<DateTime>? completedAt,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (carProfileId != null) 'car_profile_id': carProfileId,
      if (status != null) 'status': status,
      if (isModification != null) 'is_modification': isModification,
      if (area != null) 'area': area,
      if (urgency != null) 'urgency': urgency,
      if (title != null) 'title': title,
      if (description != null) 'description': description,
      if (completedAt != null) 'completed_at': completedAt,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
    });
  }

  RepairEntriesCompanion copyWith({
    Value<int>? id,
    Value<int>? carProfileId,
    Value<RepairStatus>? status,
    Value<bool>? isModification,
    Value<RepairArea>? area,
    Value<RepairUrgency?>? urgency,
    Value<String>? title,
    Value<String?>? description,
    Value<DateTime?>? completedAt,
    Value<DateTime>? createdAt,
    Value<DateTime>? updatedAt,
  }) {
    return RepairEntriesCompanion(
      id: id ?? this.id,
      carProfileId: carProfileId ?? this.carProfileId,
      status: status ?? this.status,
      isModification: isModification ?? this.isModification,
      area: area ?? this.area,
      urgency: urgency ?? this.urgency,
      title: title ?? this.title,
      description: description ?? this.description,
      completedAt: completedAt ?? this.completedAt,
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
    if (status.present) {
      map['status'] = Variable<String>(
        $RepairEntriesTable.$converterstatus.toSql(status.value),
      );
    }
    if (isModification.present) {
      map['is_modification'] = Variable<bool>(isModification.value);
    }
    if (area.present) {
      map['area'] = Variable<String>(
        $RepairEntriesTable.$converterarea.toSql(area.value),
      );
    }
    if (urgency.present) {
      map['urgency'] = Variable<String>(
        $RepairEntriesTable.$converterurgency.toSql(urgency.value),
      );
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (description.present) {
      map['description'] = Variable<String>(description.value);
    }
    if (completedAt.present) {
      map['completed_at'] = Variable<DateTime>(completedAt.value);
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
    return (StringBuffer('RepairEntriesCompanion(')
          ..write('id: $id, ')
          ..write('carProfileId: $carProfileId, ')
          ..write('status: $status, ')
          ..write('isModification: $isModification, ')
          ..write('area: $area, ')
          ..write('urgency: $urgency, ')
          ..write('title: $title, ')
          ..write('description: $description, ')
          ..write('completedAt: $completedAt, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt')
          ..write(')'))
        .toString();
  }
}

class $RepairPartsTable extends RepairParts
    with TableInfo<$RepairPartsTable, RepairPartRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepairPartsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _repairEntryIdMeta = const VerificationMeta(
    'repairEntryId',
  );
  @override
  late final GeneratedColumn<int> repairEntryId = GeneratedColumn<int>(
    'repair_entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES repair_entries (id) ON DELETE CASCADE',
    ),
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _linkMeta = const VerificationMeta('link');
  @override
  late final GeneratedColumn<String> link = GeneratedColumn<String>(
    'link',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [id, repairEntryId, title, link];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repair_parts';
  @override
  VerificationContext validateIntegrity(
    Insertable<RepairPartRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('repair_entry_id')) {
      context.handle(
        _repairEntryIdMeta,
        repairEntryId.isAcceptableOrUnknown(
          data['repair_entry_id']!,
          _repairEntryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_repairEntryIdMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('link')) {
      context.handle(
        _linkMeta,
        link.isAcceptableOrUnknown(data['link']!, _linkMeta),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RepairPartRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepairPartRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      repairEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repair_entry_id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      link: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}link'],
      ),
    );
  }

  @override
  $RepairPartsTable createAlias(String alias) {
    return $RepairPartsTable(attachedDatabase, alias);
  }
}

class RepairPartRecord extends DataClass
    implements Insertable<RepairPartRecord> {
  final int id;
  final int repairEntryId;
  final String title;
  final String? link;
  const RepairPartRecord({
    required this.id,
    required this.repairEntryId,
    required this.title,
    this.link,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['repair_entry_id'] = Variable<int>(repairEntryId);
    map['title'] = Variable<String>(title);
    if (!nullToAbsent || link != null) {
      map['link'] = Variable<String>(link);
    }
    return map;
  }

  RepairPartsCompanion toCompanion(bool nullToAbsent) {
    return RepairPartsCompanion(
      id: Value(id),
      repairEntryId: Value(repairEntryId),
      title: Value(title),
      link: link == null && nullToAbsent ? const Value.absent() : Value(link),
    );
  }

  factory RepairPartRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepairPartRecord(
      id: serializer.fromJson<int>(json['id']),
      repairEntryId: serializer.fromJson<int>(json['repairEntryId']),
      title: serializer.fromJson<String>(json['title']),
      link: serializer.fromJson<String?>(json['link']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'repairEntryId': serializer.toJson<int>(repairEntryId),
      'title': serializer.toJson<String>(title),
      'link': serializer.toJson<String?>(link),
    };
  }

  RepairPartRecord copyWith({
    int? id,
    int? repairEntryId,
    String? title,
    Value<String?> link = const Value.absent(),
  }) => RepairPartRecord(
    id: id ?? this.id,
    repairEntryId: repairEntryId ?? this.repairEntryId,
    title: title ?? this.title,
    link: link.present ? link.value : this.link,
  );
  RepairPartRecord copyWithCompanion(RepairPartsCompanion data) {
    return RepairPartRecord(
      id: data.id.present ? data.id.value : this.id,
      repairEntryId: data.repairEntryId.present
          ? data.repairEntryId.value
          : this.repairEntryId,
      title: data.title.present ? data.title.value : this.title,
      link: data.link.present ? data.link.value : this.link,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepairPartRecord(')
          ..write('id: $id, ')
          ..write('repairEntryId: $repairEntryId, ')
          ..write('title: $title, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, repairEntryId, title, link);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepairPartRecord &&
          other.id == this.id &&
          other.repairEntryId == this.repairEntryId &&
          other.title == this.title &&
          other.link == this.link);
}

class RepairPartsCompanion extends UpdateCompanion<RepairPartRecord> {
  final Value<int> id;
  final Value<int> repairEntryId;
  final Value<String> title;
  final Value<String?> link;
  const RepairPartsCompanion({
    this.id = const Value.absent(),
    this.repairEntryId = const Value.absent(),
    this.title = const Value.absent(),
    this.link = const Value.absent(),
  });
  RepairPartsCompanion.insert({
    this.id = const Value.absent(),
    required int repairEntryId,
    required String title,
    this.link = const Value.absent(),
  }) : repairEntryId = Value(repairEntryId),
       title = Value(title);
  static Insertable<RepairPartRecord> custom({
    Expression<int>? id,
    Expression<int>? repairEntryId,
    Expression<String>? title,
    Expression<String>? link,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (repairEntryId != null) 'repair_entry_id': repairEntryId,
      if (title != null) 'title': title,
      if (link != null) 'link': link,
    });
  }

  RepairPartsCompanion copyWith({
    Value<int>? id,
    Value<int>? repairEntryId,
    Value<String>? title,
    Value<String?>? link,
  }) {
    return RepairPartsCompanion(
      id: id ?? this.id,
      repairEntryId: repairEntryId ?? this.repairEntryId,
      title: title ?? this.title,
      link: link ?? this.link,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (repairEntryId.present) {
      map['repair_entry_id'] = Variable<int>(repairEntryId.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (link.present) {
      map['link'] = Variable<String>(link.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepairPartsCompanion(')
          ..write('id: $id, ')
          ..write('repairEntryId: $repairEntryId, ')
          ..write('title: $title, ')
          ..write('link: $link')
          ..write(')'))
        .toString();
  }
}

class $RepairAttachmentsTable extends RepairAttachments
    with TableInfo<$RepairAttachmentsTable, RepairAttachmentRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $RepairAttachmentsTable(this.attachedDatabase, [this._alias]);
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
  static const VerificationMeta _repairEntryIdMeta = const VerificationMeta(
    'repairEntryId',
  );
  @override
  late final GeneratedColumn<int> repairEntryId = GeneratedColumn<int>(
    'repair_entry_id',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES repair_entries (id) ON DELETE CASCADE',
    ),
  );
  @override
  late final GeneratedColumnWithTypeConverter<RepairAttachmentKind, String>
  kind = GeneratedColumn<String>(
    'kind',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  ).withConverter<RepairAttachmentKind>($RepairAttachmentsTable.$converterkind);
  static const VerificationMeta _storedPathMeta = const VerificationMeta(
    'storedPath',
  );
  @override
  late final GeneratedColumn<String> storedPath = GeneratedColumn<String>(
    'stored_path',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _originalNameMeta = const VerificationMeta(
    'originalName',
  );
  @override
  late final GeneratedColumn<String> originalName = GeneratedColumn<String>(
    'original_name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _mimeTypeMeta = const VerificationMeta(
    'mimeType',
  );
  @override
  late final GeneratedColumn<String> mimeType = GeneratedColumn<String>(
    'mime_type',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _fileExtensionMeta = const VerificationMeta(
    'fileExtension',
  );
  @override
  late final GeneratedColumn<String> fileExtension = GeneratedColumn<String>(
    'file_extension',
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
    repairEntryId,
    kind,
    storedPath,
    originalName,
    mimeType,
    fileExtension,
    createdAt,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'repair_attachments';
  @override
  VerificationContext validateIntegrity(
    Insertable<RepairAttachmentRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('repair_entry_id')) {
      context.handle(
        _repairEntryIdMeta,
        repairEntryId.isAcceptableOrUnknown(
          data['repair_entry_id']!,
          _repairEntryIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_repairEntryIdMeta);
    }
    if (data.containsKey('stored_path')) {
      context.handle(
        _storedPathMeta,
        storedPath.isAcceptableOrUnknown(data['stored_path']!, _storedPathMeta),
      );
    } else if (isInserting) {
      context.missing(_storedPathMeta);
    }
    if (data.containsKey('original_name')) {
      context.handle(
        _originalNameMeta,
        originalName.isAcceptableOrUnknown(
          data['original_name']!,
          _originalNameMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_originalNameMeta);
    }
    if (data.containsKey('mime_type')) {
      context.handle(
        _mimeTypeMeta,
        mimeType.isAcceptableOrUnknown(data['mime_type']!, _mimeTypeMeta),
      );
    }
    if (data.containsKey('file_extension')) {
      context.handle(
        _fileExtensionMeta,
        fileExtension.isAcceptableOrUnknown(
          data['file_extension']!,
          _fileExtensionMeta,
        ),
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
  RepairAttachmentRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return RepairAttachmentRecord(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      repairEntryId: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}repair_entry_id'],
      )!,
      kind: $RepairAttachmentsTable.$converterkind.fromSql(
        attachedDatabase.typeMapping.read(
          DriftSqlType.string,
          data['${effectivePrefix}kind'],
        )!,
      ),
      storedPath: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}stored_path'],
      )!,
      originalName: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}original_name'],
      )!,
      mimeType: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}mime_type'],
      ),
      fileExtension: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}file_extension'],
      ),
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
    );
  }

  @override
  $RepairAttachmentsTable createAlias(String alias) {
    return $RepairAttachmentsTable(attachedDatabase, alias);
  }

  static TypeConverter<RepairAttachmentKind, String> $converterkind =
      const RepairAttachmentKindConverter();
}

class RepairAttachmentRecord extends DataClass
    implements Insertable<RepairAttachmentRecord> {
  final int id;
  final int repairEntryId;
  final RepairAttachmentKind kind;
  final String storedPath;
  final String originalName;
  final String? mimeType;
  final String? fileExtension;
  final DateTime createdAt;
  const RepairAttachmentRecord({
    required this.id,
    required this.repairEntryId,
    required this.kind,
    required this.storedPath,
    required this.originalName,
    this.mimeType,
    this.fileExtension,
    required this.createdAt,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['repair_entry_id'] = Variable<int>(repairEntryId);
    {
      map['kind'] = Variable<String>(
        $RepairAttachmentsTable.$converterkind.toSql(kind),
      );
    }
    map['stored_path'] = Variable<String>(storedPath);
    map['original_name'] = Variable<String>(originalName);
    if (!nullToAbsent || mimeType != null) {
      map['mime_type'] = Variable<String>(mimeType);
    }
    if (!nullToAbsent || fileExtension != null) {
      map['file_extension'] = Variable<String>(fileExtension);
    }
    map['created_at'] = Variable<DateTime>(createdAt);
    return map;
  }

  RepairAttachmentsCompanion toCompanion(bool nullToAbsent) {
    return RepairAttachmentsCompanion(
      id: Value(id),
      repairEntryId: Value(repairEntryId),
      kind: Value(kind),
      storedPath: Value(storedPath),
      originalName: Value(originalName),
      mimeType: mimeType == null && nullToAbsent
          ? const Value.absent()
          : Value(mimeType),
      fileExtension: fileExtension == null && nullToAbsent
          ? const Value.absent()
          : Value(fileExtension),
      createdAt: Value(createdAt),
    );
  }

  factory RepairAttachmentRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return RepairAttachmentRecord(
      id: serializer.fromJson<int>(json['id']),
      repairEntryId: serializer.fromJson<int>(json['repairEntryId']),
      kind: serializer.fromJson<RepairAttachmentKind>(json['kind']),
      storedPath: serializer.fromJson<String>(json['storedPath']),
      originalName: serializer.fromJson<String>(json['originalName']),
      mimeType: serializer.fromJson<String?>(json['mimeType']),
      fileExtension: serializer.fromJson<String?>(json['fileExtension']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'repairEntryId': serializer.toJson<int>(repairEntryId),
      'kind': serializer.toJson<RepairAttachmentKind>(kind),
      'storedPath': serializer.toJson<String>(storedPath),
      'originalName': serializer.toJson<String>(originalName),
      'mimeType': serializer.toJson<String?>(mimeType),
      'fileExtension': serializer.toJson<String?>(fileExtension),
      'createdAt': serializer.toJson<DateTime>(createdAt),
    };
  }

  RepairAttachmentRecord copyWith({
    int? id,
    int? repairEntryId,
    RepairAttachmentKind? kind,
    String? storedPath,
    String? originalName,
    Value<String?> mimeType = const Value.absent(),
    Value<String?> fileExtension = const Value.absent(),
    DateTime? createdAt,
  }) => RepairAttachmentRecord(
    id: id ?? this.id,
    repairEntryId: repairEntryId ?? this.repairEntryId,
    kind: kind ?? this.kind,
    storedPath: storedPath ?? this.storedPath,
    originalName: originalName ?? this.originalName,
    mimeType: mimeType.present ? mimeType.value : this.mimeType,
    fileExtension: fileExtension.present
        ? fileExtension.value
        : this.fileExtension,
    createdAt: createdAt ?? this.createdAt,
  );
  RepairAttachmentRecord copyWithCompanion(RepairAttachmentsCompanion data) {
    return RepairAttachmentRecord(
      id: data.id.present ? data.id.value : this.id,
      repairEntryId: data.repairEntryId.present
          ? data.repairEntryId.value
          : this.repairEntryId,
      kind: data.kind.present ? data.kind.value : this.kind,
      storedPath: data.storedPath.present
          ? data.storedPath.value
          : this.storedPath,
      originalName: data.originalName.present
          ? data.originalName.value
          : this.originalName,
      mimeType: data.mimeType.present ? data.mimeType.value : this.mimeType,
      fileExtension: data.fileExtension.present
          ? data.fileExtension.value
          : this.fileExtension,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
    );
  }

  @override
  String toString() {
    return (StringBuffer('RepairAttachmentRecord(')
          ..write('id: $id, ')
          ..write('repairEntryId: $repairEntryId, ')
          ..write('kind: $kind, ')
          ..write('storedPath: $storedPath, ')
          ..write('originalName: $originalName, ')
          ..write('mimeType: $mimeType, ')
          ..write('fileExtension: $fileExtension, ')
          ..write('createdAt: $createdAt')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    repairEntryId,
    kind,
    storedPath,
    originalName,
    mimeType,
    fileExtension,
    createdAt,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is RepairAttachmentRecord &&
          other.id == this.id &&
          other.repairEntryId == this.repairEntryId &&
          other.kind == this.kind &&
          other.storedPath == this.storedPath &&
          other.originalName == this.originalName &&
          other.mimeType == this.mimeType &&
          other.fileExtension == this.fileExtension &&
          other.createdAt == this.createdAt);
}

class RepairAttachmentsCompanion
    extends UpdateCompanion<RepairAttachmentRecord> {
  final Value<int> id;
  final Value<int> repairEntryId;
  final Value<RepairAttachmentKind> kind;
  final Value<String> storedPath;
  final Value<String> originalName;
  final Value<String?> mimeType;
  final Value<String?> fileExtension;
  final Value<DateTime> createdAt;
  const RepairAttachmentsCompanion({
    this.id = const Value.absent(),
    this.repairEntryId = const Value.absent(),
    this.kind = const Value.absent(),
    this.storedPath = const Value.absent(),
    this.originalName = const Value.absent(),
    this.mimeType = const Value.absent(),
    this.fileExtension = const Value.absent(),
    this.createdAt = const Value.absent(),
  });
  RepairAttachmentsCompanion.insert({
    this.id = const Value.absent(),
    required int repairEntryId,
    required RepairAttachmentKind kind,
    required String storedPath,
    required String originalName,
    this.mimeType = const Value.absent(),
    this.fileExtension = const Value.absent(),
    required DateTime createdAt,
  }) : repairEntryId = Value(repairEntryId),
       kind = Value(kind),
       storedPath = Value(storedPath),
       originalName = Value(originalName),
       createdAt = Value(createdAt);
  static Insertable<RepairAttachmentRecord> custom({
    Expression<int>? id,
    Expression<int>? repairEntryId,
    Expression<String>? kind,
    Expression<String>? storedPath,
    Expression<String>? originalName,
    Expression<String>? mimeType,
    Expression<String>? fileExtension,
    Expression<DateTime>? createdAt,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (repairEntryId != null) 'repair_entry_id': repairEntryId,
      if (kind != null) 'kind': kind,
      if (storedPath != null) 'stored_path': storedPath,
      if (originalName != null) 'original_name': originalName,
      if (mimeType != null) 'mime_type': mimeType,
      if (fileExtension != null) 'file_extension': fileExtension,
      if (createdAt != null) 'created_at': createdAt,
    });
  }

  RepairAttachmentsCompanion copyWith({
    Value<int>? id,
    Value<int>? repairEntryId,
    Value<RepairAttachmentKind>? kind,
    Value<String>? storedPath,
    Value<String>? originalName,
    Value<String?>? mimeType,
    Value<String?>? fileExtension,
    Value<DateTime>? createdAt,
  }) {
    return RepairAttachmentsCompanion(
      id: id ?? this.id,
      repairEntryId: repairEntryId ?? this.repairEntryId,
      kind: kind ?? this.kind,
      storedPath: storedPath ?? this.storedPath,
      originalName: originalName ?? this.originalName,
      mimeType: mimeType ?? this.mimeType,
      fileExtension: fileExtension ?? this.fileExtension,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (repairEntryId.present) {
      map['repair_entry_id'] = Variable<int>(repairEntryId.value);
    }
    if (kind.present) {
      map['kind'] = Variable<String>(
        $RepairAttachmentsTable.$converterkind.toSql(kind.value),
      );
    }
    if (storedPath.present) {
      map['stored_path'] = Variable<String>(storedPath.value);
    }
    if (originalName.present) {
      map['original_name'] = Variable<String>(originalName.value);
    }
    if (mimeType.present) {
      map['mime_type'] = Variable<String>(mimeType.value);
    }
    if (fileExtension.present) {
      map['file_extension'] = Variable<String>(fileExtension.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('RepairAttachmentsCompanion(')
          ..write('id: $id, ')
          ..write('repairEntryId: $repairEntryId, ')
          ..write('kind: $kind, ')
          ..write('storedPath: $storedPath, ')
          ..write('originalName: $originalName, ')
          ..write('mimeType: $mimeType, ')
          ..write('fileExtension: $fileExtension, ')
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
  late final $RepairEntriesTable repairEntries = $RepairEntriesTable(this);
  late final $RepairPartsTable repairParts = $RepairPartsTable(this);
  late final $RepairAttachmentsTable repairAttachments =
      $RepairAttachmentsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    carProfiles,
    maintenanceItems,
    maintenanceLogs,
    repairEntries,
    repairParts,
    repairAttachments,
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
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'car_profiles',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('repair_entries', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'repair_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('repair_parts', kind: UpdateKind.delete)],
    ),
    WritePropagation(
      on: TableUpdateQuery.onTableName(
        'repair_entries',
        limitUpdateKind: UpdateKind.delete,
      ),
      result: [TableUpdate('repair_attachments', kind: UpdateKind.delete)],
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

  static MultiTypedResultKey<$RepairEntriesTable, List<RepairEntryRecord>>
  _repairEntriesRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.repairEntries,
    aliasName: $_aliasNameGenerator(
      db.carProfiles.id,
      db.repairEntries.carProfileId,
    ),
  );

  $$RepairEntriesTableProcessedTableManager get repairEntriesRefs {
    final manager = $$RepairEntriesTableTableManager(
      $_db,
      $_db.repairEntries,
    ).filter((f) => f.carProfileId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_repairEntriesRefsTable($_db));
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

  Expression<bool> repairEntriesRefs(
    Expression<bool> Function($$RepairEntriesTableFilterComposer f) f,
  ) {
    final $$RepairEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairEntries,
      getReferencedColumn: (t) => t.carProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairEntriesTableFilterComposer(
            $db: $db,
            $table: $db.repairEntries,
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

  Expression<T> repairEntriesRefs<T extends Object>(
    Expression<T> Function($$RepairEntriesTableAnnotationComposer a) f,
  ) {
    final $$RepairEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairEntries,
      getReferencedColumn: (t) => t.carProfileId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.repairEntries,
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
          PrefetchHooks Function({
            bool maintenanceItemsRefs,
            bool repairEntriesRefs,
          })
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
          prefetchHooksCallback:
              ({maintenanceItemsRefs = false, repairEntriesRefs = false}) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (maintenanceItemsRefs) db.maintenanceItems,
                    if (repairEntriesRefs) db.repairEntries,
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
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.carProfileId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (repairEntriesRefs)
                        await $_getPrefetchedData<
                          CarProfileRecord,
                          $CarProfilesTable,
                          RepairEntryRecord
                        >(
                          currentTable: table,
                          referencedTable: $$CarProfilesTableReferences
                              ._repairEntriesRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$CarProfilesTableReferences(
                                db,
                                table,
                                p0,
                              ).repairEntriesRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
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
      PrefetchHooks Function({
        bool maintenanceItemsRefs,
        bool repairEntriesRefs,
      })
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
typedef $$RepairEntriesTableCreateCompanionBuilder =
    RepairEntriesCompanion Function({
      Value<int> id,
      required int carProfileId,
      required RepairStatus status,
      required bool isModification,
      required RepairArea area,
      Value<RepairUrgency?> urgency,
      required String title,
      Value<String?> description,
      Value<DateTime?> completedAt,
      required DateTime createdAt,
      required DateTime updatedAt,
    });
typedef $$RepairEntriesTableUpdateCompanionBuilder =
    RepairEntriesCompanion Function({
      Value<int> id,
      Value<int> carProfileId,
      Value<RepairStatus> status,
      Value<bool> isModification,
      Value<RepairArea> area,
      Value<RepairUrgency?> urgency,
      Value<String> title,
      Value<String?> description,
      Value<DateTime?> completedAt,
      Value<DateTime> createdAt,
      Value<DateTime> updatedAt,
    });

final class $$RepairEntriesTableReferences
    extends
        BaseReferences<_$AppDatabase, $RepairEntriesTable, RepairEntryRecord> {
  $$RepairEntriesTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $CarProfilesTable _carProfileIdTable(_$AppDatabase db) =>
      db.carProfiles.createAlias(
        $_aliasNameGenerator(db.repairEntries.carProfileId, db.carProfiles.id),
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

  static MultiTypedResultKey<$RepairPartsTable, List<RepairPartRecord>>
  _repairPartsRefsTable(_$AppDatabase db) => MultiTypedResultKey.fromTable(
    db.repairParts,
    aliasName: $_aliasNameGenerator(
      db.repairEntries.id,
      db.repairParts.repairEntryId,
    ),
  );

  $$RepairPartsTableProcessedTableManager get repairPartsRefs {
    final manager = $$RepairPartsTableTableManager(
      $_db,
      $_db.repairParts,
    ).filter((f) => f.repairEntryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(_repairPartsRefsTable($_db));
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }

  static MultiTypedResultKey<
    $RepairAttachmentsTable,
    List<RepairAttachmentRecord>
  >
  _repairAttachmentsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.repairAttachments,
        aliasName: $_aliasNameGenerator(
          db.repairEntries.id,
          db.repairAttachments.repairEntryId,
        ),
      );

  $$RepairAttachmentsTableProcessedTableManager get repairAttachmentsRefs {
    final manager = $$RepairAttachmentsTableTableManager(
      $_db,
      $_db.repairAttachments,
    ).filter((f) => f.repairEntryId.id.sqlEquals($_itemColumn<int>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _repairAttachmentsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$RepairEntriesTableFilterComposer
    extends Composer<_$AppDatabase, $RepairEntriesTable> {
  $$RepairEntriesTableFilterComposer({
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

  ColumnWithTypeConverterFilters<RepairStatus, RepairStatus, String>
  get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<bool> get isModification => $composableBuilder(
    column: $table.isModification,
    builder: (column) => ColumnFilters(column),
  );

  ColumnWithTypeConverterFilters<RepairArea, RepairArea, String> get area =>
      $composableBuilder(
        column: $table.area,
        builder: (column) => ColumnWithTypeConverterFilters(column),
      );

  ColumnWithTypeConverterFilters<RepairUrgency?, RepairUrgency, String>
  get urgency => $composableBuilder(
    column: $table.urgency,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
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

  Expression<bool> repairPartsRefs(
    Expression<bool> Function($$RepairPartsTableFilterComposer f) f,
  ) {
    final $$RepairPartsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairParts,
      getReferencedColumn: (t) => t.repairEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairPartsTableFilterComposer(
            $db: $db,
            $table: $db.repairParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<bool> repairAttachmentsRefs(
    Expression<bool> Function($$RepairAttachmentsTableFilterComposer f) f,
  ) {
    final $$RepairAttachmentsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairAttachments,
      getReferencedColumn: (t) => t.repairEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairAttachmentsTableFilterComposer(
            $db: $db,
            $table: $db.repairAttachments,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }
}

class $$RepairEntriesTableOrderingComposer
    extends Composer<_$AppDatabase, $RepairEntriesTable> {
  $$RepairEntriesTableOrderingComposer({
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

  ColumnOrderings<String> get status => $composableBuilder(
    column: $table.status,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isModification => $composableBuilder(
    column: $table.isModification,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get area => $composableBuilder(
    column: $table.area,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get urgency => $composableBuilder(
    column: $table.urgency,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
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

class $$RepairEntriesTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepairEntriesTable> {
  $$RepairEntriesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RepairStatus, String> get status =>
      $composableBuilder(column: $table.status, builder: (column) => column);

  GeneratedColumn<bool> get isModification => $composableBuilder(
    column: $table.isModification,
    builder: (column) => column,
  );

  GeneratedColumnWithTypeConverter<RepairArea, String> get area =>
      $composableBuilder(column: $table.area, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RepairUrgency?, String> get urgency =>
      $composableBuilder(column: $table.urgency, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get description => $composableBuilder(
    column: $table.description,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get completedAt => $composableBuilder(
    column: $table.completedAt,
    builder: (column) => column,
  );

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

  Expression<T> repairPartsRefs<T extends Object>(
    Expression<T> Function($$RepairPartsTableAnnotationComposer a) f,
  ) {
    final $$RepairPartsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.id,
      referencedTable: $db.repairParts,
      getReferencedColumn: (t) => t.repairEntryId,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairPartsTableAnnotationComposer(
            $db: $db,
            $table: $db.repairParts,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return f(composer);
  }

  Expression<T> repairAttachmentsRefs<T extends Object>(
    Expression<T> Function($$RepairAttachmentsTableAnnotationComposer a) f,
  ) {
    final $$RepairAttachmentsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.repairAttachments,
          getReferencedColumn: (t) => t.repairEntryId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$RepairAttachmentsTableAnnotationComposer(
                $db: $db,
                $table: $db.repairAttachments,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$RepairEntriesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RepairEntriesTable,
          RepairEntryRecord,
          $$RepairEntriesTableFilterComposer,
          $$RepairEntriesTableOrderingComposer,
          $$RepairEntriesTableAnnotationComposer,
          $$RepairEntriesTableCreateCompanionBuilder,
          $$RepairEntriesTableUpdateCompanionBuilder,
          (RepairEntryRecord, $$RepairEntriesTableReferences),
          RepairEntryRecord,
          PrefetchHooks Function({
            bool carProfileId,
            bool repairPartsRefs,
            bool repairAttachmentsRefs,
          })
        > {
  $$RepairEntriesTableTableManager(_$AppDatabase db, $RepairEntriesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepairEntriesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepairEntriesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepairEntriesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> carProfileId = const Value.absent(),
                Value<RepairStatus> status = const Value.absent(),
                Value<bool> isModification = const Value.absent(),
                Value<RepairArea> area = const Value.absent(),
                Value<RepairUrgency?> urgency = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> description = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime> updatedAt = const Value.absent(),
              }) => RepairEntriesCompanion(
                id: id,
                carProfileId: carProfileId,
                status: status,
                isModification: isModification,
                area: area,
                urgency: urgency,
                title: title,
                description: description,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int carProfileId,
                required RepairStatus status,
                required bool isModification,
                required RepairArea area,
                Value<RepairUrgency?> urgency = const Value.absent(),
                required String title,
                Value<String?> description = const Value.absent(),
                Value<DateTime?> completedAt = const Value.absent(),
                required DateTime createdAt,
                required DateTime updatedAt,
              }) => RepairEntriesCompanion.insert(
                id: id,
                carProfileId: carProfileId,
                status: status,
                isModification: isModification,
                area: area,
                urgency: urgency,
                title: title,
                description: description,
                completedAt: completedAt,
                createdAt: createdAt,
                updatedAt: updatedAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RepairEntriesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback:
              ({
                carProfileId = false,
                repairPartsRefs = false,
                repairAttachmentsRefs = false,
              }) {
                return PrefetchHooks(
                  db: db,
                  explicitlyWatchedTables: [
                    if (repairPartsRefs) db.repairParts,
                    if (repairAttachmentsRefs) db.repairAttachments,
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
                                        $$RepairEntriesTableReferences
                                            ._carProfileIdTable(db),
                                    referencedColumn:
                                        $$RepairEntriesTableReferences
                                            ._carProfileIdTable(db)
                                            .id,
                                  )
                                  as T;
                        }

                        return state;
                      },
                  getPrefetchedDataCallback: (items) async {
                    return [
                      if (repairPartsRefs)
                        await $_getPrefetchedData<
                          RepairEntryRecord,
                          $RepairEntriesTable,
                          RepairPartRecord
                        >(
                          currentTable: table,
                          referencedTable: $$RepairEntriesTableReferences
                              ._repairPartsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RepairEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).repairPartsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.repairEntryId == item.id,
                              ),
                          typedResults: items,
                        ),
                      if (repairAttachmentsRefs)
                        await $_getPrefetchedData<
                          RepairEntryRecord,
                          $RepairEntriesTable,
                          RepairAttachmentRecord
                        >(
                          currentTable: table,
                          referencedTable: $$RepairEntriesTableReferences
                              ._repairAttachmentsRefsTable(db),
                          managerFromTypedResult: (p0) =>
                              $$RepairEntriesTableReferences(
                                db,
                                table,
                                p0,
                              ).repairAttachmentsRefs,
                          referencedItemsForCurrentItem:
                              (item, referencedItems) => referencedItems.where(
                                (e) => e.repairEntryId == item.id,
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

typedef $$RepairEntriesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RepairEntriesTable,
      RepairEntryRecord,
      $$RepairEntriesTableFilterComposer,
      $$RepairEntriesTableOrderingComposer,
      $$RepairEntriesTableAnnotationComposer,
      $$RepairEntriesTableCreateCompanionBuilder,
      $$RepairEntriesTableUpdateCompanionBuilder,
      (RepairEntryRecord, $$RepairEntriesTableReferences),
      RepairEntryRecord,
      PrefetchHooks Function({
        bool carProfileId,
        bool repairPartsRefs,
        bool repairAttachmentsRefs,
      })
    >;
typedef $$RepairPartsTableCreateCompanionBuilder =
    RepairPartsCompanion Function({
      Value<int> id,
      required int repairEntryId,
      required String title,
      Value<String?> link,
    });
typedef $$RepairPartsTableUpdateCompanionBuilder =
    RepairPartsCompanion Function({
      Value<int> id,
      Value<int> repairEntryId,
      Value<String> title,
      Value<String?> link,
    });

final class $$RepairPartsTableReferences
    extends BaseReferences<_$AppDatabase, $RepairPartsTable, RepairPartRecord> {
  $$RepairPartsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static $RepairEntriesTable _repairEntryIdTable(_$AppDatabase db) =>
      db.repairEntries.createAlias(
        $_aliasNameGenerator(db.repairParts.repairEntryId, db.repairEntries.id),
      );

  $$RepairEntriesTableProcessedTableManager get repairEntryId {
    final $_column = $_itemColumn<int>('repair_entry_id')!;

    final manager = $$RepairEntriesTableTableManager(
      $_db,
      $_db.repairEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_repairEntryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RepairPartsTableFilterComposer
    extends Composer<_$AppDatabase, $RepairPartsTable> {
  $$RepairPartsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnFilters(column),
  );

  $$RepairEntriesTableFilterComposer get repairEntryId {
    final $$RepairEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairEntryId,
      referencedTable: $db.repairEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairEntriesTableFilterComposer(
            $db: $db,
            $table: $db.repairEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairPartsTableOrderingComposer
    extends Composer<_$AppDatabase, $RepairPartsTable> {
  $$RepairPartsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get link => $composableBuilder(
    column: $table.link,
    builder: (column) => ColumnOrderings(column),
  );

  $$RepairEntriesTableOrderingComposer get repairEntryId {
    final $$RepairEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairEntryId,
      referencedTable: $db.repairEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.repairEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairPartsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepairPartsTable> {
  $$RepairPartsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get link =>
      $composableBuilder(column: $table.link, builder: (column) => column);

  $$RepairEntriesTableAnnotationComposer get repairEntryId {
    final $$RepairEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairEntryId,
      referencedTable: $db.repairEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.repairEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairPartsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RepairPartsTable,
          RepairPartRecord,
          $$RepairPartsTableFilterComposer,
          $$RepairPartsTableOrderingComposer,
          $$RepairPartsTableAnnotationComposer,
          $$RepairPartsTableCreateCompanionBuilder,
          $$RepairPartsTableUpdateCompanionBuilder,
          (RepairPartRecord, $$RepairPartsTableReferences),
          RepairPartRecord,
          PrefetchHooks Function({bool repairEntryId})
        > {
  $$RepairPartsTableTableManager(_$AppDatabase db, $RepairPartsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepairPartsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepairPartsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepairPartsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> repairEntryId = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String?> link = const Value.absent(),
              }) => RepairPartsCompanion(
                id: id,
                repairEntryId: repairEntryId,
                title: title,
                link: link,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int repairEntryId,
                required String title,
                Value<String?> link = const Value.absent(),
              }) => RepairPartsCompanion.insert(
                id: id,
                repairEntryId: repairEntryId,
                title: title,
                link: link,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RepairPartsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({repairEntryId = false}) {
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
                    if (repairEntryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.repairEntryId,
                                referencedTable: $$RepairPartsTableReferences
                                    ._repairEntryIdTable(db),
                                referencedColumn: $$RepairPartsTableReferences
                                    ._repairEntryIdTable(db)
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

typedef $$RepairPartsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RepairPartsTable,
      RepairPartRecord,
      $$RepairPartsTableFilterComposer,
      $$RepairPartsTableOrderingComposer,
      $$RepairPartsTableAnnotationComposer,
      $$RepairPartsTableCreateCompanionBuilder,
      $$RepairPartsTableUpdateCompanionBuilder,
      (RepairPartRecord, $$RepairPartsTableReferences),
      RepairPartRecord,
      PrefetchHooks Function({bool repairEntryId})
    >;
typedef $$RepairAttachmentsTableCreateCompanionBuilder =
    RepairAttachmentsCompanion Function({
      Value<int> id,
      required int repairEntryId,
      required RepairAttachmentKind kind,
      required String storedPath,
      required String originalName,
      Value<String?> mimeType,
      Value<String?> fileExtension,
      required DateTime createdAt,
    });
typedef $$RepairAttachmentsTableUpdateCompanionBuilder =
    RepairAttachmentsCompanion Function({
      Value<int> id,
      Value<int> repairEntryId,
      Value<RepairAttachmentKind> kind,
      Value<String> storedPath,
      Value<String> originalName,
      Value<String?> mimeType,
      Value<String?> fileExtension,
      Value<DateTime> createdAt,
    });

final class $$RepairAttachmentsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $RepairAttachmentsTable,
          RepairAttachmentRecord
        > {
  $$RepairAttachmentsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $RepairEntriesTable _repairEntryIdTable(_$AppDatabase db) =>
      db.repairEntries.createAlias(
        $_aliasNameGenerator(
          db.repairAttachments.repairEntryId,
          db.repairEntries.id,
        ),
      );

  $$RepairEntriesTableProcessedTableManager get repairEntryId {
    final $_column = $_itemColumn<int>('repair_entry_id')!;

    final manager = $$RepairEntriesTableTableManager(
      $_db,
      $_db.repairEntries,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_repairEntryIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$RepairAttachmentsTableFilterComposer
    extends Composer<_$AppDatabase, $RepairAttachmentsTable> {
  $$RepairAttachmentsTableFilterComposer({
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

  ColumnWithTypeConverterFilters<
    RepairAttachmentKind,
    RepairAttachmentKind,
    String
  >
  get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnWithTypeConverterFilters(column),
  );

  ColumnFilters<String> get storedPath => $composableBuilder(
    column: $table.storedPath,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get originalName => $composableBuilder(
    column: $table.originalName,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get fileExtension => $composableBuilder(
    column: $table.fileExtension,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  $$RepairEntriesTableFilterComposer get repairEntryId {
    final $$RepairEntriesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairEntryId,
      referencedTable: $db.repairEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairEntriesTableFilterComposer(
            $db: $db,
            $table: $db.repairEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairAttachmentsTableOrderingComposer
    extends Composer<_$AppDatabase, $RepairAttachmentsTable> {
  $$RepairAttachmentsTableOrderingComposer({
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

  ColumnOrderings<String> get kind => $composableBuilder(
    column: $table.kind,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get storedPath => $composableBuilder(
    column: $table.storedPath,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get originalName => $composableBuilder(
    column: $table.originalName,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get mimeType => $composableBuilder(
    column: $table.mimeType,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get fileExtension => $composableBuilder(
    column: $table.fileExtension,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  $$RepairEntriesTableOrderingComposer get repairEntryId {
    final $$RepairEntriesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairEntryId,
      referencedTable: $db.repairEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairEntriesTableOrderingComposer(
            $db: $db,
            $table: $db.repairEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairAttachmentsTableAnnotationComposer
    extends Composer<_$AppDatabase, $RepairAttachmentsTable> {
  $$RepairAttachmentsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumnWithTypeConverter<RepairAttachmentKind, String> get kind =>
      $composableBuilder(column: $table.kind, builder: (column) => column);

  GeneratedColumn<String> get storedPath => $composableBuilder(
    column: $table.storedPath,
    builder: (column) => column,
  );

  GeneratedColumn<String> get originalName => $composableBuilder(
    column: $table.originalName,
    builder: (column) => column,
  );

  GeneratedColumn<String> get mimeType =>
      $composableBuilder(column: $table.mimeType, builder: (column) => column);

  GeneratedColumn<String> get fileExtension => $composableBuilder(
    column: $table.fileExtension,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  $$RepairEntriesTableAnnotationComposer get repairEntryId {
    final $$RepairEntriesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.repairEntryId,
      referencedTable: $db.repairEntries,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$RepairEntriesTableAnnotationComposer(
            $db: $db,
            $table: $db.repairEntries,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$RepairAttachmentsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $RepairAttachmentsTable,
          RepairAttachmentRecord,
          $$RepairAttachmentsTableFilterComposer,
          $$RepairAttachmentsTableOrderingComposer,
          $$RepairAttachmentsTableAnnotationComposer,
          $$RepairAttachmentsTableCreateCompanionBuilder,
          $$RepairAttachmentsTableUpdateCompanionBuilder,
          (RepairAttachmentRecord, $$RepairAttachmentsTableReferences),
          RepairAttachmentRecord,
          PrefetchHooks Function({bool repairEntryId})
        > {
  $$RepairAttachmentsTableTableManager(
    _$AppDatabase db,
    $RepairAttachmentsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$RepairAttachmentsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$RepairAttachmentsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$RepairAttachmentsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<int> repairEntryId = const Value.absent(),
                Value<RepairAttachmentKind> kind = const Value.absent(),
                Value<String> storedPath = const Value.absent(),
                Value<String> originalName = const Value.absent(),
                Value<String?> mimeType = const Value.absent(),
                Value<String?> fileExtension = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
              }) => RepairAttachmentsCompanion(
                id: id,
                repairEntryId: repairEntryId,
                kind: kind,
                storedPath: storedPath,
                originalName: originalName,
                mimeType: mimeType,
                fileExtension: fileExtension,
                createdAt: createdAt,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                required int repairEntryId,
                required RepairAttachmentKind kind,
                required String storedPath,
                required String originalName,
                Value<String?> mimeType = const Value.absent(),
                Value<String?> fileExtension = const Value.absent(),
                required DateTime createdAt,
              }) => RepairAttachmentsCompanion.insert(
                id: id,
                repairEntryId: repairEntryId,
                kind: kind,
                storedPath: storedPath,
                originalName: originalName,
                mimeType: mimeType,
                fileExtension: fileExtension,
                createdAt: createdAt,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$RepairAttachmentsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({repairEntryId = false}) {
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
                    if (repairEntryId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.repairEntryId,
                                referencedTable:
                                    $$RepairAttachmentsTableReferences
                                        ._repairEntryIdTable(db),
                                referencedColumn:
                                    $$RepairAttachmentsTableReferences
                                        ._repairEntryIdTable(db)
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

typedef $$RepairAttachmentsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $RepairAttachmentsTable,
      RepairAttachmentRecord,
      $$RepairAttachmentsTableFilterComposer,
      $$RepairAttachmentsTableOrderingComposer,
      $$RepairAttachmentsTableAnnotationComposer,
      $$RepairAttachmentsTableCreateCompanionBuilder,
      $$RepairAttachmentsTableUpdateCompanionBuilder,
      (RepairAttachmentRecord, $$RepairAttachmentsTableReferences),
      RepairAttachmentRecord,
      PrefetchHooks Function({bool repairEntryId})
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
  $$RepairEntriesTableTableManager get repairEntries =>
      $$RepairEntriesTableTableManager(_db, _db.repairEntries);
  $$RepairPartsTableTableManager get repairParts =>
      $$RepairPartsTableTableManager(_db, _db.repairParts);
  $$RepairAttachmentsTableTableManager get repairAttachments =>
      $$RepairAttachmentsTableTableManager(_db, _db.repairAttachments);
}
