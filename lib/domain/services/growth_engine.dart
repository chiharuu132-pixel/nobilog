import 'dart:math';
import 'dart:typed_data';
import 'package:meta/meta.dart';
import '../../core/random_generator.dart';

@immutable
class GrowthDecision {
  const GrowthDecision({
    required this.amount, // 減少時は負の値
    required this.algorithmVersion,
  });

  final int amount;
  final int algorithmVersion;
}

abstract interface class GrowthEngine {
  GrowthDecision decideStandard({Uint8List? seed});
  GrowthDecision decideMinimum({Uint8List? seed});
  GrowthDecision decidePenalty({required int currentPoints, Uint8List? seed});
}

class GrowthEngineImpl implements GrowthEngine {
  static const int currentAlgorithmVersion = 1;

  const GrowthEngineImpl();

  @override
  GrowthDecision decideStandard({Uint8List? seed}) {
    final rng = seed != null ? RandomGenerator.fromSeed(seed) : RandomGenerator();
    final raw = rng.generateNormal(10.0, 3.0).round();
    final amount = max(7, raw); // 通常達成: N(10,3) 下限7
    return GrowthDecision(
      amount: amount,
      algorithmVersion: currentAlgorithmVersion,
    );
  }

  @override
  GrowthDecision decideMinimum({Uint8List? seed}) {
    final rng = seed != null ? RandomGenerator.fromSeed(seed) : RandomGenerator();
    final raw = rng.generateNormal(5.0, 2.0).round();
    final amount = max(3, raw); // 最低達成: N(5,2) 下限3
    return GrowthDecision(
      amount: amount,
      algorithmVersion: currentAlgorithmVersion,
    );
  }

  @override
  GrowthDecision decidePenalty({required int currentPoints, Uint8List? seed}) {
    final rng = seed != null ? RandomGenerator.fromSeed(seed) : RandomGenerator();
    final percent = rng.generateNormal(10.0, 3.0); // N(10,3)%
    final penaltyAmount = ((currentPoints * percent) / 100.0).round();
    
    // 累積ポイントがマイナスにならないよう、現在のポイントを上限に減少
    final actualPenalty = min(currentPoints, penaltyAmount);
    return GrowthDecision(
      amount: -actualPenalty,
      algorithmVersion: currentAlgorithmVersion,
    );
  }
}