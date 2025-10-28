import 'package:flutter/material.dart';
import 'screen/splash_screen.dart';
import 'screen/home_screen.dart';
import 'screen/mood_screen.dart';
import 'screen/habit_screen.dart';
import 'screen/summary_screen.dart';

void main() {
  runApp(const MindEaseApp());
}

class MindEaseApp extends StatelessWidget {
  const MindEaseApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MindEase',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: const Color(0xFF6C63FF),
        scaffoldBackgroundColor: const Color(0xFFF8F9FF),
        appBarTheme: const AppBarTheme(
          backgroundColor: Color(0xFF6C63FF),
          elevation: 0,
        ),
      ),
      home: const SplashScreen(), // ✅ start with splash
    );
  }
}

class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

class _BottomNavState extends State<BottomNav> {
  int currentIndex = 0;
  final screens = [
    const HomeScreen(),
    const MoodScreen(),
     HabitScreen(),
     SummaryScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[currentIndex],
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFF6C63FF), Color(0xFFB39DDB)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: BottomNavigationBar(
          backgroundColor: Colors.transparent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.white70,
          type: BottomNavigationBarType.fixed,
          currentIndex: currentIndex,
          onTap: (index) => setState(() => currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(Icons.mood), label: 'Mood'),
            BottomNavigationBarItem(icon: Icon(Icons.check_circle), label: 'Habits'),
            BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Summary'),
          ],
        ),
      ),
    );
  }
}