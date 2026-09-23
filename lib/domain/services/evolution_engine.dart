import 'package:meta/meta.dart';

@immutable
class EvolutionDecision {
  const EvolutionDecision({
    required this.currentStage,
    required this.stagesToUnlock,
    this.nextThreshold,
  });

  final int currentStage;
  final List<int> stagesToUnlock;
  final int? nextThreshold;
}

abstract interface class EvolutionEngine {
  int calculateStage(int totalPoints);
  EvolutionDecision evaluate({
    required int totalPoints,
    required Set<int> unlockedStages,
  });
  double visualScale({required int totalPoints});
}

class EvolutionEngineImpl implements EvolutionEngine {
  const EvolutionEngineImpl();

  @override
  int calculateStage(int totalPoints) {
    if (totalPoints >= 290) return 3;
    if (totalPoints >= 70) return 2;
    return 1;
  }

  @override
  EvolutionDecision evaluate({
    required int totalPoints,
    required Set<int> unlockedStages,
  }) {
    final currentStage = calculateStage(totalPoints);
    final stagesToUnlock = <int>[];

    for (int stage = 1; stage <= currentStage; stage++) {
      if (!unlockedStages.contains(stage)) {
        stagesToUnlock.add(stage);
      }
    }

    int? nextThreshold;
    if (currentStage == 1) {
      nextThreshold = 70;
    } else if (currentStage == 2) {
      nextThreshold = 290;
    } else {
      nextThreshold = null;
    }

    return EvolutionDecision(
      currentStage: currentStage,
      stagesToUnlock: stagesToUnlock,
      nextThreshold: nextThreshold,
    );
  }

  @override
  double visualScale({required int totalPoints}) {
    if (totalPoints <= 0) return 0.85;
    if (totalPoints >= 300) return 1.10;
    return 0.85 + (totalPoints / 300.0) * (1.10 - 0.85);
  }
}