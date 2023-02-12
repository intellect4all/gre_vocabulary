import 'package:gre_vocabulary/src/core/common_domains/models/success_model.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/core/exceptions.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/get_words_response_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/isar_word_details_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/isar_word_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/word_details_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/word_model.dart';
import 'package:hive/hive.dart';
import 'package:isar/isar.dart';

import '../../domain/core/constants.dart';
import '../../domain/value_objects/word.dart';
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

    await _hiveBoxes.isar.writeTxn(() async {
      final words =
          allWords.map((e) => IsarWordModel.fromWordModel(e)).toList();
      words.sort(
        (a, b) => a.value.compareTo(b.value),
      );

      await _hiveBoxes.isar.words.putAll(words);
    });

    await _hiveBoxes.generalDataBox.put(DBKeys.wordsLoaded, true);

    return const SuccessModel();
  }

  @override
  Future<GetWordsResponseModel<WordModel>> getAllWords({
    required int limit,
    required int offset,
  }) async {
    final words = await _hiveBoxes.isar.words
        .where()
        .offset(offset)
        .limit(limit)
        .findAll();

    final totalCount = await _hiveBoxes.isar.words.count();

    final wordModels = words
        .map(
          (e) => WordModel(
            value: WordObject(e.value),
            definition: e.definition,
            example: e.example,
            isHitWord: e.isHitWord,
            source: e.source,
          ),
        )
        .toList();

    return GetWordsResponseModel(
      words: wordModels,
      totalWords: totalCount,
      currentPage: offset <= 0 ? 1 : (offset ~/ limit) + 1,
      totalPages: (totalCount / limit).ceil(),
      wordsPerPage: limit,
    );
  }

  @override
  Future<WordModel> getWord(String word) async {
    final wordModel =
        await _hiveBoxes.isar.words.where().valueEqualTo(word).findFirst();

    if (wordModel == null) {
      throw WordNotFoundException(word: word);
    }

    return WordModel(
      value: WordObject(wordModel.value),
      definition: wordModel.definition,
      example: wordModel.example,
      isHitWord: wordModel.isHitWord,
      source: wordModel.source,
    );
  }

  @override
  Future<int> allWordsCount() async {
    return await _hiveBoxes.isar.words.count();
  }

  @override
  Future<SuccessModel> markWordAsShown({required String word}) async {
    final wordModel = await getWord(word);

    // get the word details
    final wordDetails =
        await _hiveBoxes.isar.wordDetails.where().wordEqualTo(word).findFirst();

    // if word details is not present, create a new one
    if (wordDetails == null) {
      await _hiveBoxes.isar.writeTxn(() async {
        await _hiveBoxes.isar.wordDetails.put(
          IsarWordDetailsModel.fresh(
            word: word,
            id: wordModel.id,
          ),
        );
      });
    } else {
      // if word details is present, update the shown count and last shown date
      await _hiveBoxes.isar.writeTxn(() async {
        await _hiveBoxes.isar.wordDetails.put(
          wordDetails.copyWith(
            shownCount: wordDetails.shownCount + 1,
            lastShownDate: DateTime.now(),
          ),
        );
      });
    }

    return const SuccessModel();
  }

  @override
  Future<GetWordsResponseModel<WordDetailsModel>> getAllWordDetails({
    required int limit,
    required int offset,
  }) {
    // TODO: implement getAllWordDetails
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
  Future<List<WordDetailsModel>> getWordsByIndexes(List<int> indexesToBeShown) {
    // TODO: implement getWordsByIndex
    throw UnimplementedError();
  }

  @override
  Future<SuccessModel> markWordAsMemorized({required String word}) {
    // TODO: implement markWordAsMemorized
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
}
