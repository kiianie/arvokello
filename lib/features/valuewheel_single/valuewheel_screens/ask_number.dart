import 'package:arvokello/features/valuewheel_single/valuewheel_screens/ask_words.dart';
import 'package:arvokello/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:arvokello/language_packs/languages.dart';

class ArvokelloApp extends StatefulWidget {
  final AppLanguage selectedLanguage;
  const ArvokelloApp({super.key, this.selectedLanguage = AppLanguage.finnish});

  @override
  State<ArvokelloApp> createState() => _ArvokelloAppState();
}

class _ArvokelloAppState extends State<ArvokelloApp> {
  String? _selectedMode;

  @override
  Widget build(BuildContext context) {
    final TextEditingController controller = TextEditingController();
    final labels = languagePacks[widget.selectedLanguage]!;

    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: _selectedMode == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      labels['chooseModeTitle'] ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _selectedMode = 'individual';
                            });
                          },
                          icon: Column(
                            children: [
                              Icon(Icons.person, color: Color.fromARGB(255, 68, 92, 135)),
                              Text(labels['individualMode'] ?? ''),
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
                        TextButton.icon(
                          onPressed: () {
                            setState(() {
                              _selectedMode = 'group';
                            });
                          },
                          icon: Column(
                            children: [
                              Icon(Icons.group, color: Color.fromARGB(255, 68, 92, 135)),
                              Text(labels['groupMode'] ?? 'Group'),
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
                    SizedBox(height: 60),
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
                )
              : _selectedMode == 'individual'
                  ? Column(
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
                            setState(() {
                              _selectedMode = null;
                            });
                          },
                          child: Text(labels['backButton'] ?? ''),
                        ),
                      ],
                    )
                  : Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(labels['groupModeComing'] ?? 'Group mode coming soon!', style: const TextStyle(fontSize: 22)),
                          const SizedBox(height: 30),
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
                              setState(() {
                                _selectedMode = null;
                              });
                            },
                            child: Text(labels['backButton'] ?? ''),
                          ),
                        ],
                      ),
                    ),
        ),
      ),
    );
  }
}
