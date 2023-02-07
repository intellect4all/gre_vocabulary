import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/value_objects/word.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/data_source/db_keys.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/data_source/isar_local_data_source.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/isar_word_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/word_model.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:hive_test/hive_test.dart';
import 'package:isar/isar.dart';
import 'package:mockito/annotations.dart';
import 'package:path/path.dart' as path;

@GenerateMocks(
  [],
)
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late IDataBase dataBase;

  late IsarLocalDataSource isarLocalDataSource;

  // generate 10 random words
  const tWords = [
    'abandon',
    'ability',
    'able',
    'abortion',
    'about',
    'above',
    'abroad',
    'absence',
    'absolute',
    'absolutely',
  ];

  setUp(() async {
    await setUpTestHive();

    final tGeneralBox = await Hive.openBox('test_general');
    final tMemorizedWordsBox = await Hive.openBox<int>('test_memorized_words');

    // await Isar.initializeIsarCore(download: true);
    final dartToolDir = path.join(Directory.current.path, '.dart_tool');
    final testTempPath = path.join(dartToolDir, 'test', 'tmp');

    // close all isar instances

    // check if isar instance is already open
    var isar = Isar.getInstance("isar");

    if (isar != null) {
      await isar.close();
    }

    final tIsar = await Isar.open(
      [IsarWordModelSchema],
      directory: testTempPath,
      name: 'isar',
    );

    // clear all boxes
    dataBase = DB(
      generalDataBox: tGeneralBox,
      memorizedWordsBox: tMemorizedWordsBox,
      isar: tIsar,
    );
    isarLocalDataSource = IsarLocalDataSource(hiveBoxes: dataBase);
  });

  group('areWordsLoaded', () {
    test('should return false if wordsLoaded is not set', () async {
      final result = await isarLocalDataSource.areWordsLoaded();
      expect(result, false);
    });

    test('should return true if wordsLoaded is set', () async {
      await dataBase.generalDataBox.put(DBKeys.wordsLoaded, true);
      final result = await isarLocalDataSource.areWordsLoaded();
      expect(result, true);
    });
  });

  group(
    "saveAllWords",
    () {
      test(
        "should save all words to the isar db",
        () async {
          // arrange
          final tAllWords = List.generate(
            10,
            (index) => WordModel(
              value: WordObject(tWords[index]),
              definition: 'test definition $index',
              example: 'test example $index',
              isHitWord: index % 2 == 0,
              source: 'test source $index',
            ),
          );
          // act
          await isarLocalDataSource.saveAllWords(tAllWords);

          final result = await dataBase.isar.words.where().findAll();
          final wordModels = result
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

          // assert
          expect(result.length, tAllWords.length);
          expect(wordModels, tAllWords);
        },
      );

      test(
        "should store word count in hive general box",
        () async {
          // arrange
          final tAllWords = List.generate(
            10,
            (index) => WordModel(
              value: WordObject(tWords[index]),
              definition: 'test definition $index',
              example: 'test example $index',
              isHitWord: index % 2 == 0,
              source: 'test source $index',
            ),
          );
          // act
          await isarLocalDataSource.saveAllWords(tAllWords);

          // assert
          expect(
            dataBase.generalDataBox.get(DBKeys.allWordsCount),
            tAllWords.length,
          );
        },
      );

      test(
        "should store wordsLoaded in hive general box",
        () async {
          // arrange
          final tAllWords = List.generate(
            10,
            (index) => WordModel(
              value: WordObject(tWords[index]),
              definition: 'test definition $index',
              example: 'test example $index',
              isHitWord: index % 2 == 0,
              source: 'test source $index',
            ),
          );
          // act
          await isarLocalDataSource.saveAllWords(tAllWords);

          // assert
          expect(
            dataBase.generalDataBox.get(DBKeys.wordsLoaded),
            true,
          );
        },
      );
    },
  );
}
