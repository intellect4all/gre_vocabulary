import 'package:dartz/dartz.dart';

import '../../../domain/core/failures.dart';
import '../../models/word_model.dart';
import '../words_lists/base_words_list.dart';

abstract class CSVListsParser {
  final List<BaseWordsList> wordsLists;

  const CSVListsParser(this.wordsLists);

  Either<VocabularyFailure, List<WordModel>> parse();
}
