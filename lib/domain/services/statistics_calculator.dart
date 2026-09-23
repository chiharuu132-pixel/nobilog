abstract interface class StatisticsCalculator {
  /// 直近の記録履歴から3回連続未達成かどうかを判定
  bool shouldSuggestSimplification(List<String> recentRecordStates);
}

class StatisticsCalculatorImpl implements StatisticsCalculator {
  const StatisticsCalculatorImpl();

  @override
  bool shouldSuggestSimplification(List<String> recentRecordStates) {
    if (recentRecordStates.length < 3) return false;

    // 直近3件を取り出し、すべて 'missed' か判定
    final last3 = recentRecordStates.take(3);
    return last3.every((state) => state == 'missed');
  }
}