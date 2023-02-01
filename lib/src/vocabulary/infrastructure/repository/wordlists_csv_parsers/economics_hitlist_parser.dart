import 'package:gre_vocabulary/src/vocabulary/domain/entities/word.dart';

import 'wordlist_parser.dart';

class EconomicsHitListParser extends WordListParser {
  const EconomicsHitListParser(super.rawList);

  @override
  List<Word> getWords() {
    final words = <Word>[];
    String currentWord = '';
    String currentWordMeaning = '';
    String example = '';
    for (var row in rawList) {
      final string = row.first.toString().trim().toLowerCase();
      if (string.isEmpty) {
        continue;
      }
      final splitTexts = string.split(' ');
      if (currentWord.isEmpty) {
        currentWord = splitTexts.first.replaceAll(":", '');
        currentWordMeaning = splitTexts.skip(1).join(' ');
        continue;
      }
      if (string.startsWith('"')) {
        example = string;
        continue;
      }
      if (splitTexts.first == "Synonyms:") {
        currentWordMeaning = "$currentWordMeaning | $string ";
        continue;
      }
      if (splitTexts.first == 'source:') {
        words.add(
          Word(
            value: currentWord,
            definition: currentWordMeaning,
            example: example,
            isHitWord: true,
          ),
        );

        currentWord = '';
        example = '';
        continue;
      }
    }
    return words;
  }
}