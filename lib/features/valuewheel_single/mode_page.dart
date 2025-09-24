import 'package:flutter/material.dart';
import 'package:arvokello/language_packs/languages.dart';
import 'package:arvokello/features/valuewheel_multi/generate_game.dart';
import 'package:arvokello/features/valuewheel_single/valuewheel_screens/ask_number.dart'; // Import for ArvokelloApp

class ModeChooser extends StatelessWidget {
  final AppLanguage selectedLanguage;

  const ModeChooser({
    super.key,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final labels = languagePacks[selectedLanguage]!;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          labels['chooseModeTitle'] ?? '',
          textAlign: TextAlign.center,
          style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 40),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            TextButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArvokelloApp(selectedLanguage: selectedLanguage),
                  ),
                );
              },
              icon: Column(
                children: [
                  Icon(Icons.person, color: Color.fromARGB(255, 68, 92, 135)),
                  Text(labels['individualMode'] ?? ''),
                ],
              ),
              style: IconButton.styleFrom(
                iconSize: 80,
                foregroundColor: const Color.fromARGB(255, 102, 114, 135),
                backgroundColor: const Color.fromARGB(255, 229, 231, 236),
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              label: Text(''),
            ),
            TextButton.icon(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ArvokelloAppMulti(selectedLanguage: selectedLanguage),
                  ),
                );
              },
              icon: Column(
                children: [
                  Icon(Icons.group, color: Color.fromARGB(255, 68, 92, 135)),
                  Text(labels['groupMode'] ?? 'Group'),
                ],
              ),
              style: IconButton.styleFrom(
                iconSize: 80,
                foregroundColor: const Color.fromARGB(255, 102, 114, 135),
                backgroundColor: const Color.fromARGB(255, 229, 231, 236),
                padding: const EdgeInsets.all(20),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(11),
                ),
              ),
              label: Text(''),
            ),
          ],
        ),
        const SizedBox(height: 60),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: const Color.fromARGB(255, 229, 231, 236),
            foregroundColor: const Color.fromARGB(255, 95, 106, 125),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text(labels['backButton'] ?? ''),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}
