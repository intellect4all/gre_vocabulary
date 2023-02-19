import 'package:gre_vocabulary/src/vocabulary/domain/core/constants.dart';

import '../../../domain/value_objects/word.dart';
import '../../models/word_model.dart';
import 'wordlist_parser.dart';

class OnlinePrepListParser extends WordListParser {
  OnlinePrepListParser();

  @override
  List<WordModel> getWords({
    required List<List> rawList,
    required WordsListKey wordsListKey,
  }) {
    final words = <WordModel>[];
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
          WordModel(
            value: WordObject(currentWord),
            definition: currentWordMeaning,
            example: example,
            source: wordsListKey,
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
