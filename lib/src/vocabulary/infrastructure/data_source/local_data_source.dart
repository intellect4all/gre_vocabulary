import 'package:gre_vocabulary/src/core/common_domains/models/success_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/word_model.dart';

import '../../domain/core/constants.dart';

abstract class LocalDataSource {
  Future<bool> areWordsLoaded();

  Future<SuccessModel> saveAllWords(List<WordModel> allWords);

  Future<SuccessModel> saveWordsToSource(
      Map<WordsListKey, List<WordModel>> wordsToSource);
}
