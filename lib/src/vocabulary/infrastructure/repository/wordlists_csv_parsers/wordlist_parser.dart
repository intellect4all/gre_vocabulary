import 'package:gre_vocabulary/src/vocabulary/domain/entities/word.dart';

import '../../../domain/core/constants.dart';

/// Abstract class that all wordlist parsers should implement
abstract class WordListParser {
  final List<List> rawList;
  final WordsListKey wordsListKey;

  const WordListParser({
    required this.rawList,
    required this.wordsListKey,
  });

  /// takes a list of lists of words and returns a list of words
  ///
  /// the list inside the list is similar to a row in a csv file
  List<Word> getWords();
}
