class HabitWithCreature {
  final String habitId;
  final String title;
  final String creatureId;
  final String species;
  final int totalPoints;
  final int stage;
  final double visualScale;
  final String? todayRecordState;

  HabitWithCreature({
    required this.habitId,
    required this.title,
    required this.creatureId,
    required this.species,
    required this.totalPoints,
    required this.stage,
    required this.visualScale,
    this.todayRecordState,
  });
}
