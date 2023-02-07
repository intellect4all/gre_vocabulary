import 'package:gre_vocabulary/src/core/common_domains/models/success_model.dart';
import 'package:gre_vocabulary/src/vocabulary/core/constants.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/get_words_response_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/isar_word_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/word_details_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/word_model.dart';
import 'package:hive/hive.dart';
import 'package:isar/isar.dart';

import 'db_keys.dart';
import 'local_data_source.dart';

abstract class IDataBase {
  final Box<int> memorizedWordsBox;
  final Box generalDataBox;
  final Isar isar;

  const IDataBase({
    required this.memorizedWordsBox,
    required this.generalDataBox,
    required this.isar,
  });
}

class DB extends IDataBase {
  DB(
      {required super.memorizedWordsBox,
      required super.generalDataBox,
      required super.isar});
}

class IsarLocalDataSource implements LocalDataSource {
  final IDataBase _hiveBoxes;

  IsarLocalDataSource({
    required IDataBase hiveBoxes,
  }) : _hiveBoxes = hiveBoxes;

  @override
  Future<bool> areWordsLoaded() async {
    return await _hiveBoxes.generalDataBox.get(DBKeys.wordsLoaded) ?? false;
  }

  @override
  Future<SuccessModel> saveAllWords(List<WordModel> allWords) async {
    final count = allWords.length;

    // clear the db
    await _hiveBoxes.isar.writeTxn(() async {
      await _hiveBoxes.isar.words.clear();
    });

    _hiveBoxes.isar.writeTxn(() async {
      final words =
          allWords.map((e) => IsarWordModel.fromWordModel(e)).toList();
      words.sort(
        (a, b) => a.value.compareTo(b.value),
      );

      await _hiveBoxes.isar.words.putAll(words);
    });

    await _hiveBoxes.generalDataBox.put(DBKeys.allWordsCount, count);
    await _hiveBoxes.generalDataBox.put(DBKeys.wordsLoaded, true);

    return const SuccessModel();
  }

  @override
  Future<GetWordsResponseModel<WordModel>> getAllWords({
    required int limit,
    required int offset,
  }) {
    // TODO: implement getAllWords
    throw UnimplementedError();
  }

  @override
  Future<List<int>> allMemorizedIndex() {
    // TODO: implement allMemorizedIndex
    throw UnimplementedError();
  }

  @override
  Future<List<int>> allRecentlyShownIndex() {
    // TODO: implement allRecentlyShownIndex
    throw UnimplementedError();
  }

  @override
  Future<int> allWordsCount() {
    // TODO: implement allWordsCount
    throw UnimplementedError();
  }

  @override
  Future<SuccessModel> clearWordShowHistory({required String word}) {
    // TODO: implement clearWordShowHistory
    throw UnimplementedError();
  }

  @override
  Future<GetWordsResponseModel<WordDetailsModel>> getAllMemorizedWords(
      {required int limit, required int offset}) {
    // TODO: implement getAllMemorizedWords
    throw UnimplementedError();
  }

  @override
  Future<GetWordsResponseModel<WordDetailsModel>> getAllShownWords(
      {required int limit, required int offset}) {
    // TODO: implement getAllShownWords
    throw UnimplementedError();
  }

  @override
  Future<GetWordsResponseModel<WordDetailsModel>> getAllToBeRememberedWords(
      {required int limit, required int offset}) {
    // TODO: implement getAllToBeRememberedWords
    throw UnimplementedError();
  }

  @override
  Future<GetWordsResponseModel<WordDetailsModel>> getAllWordDetails(
      {required int limit, required int offset, required int shownThreshold}) {
    // TODO: implement getAllWordDetails
    throw UnimplementedError();
  }

  @override
  Future<GetWordsResponseModel<WordModel>> getAllWordsForSource(
      {required WordsListKey source, required int limit, required int offset}) {
    // TODO: implement getAllWordsForSource
    throw UnimplementedError();
  }

  @override
  Future<GetWordsResponseModel<WordDetailsModel>> getAllWordsShownToday(
      {required int limit, required int offset}) {
    // TODO: implement getAllWordsShownToday
    throw UnimplementedError();
  }

  @override
  Future<WordDetailsModel> getWordDetails({required String word}) {
    // TODO: implement getWordDetails
    throw UnimplementedError();
  }

  @override
  Future<List<WordDetailsModel>> getWordsByIndex(List<int> indexesToBeShown) {
    // TODO: implement getWordsByIndex
    throw UnimplementedError();
  }

  @override
  Future<SuccessModel> markWordAsMemorized({required String word}) {
    // TODO: implement markWordAsMemorized
    throw UnimplementedError();
  }

  @override
  Future<SuccessModel> markWordAsShown({required String word}) {
    // TODO: implement markWordAsShown
    throw UnimplementedError();
  }

  @override
  Future<SuccessModel> markWordAsToBeRemembered({required String word}) {
    // TODO: implement markWordAsToBeRemembered
    throw UnimplementedError();
  }

  @override
  Future<SuccessModel> removeWordFromMemorized({required String word}) {
    // TODO: implement removeWordFromMemorized
    throw UnimplementedError();
  }

  @override
  Future<SuccessModel> removeWordFromToBeRemembered({required String word}) {
    // TODO: implement removeWordFromToBeRemembered
    throw UnimplementedError();
  }

  @override
  Future<SuccessModel> saveWordsToSource(
      Map<WordsListKey, List<WordModel>> wordsToSource) {
    // TODO: implement saveWordsToSource
    throw UnimplementedError();
  }
}
