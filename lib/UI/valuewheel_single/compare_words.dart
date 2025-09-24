import 'package:flutter/material.dart';
import 'package:arvokello/language_packs/languages.dart';
import 'results.dart';
import '../../models/arvokello.dart';

class CompareWords extends StatefulWidget {
  final ArvokelloGame game;
  final AppLanguage selectedLanguage;

  const CompareWords({
    super.key,
    required this.game,
    required this.selectedLanguage,
  });

  @override
  State<CompareWords> createState() => _CompareWordsState();
}

class _CompareWordsState extends State<CompareWords> {
  late List<List<int>> pairs;
  int pairIndex = 0;

  @override
  void initState() {
    super.initState();
    pairs = widget.game.generatePairs();
  }

  void selectValue(int winnerIdx) {
    widget.game.recordWin(winnerIdx);
    setState(() {
      pairIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final labels = languagePacks[widget.selectedLanguage]!;

    // Näytetään tulokset kun kaikki parit käyty läpi
    if (pairIndex >= pairs.length) {
      final sortedResults = widget.game.getSortedResults();

      return Results(
        results: sortedResults,
        selectedLanguage: widget.selectedLanguage,
      );
    }

    // Nykyinen pari
    final i = pairs[pairIndex][0];
    final j = pairs[pairIndex][1];
    final word1 = widget.game.words[i];
    final word2 = widget.game.words[j];

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text(labels[''] ?? '')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              labels['compareLabel'] ?? '',
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 249, 212, 157),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () => selectValue(i),
                    child: Text(word1.text, style: const TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 249, 212, 157),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                    onPressed: () => selectValue(j),
                    child: Text(word2.text, style: const TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
