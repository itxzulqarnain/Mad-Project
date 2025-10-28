import 'package:flutter/material.dart';
import '../data/shared_prefs.dart';

class MoodScreen extends StatefulWidget {
  const MoodScreen({super.key});

  @override
  State<MoodScreen> createState() => _MoodScreenState();
}

class _MoodScreenState extends State<MoodScreen> {
  String? selectedMood;

  @override
  void initState() {
    super.initState();
    loadMood();
  }

  Future<void> loadMood() async {
    selectedMood = await AppData.getMood();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Mood Tracker 🌤️")),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              "How are you feeling today?",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
            ),
            const SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 15,
              runSpacing: 10,
              children: [
                moodEmoji("😊", "Happy"),
                moodEmoji("😔", "Sad"),
                moodEmoji("😠", "Angry"),
                moodEmoji("😌", "Calm"),
                moodEmoji("🤩", "Excited"),
                moodEmoji("😴", "Tired"),
              ],
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () async {
                if (selectedMood == null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Please select a mood!")),
                  );
                } else {
                  await AppData.saveMood(selectedMood!);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text("Mood saved: $selectedMood")),
                  );
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF6C63FF),
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12)),
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              child: const Text("Save Mood"),
            ),
          ],
        ),
      ),
    );
  }

  Widget moodEmoji(String emoji, String mood) {
    final isSelected = selectedMood == mood;
    return GestureDetector(
      onTap: () => setState(() => selectedMood = mood),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isSelected ? const Color(0xFF6C63FF) : Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
                color: Colors.grey.shade300,
                blurRadius: 5,
                offset: const Offset(2, 3))
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 28)),
            const SizedBox(height: 5),
            Text(mood,
                style: TextStyle(
                    color: isSelected ? Colors.white : Colors.black87)),
          ],
        ),
      ),
    );
  }
}