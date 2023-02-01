import '../../../domain/core/constants.dart';
import '../wordlists_csv_parsers/wordlist_parser.dart';

abstract class BaseWordsList {
  final WordListParser wordsParser;
  final String path;
  final WordsListKey wordsListKey;

  const BaseWordsList({
    required this.wordsParser,
    required this.path,
    required this.wordsListKey,
  });
}
