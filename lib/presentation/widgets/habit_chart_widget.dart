import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/providers.dart';
import 'dart:math' as math;

class HabitChartWidget extends ConsumerWidget {
  final String habitId;

  const HabitChartWidget({super.key, required this.habitId});

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
            gridData: const FlGridData(show: false),
            titlesData: const FlTitlesData(show: false),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: spots,
                isCurved: true,
                color: Theme.of(context).colorScheme.primary,
                barWidth: 3,
                isStrokeCapRound: true,
                dotData: const FlDotData(show: false),
                belowBarData: BarAreaData(
                  show: true,
                  color: Theme.of(context).colorScheme.primary.withOpacity(0.15),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}