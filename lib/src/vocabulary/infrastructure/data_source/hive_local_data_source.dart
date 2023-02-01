import 'package:gre_vocabulary/src/core/common_domains/models/success_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/get_words_response_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/word_model.dart';

import '../../core/constants.dart';
import 'local_data_source.dart';

class HiveLocalDataSource implements LocalDataSource {
  @override
  Future<bool> areWordsLoaded() {
    // TODO: implement areWordsLoaded
    throw UnimplementedError();
  }

  @override
  Future<SuccessModel> saveAllWords(List<WordModel> allWords) {
    // TODO: implement saveAllWords
    throw UnimplementedError();
  }

  @override
  Future<SuccessModel> saveWordsToSource(
      Map<WordsListKey, List<WordModel>> wordsToSource) {
    // TODO: implement saveWordsToSource
    throw UnimplementedError();
  }

  @override
  Future<GetWordsResponseModel<WordModel>> getAllWords(
      {required int limit, required int offset}) {
    // TODO: implement getAllWords
    throw UnimplementedError();
  }
}
