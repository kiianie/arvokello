import 'package:arvokello/main.dart';
import 'package:flutter/material.dart';
import 'package:arvokello/language_packs/languages.dart';
import 'package:arvokello/models/arvokello.dart';
import 'package:arvokello/UI/valuewheel_single/ask_words.dart';

class ArvokelloAppMulti extends StatefulWidget {
  final AppLanguage selectedLanguage;
  const ArvokelloAppMulti({super.key, this.selectedLanguage = AppLanguage.finnish});

  @override
  State<ArvokelloAppMulti> createState() => _ArvokelloAppMultiState();
}

class _ArvokelloAppMultiState extends State<ArvokelloAppMulti> {
  @override
  Widget build(BuildContext context) {
    final labels = languagePacks[widget.selectedLanguage]!;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              SizedBox(height: 200),
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
                  MaterialPageRoute route = MaterialPageRoute(
                    builder: (context) => MultiGameCreation(selectedLanguage: widget.selectedLanguage),
                  );
                },
                child: Text(labels['createButton'] ?? ''),
              ),
              SizedBox(height: 80),
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
            ],
          ),
        ),
      )
    );
  }
}

class MultiGameCreation extends StatefulWidget {
  final AppLanguage selectedLanguage;
  const MultiGameCreation({super.key, required this.selectedLanguage});

  @override
  State<MultiGameCreation> createState() => _MultiGameCreationState();
}

class _MultiGameCreationState extends State<MultiGameCreation> {
  late ArvokelloSession session;

  @override
  void initState() {
    super.initState();
    // Luo sessio koodilla
    final sessionId = ArvokelloSession.generateSessionCode(6); 
    session = ArvokelloSession(sessionId: sessionId, baseWords: []);
  }

  final TextEditingController _amountController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final labels = languagePacks[widget.selectedLanguage]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(labels['createSessionTitle'] ?? 'Create Session'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            // Näytä koodi
            Text(
              "${labels['sessionCode'] ?? 'Session Code'}: ${session.sessionId}",
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),

            // Kysy montako sanaa pääkäyttäjä haluaa
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: labels['howManyWords'] ?? 'Number of values',
                border: const OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                final amount = int.tryParse(_amountController.text);
                if (amount != null && amount > 0) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => AskWords(
                        amount: amount,
                        selectedLanguage: widget.selectedLanguage,
                        onWordsSubmitted: (words) {
                          // Tallenna sanat sessioon
                          setState(() {
                            session.baseWords.addAll(words);
                          });

                          // Siirry "Session ready" -näkymään
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SessionReadyScreen(session: session, selectedLanguage: widget.selectedLanguage),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                }
              },
              child: Text(labels['continueButton'] ?? 'Continue'),
            ),
          ],
        ),
      ),
    );
  }
}

class SessionReadyScreen extends StatelessWidget {
  final ArvokelloSession session;
  final AppLanguage selectedLanguage;

  const SessionReadyScreen({super.key, required this.session, required this.selectedLanguage});

  @override
  Widget build(BuildContext context) {
    final labels = languagePacks[selectedLanguage]!;

    return Scaffold(
      appBar: AppBar(
        title: Text(labels['sessionReady'] ?? 'Session Ready'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("${labels['shareCode'] ?? 'Share this code'}: ${session.sessionId}",
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),

            const SizedBox(height: 20),

            Text(labels['waitingPlayers'] ?? 'Waiting for players...'),
          ],
        ),
      ),
    );
  }
}
