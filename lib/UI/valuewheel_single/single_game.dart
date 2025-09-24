import 'package:arvokello/UI/valuewheel_single/ask_words.dart';
import 'package:arvokello/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arvokello/language_packs/languages.dart';
import 'package:arvokello/UI/valuewheel_single/compare_words.dart';
import '../../models/arvokello.dart';

class ArvokelloApp extends StatefulWidget {
  final AppLanguage selectedLanguage;
  const ArvokelloApp({super.key, this.selectedLanguage = AppLanguage.finnish});

  @override
  State<ArvokelloApp> createState() => _ArvokelloAppState();
}

class _ArvokelloAppState extends State<ArvokelloApp> {
  final TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final labels = languagePacks[widget.selectedLanguage]!;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                labels['askNumberTitle'] ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 30),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                elevation: 4,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: labels['askNumberLabel'] ?? '',
                      labelStyle: TextStyle(color: Colors.grey[600]),
                    ),
                    keyboardType: TextInputType.number,
                    inputFormatters: <TextInputFormatter>[
                      FilteringTextInputFormatter.digitsOnly,
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                width: double.infinity,
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
                    int? amount = int.tryParse(controller.text);
                    if (amount != null && amount > 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AskWords(
                            amount: amount,
                            selectedLanguage: widget.selectedLanguage,
                            onWordsSubmitted: (words) {
                              final game = ArvokelloGame(words: words);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CompareWords(
                                    game: game,
                                    selectedLanguage: widget.selectedLanguage,
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    }
                  },
                  child: Text(
                    labels['continueButton'] ?? '',
                    style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),
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
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) => MainApp()),
                    (route) => false,
                  );
                },
                child: Text(labels['backButton'] ?? ''),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
