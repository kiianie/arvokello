import 'package:flutter/material.dart';
import 'package:arvokello/screens/compare_words.dart';
import 'package:arvokello/language_packs/languages.dart';

class AskWords extends StatefulWidget {
  final int? amount;
  final AppLanguage selectedLanguage;
  const AskWords({super.key, required this.amount, required this.selectedLanguage});

  @override
  State<AskWords> createState() => _AskWordsState();
}

class _AskWordsState extends State<AskWords> {
  late List<TextEditingController> controllers;

  @override
  void initState() {
    super.initState();
    controllers = List.generate(widget.amount ?? 0, (_) => TextEditingController());
  }

  @override
  void dispose() {
    for (var c in controllers) {
      c.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labels = languagePacks[widget.selectedLanguage]!;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        title: Text(labels['askWordsTitle'] ?? ''),
        centerTitle: true,
        elevation: 2,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              labels['amountLabel']?.replaceFirst('{amount}', (widget.amount ?? 0).toString()) ?? '',
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Word input list
            Expanded(
              child: ListView.separated(
                itemCount: widget.amount ?? 0,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final label = labels['askValueLabel']?.replaceFirst('{index}', (index + 1).toString()) ?? '';
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    elevation: 3,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                      child: TextField(
                        controller: controllers[index],
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          labelText: label,
                          labelStyle: TextStyle(color: Colors.grey[600]),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 20),

            // Continue button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  backgroundColor: const Color.fromARGB(255, 192, 201, 216),
                ),
                onPressed: () {
                  List<String> values = controllers.map((c) => c.text).toList();
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CompareWords(
                        list: values,
                        selectedLanguage: widget.selectedLanguage,
                      ),
                    ),
                  );
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
    );
  }
}
