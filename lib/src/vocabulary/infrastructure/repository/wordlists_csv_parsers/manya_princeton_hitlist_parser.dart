import 'package:gre_vocabulary/src/vocabulary/domain/entities/word.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/value_objects/word.dart';

import 'wordlist_parser.dart';

class ManyaPrincetonHitListParser extends WordListParser {
  const ManyaPrincetonHitListParser(super.rawList);

  @override
  List<Word> getWords() {
    final words = <Word>[];
    String currentWord = '';
    String currentWordMeaning = '';
    String pending = '';

    for (var row in rawList) {
      if (row.isEmpty) {
        continue;
      }
      final string = row.first.toString().trim().toLowerCase();
      if (string.isEmpty) {
        continue;
      }
      final splitTexts = string.split(' ');
      // toLog("length: ${splitTexts.length}: $count");
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
            definition: "$currentWordMeaning $pending",
            example: '',
            isHitWord: false,
          ),
        );
        pending = '';

        try {
          currentWord = splitTexts[1];
          currentWordMeaning = splitTexts.skip(2).join(' ').trim();
        } catch (_) {}
      }
    }
    if (pending.isNotEmpty) {
      words.add(
        Word(
          value: WordObject(currentWord),
          definition: "$currentWordMeaning $pending",
          example: '',
          isHitWord: false,
        ),
      );
    }

    return words;
  }
}
