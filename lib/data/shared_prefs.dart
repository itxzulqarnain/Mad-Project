import 'package:shared_preferences/shared_preferences.dart';

class AppData {
  static Future<void> saveMood(String mood) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('mood', mood);
  }

  static Future<String?> getMood() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('mood');
  }

  static Future<void> saveHabits(List<String> habits) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('habits', habits);
  }

  static Future<List<String>> getHabits() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('habits') ?? [];
  }

  static Future<void> saveCompletedHabits(List<String> completed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('completedHabits', completed);
  }

  static Future<List<String>> getCompletedHabits() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList('completedHabits') ?? [];
  }
}