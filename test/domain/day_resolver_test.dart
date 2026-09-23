import 'package:flutter_test/flutter_test.dart';
import 'package:nobilog/core/local_date.dart';
import 'package:nobilog/domain/services/day_resolver.dart';

void main() {
  group('DayResolver Test', () {
    const resolver = DayResolverImpl();

    test('3:59 AM resolves to the previous calendar day', () {
      final dt = DateTime(2026, 5, 10, 3, 59); // 5月10日 午前3:59
      final resolved = resolver.resolveOperationalDay(dt, boundaryHour: 4);

      expect(resolved, equals(const LocalDate(year: 2026, month: 5, day: 9))); // 5月9日扱い
    });

    test('4:00 AM resolves to the current calendar day', () {
      final dt = DateTime(2026, 5, 10, 4, 0); // 5月10日 午前4:00
      final resolved = resolver.resolveOperationalDay(dt, boundaryHour: 4);

      expect(resolved, equals(const LocalDate(year: 2026, month: 5, day: 10))); // 5月10日扱い
    });
  });
}