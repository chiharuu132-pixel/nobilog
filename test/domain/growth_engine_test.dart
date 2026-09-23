import 'package:flutter_test/flutter_test.dart';
import 'package:nobilog/domain/services/growth_engine.dart';
import 'package:nobilog/domain/services/evolution_engine.dart';

void main() {
  group('GrowthEngine Test', () {
    const growthEngine = GrowthEngineImpl();

    test('Standard growth respects minimum bound of 7', () {
      for (int i = 0; i < 100; i++) {
        final decision = growthEngine.decideStandard();
        expect(decision.amount, greaterThanOrEqualTo(7));
      }
    });

    test('Minimum growth respects minimum bound of 3', () {
      for (int i = 0; i < 100; i++) {
        final decision = growthEngine.decideMinimum();
        expect(decision.amount, greaterThanOrEqualTo(3));
      }
    });

    test('Penalty calculation returns non-positive amount', () {
      final decision = growthEngine.decidePenalty(currentPoints: 100);
      expect(decision.amount, lessThanOrEqualTo(0));
    });
  });

  group('EvolutionEngine Test', () {
    const evolutionEngine = EvolutionEngineImpl();

    test('Stage calculation threshold check', () {
      expect(evolutionEngine.calculateStage(0), equals(1));
      expect(evolutionEngine.calculateStage(69), equals(1));
      expect(evolutionEngine.calculateStage(70), equals(2));
      expect(evolutionEngine.calculateStage(289), equals(2));
      expect(evolutionEngine.calculateStage(290), equals(3));
    });

    test('Degradation check (Points drop below threshold)', () {
      // 290ptから減算で60ptまで下がった場合、Stage 1に下がる
      expect(evolutionEngine.calculateStage(60), equals(1));
    });
  });
}