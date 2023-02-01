import '../../wordlists_csv_parsers/wordlist_parser.dart';

class BaseWordsList {
  final WordListParser wordsParser;
  final String path;
  final WordsListKey key;

  const BaseWordsList({
    required this.wordsParser,
    required this.path,
    required this.key,
  });
}

typedef WordsListKey = String;
