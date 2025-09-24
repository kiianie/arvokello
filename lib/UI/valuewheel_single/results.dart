import 'package:flutter/material.dart';
import 'package:arvokello/language_packs/languages.dart';
import '../../models/arvokello.dart';

class Results extends StatelessWidget {
  final List<ArvokelloWord> results;
  final AppLanguage selectedLanguage;

  const Results({
    super.key,
    required this.results,
    required this.selectedLanguage,
  });

  @override
  Widget build(BuildContext context) {
    final labels = languagePacks[selectedLanguage]!;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(title: Text(labels['results'] ?? 'Results')),
      body: Column(
        children: [
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.all(24.0),
              itemCount: results.length,
              separatorBuilder: (_, __) => const SizedBox(height: 12),
              itemBuilder: (context, index) {
                final word = results[index];
                return Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  elevation: 3,
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: const Color.fromARGB(255, 136, 149, 171),
                      child: Text('${index + 1}', style: const TextStyle(color: Colors.white)),
                    ),
                    title: Text(
                      word.text,
                      style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                    ),
                    trailing: Text(
                      '${word.score} pts',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.grey[700],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
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
      ),
    );
  }
}
