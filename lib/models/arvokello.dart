// features/valuewheel_single/src/arvokello_single_model.dart

class ArvokelloWord {
  final int id;        // Uniikki tunniste sanalle
  final String text;   // Sanojen teksti
  int score;           // Pisteet vertailujen jälkeen

  ArvokelloWord({
    required this.id,
    required this.text,
    this.score = 0,
  });

  void incrementScore(int points) {
    score += points;
  }

  factory ArvokelloWord.fromJson(Map<String, dynamic> json) {
    return ArvokelloWord(
      id: json['id'],
      text: json['text'],
      score: json['score'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'text': text,
      'score': score,
    };
  }
}

class ArvokelloGame {
  List<ArvokelloWord> words;

  ArvokelloGame({required this.words});

  // Luo satunnaiset parit vertailua varten
  List<List<int>> generatePairs() {
    final pairs = <List<int>>[];
    for (int i = 0; i < words.length; i++) {
      for (int j = i + 1; j < words.length; j++) {
        pairs.add([i, j]);
      }
    }
    pairs.shuffle();
    return pairs;
  }

  // Päivitä voittajan pisteet
  void recordWin(int wordIndex) {
    words[wordIndex].incrementScore(1);
  }

  // Palauta sanat pistejärjestyksessä
  List<ArvokelloWord> getSortedResults() {
    final sorted = List<ArvokelloWord>.from(words);
    sorted.sort((a, b) => b.score.compareTo(a.score));
    return sorted;
  }
}
