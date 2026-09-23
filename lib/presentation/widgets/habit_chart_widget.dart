import 'dart:math' as math;
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';

class HabitChartWidget extends ConsumerWidget {
  final String habitId;
  final bool showAxes; // 縦軸・横軸・グリッドの表示フラグ
  final bool enableTouch; // グラフのタップによる数値表示の有無

  const HabitChartWidget({
    super.key,
    required this.habitId,
    this.showAxes = true,
    this.enableTouch = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final chartAsync = ref.watch(habitChartProvider(habitId));

    return chartAsync.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, s) => const Center(child: Text('チャート読み込み失敗')),
      data: (points) {
        if (points.isEmpty) return const SizedBox.shrink();

        final spots = <FlSpot>[];
        double maxVal = 0;
        for (int i = 0; i < points.length; i++) {
          final val = points[i].totalPoints.toDouble();
          spots.add(FlSpot(i.toDouble(), val));
          if (val > maxVal) maxVal = val;
        }

        final maxY = math.max(30.0, maxVal * 1.2);

        return LineChart(
          LineChartData(
            minY: 0,
            maxY: maxY,
            lineTouchData: LineTouchData(
              enabled: enableTouch,
            ),
            gridData: FlGridData(
              show: showAxes,
              drawVerticalLine: false,
              getDrawingHorizontalLine: (value) {
                return FlLine(
                  color: Theme.of(context).dividerColor.withOpacity(0.2),
                  strokeWidth: 1,
                );
              },
            ),
            titlesData: FlTitlesData(
              show: showAxes,
              topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: showAxes,
                  reservedSize: 20,
                  interval: math.max(1.0, (points.length / 4).floorToDouble()),
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index < 0 || index >= points.length) {
                      return const SizedBox.shrink();
                    }
                    final date = points[index].day;
                    return Padding(
                      padding: const EdgeInsets.only(top: 4.0),
                      child: Text(
                        '${date.month}/${date.day}',
                        style: TextStyle(
                          fontSize: 10,
                          color: Theme.of(context).textTheme.bodySmall?.color,
                        ),
                      ),
                    );
                  },
                ),
              ),
              leftTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: showAxes,
                  reservedSize: 28,
                  getTitlesWidget: (value, meta) {
                    if (value == meta.max || value == meta.min) {
                      return const SizedBox.shrink();
                    }
                    return Text(
                      value.toInt().toString(),
                      style: TextStyle(
                        fontSize: 10,
                        color: Theme.of(context).textTheme.bodySmall?.color,
                      ),
                    );
                  },
                ),
              ),
            ),
            borderData: FlBorderData(
              show: showAxes,
              border: Border(
                bottom: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.3),
                ),
                left: BorderSide(
                  color: Theme.of(context).dividerColor.withOpacity(0.3),
                ),
              ),
            ),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: false, // ★ 直線で接続（無理な滑らかさを除去）
                color: Theme.of(context).colorScheme.primary,
                barWidth: 2,
                isStrokeCapRound: true,
                // ★ 離散データポイントに小さな丸を表示
                dotData: FlDotData(
                  show: true,
                  getDotPainter: (spot, percent, barData, index) => FlDotCirclePainter(
                    radius: 3,
                    color: Theme.of(context).colorScheme.primary,
                    strokeWidth: 1,
                    strokeColor: Colors.white,
                  ),
                ),
                belowBarData: BarAreaData(
                  show: true,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.12),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}