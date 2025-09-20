
import 'package:flutter/material.dart';
import 'valuewheel_screens/ask_number.dart';
import 'language_packs/languages.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  AppLanguage _selectedLanguage = AppLanguage.finnish;

  @override
  Widget build(BuildContext context) {
    final labels = languagePacks[_selectedLanguage]!;
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(labels['appTitle'] ?? ''),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<AppLanguage>(
                value: _selectedLanguage,
                underline: Container(),
                icon: const Icon(Icons.language, color: Color.fromARGB(255, 174, 182, 223)),
                dropdownColor: Colors.white,
                items: const [
                  DropdownMenuItem(
                    value: AppLanguage.finnish,
                    child: Text('Suomi'),
                  ),
                  DropdownMenuItem(
                    value: AppLanguage.english,
                    child: Text('English'),
                  ),
                ],
                onChanged: (AppLanguage? value) {
                  if (value != null) {
                    setState(() {
                      _selectedLanguage = value;
                    });
                  }
                },
              ),
            ),
          ],
        ),
        body: Center(
          child: ArvokelloApp(selectedLanguage: _selectedLanguage),
        ),
      ),
    );
  }
}
