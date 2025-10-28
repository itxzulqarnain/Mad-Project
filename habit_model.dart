import 'package:hive/hive.dart';

part 'habit_model.g.dart';

@HiveType(typeId: 1)
class Habit extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  bool isCompleted;

  Habit({required this.name, this.isCompleted = false});
}