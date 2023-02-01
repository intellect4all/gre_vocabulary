import 'package:dartz/dartz.dart';

import '../../domain/core/failures.dart';
import '../models/word_model.dart';
import '../repository/words_lists/base_words_list.dart';
import '../repository/words_lists/word_lists.dart';

abstract class CSVListsParser {
  final List<WordsList> wordsLists;

  const CSVListsParser(this.wordsLists);

  Either<VocabularyFailure, CSVParsingResponse> parse();
}

class CSVParsingResponse {
  final List<WordModel> allWords;

  /// key is the name of the list
  /// should be unique for each word_list
  final Map<WordsListKey, List<WordModel>> wordsToSource;

  const CSVParsingResponse({
    required this.allWords,
    required this.wordsToSource,
  });
}
