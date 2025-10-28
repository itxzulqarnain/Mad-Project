import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HabitScreen extends StatefulWidget {
  @override
  _HabitScreenState createState() => _HabitScreenState();
}

class _HabitScreenState extends State<HabitScreen> {
  List<Map<String, dynamic>> habits = [];
  TextEditingController _habitController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _loadHabits();
  }

  Future<void> _loadHabits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? data = prefs.getString('habits');
    if (data != null) {
      setState(() {
        habits = List<Map<String, dynamic>>.from(json.decode(data));
      });
    }
  }

  Future<void> _saveHabits() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('habits', json.encode(habits));
  }

  void _addHabit(String name) {
    if (name.isEmpty) return;
    setState(() {
      habits.add({"name": name, "completed": false});
      _habitController.clear();
    });
    _saveHabits();
  }

  void _toggleHabit(int index) {
    setState(() {
      habits[index]["completed"] = !habits[index]["completed"];
    });
    _saveHabits();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Habit Tracker 🌱"),
        backgroundColor: Colors.teal,
        centerTitle: true,
      ),
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Colors.teal, Colors.greenAccent],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: TextField(
                controller: _habitController,
                decoration: InputDecoration(
                  labelText: "Add a new habit",
                  suffixIcon: IconButton(
                    icon: Icon(Icons.add, color: Colors.teal[800]),
                    onPressed: () => _addHabit(_habitController.text),
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: habits.length,
                itemBuilder: (context, index) {
                  final habit = habits[index];
                  return Card(
                    color: habit["completed"] ? Colors.teal[100] : Colors.white,
                    child: ListTile(
                      title: Text(
                        habit["name"],
                        style: TextStyle(
                          decoration: habit["completed"]
                              ? TextDecoration.lineThrough
                              : TextDecoration.none,
                        ),
                      ),
                      trailing: Checkbox(
                        value: habit["completed"],
                        onChanged: (value) => _toggleHabit(index),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}