import 'package:flutter/material.dart';
import 'package:arvokello/language_packs/languages.dart';
import 'results.dart';
import 'dart:math';

class CompareWords extends StatefulWidget {
  final List<String> list;
  final AppLanguage selectedLanguage;
  const CompareWords({super.key, required this.list, required this.selectedLanguage});

  @override
  State<CompareWords> createState() => _CompareWordsState();
}

class _CompareWordsState extends State<CompareWords> {
  late List<List<int>> pairs;
  int pairIndex = 0;
  late Map<String, int> winCounts;

  @override
  void initState() {
    super.initState();
    pairs = [];
    final rand = Random();
    for (int i = 0; i < widget.list.length; i++) {
      for (int j = i + 1; j < widget.list.length; j++) {
        if (rand.nextBool()) {
          pairs.add([i, j]);
        } else {
          pairs.add([j, i]);
        }
      }
    }
    pairs.shuffle(rand);
    winCounts = {for (var v in widget.list) v: 0};
  }

  void selectValue(int winnerIdx) {
    final winner = widget.list[winnerIdx];
    winCounts[winner] = (winCounts[winner] ?? 0) + 1;
    setState(() {
      pairIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final labels = languagePacks[widget.selectedLanguage]!;

    // Show results if done
    if (pairIndex >= pairs.length) {
      final sortedResults = winCounts.entries.toList()
        ..sort((a, b) => b.value.compareTo(a.value));

      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(title: Text(labels[''] ?? '')),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  labels['compareTitle'] ?? 'Comparison Complete',
                  style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 30),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.infinity, 50),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Results(
                          results: sortedResults.map((e) => {e.key: e.value}).toList(),
                          selectedLanguage: widget.selectedLanguage,
                        ),
                      ),
                    );
                  },
                  child: Text(labels['results'] ?? 'See Results', style: const TextStyle(fontSize: 18)),
                ),
                const SizedBox(height: 12),
              ],
            ),
          ),
        ),
      );
    }

    // Current pair
    final i = pairs[pairIndex][0];
    final j = pairs[pairIndex][1];
    final value1 = widget.list[i];
    final value2 = widget.list[j];
    final value1Label = (labels['value1'] ?? '').replaceFirst('{value}', value1);
    final value2Label = (labels['value2'] ?? '').replaceFirst('{value}', value2);

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text(labels['compareTitle'] ?? 'Compare Words')),
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
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () => selectValue(i),
                    child: Text(value1Label, style: const TextStyle(fontSize: 20)),
                  ),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 249, 212, 157),
                      foregroundColor: Colors.black,
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                    ),
                    onPressed: () => selectValue(j),
                    child: Text(value2Label, style: const TextStyle(fontSize: 20)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
