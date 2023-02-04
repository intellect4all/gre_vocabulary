import 'package:gre_vocabulary/src/vocabulary/domain/entities/word.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/value_objects/word.dart';

import 'wordlist_parser.dart';

class GrePreListParser extends WordListParser {
  GrePreListParser(super.rawList);

  @override
  List<Word> getWords() {
    final words = <Word>[];
    for (var row in rawList) {
      if (row.isEmpty) {
        continue;
      }
      words.add(
        Word(
          value: WordObject(row[0].toString().toLowerCase().trim()),
          definition: row[1].toString().toLowerCase().trim(),
          example: '',
        ),
      );
    }
    return words;
  }
}
