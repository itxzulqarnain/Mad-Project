import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SummaryScreen extends StatefulWidget {
  @override
  _SummaryScreenState createState() => _SummaryScreenState();
}

class _SummaryScreenState extends State<SummaryScreen> {
  int totalHabits = 0;
  int completedHabits = 0;
  String? lastMood;

  @override
  void initState() {
    super.initState();
    _loadSummary();
  }

  Future<void> _loadSummary() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? habitsData = prefs.getString('habits');
    String? moodData = prefs.getString('mood');

    if (habitsData != null) {
      List habits = json.decode(habitsData);
      setState(() {
        totalHabits = habits.length;
        completedHabits = habits.where((h) => h["completed"]).length;
      });
    }

    if (moodData != null) {
      setState(() {
        lastMood = moodData;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Summary 📊"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.greenAccent, Colors.teal],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Habits Completed: $completedHabits / $totalHabits",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              SizedBox(height: 10),
              Text("Last Mood: ${lastMood ?? "Not Set 😶"}",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ),
    );
  }
}