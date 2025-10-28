import 'package:hive/hive.dart';

part 'mood_model.g.dart';

@HiveType(typeId: 0)
class Mood {
  @HiveField(0)
  String emoji;

  @HiveField(1)
  DateTime date;

  Mood({required this.emoji, required this.date});
}