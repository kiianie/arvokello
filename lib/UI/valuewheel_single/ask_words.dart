import 'package:flutter/material.dart';
import 'package:arvokello/language_packs/languages.dart';
import '../../models/arvokello.dart';

class AskWords extends StatefulWidget {
  final int? amount;
  final AppLanguage selectedLanguage;

  /// Tämä callback määrittää mitä tapahtuu kun sanat on syötetty
  final void Function(List<ArvokelloWord> words) onWordsSubmitted;

  const AskWords({
    super.key,
    required this.amount,
    required this.selectedLanguage,
    required this.onWordsSubmitted,
  });

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
      appBar: AppBar(
        title: Text(labels['askWordsTitle'] ?? ''),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            Text(
              labels['amountLabel']?.replaceFirst('{amount}', (widget.amount ?? 0).toString()) ?? '',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView.separated(
                itemCount: widget.amount ?? 0,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final label = labels['askValueLabel']?.replaceFirst('{index}', (index + 1).toString()) ?? '';
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: TextField(
                        controller: controllers[index],
                        decoration: InputDecoration(labelText: label),
                      ),
                    ),
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () {
                final words = controllers
                    .asMap()
                    .entries
                    .map((e) => ArvokelloWord(id: e.key, text: e.value.text))
                    .toList();

                widget.onWordsSubmitted(words);
              },
              child: Text(labels['continueButton'] ?? 'Continue'),
            ),
          ],
        ),
      ),
    );
  }
}
