//import 'package:arvokello/features/valuewheel_single/valuewheel_screens/ask_words.dart';
//import 'package:arvokello/main.dart';
import 'package:flutter/material.dart';
//import 'package:flutter/services.dart';
import 'package:arvokello/language_packs/languages.dart';

class ArvokelloAppMulti extends StatefulWidget {
  final AppLanguage selectedLanguage;
  const ArvokelloAppMulti({super.key, this.selectedLanguage = AppLanguage.finnish});

  @override
  State<ArvokelloAppMulti> createState() => _ArvokelloAppMultiState();
}

class _ArvokelloAppMultiState extends State<ArvokelloAppMulti> {
  String? _selectedMode;

  @override
  Widget build(BuildContext context) {
    final labels = languagePacks[widget.selectedLanguage]!;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
            backgroundColor: const Color.fromARGB(255, 229, 231, 236),
            foregroundColor: const Color.fromARGB(255, 95, 106, 125),
          ),
          onPressed: () {
            setState(() {
              _selectedMode = null;
            });
          },
          child: Text(labels['backButton'] ?? ''),
        ),
      )
    );
  }
}