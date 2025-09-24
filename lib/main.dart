import 'package:flutter/material.dart';
import 'UI/valuewheel_single/mode_page.dart';
import 'language_packs/languages.dart';
import 'package:arvokello/state_management.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => AppState(),
      child: const MainApp(),
    ),
  );
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {

  String? _selectedFeature;

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);
    AppLanguage selectedLanguage = appState.getLanguage.isEmpty
        ? AppLanguage.finnish
        : AppLanguage.values.firstWhere(
            (lang) => lang.toString() == appState.getLanguage,
            orElse: () => AppLanguage.finnish,
          );
    final labels = languagePacks[selectedLanguage]!;

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(labels['appTitle'] ?? ''),
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: DropdownButton<AppLanguage>(
                value: selectedLanguage,
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
                  DropdownMenuItem(
                    value: AppLanguage.german,
                    child: Text('Deutsch'),
                  ),
                ],
                onChanged: (AppLanguage? value) {
                  if (value != null) {
                    appState.setLanguage(value.toString());
                  }
                },
              ),
            ),
          ],
        ),
        body: _selectedFeature == null
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      labels['featureSelectTitle'] ?? '',
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.normal),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon( // valuewheel
                          onPressed: () {
                            setState(() {
                              _selectedFeature = 'feature1';
                            });
                          },
                          icon: Column(
                            children: [
                              Icon(Icons.scale, color: Color.fromARGB(255, 68, 92, 135)),
                              Text(labels['feature1'] ?? ''),
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
                        TextButton.icon( // second feature
                          onPressed: () {
                            setState(() {
                              _selectedFeature = 'feature2';
                            });
                          },
                          icon: Column(
                            children: [
                              Icon(Icons.travel_explore, color: Color.fromARGB(255, 68, 92, 135),),
                              Text(labels['feature2'] ?? ''),
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
                    const SizedBox(height: 20),
                  ],
                ),
              )
            : _selectedFeature == 'feature1'
                ? ModeChooser(selectedLanguage: selectedLanguage)
                : Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(labels['otherComing'] ?? '', style: const TextStyle(fontSize: 22)),
                        const SizedBox(height: 30),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => MainApp()),
                              (route) => false,
                            );
                          },
                          child: Text(labels['backButton'] ?? 'Back'),
                        ),
                      ],
                    ),
                  ),
      ),
    );
  }
}
