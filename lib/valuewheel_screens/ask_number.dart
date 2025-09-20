import 'package:arvokello/valuewheel_screens/ask_words.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arvokello/language_packs/languages.dart';

class ArvokelloApp extends StatelessWidget {
  final AppLanguage selectedLanguage;
  const ArvokelloApp({super.key, this.selectedLanguage = AppLanguage.finnish});

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final labels = languagePacks[selectedLanguage]!;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Title
              Text(
                labels['askNumberTitle'] ?? '',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 30),

              // Input card
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

              // Continue button
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    backgroundColor: const Color.fromARGB(255, 186, 202, 230),
                  ),
                  onPressed: () {
                    int? amount = int.tryParse(controller.text);
                    if (amount != null && amount > 0) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AskWords(
                            amount: amount,
                            selectedLanguage: selectedLanguage,
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
            ],
          ),
        ),
      ),
    );
  }
}
