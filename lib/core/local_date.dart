import 'package:meta/meta.dart';

@immutable
class LocalDate implements Comparable<LocalDate> {
  const LocalDate({
    required this.year,
    required this.month,
    required this.day,
  });

  final int year;
  final int month;
  final int day;

  factory LocalDate.fromDate(DateTime dateTime) {
    return LocalDate(
      year: dateTime.year,
      month: dateTime.month,
      day: dateTime.day,
    );
  }

  factory LocalDate.parse(String value) {
    final parts = value.split('-');
    if (parts.length != 3) {
      throw FormatException('Invalid date format: $value');
    }
    return LocalDate(
      year: int.parse(parts[0]),
      month: int.parse(parts[1]),
      day: int.parse(parts[2]),
    );
  }

  String toIso8601Date() {
    final y = year.toString().padLeft(4, '0');
    final m = month.toString().padLeft(2, '0');
    final d = day.toString().padLeft(2, '0');
    return '$y-$m-$d';
  }

  LocalDate addDays(int days) {
    final dt = DateTime(year, month, day).add(Duration(days: days));
    return LocalDate.fromDate(dt);
  }

  @override
  int compareTo(LocalDate other) {
    if (year != other.year) return year.compareTo(other.year);
    if (month != other.month) return month.compareTo(other.month);
    return day.compareTo(other.day);
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is LocalDate &&
          runtimeType == other.runtimeType &&
          year == other.year &&
          month == other.month &&
          day == other.day;

  @override
  int get hashCode => year.hashCode ^ month.hashCode ^ day.hashCode;

  @override
  String toString() => toIso8601Date();
}