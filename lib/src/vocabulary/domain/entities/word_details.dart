import 'package:gre_vocabulary/src/vocabulary/domain/entities/word.dart';

/// this is a wrapper around a word so that we can add more details to it
class WordDetails {
  /// the word
  final Word word;

  /// the number of times the word has been shown
  final int timesShown;

  /// whether the word should be shown or not
  final bool show;

  /// whether the word has been memorized or not
  final bool isMemorized;

  /// the date the word was last shown
  final String lastShownDate;

  const WordDetails({
    required this.word,
    required this.timesShown,
    required this.show,
    required this.isMemorized,
    required this.lastShownDate,
  });
}