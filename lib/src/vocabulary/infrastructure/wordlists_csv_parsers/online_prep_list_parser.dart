import 'package:gre_vocabulary/src/vocabulary/domain/entities/word.dart';

import 'wordlist_parser.dart';

class OnlinePrepListParser extends WordListParser {
  OnlinePrepListParser(super.rawList);

  @override
  List<Word> getWords() {
    final words = <Word>[];
    String currentWord = '';
    String currentWordMeaning = '';
    String example = '';

    for (var row in rawList) {
      if (row.isEmpty) {
        continue;
      }
      final string = row.first.toString().toLowerCase();
      if (currentWord.isEmpty) {
        currentWord = string.trim();
        continue;
      }
      final splitText = string.trim().split(' ');
      if (string.startsWith(" ") && splitText.length == 1) {
        words.add(
          Word(
            value: currentWord,
            meaning: currentWordMeaning,
            example: example,
          ),
        );

        currentWord = string.trim();
        currentWordMeaning = '';
        example = '';
        continue;
      }
      if (string.contains('(') ||
          string.contains(
            ".",
          )) {
        example = example;
        continue;
      }
      currentWordMeaning = "${currentWordMeaning.trim()} ${string.trim()}";
    }

    return words;
  }
}
