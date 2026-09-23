import '../../core/local_date.dart';

abstract interface class DayResolver {
  /// 日時と境界時間（例: 4）から運用日（Operational Date）を求める
  LocalDate resolveOperationalDay(DateTime dateTime, {int boundaryHour = 4});
}

class DayResolverImpl implements DayResolver {
  const DayResolverImpl();

  @override
  LocalDate resolveOperationalDay(DateTime dateTime, {int boundaryHour = 4}) {
    // 境界時間未満（例: 午前3時59分）なら前日扱いにする
    final effectiveDateTime = dateTime.hour < boundaryHour
        ? dateTime.subtract(const Duration(days: 1))
        : dateTime;

    return LocalDate.fromDate(effectiveDateTime);
  }
}