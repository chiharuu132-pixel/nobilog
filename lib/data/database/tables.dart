import 'package:drift/drift.dart';

// --- 習慣テーブル ---
class Habits extends Table {
  TextColumn get id => text()();
  TextColumn get title => text().withLength(min: 1, max: 40)();
  TextColumn get startDay => text()(); // YYYY-MM-DD
  TextColumn get creatureId => text()();
  DateTimeColumn get createdAtUtc => dateTime()();
  IntColumn get revision => integer().withDefault(const Constant(1))();
  DateTimeColumn get archivedAtUtc => dateTime().nullable()();
  TextColumn get archivedFromDay => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// --- 生き物テーブル ---
class Creatures extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text()();
  TextColumn get species => text()();
  TextColumn get nickname => text().nullable()();
  TextColumn get growthMode => text()(); // 'fixed' | 'normalDistribution' など
  BlobColumn get growthSeed => blob()();
  IntColumn get growthAlgorithmVersion => integer()();
  IntColumn get nextGrantOrdinal => integer()();
  IntColumn get maxStageReached => integer().withDefault(const Constant(1))();
  DateTimeColumn get createdAtUtc => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}

// --- 日付記録テーブル ---
class DayRecords extends Table {
  TextColumn get habitId => text()();
  TextColumn get day => text()(); // YYYY-MM-DD
  TextColumn get state => text()(); // 'minimum' | 'standard' | 'rest' | 'missed' | 'cancelled'
  DateTimeColumn get firstRecordedAtUtc => dateTime()();
  DateTimeColumn get updatedAtUtc => dateTime()();
  TextColumn get recordedZoneId => text()();
  IntColumn get recordedBoundaryHour => integer()();
  BoolColumn get isBackfilled => boolean().withDefault(const Constant(false))();

  @override
  Set<Column> get primaryKey => {habitId, day}; // 複合主キー
}

// --- 成長・減算履歴テーブル ---
class GrowthGrants extends Table {
  TextColumn get id => text()();
  TextColumn get habitId => text()();
  TextColumn get creatureId => text()();
  TextColumn get day => text()(); // YYYY-MM-DD
  IntColumn get ordinal => integer()();
  IntColumn get amount => integer()(); // ※負の値（ペナルティ）を許容
  IntColumn get algorithmVersion => integer()();
  DateTimeColumn get issuedAtUtc => dateTime()();

  @override
  Set<Column> get primaryKey => {id};
}