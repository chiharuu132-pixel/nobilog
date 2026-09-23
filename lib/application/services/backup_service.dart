import 'dart:convert';
import 'package:drift/drift.dart';
import '../../data/database/app_database.dart';

class BackupService {
  final AppDatabase db;

  BackupService(this.db);

  /// 全データをJSON文字列としてエクスポート
  Future<String> exportToJson() async {
    final habits = await db.select(db.habits).get();
    final creatures = await db.select(db.creatures).get();
    final dayRecords = await db.select(db.dayRecords).get();
    final growthGrants = await db.select(db.growthGrants).get();

    final data = {
      'version': 1,
      'createdAt': DateTime.now().toUtc().toIso8601String(),
      'habits': habits.map((h) => {
        'id': h.id,
        'title': h.title,
        'startDay': h.startDay,
        'creatureId': h.creatureId,
        'createdAtUtc': h.createdAtUtc.toIso8601String(),
        'revision': h.revision,
        'archivedAtUtc': h.archivedAtUtc?.toIso8601String(),
        'archivedFromDay': h.archivedFromDay,
      }).toList(),
      'creatures': creatures.map((c) => {
        'id': c.id,
        'habitId': c.habitId,
        'species': c.species,
        'nickname': c.nickname,
        'growthMode': c.growthMode,
        'growthSeed': c.growthSeed.toList(),
        'growthAlgorithmVersion': c.growthAlgorithmVersion,
        'nextGrantOrdinal': c.nextGrantOrdinal,
        'maxStageReached': c.maxStageReached,
        'createdAtUtc': c.createdAtUtc.toIso8601String(),
      }).toList(),
      'dayRecords': dayRecords.map((r) => {
        'habitId': r.habitId,
        'day': r.day,
        'state': r.state,
        'firstRecordedAtUtc': r.firstRecordedAtUtc.toIso8601String(),
        'updatedAtUtc': r.updatedAtUtc.toIso8601String(),
        'recordedZoneId': r.recordedZoneId,
        'recordedBoundaryHour': r.recordedBoundaryHour,
        'isBackfilled': r.isBackfilled,
      }).toList(),
      'growthGrants': growthGrants.map((g) => {
        'id': g.id,
        'habitId': g.habitId,
        'creatureId': g.creatureId,
        'day': g.day,
        'ordinal': g.ordinal,
        'amount': g.amount,
        'algorithmVersion': g.algorithmVersion,
        'issuedAtUtc': g.issuedAtUtc.toIso8601String(),
      }).toList(),
    };

    return const JsonEncoder.withIndent('  ').convert(data);
  }

  /// JSON文字列からデータを全置換でインポート（復元）
  Future<void> importFromJson(String jsonStr) async {
    final Map<String, dynamic> json = jsonDecode(jsonStr);

    await db.transaction(() async {
      // 既存データを削除
      await db.delete(db.growthGrants).go();
      await db.delete(db.dayRecords).go();
      await db.delete(db.habits).go();
      await db.delete(db.creatures).go();

      // Habits 復元
      for (final h in json['habits'] as List) {
        await db.into(db.habits).insert(
          HabitsCompanion.insert(
            id: h['id'],
            title: h['title'],
            startDay: h['startDay'],
            creatureId: h['creatureId'],
            createdAtUtc: DateTime.parse(h['createdAtUtc']),
            revision: Value(h['revision'] ?? 1),
            archivedAtUtc: Value(h['archivedAtUtc'] != null ? DateTime.parse(h['archivedAtUtc']) : null),
            archivedFromDay: Value(h['archivedFromDay']),
          ),
        );
      }

      // Creatures 復元
      for (final c in json['creatures'] as List) {
        await db.into(db.creatures).insert(
          CreaturesCompanion.insert(
            id: c['id'],
            habitId: c['habitId'],
            species: c['species'],
            nickname: Value(c['nickname']),
            growthMode: c['growthMode'],
            growthSeed: Uint8List.fromList(List<int>.from(c['growthSeed'])),
            growthAlgorithmVersion: c['growthAlgorithmVersion'],
            nextGrantOrdinal: c['nextGrantOrdinal'],
            maxStageReached: Value(c['maxStageReached'] ?? 1),
            createdAtUtc: DateTime.parse(c['createdAtUtc']),
          ),
        );
      }

      // DayRecords 復元
      for (final r in json['dayRecords'] as List) {
        await db.into(db.dayRecords).insert(
          DayRecordsCompanion.insert(
            habitId: r['habitId'],
            day: r['day'],
            state: r['state'],
            firstRecordedAtUtc: DateTime.parse(r['firstRecordedAtUtc']),
            updatedAtUtc: DateTime.parse(r['updatedAtUtc']),
            recordedZoneId: r['recordedZoneId'],
            recordedBoundaryHour: r['recordedBoundaryHour'],
            isBackfilled: Value(r['isBackfilled'] ?? false),
          ),
        );
      }

      // GrowthGrants 復元
      for (final g in json['growthGrants'] as List) {
        await db.into(db.growthGrants).insert(
          GrowthGrantsCompanion.insert(
            id: g['id'],
            habitId: g['habitId'],
            creatureId: g['creatureId'],
            day: g['day'],
            ordinal: g['ordinal'],
            amount: g['amount'],
            algorithmVersion: g['algorithmVersion'],
            issuedAtUtc: DateTime.parse(g['issuedAtUtc']),
          ),
        );
      }
    });
  }
}