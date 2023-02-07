import 'package:gre_vocabulary/src/vocabulary/domain/entities/word.dart';

import '../../../domain/value_objects/word.dart';
import 'wordlist_parser.dart';

class ManyaHitListParser extends WordListParser {
  const ManyaHitListParser(
      {required super.rawList, required super.wordsListKey});

  @override
  List<Word> getWords() {
    final words = <Word>[];
    String currentWord = '';
    String currentWordMeaning = '';
    String pending = '';

    for (var row in rawList) {
      final string = row.first.toString().trim().toLowerCase();
      if (string.isEmpty) {
        continue;
      }
      final splitTexts = string.split(' ');
      final number = int.tryParse(splitTexts.first);

      if (number == null) {
        pending = "$pending $string ";
        continue;
      } else {
        if (currentWord.isEmpty) {
          currentWord = splitTexts[1];
          currentWordMeaning =
              "${splitTexts.skip(2).join(' ')} $pending".trim();
          continue;
        }
        words.add(
          Word(
            value: WordObject(currentWord),
            definition: currentWordMeaning,
            example: '',
            isHitWord: true,
            source: wordsListKey,
          ),
        );
        pending = '';

        currentWord = splitTexts[1];
        currentWordMeaning = splitTexts.skip(2).join(' ').trim();
      }
    }
    if (pending.isNotEmpty) {
      words.add(
        Word(
          value: WordObject(currentWord),
          definition: currentWordMeaning,
          example: '',
          isHitWord: true,
          source: wordsListKey,
        ),
      );
    }

    return words;
  }
}
