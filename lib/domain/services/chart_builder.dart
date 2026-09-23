import 'package:meta/meta.dart';
import '../../core/local_date.dart';

@immutable
class ChartPoint {
  const ChartPoint({
    required this.day,
    required this.totalPoints,
  });

  final LocalDate day;
  final int totalPoints;
}

abstract interface class ChartBuilder {
  /// 付与履歴から、開始日から終了日までの日別累積ポイント系列を構築する
  List<ChartPoint> buildSeries({
    required Map<String, int> dailyGrants, // キー: 'YYYY-MM-DD', 値: その日の増減合計
    required LocalDate startDay,
    required LocalDate endDay,
  });
}

class ChartBuilderImpl implements ChartBuilder {
  const ChartBuilderImpl();

  @override
  List<ChartPoint> buildSeries({
    required Map<String, int> dailyGrants,
    required LocalDate startDay,
    required LocalDate endDay,
  }) {
    final points = <ChartPoint>[];
    int runningTotal = 0;

    LocalDate current = startDay;
    while (current.compareTo(endDay) <= 0) {
      final dateStr = current.toIso8601Date();
      final delta = dailyGrants[dateStr] ?? 0;
      runningTotal += delta;

      // マイナスにならないよう下限0でガード
      if (runningTotal < 0) runningTotal = 0;

      points.add(ChartPoint(
        day: current,
        totalPoints: runningTotal,
      ));

      current = current.addDays(1);
    }

    return points;
  }
}