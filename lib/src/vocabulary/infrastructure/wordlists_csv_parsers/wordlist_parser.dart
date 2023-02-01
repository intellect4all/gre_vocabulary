import 'package:gre_vocabulary/src/vocabulary/domain/entities/word.dart';

/// Abstract class that all wordlist parsers should implement
abstract class WordListParser {
  final List<List> rawList;

  const WordListParser(this.rawList);

  /// takes a list of lists of words and returns a list of words
  ///
  /// the list inside the list is similar to a row in a csv file
  List<Word> getWords();
}
