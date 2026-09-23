// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $HabitsTable extends Habits with TableInfo<$HabitsTable, Habit> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $HabitsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  @override
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
    'title',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(
      minTextLength: 1,
      maxTextLength: 40,
    ),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _startDayMeta = const VerificationMeta(
    'startDay',
  );
  @override
  late final GeneratedColumn<String> startDay = GeneratedColumn<String>(
    'start_day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creatureIdMeta = const VerificationMeta(
    'creatureId',
  );
  @override
  late final GeneratedColumn<String> creatureId = GeneratedColumn<String>(
    'creature_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _revisionMeta = const VerificationMeta(
    'revision',
  );
  @override
  late final GeneratedColumn<int> revision = GeneratedColumn<int>(
    'revision',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _archivedAtUtcMeta = const VerificationMeta(
    'archivedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> archivedAtUtc =
      GeneratedColumn<DateTime>(
        'archived_at_utc',
        aliasedName,
        true,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: false,
      );
  static const VerificationMeta _archivedFromDayMeta = const VerificationMeta(
    'archivedFromDay',
  );
  @override
  late final GeneratedColumn<String> archivedFromDay = GeneratedColumn<String>(
    'archived_from_day',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    title,
    startDay,
    creatureId,
    createdAtUtc,
    revision,
    archivedAtUtc,
    archivedFromDay,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'habits';
  @override
  VerificationContext validateIntegrity(
    Insertable<Habit> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('title')) {
      context.handle(
        _titleMeta,
        title.isAcceptableOrUnknown(data['title']!, _titleMeta),
      );
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('start_day')) {
      context.handle(
        _startDayMeta,
        startDay.isAcceptableOrUnknown(data['start_day']!, _startDayMeta),
      );
    } else if (isInserting) {
      context.missing(_startDayMeta);
    }
    if (data.containsKey('creature_id')) {
      context.handle(
        _creatureIdMeta,
        creatureId.isAcceptableOrUnknown(data['creature_id']!, _creatureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_creatureIdMeta);
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    if (data.containsKey('revision')) {
      context.handle(
        _revisionMeta,
        revision.isAcceptableOrUnknown(data['revision']!, _revisionMeta),
      );
    }
    if (data.containsKey('archived_at_utc')) {
      context.handle(
        _archivedAtUtcMeta,
        archivedAtUtc.isAcceptableOrUnknown(
          data['archived_at_utc']!,
          _archivedAtUtcMeta,
        ),
      );
    }
    if (data.containsKey('archived_from_day')) {
      context.handle(
        _archivedFromDayMeta,
        archivedFromDay.isAcceptableOrUnknown(
          data['archived_from_day']!,
          _archivedFromDayMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Habit map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Habit(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      title: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}title'],
      )!,
      startDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}start_day'],
      )!,
      creatureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creature_id'],
      )!,
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
      revision: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}revision'],
      )!,
      archivedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}archived_at_utc'],
      ),
      archivedFromDay: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}archived_from_day'],
      ),
    );
  }

  @override
  $HabitsTable createAlias(String alias) {
    return $HabitsTable(attachedDatabase, alias);
  }
}

class Habit extends DataClass implements Insertable<Habit> {
  final String id;
  final String title;
  final String startDay;
  final String creatureId;
  final DateTime createdAtUtc;
  final int revision;
  final DateTime? archivedAtUtc;
  final String? archivedFromDay;
  const Habit({
    required this.id,
    required this.title,
    required this.startDay,
    required this.creatureId,
    required this.createdAtUtc,
    required this.revision,
    this.archivedAtUtc,
    this.archivedFromDay,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['title'] = Variable<String>(title);
    map['start_day'] = Variable<String>(startDay);
    map['creature_id'] = Variable<String>(creatureId);
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    map['revision'] = Variable<int>(revision);
    if (!nullToAbsent || archivedAtUtc != null) {
      map['archived_at_utc'] = Variable<DateTime>(archivedAtUtc);
    }
    if (!nullToAbsent || archivedFromDay != null) {
      map['archived_from_day'] = Variable<String>(archivedFromDay);
    }
    return map;
  }

  HabitsCompanion toCompanion(bool nullToAbsent) {
    return HabitsCompanion(
      id: Value(id),
      title: Value(title),
      startDay: Value(startDay),
      creatureId: Value(creatureId),
      createdAtUtc: Value(createdAtUtc),
      revision: Value(revision),
      archivedAtUtc: archivedAtUtc == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedAtUtc),
      archivedFromDay: archivedFromDay == null && nullToAbsent
          ? const Value.absent()
          : Value(archivedFromDay),
    );
  }

  factory Habit.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Habit(
      id: serializer.fromJson<String>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      startDay: serializer.fromJson<String>(json['startDay']),
      creatureId: serializer.fromJson<String>(json['creatureId']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
      revision: serializer.fromJson<int>(json['revision']),
      archivedAtUtc: serializer.fromJson<DateTime?>(json['archivedAtUtc']),
      archivedFromDay: serializer.fromJson<String?>(json['archivedFromDay']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'title': serializer.toJson<String>(title),
      'startDay': serializer.toJson<String>(startDay),
      'creatureId': serializer.toJson<String>(creatureId),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
      'revision': serializer.toJson<int>(revision),
      'archivedAtUtc': serializer.toJson<DateTime?>(archivedAtUtc),
      'archivedFromDay': serializer.toJson<String?>(archivedFromDay),
    };
  }

  Habit copyWith({
    String? id,
    String? title,
    String? startDay,
    String? creatureId,
    DateTime? createdAtUtc,
    int? revision,
    Value<DateTime?> archivedAtUtc = const Value.absent(),
    Value<String?> archivedFromDay = const Value.absent(),
  }) => Habit(
    id: id ?? this.id,
    title: title ?? this.title,
    startDay: startDay ?? this.startDay,
    creatureId: creatureId ?? this.creatureId,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
    revision: revision ?? this.revision,
    archivedAtUtc: archivedAtUtc.present
        ? archivedAtUtc.value
        : this.archivedAtUtc,
    archivedFromDay: archivedFromDay.present
        ? archivedFromDay.value
        : this.archivedFromDay,
  );
  Habit copyWithCompanion(HabitsCompanion data) {
    return Habit(
      id: data.id.present ? data.id.value : this.id,
      title: data.title.present ? data.title.value : this.title,
      startDay: data.startDay.present ? data.startDay.value : this.startDay,
      creatureId: data.creatureId.present
          ? data.creatureId.value
          : this.creatureId,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
      revision: data.revision.present ? data.revision.value : this.revision,
      archivedAtUtc: data.archivedAtUtc.present
          ? data.archivedAtUtc.value
          : this.archivedAtUtc,
      archivedFromDay: data.archivedFromDay.present
          ? data.archivedFromDay.value
          : this.archivedFromDay,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Habit(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startDay: $startDay, ')
          ..write('creatureId: $creatureId, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('revision: $revision, ')
          ..write('archivedAtUtc: $archivedAtUtc, ')
          ..write('archivedFromDay: $archivedFromDay')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    title,
    startDay,
    creatureId,
    createdAtUtc,
    revision,
    archivedAtUtc,
    archivedFromDay,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Habit &&
          other.id == this.id &&
          other.title == this.title &&
          other.startDay == this.startDay &&
          other.creatureId == this.creatureId &&
          other.createdAtUtc == this.createdAtUtc &&
          other.revision == this.revision &&
          other.archivedAtUtc == this.archivedAtUtc &&
          other.archivedFromDay == this.archivedFromDay);
}

class HabitsCompanion extends UpdateCompanion<Habit> {
  final Value<String> id;
  final Value<String> title;
  final Value<String> startDay;
  final Value<String> creatureId;
  final Value<DateTime> createdAtUtc;
  final Value<int> revision;
  final Value<DateTime?> archivedAtUtc;
  final Value<String?> archivedFromDay;
  final Value<int> rowid;
  const HabitsCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.startDay = const Value.absent(),
    this.creatureId = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.revision = const Value.absent(),
    this.archivedAtUtc = const Value.absent(),
    this.archivedFromDay = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  HabitsCompanion.insert({
    required String id,
    required String title,
    required String startDay,
    required String creatureId,
    required DateTime createdAtUtc,
    this.revision = const Value.absent(),
    this.archivedAtUtc = const Value.absent(),
    this.archivedFromDay = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       title = Value(title),
       startDay = Value(startDay),
       creatureId = Value(creatureId),
       createdAtUtc = Value(createdAtUtc);
  static Insertable<Habit> custom({
    Expression<String>? id,
    Expression<String>? title,
    Expression<String>? startDay,
    Expression<String>? creatureId,
    Expression<DateTime>? createdAtUtc,
    Expression<int>? revision,
    Expression<DateTime>? archivedAtUtc,
    Expression<String>? archivedFromDay,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (startDay != null) 'start_day': startDay,
      if (creatureId != null) 'creature_id': creatureId,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (revision != null) 'revision': revision,
      if (archivedAtUtc != null) 'archived_at_utc': archivedAtUtc,
      if (archivedFromDay != null) 'archived_from_day': archivedFromDay,
      if (rowid != null) 'rowid': rowid,
    });
  }

  HabitsCompanion copyWith({
    Value<String>? id,
    Value<String>? title,
    Value<String>? startDay,
    Value<String>? creatureId,
    Value<DateTime>? createdAtUtc,
    Value<int>? revision,
    Value<DateTime?>? archivedAtUtc,
    Value<String?>? archivedFromDay,
    Value<int>? rowid,
  }) {
    return HabitsCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      startDay: startDay ?? this.startDay,
      creatureId: creatureId ?? this.creatureId,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      revision: revision ?? this.revision,
      archivedAtUtc: archivedAtUtc ?? this.archivedAtUtc,
      archivedFromDay: archivedFromDay ?? this.archivedFromDay,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (startDay.present) {
      map['start_day'] = Variable<String>(startDay.value);
    }
    if (creatureId.present) {
      map['creature_id'] = Variable<String>(creatureId.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    if (revision.present) {
      map['revision'] = Variable<int>(revision.value);
    }
    if (archivedAtUtc.present) {
      map['archived_at_utc'] = Variable<DateTime>(archivedAtUtc.value);
    }
    if (archivedFromDay.present) {
      map['archived_from_day'] = Variable<String>(archivedFromDay.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('HabitsCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('startDay: $startDay, ')
          ..write('creatureId: $creatureId, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('revision: $revision, ')
          ..write('archivedAtUtc: $archivedAtUtc, ')
          ..write('archivedFromDay: $archivedFromDay, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $CreaturesTable extends Creatures
    with TableInfo<$CreaturesTable, Creature> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $CreaturesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _speciesMeta = const VerificationMeta(
    'species',
  );
  @override
  late final GeneratedColumn<String> species = GeneratedColumn<String>(
    'species',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nicknameMeta = const VerificationMeta(
    'nickname',
  );
  @override
  late final GeneratedColumn<String> nickname = GeneratedColumn<String>(
    'nickname',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _growthModeMeta = const VerificationMeta(
    'growthMode',
  );
  @override
  late final GeneratedColumn<String> growthMode = GeneratedColumn<String>(
    'growth_mode',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _growthSeedMeta = const VerificationMeta(
    'growthSeed',
  );
  @override
  late final GeneratedColumn<Uint8List> growthSeed = GeneratedColumn<Uint8List>(
    'growth_seed',
    aliasedName,
    false,
    type: DriftSqlType.blob,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _growthAlgorithmVersionMeta =
      const VerificationMeta('growthAlgorithmVersion');
  @override
  late final GeneratedColumn<int> growthAlgorithmVersion = GeneratedColumn<int>(
    'growth_algorithm_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nextGrantOrdinalMeta = const VerificationMeta(
    'nextGrantOrdinal',
  );
  @override
  late final GeneratedColumn<int> nextGrantOrdinal = GeneratedColumn<int>(
    'next_grant_ordinal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _maxStageReachedMeta = const VerificationMeta(
    'maxStageReached',
  );
  @override
  late final GeneratedColumn<int> maxStageReached = GeneratedColumn<int>(
    'max_stage_reached',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultValue: const Constant(1),
  );
  static const VerificationMeta _createdAtUtcMeta = const VerificationMeta(
    'createdAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> createdAtUtc = GeneratedColumn<DateTime>(
    'created_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    species,
    nickname,
    growthMode,
    growthSeed,
    growthAlgorithmVersion,
    nextGrantOrdinal,
    maxStageReached,
    createdAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'creatures';
  @override
  VerificationContext validateIntegrity(
    Insertable<Creature> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('species')) {
      context.handle(
        _speciesMeta,
        species.isAcceptableOrUnknown(data['species']!, _speciesMeta),
      );
    } else if (isInserting) {
      context.missing(_speciesMeta);
    }
    if (data.containsKey('nickname')) {
      context.handle(
        _nicknameMeta,
        nickname.isAcceptableOrUnknown(data['nickname']!, _nicknameMeta),
      );
    }
    if (data.containsKey('growth_mode')) {
      context.handle(
        _growthModeMeta,
        growthMode.isAcceptableOrUnknown(data['growth_mode']!, _growthModeMeta),
      );
    } else if (isInserting) {
      context.missing(_growthModeMeta);
    }
    if (data.containsKey('growth_seed')) {
      context.handle(
        _growthSeedMeta,
        growthSeed.isAcceptableOrUnknown(data['growth_seed']!, _growthSeedMeta),
      );
    } else if (isInserting) {
      context.missing(_growthSeedMeta);
    }
    if (data.containsKey('growth_algorithm_version')) {
      context.handle(
        _growthAlgorithmVersionMeta,
        growthAlgorithmVersion.isAcceptableOrUnknown(
          data['growth_algorithm_version']!,
          _growthAlgorithmVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_growthAlgorithmVersionMeta);
    }
    if (data.containsKey('next_grant_ordinal')) {
      context.handle(
        _nextGrantOrdinalMeta,
        nextGrantOrdinal.isAcceptableOrUnknown(
          data['next_grant_ordinal']!,
          _nextGrantOrdinalMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_nextGrantOrdinalMeta);
    }
    if (data.containsKey('max_stage_reached')) {
      context.handle(
        _maxStageReachedMeta,
        maxStageReached.isAcceptableOrUnknown(
          data['max_stage_reached']!,
          _maxStageReachedMeta,
        ),
      );
    }
    if (data.containsKey('created_at_utc')) {
      context.handle(
        _createdAtUtcMeta,
        createdAtUtc.isAcceptableOrUnknown(
          data['created_at_utc']!,
          _createdAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_createdAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Creature map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Creature(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      species: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}species'],
      )!,
      nickname: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}nickname'],
      ),
      growthMode: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}growth_mode'],
      )!,
      growthSeed: attachedDatabase.typeMapping.read(
        DriftSqlType.blob,
        data['${effectivePrefix}growth_seed'],
      )!,
      growthAlgorithmVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}growth_algorithm_version'],
      )!,
      nextGrantOrdinal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}next_grant_ordinal'],
      )!,
      maxStageReached: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}max_stage_reached'],
      )!,
      createdAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at_utc'],
      )!,
    );
  }

  @override
  $CreaturesTable createAlias(String alias) {
    return $CreaturesTable(attachedDatabase, alias);
  }
}

class Creature extends DataClass implements Insertable<Creature> {
  final String id;
  final String habitId;
  final String species;
  final String? nickname;
  final String growthMode;
  final Uint8List growthSeed;
  final int growthAlgorithmVersion;
  final int nextGrantOrdinal;
  final int maxStageReached;
  final DateTime createdAtUtc;
  const Creature({
    required this.id,
    required this.habitId,
    required this.species,
    this.nickname,
    required this.growthMode,
    required this.growthSeed,
    required this.growthAlgorithmVersion,
    required this.nextGrantOrdinal,
    required this.maxStageReached,
    required this.createdAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['habit_id'] = Variable<String>(habitId);
    map['species'] = Variable<String>(species);
    if (!nullToAbsent || nickname != null) {
      map['nickname'] = Variable<String>(nickname);
    }
    map['growth_mode'] = Variable<String>(growthMode);
    map['growth_seed'] = Variable<Uint8List>(growthSeed);
    map['growth_algorithm_version'] = Variable<int>(growthAlgorithmVersion);
    map['next_grant_ordinal'] = Variable<int>(nextGrantOrdinal);
    map['max_stage_reached'] = Variable<int>(maxStageReached);
    map['created_at_utc'] = Variable<DateTime>(createdAtUtc);
    return map;
  }

  CreaturesCompanion toCompanion(bool nullToAbsent) {
    return CreaturesCompanion(
      id: Value(id),
      habitId: Value(habitId),
      species: Value(species),
      nickname: nickname == null && nullToAbsent
          ? const Value.absent()
          : Value(nickname),
      growthMode: Value(growthMode),
      growthSeed: Value(growthSeed),
      growthAlgorithmVersion: Value(growthAlgorithmVersion),
      nextGrantOrdinal: Value(nextGrantOrdinal),
      maxStageReached: Value(maxStageReached),
      createdAtUtc: Value(createdAtUtc),
    );
  }

  factory Creature.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Creature(
      id: serializer.fromJson<String>(json['id']),
      habitId: serializer.fromJson<String>(json['habitId']),
      species: serializer.fromJson<String>(json['species']),
      nickname: serializer.fromJson<String?>(json['nickname']),
      growthMode: serializer.fromJson<String>(json['growthMode']),
      growthSeed: serializer.fromJson<Uint8List>(json['growthSeed']),
      growthAlgorithmVersion: serializer.fromJson<int>(
        json['growthAlgorithmVersion'],
      ),
      nextGrantOrdinal: serializer.fromJson<int>(json['nextGrantOrdinal']),
      maxStageReached: serializer.fromJson<int>(json['maxStageReached']),
      createdAtUtc: serializer.fromJson<DateTime>(json['createdAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'habitId': serializer.toJson<String>(habitId),
      'species': serializer.toJson<String>(species),
      'nickname': serializer.toJson<String?>(nickname),
      'growthMode': serializer.toJson<String>(growthMode),
      'growthSeed': serializer.toJson<Uint8List>(growthSeed),
      'growthAlgorithmVersion': serializer.toJson<int>(growthAlgorithmVersion),
      'nextGrantOrdinal': serializer.toJson<int>(nextGrantOrdinal),
      'maxStageReached': serializer.toJson<int>(maxStageReached),
      'createdAtUtc': serializer.toJson<DateTime>(createdAtUtc),
    };
  }

  Creature copyWith({
    String? id,
    String? habitId,
    String? species,
    Value<String?> nickname = const Value.absent(),
    String? growthMode,
    Uint8List? growthSeed,
    int? growthAlgorithmVersion,
    int? nextGrantOrdinal,
    int? maxStageReached,
    DateTime? createdAtUtc,
  }) => Creature(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    species: species ?? this.species,
    nickname: nickname.present ? nickname.value : this.nickname,
    growthMode: growthMode ?? this.growthMode,
    growthSeed: growthSeed ?? this.growthSeed,
    growthAlgorithmVersion:
        growthAlgorithmVersion ?? this.growthAlgorithmVersion,
    nextGrantOrdinal: nextGrantOrdinal ?? this.nextGrantOrdinal,
    maxStageReached: maxStageReached ?? this.maxStageReached,
    createdAtUtc: createdAtUtc ?? this.createdAtUtc,
  );
  Creature copyWithCompanion(CreaturesCompanion data) {
    return Creature(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      species: data.species.present ? data.species.value : this.species,
      nickname: data.nickname.present ? data.nickname.value : this.nickname,
      growthMode: data.growthMode.present
          ? data.growthMode.value
          : this.growthMode,
      growthSeed: data.growthSeed.present
          ? data.growthSeed.value
          : this.growthSeed,
      growthAlgorithmVersion: data.growthAlgorithmVersion.present
          ? data.growthAlgorithmVersion.value
          : this.growthAlgorithmVersion,
      nextGrantOrdinal: data.nextGrantOrdinal.present
          ? data.nextGrantOrdinal.value
          : this.nextGrantOrdinal,
      maxStageReached: data.maxStageReached.present
          ? data.maxStageReached.value
          : this.maxStageReached,
      createdAtUtc: data.createdAtUtc.present
          ? data.createdAtUtc.value
          : this.createdAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Creature(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('species: $species, ')
          ..write('nickname: $nickname, ')
          ..write('growthMode: $growthMode, ')
          ..write('growthSeed: $growthSeed, ')
          ..write('growthAlgorithmVersion: $growthAlgorithmVersion, ')
          ..write('nextGrantOrdinal: $nextGrantOrdinal, ')
          ..write('maxStageReached: $maxStageReached, ')
          ..write('createdAtUtc: $createdAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    habitId,
    species,
    nickname,
    growthMode,
    $driftBlobEquality.hash(growthSeed),
    growthAlgorithmVersion,
    nextGrantOrdinal,
    maxStageReached,
    createdAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Creature &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.species == this.species &&
          other.nickname == this.nickname &&
          other.growthMode == this.growthMode &&
          $driftBlobEquality.equals(other.growthSeed, this.growthSeed) &&
          other.growthAlgorithmVersion == this.growthAlgorithmVersion &&
          other.nextGrantOrdinal == this.nextGrantOrdinal &&
          other.maxStageReached == this.maxStageReached &&
          other.createdAtUtc == this.createdAtUtc);
}

class CreaturesCompanion extends UpdateCompanion<Creature> {
  final Value<String> id;
  final Value<String> habitId;
  final Value<String> species;
  final Value<String?> nickname;
  final Value<String> growthMode;
  final Value<Uint8List> growthSeed;
  final Value<int> growthAlgorithmVersion;
  final Value<int> nextGrantOrdinal;
  final Value<int> maxStageReached;
  final Value<DateTime> createdAtUtc;
  final Value<int> rowid;
  const CreaturesCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.species = const Value.absent(),
    this.nickname = const Value.absent(),
    this.growthMode = const Value.absent(),
    this.growthSeed = const Value.absent(),
    this.growthAlgorithmVersion = const Value.absent(),
    this.nextGrantOrdinal = const Value.absent(),
    this.maxStageReached = const Value.absent(),
    this.createdAtUtc = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  CreaturesCompanion.insert({
    required String id,
    required String habitId,
    required String species,
    this.nickname = const Value.absent(),
    required String growthMode,
    required Uint8List growthSeed,
    required int growthAlgorithmVersion,
    required int nextGrantOrdinal,
    this.maxStageReached = const Value.absent(),
    required DateTime createdAtUtc,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       habitId = Value(habitId),
       species = Value(species),
       growthMode = Value(growthMode),
       growthSeed = Value(growthSeed),
       growthAlgorithmVersion = Value(growthAlgorithmVersion),
       nextGrantOrdinal = Value(nextGrantOrdinal),
       createdAtUtc = Value(createdAtUtc);
  static Insertable<Creature> custom({
    Expression<String>? id,
    Expression<String>? habitId,
    Expression<String>? species,
    Expression<String>? nickname,
    Expression<String>? growthMode,
    Expression<Uint8List>? growthSeed,
    Expression<int>? growthAlgorithmVersion,
    Expression<int>? nextGrantOrdinal,
    Expression<int>? maxStageReached,
    Expression<DateTime>? createdAtUtc,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (species != null) 'species': species,
      if (nickname != null) 'nickname': nickname,
      if (growthMode != null) 'growth_mode': growthMode,
      if (growthSeed != null) 'growth_seed': growthSeed,
      if (growthAlgorithmVersion != null)
        'growth_algorithm_version': growthAlgorithmVersion,
      if (nextGrantOrdinal != null) 'next_grant_ordinal': nextGrantOrdinal,
      if (maxStageReached != null) 'max_stage_reached': maxStageReached,
      if (createdAtUtc != null) 'created_at_utc': createdAtUtc,
      if (rowid != null) 'rowid': rowid,
    });
  }

  CreaturesCompanion copyWith({
    Value<String>? id,
    Value<String>? habitId,
    Value<String>? species,
    Value<String?>? nickname,
    Value<String>? growthMode,
    Value<Uint8List>? growthSeed,
    Value<int>? growthAlgorithmVersion,
    Value<int>? nextGrantOrdinal,
    Value<int>? maxStageReached,
    Value<DateTime>? createdAtUtc,
    Value<int>? rowid,
  }) {
    return CreaturesCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      species: species ?? this.species,
      nickname: nickname ?? this.nickname,
      growthMode: growthMode ?? this.growthMode,
      growthSeed: growthSeed ?? this.growthSeed,
      growthAlgorithmVersion:
          growthAlgorithmVersion ?? this.growthAlgorithmVersion,
      nextGrantOrdinal: nextGrantOrdinal ?? this.nextGrantOrdinal,
      maxStageReached: maxStageReached ?? this.maxStageReached,
      createdAtUtc: createdAtUtc ?? this.createdAtUtc,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (species.present) {
      map['species'] = Variable<String>(species.value);
    }
    if (nickname.present) {
      map['nickname'] = Variable<String>(nickname.value);
    }
    if (growthMode.present) {
      map['growth_mode'] = Variable<String>(growthMode.value);
    }
    if (growthSeed.present) {
      map['growth_seed'] = Variable<Uint8List>(growthSeed.value);
    }
    if (growthAlgorithmVersion.present) {
      map['growth_algorithm_version'] = Variable<int>(
        growthAlgorithmVersion.value,
      );
    }
    if (nextGrantOrdinal.present) {
      map['next_grant_ordinal'] = Variable<int>(nextGrantOrdinal.value);
    }
    if (maxStageReached.present) {
      map['max_stage_reached'] = Variable<int>(maxStageReached.value);
    }
    if (createdAtUtc.present) {
      map['created_at_utc'] = Variable<DateTime>(createdAtUtc.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CreaturesCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('species: $species, ')
          ..write('nickname: $nickname, ')
          ..write('growthMode: $growthMode, ')
          ..write('growthSeed: $growthSeed, ')
          ..write('growthAlgorithmVersion: $growthAlgorithmVersion, ')
          ..write('nextGrantOrdinal: $nextGrantOrdinal, ')
          ..write('maxStageReached: $maxStageReached, ')
          ..write('createdAtUtc: $createdAtUtc, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $DayRecordsTable extends DayRecords
    with TableInfo<$DayRecordsTable, DayRecord> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DayRecordsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<String> day = GeneratedColumn<String>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _stateMeta = const VerificationMeta('state');
  @override
  late final GeneratedColumn<String> state = GeneratedColumn<String>(
    'state',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _firstRecordedAtUtcMeta =
      const VerificationMeta('firstRecordedAtUtc');
  @override
  late final GeneratedColumn<DateTime> firstRecordedAtUtc =
      GeneratedColumn<DateTime>(
        'first_recorded_at_utc',
        aliasedName,
        false,
        type: DriftSqlType.dateTime,
        requiredDuringInsert: true,
      );
  static const VerificationMeta _updatedAtUtcMeta = const VerificationMeta(
    'updatedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAtUtc = GeneratedColumn<DateTime>(
    'updated_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordedZoneIdMeta = const VerificationMeta(
    'recordedZoneId',
  );
  @override
  late final GeneratedColumn<String> recordedZoneId = GeneratedColumn<String>(
    'recorded_zone_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _recordedBoundaryHourMeta =
      const VerificationMeta('recordedBoundaryHour');
  @override
  late final GeneratedColumn<int> recordedBoundaryHour = GeneratedColumn<int>(
    'recorded_boundary_hour',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _isBackfilledMeta = const VerificationMeta(
    'isBackfilled',
  );
  @override
  late final GeneratedColumn<bool> isBackfilled = GeneratedColumn<bool>(
    'is_backfilled',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("is_backfilled" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    habitId,
    day,
    state,
    firstRecordedAtUtc,
    updatedAtUtc,
    recordedZoneId,
    recordedBoundaryHour,
    isBackfilled,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'day_records';
  @override
  VerificationContext validateIntegrity(
    Insertable<DayRecord> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('state')) {
      context.handle(
        _stateMeta,
        state.isAcceptableOrUnknown(data['state']!, _stateMeta),
      );
    } else if (isInserting) {
      context.missing(_stateMeta);
    }
    if (data.containsKey('first_recorded_at_utc')) {
      context.handle(
        _firstRecordedAtUtcMeta,
        firstRecordedAtUtc.isAcceptableOrUnknown(
          data['first_recorded_at_utc']!,
          _firstRecordedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_firstRecordedAtUtcMeta);
    }
    if (data.containsKey('updated_at_utc')) {
      context.handle(
        _updatedAtUtcMeta,
        updatedAtUtc.isAcceptableOrUnknown(
          data['updated_at_utc']!,
          _updatedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_updatedAtUtcMeta);
    }
    if (data.containsKey('recorded_zone_id')) {
      context.handle(
        _recordedZoneIdMeta,
        recordedZoneId.isAcceptableOrUnknown(
          data['recorded_zone_id']!,
          _recordedZoneIdMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recordedZoneIdMeta);
    }
    if (data.containsKey('recorded_boundary_hour')) {
      context.handle(
        _recordedBoundaryHourMeta,
        recordedBoundaryHour.isAcceptableOrUnknown(
          data['recorded_boundary_hour']!,
          _recordedBoundaryHourMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_recordedBoundaryHourMeta);
    }
    if (data.containsKey('is_backfilled')) {
      context.handle(
        _isBackfilledMeta,
        isBackfilled.isAcceptableOrUnknown(
          data['is_backfilled']!,
          _isBackfilledMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {habitId, day};
  @override
  DayRecord map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DayRecord(
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day'],
      )!,
      state: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}state'],
      )!,
      firstRecordedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}first_recorded_at_utc'],
      )!,
      updatedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at_utc'],
      )!,
      recordedZoneId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}recorded_zone_id'],
      )!,
      recordedBoundaryHour: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}recorded_boundary_hour'],
      )!,
      isBackfilled: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}is_backfilled'],
      )!,
    );
  }

  @override
  $DayRecordsTable createAlias(String alias) {
    return $DayRecordsTable(attachedDatabase, alias);
  }
}

class DayRecord extends DataClass implements Insertable<DayRecord> {
  final String habitId;
  final String day;
  final String state;
  final DateTime firstRecordedAtUtc;
  final DateTime updatedAtUtc;
  final String recordedZoneId;
  final int recordedBoundaryHour;
  final bool isBackfilled;
  const DayRecord({
    required this.habitId,
    required this.day,
    required this.state,
    required this.firstRecordedAtUtc,
    required this.updatedAtUtc,
    required this.recordedZoneId,
    required this.recordedBoundaryHour,
    required this.isBackfilled,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['habit_id'] = Variable<String>(habitId);
    map['day'] = Variable<String>(day);
    map['state'] = Variable<String>(state);
    map['first_recorded_at_utc'] = Variable<DateTime>(firstRecordedAtUtc);
    map['updated_at_utc'] = Variable<DateTime>(updatedAtUtc);
    map['recorded_zone_id'] = Variable<String>(recordedZoneId);
    map['recorded_boundary_hour'] = Variable<int>(recordedBoundaryHour);
    map['is_backfilled'] = Variable<bool>(isBackfilled);
    return map;
  }

  DayRecordsCompanion toCompanion(bool nullToAbsent) {
    return DayRecordsCompanion(
      habitId: Value(habitId),
      day: Value(day),
      state: Value(state),
      firstRecordedAtUtc: Value(firstRecordedAtUtc),
      updatedAtUtc: Value(updatedAtUtc),
      recordedZoneId: Value(recordedZoneId),
      recordedBoundaryHour: Value(recordedBoundaryHour),
      isBackfilled: Value(isBackfilled),
    );
  }

  factory DayRecord.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DayRecord(
      habitId: serializer.fromJson<String>(json['habitId']),
      day: serializer.fromJson<String>(json['day']),
      state: serializer.fromJson<String>(json['state']),
      firstRecordedAtUtc: serializer.fromJson<DateTime>(
        json['firstRecordedAtUtc'],
      ),
      updatedAtUtc: serializer.fromJson<DateTime>(json['updatedAtUtc']),
      recordedZoneId: serializer.fromJson<String>(json['recordedZoneId']),
      recordedBoundaryHour: serializer.fromJson<int>(
        json['recordedBoundaryHour'],
      ),
      isBackfilled: serializer.fromJson<bool>(json['isBackfilled']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'habitId': serializer.toJson<String>(habitId),
      'day': serializer.toJson<String>(day),
      'state': serializer.toJson<String>(state),
      'firstRecordedAtUtc': serializer.toJson<DateTime>(firstRecordedAtUtc),
      'updatedAtUtc': serializer.toJson<DateTime>(updatedAtUtc),
      'recordedZoneId': serializer.toJson<String>(recordedZoneId),
      'recordedBoundaryHour': serializer.toJson<int>(recordedBoundaryHour),
      'isBackfilled': serializer.toJson<bool>(isBackfilled),
    };
  }

  DayRecord copyWith({
    String? habitId,
    String? day,
    String? state,
    DateTime? firstRecordedAtUtc,
    DateTime? updatedAtUtc,
    String? recordedZoneId,
    int? recordedBoundaryHour,
    bool? isBackfilled,
  }) => DayRecord(
    habitId: habitId ?? this.habitId,
    day: day ?? this.day,
    state: state ?? this.state,
    firstRecordedAtUtc: firstRecordedAtUtc ?? this.firstRecordedAtUtc,
    updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
    recordedZoneId: recordedZoneId ?? this.recordedZoneId,
    recordedBoundaryHour: recordedBoundaryHour ?? this.recordedBoundaryHour,
    isBackfilled: isBackfilled ?? this.isBackfilled,
  );
  DayRecord copyWithCompanion(DayRecordsCompanion data) {
    return DayRecord(
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      day: data.day.present ? data.day.value : this.day,
      state: data.state.present ? data.state.value : this.state,
      firstRecordedAtUtc: data.firstRecordedAtUtc.present
          ? data.firstRecordedAtUtc.value
          : this.firstRecordedAtUtc,
      updatedAtUtc: data.updatedAtUtc.present
          ? data.updatedAtUtc.value
          : this.updatedAtUtc,
      recordedZoneId: data.recordedZoneId.present
          ? data.recordedZoneId.value
          : this.recordedZoneId,
      recordedBoundaryHour: data.recordedBoundaryHour.present
          ? data.recordedBoundaryHour.value
          : this.recordedBoundaryHour,
      isBackfilled: data.isBackfilled.present
          ? data.isBackfilled.value
          : this.isBackfilled,
    );
  }

  @override
  String toString() {
    return (StringBuffer('DayRecord(')
          ..write('habitId: $habitId, ')
          ..write('day: $day, ')
          ..write('state: $state, ')
          ..write('firstRecordedAtUtc: $firstRecordedAtUtc, ')
          ..write('updatedAtUtc: $updatedAtUtc, ')
          ..write('recordedZoneId: $recordedZoneId, ')
          ..write('recordedBoundaryHour: $recordedBoundaryHour, ')
          ..write('isBackfilled: $isBackfilled')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    habitId,
    day,
    state,
    firstRecordedAtUtc,
    updatedAtUtc,
    recordedZoneId,
    recordedBoundaryHour,
    isBackfilled,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DayRecord &&
          other.habitId == this.habitId &&
          other.day == this.day &&
          other.state == this.state &&
          other.firstRecordedAtUtc == this.firstRecordedAtUtc &&
          other.updatedAtUtc == this.updatedAtUtc &&
          other.recordedZoneId == this.recordedZoneId &&
          other.recordedBoundaryHour == this.recordedBoundaryHour &&
          other.isBackfilled == this.isBackfilled);
}

class DayRecordsCompanion extends UpdateCompanion<DayRecord> {
  final Value<String> habitId;
  final Value<String> day;
  final Value<String> state;
  final Value<DateTime> firstRecordedAtUtc;
  final Value<DateTime> updatedAtUtc;
  final Value<String> recordedZoneId;
  final Value<int> recordedBoundaryHour;
  final Value<bool> isBackfilled;
  final Value<int> rowid;
  const DayRecordsCompanion({
    this.habitId = const Value.absent(),
    this.day = const Value.absent(),
    this.state = const Value.absent(),
    this.firstRecordedAtUtc = const Value.absent(),
    this.updatedAtUtc = const Value.absent(),
    this.recordedZoneId = const Value.absent(),
    this.recordedBoundaryHour = const Value.absent(),
    this.isBackfilled = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DayRecordsCompanion.insert({
    required String habitId,
    required String day,
    required String state,
    required DateTime firstRecordedAtUtc,
    required DateTime updatedAtUtc,
    required String recordedZoneId,
    required int recordedBoundaryHour,
    this.isBackfilled = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : habitId = Value(habitId),
       day = Value(day),
       state = Value(state),
       firstRecordedAtUtc = Value(firstRecordedAtUtc),
       updatedAtUtc = Value(updatedAtUtc),
       recordedZoneId = Value(recordedZoneId),
       recordedBoundaryHour = Value(recordedBoundaryHour);
  static Insertable<DayRecord> custom({
    Expression<String>? habitId,
    Expression<String>? day,
    Expression<String>? state,
    Expression<DateTime>? firstRecordedAtUtc,
    Expression<DateTime>? updatedAtUtc,
    Expression<String>? recordedZoneId,
    Expression<int>? recordedBoundaryHour,
    Expression<bool>? isBackfilled,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (habitId != null) 'habit_id': habitId,
      if (day != null) 'day': day,
      if (state != null) 'state': state,
      if (firstRecordedAtUtc != null)
        'first_recorded_at_utc': firstRecordedAtUtc,
      if (updatedAtUtc != null) 'updated_at_utc': updatedAtUtc,
      if (recordedZoneId != null) 'recorded_zone_id': recordedZoneId,
      if (recordedBoundaryHour != null)
        'recorded_boundary_hour': recordedBoundaryHour,
      if (isBackfilled != null) 'is_backfilled': isBackfilled,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DayRecordsCompanion copyWith({
    Value<String>? habitId,
    Value<String>? day,
    Value<String>? state,
    Value<DateTime>? firstRecordedAtUtc,
    Value<DateTime>? updatedAtUtc,
    Value<String>? recordedZoneId,
    Value<int>? recordedBoundaryHour,
    Value<bool>? isBackfilled,
    Value<int>? rowid,
  }) {
    return DayRecordsCompanion(
      habitId: habitId ?? this.habitId,
      day: day ?? this.day,
      state: state ?? this.state,
      firstRecordedAtUtc: firstRecordedAtUtc ?? this.firstRecordedAtUtc,
      updatedAtUtc: updatedAtUtc ?? this.updatedAtUtc,
      recordedZoneId: recordedZoneId ?? this.recordedZoneId,
      recordedBoundaryHour: recordedBoundaryHour ?? this.recordedBoundaryHour,
      isBackfilled: isBackfilled ?? this.isBackfilled,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    if (state.present) {
      map['state'] = Variable<String>(state.value);
    }
    if (firstRecordedAtUtc.present) {
      map['first_recorded_at_utc'] = Variable<DateTime>(
        firstRecordedAtUtc.value,
      );
    }
    if (updatedAtUtc.present) {
      map['updated_at_utc'] = Variable<DateTime>(updatedAtUtc.value);
    }
    if (recordedZoneId.present) {
      map['recorded_zone_id'] = Variable<String>(recordedZoneId.value);
    }
    if (recordedBoundaryHour.present) {
      map['recorded_boundary_hour'] = Variable<int>(recordedBoundaryHour.value);
    }
    if (isBackfilled.present) {
      map['is_backfilled'] = Variable<bool>(isBackfilled.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DayRecordsCompanion(')
          ..write('habitId: $habitId, ')
          ..write('day: $day, ')
          ..write('state: $state, ')
          ..write('firstRecordedAtUtc: $firstRecordedAtUtc, ')
          ..write('updatedAtUtc: $updatedAtUtc, ')
          ..write('recordedZoneId: $recordedZoneId, ')
          ..write('recordedBoundaryHour: $recordedBoundaryHour, ')
          ..write('isBackfilled: $isBackfilled, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GrowthGrantsTable extends GrowthGrants
    with TableInfo<$GrowthGrantsTable, GrowthGrant> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GrowthGrantsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _habitIdMeta = const VerificationMeta(
    'habitId',
  );
  @override
  late final GeneratedColumn<String> habitId = GeneratedColumn<String>(
    'habit_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _creatureIdMeta = const VerificationMeta(
    'creatureId',
  );
  @override
  late final GeneratedColumn<String> creatureId = GeneratedColumn<String>(
    'creature_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _dayMeta = const VerificationMeta('day');
  @override
  late final GeneratedColumn<String> day = GeneratedColumn<String>(
    'day',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ordinalMeta = const VerificationMeta(
    'ordinal',
  );
  @override
  late final GeneratedColumn<int> ordinal = GeneratedColumn<int>(
    'ordinal',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _amountMeta = const VerificationMeta('amount');
  @override
  late final GeneratedColumn<int> amount = GeneratedColumn<int>(
    'amount',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _algorithmVersionMeta = const VerificationMeta(
    'algorithmVersion',
  );
  @override
  late final GeneratedColumn<int> algorithmVersion = GeneratedColumn<int>(
    'algorithm_version',
    aliasedName,
    false,
    type: DriftSqlType.int,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _issuedAtUtcMeta = const VerificationMeta(
    'issuedAtUtc',
  );
  @override
  late final GeneratedColumn<DateTime> issuedAtUtc = GeneratedColumn<DateTime>(
    'issued_at_utc',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    habitId,
    creatureId,
    day,
    ordinal,
    amount,
    algorithmVersion,
    issuedAtUtc,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'growth_grants';
  @override
  VerificationContext validateIntegrity(
    Insertable<GrowthGrant> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('habit_id')) {
      context.handle(
        _habitIdMeta,
        habitId.isAcceptableOrUnknown(data['habit_id']!, _habitIdMeta),
      );
    } else if (isInserting) {
      context.missing(_habitIdMeta);
    }
    if (data.containsKey('creature_id')) {
      context.handle(
        _creatureIdMeta,
        creatureId.isAcceptableOrUnknown(data['creature_id']!, _creatureIdMeta),
      );
    } else if (isInserting) {
      context.missing(_creatureIdMeta);
    }
    if (data.containsKey('day')) {
      context.handle(
        _dayMeta,
        day.isAcceptableOrUnknown(data['day']!, _dayMeta),
      );
    } else if (isInserting) {
      context.missing(_dayMeta);
    }
    if (data.containsKey('ordinal')) {
      context.handle(
        _ordinalMeta,
        ordinal.isAcceptableOrUnknown(data['ordinal']!, _ordinalMeta),
      );
    } else if (isInserting) {
      context.missing(_ordinalMeta);
    }
    if (data.containsKey('amount')) {
      context.handle(
        _amountMeta,
        amount.isAcceptableOrUnknown(data['amount']!, _amountMeta),
      );
    } else if (isInserting) {
      context.missing(_amountMeta);
    }
    if (data.containsKey('algorithm_version')) {
      context.handle(
        _algorithmVersionMeta,
        algorithmVersion.isAcceptableOrUnknown(
          data['algorithm_version']!,
          _algorithmVersionMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_algorithmVersionMeta);
    }
    if (data.containsKey('issued_at_utc')) {
      context.handle(
        _issuedAtUtcMeta,
        issuedAtUtc.isAcceptableOrUnknown(
          data['issued_at_utc']!,
          _issuedAtUtcMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_issuedAtUtcMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  GrowthGrant map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return GrowthGrant(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      habitId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}habit_id'],
      )!,
      creatureId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}creature_id'],
      )!,
      day: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}day'],
      )!,
      ordinal: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}ordinal'],
      )!,
      amount: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}amount'],
      )!,
      algorithmVersion: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}algorithm_version'],
      )!,
      issuedAtUtc: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}issued_at_utc'],
      )!,
    );
  }

  @override
  $GrowthGrantsTable createAlias(String alias) {
    return $GrowthGrantsTable(attachedDatabase, alias);
  }
}

class GrowthGrant extends DataClass implements Insertable<GrowthGrant> {
  final String id;
  final String habitId;
  final String creatureId;
  final String day;
  final int ordinal;
  final int amount;
  final int algorithmVersion;
  final DateTime issuedAtUtc;
  const GrowthGrant({
    required this.id,
    required this.habitId,
    required this.creatureId,
    required this.day,
    required this.ordinal,
    required this.amount,
    required this.algorithmVersion,
    required this.issuedAtUtc,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['habit_id'] = Variable<String>(habitId);
    map['creature_id'] = Variable<String>(creatureId);
    map['day'] = Variable<String>(day);
    map['ordinal'] = Variable<int>(ordinal);
    map['amount'] = Variable<int>(amount);
    map['algorithm_version'] = Variable<int>(algorithmVersion);
    map['issued_at_utc'] = Variable<DateTime>(issuedAtUtc);
    return map;
  }

  GrowthGrantsCompanion toCompanion(bool nullToAbsent) {
    return GrowthGrantsCompanion(
      id: Value(id),
      habitId: Value(habitId),
      creatureId: Value(creatureId),
      day: Value(day),
      ordinal: Value(ordinal),
      amount: Value(amount),
      algorithmVersion: Value(algorithmVersion),
      issuedAtUtc: Value(issuedAtUtc),
    );
  }

  factory GrowthGrant.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return GrowthGrant(
      id: serializer.fromJson<String>(json['id']),
      habitId: serializer.fromJson<String>(json['habitId']),
      creatureId: serializer.fromJson<String>(json['creatureId']),
      day: serializer.fromJson<String>(json['day']),
      ordinal: serializer.fromJson<int>(json['ordinal']),
      amount: serializer.fromJson<int>(json['amount']),
      algorithmVersion: serializer.fromJson<int>(json['algorithmVersion']),
      issuedAtUtc: serializer.fromJson<DateTime>(json['issuedAtUtc']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'habitId': serializer.toJson<String>(habitId),
      'creatureId': serializer.toJson<String>(creatureId),
      'day': serializer.toJson<String>(day),
      'ordinal': serializer.toJson<int>(ordinal),
      'amount': serializer.toJson<int>(amount),
      'algorithmVersion': serializer.toJson<int>(algorithmVersion),
      'issuedAtUtc': serializer.toJson<DateTime>(issuedAtUtc),
    };
  }

  GrowthGrant copyWith({
    String? id,
    String? habitId,
    String? creatureId,
    String? day,
    int? ordinal,
    int? amount,
    int? algorithmVersion,
    DateTime? issuedAtUtc,
  }) => GrowthGrant(
    id: id ?? this.id,
    habitId: habitId ?? this.habitId,
    creatureId: creatureId ?? this.creatureId,
    day: day ?? this.day,
    ordinal: ordinal ?? this.ordinal,
    amount: amount ?? this.amount,
    algorithmVersion: algorithmVersion ?? this.algorithmVersion,
    issuedAtUtc: issuedAtUtc ?? this.issuedAtUtc,
  );
  GrowthGrant copyWithCompanion(GrowthGrantsCompanion data) {
    return GrowthGrant(
      id: data.id.present ? data.id.value : this.id,
      habitId: data.habitId.present ? data.habitId.value : this.habitId,
      creatureId: data.creatureId.present
          ? data.creatureId.value
          : this.creatureId,
      day: data.day.present ? data.day.value : this.day,
      ordinal: data.ordinal.present ? data.ordinal.value : this.ordinal,
      amount: data.amount.present ? data.amount.value : this.amount,
      algorithmVersion: data.algorithmVersion.present
          ? data.algorithmVersion.value
          : this.algorithmVersion,
      issuedAtUtc: data.issuedAtUtc.present
          ? data.issuedAtUtc.value
          : this.issuedAtUtc,
    );
  }

  @override
  String toString() {
    return (StringBuffer('GrowthGrant(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('creatureId: $creatureId, ')
          ..write('day: $day, ')
          ..write('ordinal: $ordinal, ')
          ..write('amount: $amount, ')
          ..write('algorithmVersion: $algorithmVersion, ')
          ..write('issuedAtUtc: $issuedAtUtc')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    habitId,
    creatureId,
    day,
    ordinal,
    amount,
    algorithmVersion,
    issuedAtUtc,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is GrowthGrant &&
          other.id == this.id &&
          other.habitId == this.habitId &&
          other.creatureId == this.creatureId &&
          other.day == this.day &&
          other.ordinal == this.ordinal &&
          other.amount == this.amount &&
          other.algorithmVersion == this.algorithmVersion &&
          other.issuedAtUtc == this.issuedAtUtc);
}

class GrowthGrantsCompanion extends UpdateCompanion<GrowthGrant> {
  final Value<String> id;
  final Value<String> habitId;
  final Value<String> creatureId;
  final Value<String> day;
  final Value<int> ordinal;
  final Value<int> amount;
  final Value<int> algorithmVersion;
  final Value<DateTime> issuedAtUtc;
  final Value<int> rowid;
  const GrowthGrantsCompanion({
    this.id = const Value.absent(),
    this.habitId = const Value.absent(),
    this.creatureId = const Value.absent(),
    this.day = const Value.absent(),
    this.ordinal = const Value.absent(),
    this.amount = const Value.absent(),
    this.algorithmVersion = const Value.absent(),
    this.issuedAtUtc = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GrowthGrantsCompanion.insert({
    required String id,
    required String habitId,
    required String creatureId,
    required String day,
    required int ordinal,
    required int amount,
    required int algorithmVersion,
    required DateTime issuedAtUtc,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       habitId = Value(habitId),
       creatureId = Value(creatureId),
       day = Value(day),
       ordinal = Value(ordinal),
       amount = Value(amount),
       algorithmVersion = Value(algorithmVersion),
       issuedAtUtc = Value(issuedAtUtc);
  static Insertable<GrowthGrant> custom({
    Expression<String>? id,
    Expression<String>? habitId,
    Expression<String>? creatureId,
    Expression<String>? day,
    Expression<int>? ordinal,
    Expression<int>? amount,
    Expression<int>? algorithmVersion,
    Expression<DateTime>? issuedAtUtc,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (habitId != null) 'habit_id': habitId,
      if (creatureId != null) 'creature_id': creatureId,
      if (day != null) 'day': day,
      if (ordinal != null) 'ordinal': ordinal,
      if (amount != null) 'amount': amount,
      if (algorithmVersion != null) 'algorithm_version': algorithmVersion,
      if (issuedAtUtc != null) 'issued_at_utc': issuedAtUtc,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GrowthGrantsCompanion copyWith({
    Value<String>? id,
    Value<String>? habitId,
    Value<String>? creatureId,
    Value<String>? day,
    Value<int>? ordinal,
    Value<int>? amount,
    Value<int>? algorithmVersion,
    Value<DateTime>? issuedAtUtc,
    Value<int>? rowid,
  }) {
    return GrowthGrantsCompanion(
      id: id ?? this.id,
      habitId: habitId ?? this.habitId,
      creatureId: creatureId ?? this.creatureId,
      day: day ?? this.day,
      ordinal: ordinal ?? this.ordinal,
      amount: amount ?? this.amount,
      algorithmVersion: algorithmVersion ?? this.algorithmVersion,
      issuedAtUtc: issuedAtUtc ?? this.issuedAtUtc,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (habitId.present) {
      map['habit_id'] = Variable<String>(habitId.value);
    }
    if (creatureId.present) {
      map['creature_id'] = Variable<String>(creatureId.value);
    }
    if (day.present) {
      map['day'] = Variable<String>(day.value);
    }
    if (ordinal.present) {
      map['ordinal'] = Variable<int>(ordinal.value);
    }
    if (amount.present) {
      map['amount'] = Variable<int>(amount.value);
    }
    if (algorithmVersion.present) {
      map['algorithm_version'] = Variable<int>(algorithmVersion.value);
    }
    if (issuedAtUtc.present) {
      map['issued_at_utc'] = Variable<DateTime>(issuedAtUtc.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GrowthGrantsCompanion(')
          ..write('id: $id, ')
          ..write('habitId: $habitId, ')
          ..write('creatureId: $creatureId, ')
          ..write('day: $day, ')
          ..write('ordinal: $ordinal, ')
          ..write('amount: $amount, ')
          ..write('algorithmVersion: $algorithmVersion, ')
          ..write('issuedAtUtc: $issuedAtUtc, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $HabitsTable habits = $HabitsTable(this);
  late final $CreaturesTable creatures = $CreaturesTable(this);
  late final $DayRecordsTable dayRecords = $DayRecordsTable(this);
  late final $GrowthGrantsTable growthGrants = $GrowthGrantsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    habits,
    creatures,
    dayRecords,
    growthGrants,
  ];
}

typedef $$HabitsTableCreateCompanionBuilder =
    HabitsCompanion Function({
      required String id,
      required String title,
      required String startDay,
      required String creatureId,
      required DateTime createdAtUtc,
      Value<int> revision,
      Value<DateTime?> archivedAtUtc,
      Value<String?> archivedFromDay,
      Value<int> rowid,
    });
typedef $$HabitsTableUpdateCompanionBuilder =
    HabitsCompanion Function({
      Value<String> id,
      Value<String> title,
      Value<String> startDay,
      Value<String> creatureId,
      Value<DateTime> createdAtUtc,
      Value<int> revision,
      Value<DateTime?> archivedAtUtc,
      Value<String?> archivedFromDay,
      Value<int> rowid,
    });

class $$HabitsTableFilterComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableFilterComposer({
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

  ColumnFilters<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get startDay => $composableBuilder(
    column: $table.startDay,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creatureId => $composableBuilder(
    column: $table.creatureId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get archivedAtUtc => $composableBuilder(
    column: $table.archivedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get archivedFromDay => $composableBuilder(
    column: $table.archivedFromDay,
    builder: (column) => ColumnFilters(column),
  );
}

class $$HabitsTableOrderingComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableOrderingComposer({
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

  ColumnOrderings<String> get title => $composableBuilder(
    column: $table.title,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get startDay => $composableBuilder(
    column: $table.startDay,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creatureId => $composableBuilder(
    column: $table.creatureId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get revision => $composableBuilder(
    column: $table.revision,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get archivedAtUtc => $composableBuilder(
    column: $table.archivedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get archivedFromDay => $composableBuilder(
    column: $table.archivedFromDay,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$HabitsTableAnnotationComposer
    extends Composer<_$AppDatabase, $HabitsTable> {
  $$HabitsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get title =>
      $composableBuilder(column: $table.title, builder: (column) => column);

  GeneratedColumn<String> get startDay =>
      $composableBuilder(column: $table.startDay, builder: (column) => column);

  GeneratedColumn<String> get creatureId => $composableBuilder(
    column: $table.creatureId,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<int> get revision =>
      $composableBuilder(column: $table.revision, builder: (column) => column);

  GeneratedColumn<DateTime> get archivedAtUtc => $composableBuilder(
    column: $table.archivedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get archivedFromDay => $composableBuilder(
    column: $table.archivedFromDay,
    builder: (column) => column,
  );
}

class $$HabitsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $HabitsTable,
          Habit,
          $$HabitsTableFilterComposer,
          $$HabitsTableOrderingComposer,
          $$HabitsTableAnnotationComposer,
          $$HabitsTableCreateCompanionBuilder,
          $$HabitsTableUpdateCompanionBuilder,
          (Habit, BaseReferences<_$AppDatabase, $HabitsTable, Habit>),
          Habit,
          PrefetchHooks Function()
        > {
  $$HabitsTableTableManager(_$AppDatabase db, $HabitsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$HabitsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$HabitsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$HabitsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> title = const Value.absent(),
                Value<String> startDay = const Value.absent(),
                Value<String> creatureId = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
                Value<int> revision = const Value.absent(),
                Value<DateTime?> archivedAtUtc = const Value.absent(),
                Value<String?> archivedFromDay = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion(
                id: id,
                title: title,
                startDay: startDay,
                creatureId: creatureId,
                createdAtUtc: createdAtUtc,
                revision: revision,
                archivedAtUtc: archivedAtUtc,
                archivedFromDay: archivedFromDay,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String title,
                required String startDay,
                required String creatureId,
                required DateTime createdAtUtc,
                Value<int> revision = const Value.absent(),
                Value<DateTime?> archivedAtUtc = const Value.absent(),
                Value<String?> archivedFromDay = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => HabitsCompanion.insert(
                id: id,
                title: title,
                startDay: startDay,
                creatureId: creatureId,
                createdAtUtc: createdAtUtc,
                revision: revision,
                archivedAtUtc: archivedAtUtc,
                archivedFromDay: archivedFromDay,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$HabitsTable, Habit>(table),
                  BaseReferences<_$AppDatabase, $HabitsTable, Habit>(
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

typedef $$HabitsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $HabitsTable,
      Habit,
      $$HabitsTableFilterComposer,
      $$HabitsTableOrderingComposer,
      $$HabitsTableAnnotationComposer,
      $$HabitsTableCreateCompanionBuilder,
      $$HabitsTableUpdateCompanionBuilder,
      (Habit, BaseReferences<_$AppDatabase, $HabitsTable, Habit>),
      Habit,
      PrefetchHooks Function()
    >;
typedef $$CreaturesTableCreateCompanionBuilder =
    CreaturesCompanion Function({
      required String id,
      required String habitId,
      required String species,
      Value<String?> nickname,
      required String growthMode,
      required Uint8List growthSeed,
      required int growthAlgorithmVersion,
      required int nextGrantOrdinal,
      Value<int> maxStageReached,
      required DateTime createdAtUtc,
      Value<int> rowid,
    });
typedef $$CreaturesTableUpdateCompanionBuilder =
    CreaturesCompanion Function({
      Value<String> id,
      Value<String> habitId,
      Value<String> species,
      Value<String?> nickname,
      Value<String> growthMode,
      Value<Uint8List> growthSeed,
      Value<int> growthAlgorithmVersion,
      Value<int> nextGrantOrdinal,
      Value<int> maxStageReached,
      Value<DateTime> createdAtUtc,
      Value<int> rowid,
    });

class $$CreaturesTableFilterComposer
    extends Composer<_$AppDatabase, $CreaturesTable> {
  $$CreaturesTableFilterComposer({
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

  ColumnFilters<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get growthMode => $composableBuilder(
    column: $table.growthMode,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<Uint8List> get growthSeed => $composableBuilder(
    column: $table.growthSeed,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get growthAlgorithmVersion => $composableBuilder(
    column: $table.growthAlgorithmVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get nextGrantOrdinal => $composableBuilder(
    column: $table.nextGrantOrdinal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get maxStageReached => $composableBuilder(
    column: $table.maxStageReached,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnFilters(column),
  );
}

class $$CreaturesTableOrderingComposer
    extends Composer<_$AppDatabase, $CreaturesTable> {
  $$CreaturesTableOrderingComposer({
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

  ColumnOrderings<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get species => $composableBuilder(
    column: $table.species,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get nickname => $composableBuilder(
    column: $table.nickname,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get growthMode => $composableBuilder(
    column: $table.growthMode,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<Uint8List> get growthSeed => $composableBuilder(
    column: $table.growthSeed,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get growthAlgorithmVersion => $composableBuilder(
    column: $table.growthAlgorithmVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get nextGrantOrdinal => $composableBuilder(
    column: $table.nextGrantOrdinal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get maxStageReached => $composableBuilder(
    column: $table.maxStageReached,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$CreaturesTableAnnotationComposer
    extends Composer<_$AppDatabase, $CreaturesTable> {
  $$CreaturesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<String> get species =>
      $composableBuilder(column: $table.species, builder: (column) => column);

  GeneratedColumn<String> get nickname =>
      $composableBuilder(column: $table.nickname, builder: (column) => column);

  GeneratedColumn<String> get growthMode => $composableBuilder(
    column: $table.growthMode,
    builder: (column) => column,
  );

  GeneratedColumn<Uint8List> get growthSeed => $composableBuilder(
    column: $table.growthSeed,
    builder: (column) => column,
  );

  GeneratedColumn<int> get growthAlgorithmVersion => $composableBuilder(
    column: $table.growthAlgorithmVersion,
    builder: (column) => column,
  );

  GeneratedColumn<int> get nextGrantOrdinal => $composableBuilder(
    column: $table.nextGrantOrdinal,
    builder: (column) => column,
  );

  GeneratedColumn<int> get maxStageReached => $composableBuilder(
    column: $table.maxStageReached,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get createdAtUtc => $composableBuilder(
    column: $table.createdAtUtc,
    builder: (column) => column,
  );
}

class $$CreaturesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $CreaturesTable,
          Creature,
          $$CreaturesTableFilterComposer,
          $$CreaturesTableOrderingComposer,
          $$CreaturesTableAnnotationComposer,
          $$CreaturesTableCreateCompanionBuilder,
          $$CreaturesTableUpdateCompanionBuilder,
          (Creature, BaseReferences<_$AppDatabase, $CreaturesTable, Creature>),
          Creature,
          PrefetchHooks Function()
        > {
  $$CreaturesTableTableManager(_$AppDatabase db, $CreaturesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$CreaturesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$CreaturesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$CreaturesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<String> species = const Value.absent(),
                Value<String?> nickname = const Value.absent(),
                Value<String> growthMode = const Value.absent(),
                Value<Uint8List> growthSeed = const Value.absent(),
                Value<int> growthAlgorithmVersion = const Value.absent(),
                Value<int> nextGrantOrdinal = const Value.absent(),
                Value<int> maxStageReached = const Value.absent(),
                Value<DateTime> createdAtUtc = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => CreaturesCompanion(
                id: id,
                habitId: habitId,
                species: species,
                nickname: nickname,
                growthMode: growthMode,
                growthSeed: growthSeed,
                growthAlgorithmVersion: growthAlgorithmVersion,
                nextGrantOrdinal: nextGrantOrdinal,
                maxStageReached: maxStageReached,
                createdAtUtc: createdAtUtc,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String habitId,
                required String species,
                Value<String?> nickname = const Value.absent(),
                required String growthMode,
                required Uint8List growthSeed,
                required int growthAlgorithmVersion,
                required int nextGrantOrdinal,
                Value<int> maxStageReached = const Value.absent(),
                required DateTime createdAtUtc,
                Value<int> rowid = const Value.absent(),
              }) => CreaturesCompanion.insert(
                id: id,
                habitId: habitId,
                species: species,
                nickname: nickname,
                growthMode: growthMode,
                growthSeed: growthSeed,
                growthAlgorithmVersion: growthAlgorithmVersion,
                nextGrantOrdinal: nextGrantOrdinal,
                maxStageReached: maxStageReached,
                createdAtUtc: createdAtUtc,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$CreaturesTable, Creature>(table),
                  BaseReferences<_$AppDatabase, $CreaturesTable, Creature>(
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

typedef $$CreaturesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $CreaturesTable,
      Creature,
      $$CreaturesTableFilterComposer,
      $$CreaturesTableOrderingComposer,
      $$CreaturesTableAnnotationComposer,
      $$CreaturesTableCreateCompanionBuilder,
      $$CreaturesTableUpdateCompanionBuilder,
      (Creature, BaseReferences<_$AppDatabase, $CreaturesTable, Creature>),
      Creature,
      PrefetchHooks Function()
    >;
typedef $$DayRecordsTableCreateCompanionBuilder =
    DayRecordsCompanion Function({
      required String habitId,
      required String day,
      required String state,
      required DateTime firstRecordedAtUtc,
      required DateTime updatedAtUtc,
      required String recordedZoneId,
      required int recordedBoundaryHour,
      Value<bool> isBackfilled,
      Value<int> rowid,
    });
typedef $$DayRecordsTableUpdateCompanionBuilder =
    DayRecordsCompanion Function({
      Value<String> habitId,
      Value<String> day,
      Value<String> state,
      Value<DateTime> firstRecordedAtUtc,
      Value<DateTime> updatedAtUtc,
      Value<String> recordedZoneId,
      Value<int> recordedBoundaryHour,
      Value<bool> isBackfilled,
      Value<int> rowid,
    });

class $$DayRecordsTableFilterComposer
    extends Composer<_$AppDatabase, $DayRecordsTable> {
  $$DayRecordsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get firstRecordedAtUtc => $composableBuilder(
    column: $table.firstRecordedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAtUtc => $composableBuilder(
    column: $table.updatedAtUtc,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get recordedZoneId => $composableBuilder(
    column: $table.recordedZoneId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get recordedBoundaryHour => $composableBuilder(
    column: $table.recordedBoundaryHour,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get isBackfilled => $composableBuilder(
    column: $table.isBackfilled,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DayRecordsTableOrderingComposer
    extends Composer<_$AppDatabase, $DayRecordsTable> {
  $$DayRecordsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get state => $composableBuilder(
    column: $table.state,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get firstRecordedAtUtc => $composableBuilder(
    column: $table.firstRecordedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAtUtc => $composableBuilder(
    column: $table.updatedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get recordedZoneId => $composableBuilder(
    column: $table.recordedZoneId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get recordedBoundaryHour => $composableBuilder(
    column: $table.recordedBoundaryHour,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get isBackfilled => $composableBuilder(
    column: $table.isBackfilled,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DayRecordsTableAnnotationComposer
    extends Composer<_$AppDatabase, $DayRecordsTable> {
  $$DayRecordsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<String> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<String> get state =>
      $composableBuilder(column: $table.state, builder: (column) => column);

  GeneratedColumn<DateTime> get firstRecordedAtUtc => $composableBuilder(
    column: $table.firstRecordedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get updatedAtUtc => $composableBuilder(
    column: $table.updatedAtUtc,
    builder: (column) => column,
  );

  GeneratedColumn<String> get recordedZoneId => $composableBuilder(
    column: $table.recordedZoneId,
    builder: (column) => column,
  );

  GeneratedColumn<int> get recordedBoundaryHour => $composableBuilder(
    column: $table.recordedBoundaryHour,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get isBackfilled => $composableBuilder(
    column: $table.isBackfilled,
    builder: (column) => column,
  );
}

class $$DayRecordsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $DayRecordsTable,
          DayRecord,
          $$DayRecordsTableFilterComposer,
          $$DayRecordsTableOrderingComposer,
          $$DayRecordsTableAnnotationComposer,
          $$DayRecordsTableCreateCompanionBuilder,
          $$DayRecordsTableUpdateCompanionBuilder,
          (
            DayRecord,
            BaseReferences<_$AppDatabase, $DayRecordsTable, DayRecord>,
          ),
          DayRecord,
          PrefetchHooks Function()
        > {
  $$DayRecordsTableTableManager(_$AppDatabase db, $DayRecordsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DayRecordsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DayRecordsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DayRecordsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> habitId = const Value.absent(),
                Value<String> day = const Value.absent(),
                Value<String> state = const Value.absent(),
                Value<DateTime> firstRecordedAtUtc = const Value.absent(),
                Value<DateTime> updatedAtUtc = const Value.absent(),
                Value<String> recordedZoneId = const Value.absent(),
                Value<int> recordedBoundaryHour = const Value.absent(),
                Value<bool> isBackfilled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DayRecordsCompanion(
                habitId: habitId,
                day: day,
                state: state,
                firstRecordedAtUtc: firstRecordedAtUtc,
                updatedAtUtc: updatedAtUtc,
                recordedZoneId: recordedZoneId,
                recordedBoundaryHour: recordedBoundaryHour,
                isBackfilled: isBackfilled,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String habitId,
                required String day,
                required String state,
                required DateTime firstRecordedAtUtc,
                required DateTime updatedAtUtc,
                required String recordedZoneId,
                required int recordedBoundaryHour,
                Value<bool> isBackfilled = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => DayRecordsCompanion.insert(
                habitId: habitId,
                day: day,
                state: state,
                firstRecordedAtUtc: firstRecordedAtUtc,
                updatedAtUtc: updatedAtUtc,
                recordedZoneId: recordedZoneId,
                recordedBoundaryHour: recordedBoundaryHour,
                isBackfilled: isBackfilled,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$DayRecordsTable, DayRecord>(table),
                  BaseReferences<_$AppDatabase, $DayRecordsTable, DayRecord>(
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

typedef $$DayRecordsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $DayRecordsTable,
      DayRecord,
      $$DayRecordsTableFilterComposer,
      $$DayRecordsTableOrderingComposer,
      $$DayRecordsTableAnnotationComposer,
      $$DayRecordsTableCreateCompanionBuilder,
      $$DayRecordsTableUpdateCompanionBuilder,
      (DayRecord, BaseReferences<_$AppDatabase, $DayRecordsTable, DayRecord>),
      DayRecord,
      PrefetchHooks Function()
    >;
typedef $$GrowthGrantsTableCreateCompanionBuilder =
    GrowthGrantsCompanion Function({
      required String id,
      required String habitId,
      required String creatureId,
      required String day,
      required int ordinal,
      required int amount,
      required int algorithmVersion,
      required DateTime issuedAtUtc,
      Value<int> rowid,
    });
typedef $$GrowthGrantsTableUpdateCompanionBuilder =
    GrowthGrantsCompanion Function({
      Value<String> id,
      Value<String> habitId,
      Value<String> creatureId,
      Value<String> day,
      Value<int> ordinal,
      Value<int> amount,
      Value<int> algorithmVersion,
      Value<DateTime> issuedAtUtc,
      Value<int> rowid,
    });

class $$GrowthGrantsTableFilterComposer
    extends Composer<_$AppDatabase, $GrowthGrantsTable> {
  $$GrowthGrantsTableFilterComposer({
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

  ColumnFilters<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get creatureId => $composableBuilder(
    column: $table.creatureId,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<int> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get issuedAtUtc => $composableBuilder(
    column: $table.issuedAtUtc,
    builder: (column) => ColumnFilters(column),
  );
}

class $$GrowthGrantsTableOrderingComposer
    extends Composer<_$AppDatabase, $GrowthGrantsTable> {
  $$GrowthGrantsTableOrderingComposer({
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

  ColumnOrderings<String> get habitId => $composableBuilder(
    column: $table.habitId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get creatureId => $composableBuilder(
    column: $table.creatureId,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get day => $composableBuilder(
    column: $table.day,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get ordinal => $composableBuilder(
    column: $table.ordinal,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get amount => $composableBuilder(
    column: $table.amount,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<int> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get issuedAtUtc => $composableBuilder(
    column: $table.issuedAtUtc,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GrowthGrantsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GrowthGrantsTable> {
  $$GrowthGrantsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get habitId =>
      $composableBuilder(column: $table.habitId, builder: (column) => column);

  GeneratedColumn<String> get creatureId => $composableBuilder(
    column: $table.creatureId,
    builder: (column) => column,
  );

  GeneratedColumn<String> get day =>
      $composableBuilder(column: $table.day, builder: (column) => column);

  GeneratedColumn<int> get ordinal =>
      $composableBuilder(column: $table.ordinal, builder: (column) => column);

  GeneratedColumn<int> get amount =>
      $composableBuilder(column: $table.amount, builder: (column) => column);

  GeneratedColumn<int> get algorithmVersion => $composableBuilder(
    column: $table.algorithmVersion,
    builder: (column) => column,
  );

  GeneratedColumn<DateTime> get issuedAtUtc => $composableBuilder(
    column: $table.issuedAtUtc,
    builder: (column) => column,
  );
}

class $$GrowthGrantsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GrowthGrantsTable,
          GrowthGrant,
          $$GrowthGrantsTableFilterComposer,
          $$GrowthGrantsTableOrderingComposer,
          $$GrowthGrantsTableAnnotationComposer,
          $$GrowthGrantsTableCreateCompanionBuilder,
          $$GrowthGrantsTableUpdateCompanionBuilder,
          (
            GrowthGrant,
            BaseReferences<_$AppDatabase, $GrowthGrantsTable, GrowthGrant>,
          ),
          GrowthGrant,
          PrefetchHooks Function()
        > {
  $$GrowthGrantsTableTableManager(_$AppDatabase db, $GrowthGrantsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GrowthGrantsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GrowthGrantsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GrowthGrantsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> habitId = const Value.absent(),
                Value<String> creatureId = const Value.absent(),
                Value<String> day = const Value.absent(),
                Value<int> ordinal = const Value.absent(),
                Value<int> amount = const Value.absent(),
                Value<int> algorithmVersion = const Value.absent(),
                Value<DateTime> issuedAtUtc = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GrowthGrantsCompanion(
                id: id,
                habitId: habitId,
                creatureId: creatureId,
                day: day,
                ordinal: ordinal,
                amount: amount,
                algorithmVersion: algorithmVersion,
                issuedAtUtc: issuedAtUtc,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String habitId,
                required String creatureId,
                required String day,
                required int ordinal,
                required int amount,
                required int algorithmVersion,
                required DateTime issuedAtUtc,
                Value<int> rowid = const Value.absent(),
              }) => GrowthGrantsCompanion.insert(
                id: id,
                habitId: habitId,
                creatureId: creatureId,
                day: day,
                ordinal: ordinal,
                amount: amount,
                algorithmVersion: algorithmVersion,
                issuedAtUtc: issuedAtUtc,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable<$GrowthGrantsTable, GrowthGrant>(table),
                  BaseReferences<
                    _$AppDatabase,
                    $GrowthGrantsTable,
                    GrowthGrant
                  >(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$GrowthGrantsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GrowthGrantsTable,
      GrowthGrant,
      $$GrowthGrantsTableFilterComposer,
      $$GrowthGrantsTableOrderingComposer,
      $$GrowthGrantsTableAnnotationComposer,
      $$GrowthGrantsTableCreateCompanionBuilder,
      $$GrowthGrantsTableUpdateCompanionBuilder,
      (
        GrowthGrant,
        BaseReferences<_$AppDatabase, $GrowthGrantsTable, GrowthGrant>,
      ),
      GrowthGrant,
      PrefetchHooks Function()
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$HabitsTableTableManager get habits =>
      $$HabitsTableTableManager(_db, _db.habits);
  $$CreaturesTableTableManager get creatures =>
      $$CreaturesTableTableManager(_db, _db.creatures);
  $$DayRecordsTableTableManager get dayRecords =>
      $$DayRecordsTableTableManager(_db, _db.dayRecords);
  $$GrowthGrantsTableTableManager get growthGrants =>
      $$GrowthGrantsTableTableManager(_db, _db.growthGrants);
}
