import 'package:gre_vocabulary/src/core/common_domains/models/success_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/word_model.dart';

import '../../core/constants.dart';
import '../models/get_words_response_model.dart';

abstract class LocalDataSource {
  Future<bool> areWordsLoaded();

  Future<SuccessModel> saveAllWords(List<WordModel> allWords);

  Future<SuccessModel> saveWordsToSource(
      Map<WordsListKey, List<WordModel>> wordsToSource);

  Future<GetWordsResponseModel<WordModel>> getAllWords(
      {required int limit, required int offset});

  Future<GetWordsResponseModel<WordModel>> getAllWordsForSource({
    required WordsListKey source,
    required int limit,
    required int offset,
  });
}
