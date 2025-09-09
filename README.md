# Arvokello

This application is called Arvokello. It allows its user to rank words (=values) into order by comparing two values at a time.

This Flutter app allows a user to:
1. Enter a number (n).
2. Input n amount of words.
3. Compare the words in pairs, selecting the better one each time.
4. See the final ranking of all words based on their selections.

## Structure
- **Main.dart**: App entry point and routing.
- **Screens**: UI for each step of the process (`AskNumberScreen`, `AskWordsScreen`, `CompareWordsScreen`, `ResultsScreen`).
- **Models**: Data structures (e.g., `Word`).
- **Services**: Business logic (`WordService`) for storing words, recording comparisons, and generating rankings.

The code is organized so that UI, logic, and data are separated, making the project easy to maintain and extend.

```mermaid

classDiagram
    class Main {
      +main()
    }

    class AskNumberScreen {
      +build()
    }

    class AskWordsScreen {
      +build()
    }

    class CompareWordsScreen {
      +build()
    }

    class ResultsScreen {
      +build()
    }

    class WordService {
      -List~Word~ words
      +addWord(word: Word)
      +getWordPairs(): List~List~Word~~
      +recordComparison(better: Word, worse: Word)
      +getResults(): List~Word~
    }

    class Word {
      +String text
      +int score
    }

    Main --> AskNumberScreen
    AskNumberScreen --> AskWordsScreen
    AskWordsScreen --> CompareWordsScreen
    CompareWordsScreen --> ResultsScreen
    ResultsScreen --> WordService
    WordService --> Word

```


```mermaid
sequenceDiagram
    participant U as User
    participant M as Main
    participant N as AskNumberScreen
    participant W as AskWordsScreen
    participant C as CompareWordsScreen
    participant R as ResultsScreen
    participant S as WordService

    U->>M: Start app
    M->>N: Show number input screen
    U->>N: Enter number
    N->>W: Pass number and show word input screen
    U->>W: Enter words
    W->>S: Save words
    W->>C: Show comparison screen
    loop For each word pair
        U->>C: Choose better word
        C->>S: Record comparison result
    end
    C->>R: Show results screen
    R->>S: Get sort

```