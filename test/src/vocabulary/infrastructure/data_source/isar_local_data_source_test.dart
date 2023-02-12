import 'dart:io';

import 'package:flutter_test/flutter_test.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/core/exceptions.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/value_objects/word.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/data_source/db_keys.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/data_source/isar_local_data_source.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/get_words_response_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/isar_word_details_model.dart';
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

    // if yes, close it
    if (isar != null) {
      await isar.writeTxn(() async => await isar.clear());
      await isar.close();
    }

    final tIsar = await Isar.open(
      [IsarWordModelSchema, IsarWordDetailsModelSchema],
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
        "should store wordsLoaded in hive general box",
        () async {
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

  group(
    "getAllWords",
    () {
      test(
        "should return all words from the isar db",
        () async {
          // arrange
          const tOffset = 0;
          const tLimit = 5;
          await isarLocalDataSource.saveAllWords(tAllWords);
          final tWordsResponseModel = GetWordsResponseModel(
            words: tAllWords.sublist(0, 5),
            totalWords: 10,
            currentPage: tOffset <= 0 ? 1 : (tOffset ~/ tLimit) + 1,
            totalPages: (10 / tLimit).ceil(),
            wordsPerPage: tLimit,
          );

          // act
          final result =
              await isarLocalDataSource.getAllWords(limit: 5, offset: 0);

          // assert
          expect(result.words.length, 5);
          expect(result.words, tAllWords.sublist(0, 5));
          expect(result, tWordsResponseModel);
        },
      );

      // test that offset works
      test(
        "should return correct offsets words from the isar db",
        () async {
          // arrange
          const tOffset = 5;
          const tLimit = 5;
          await isarLocalDataSource.saveAllWords(tAllWords);
          final tWordsResponseModel = GetWordsResponseModel(
            words: tAllWords.sublist(5, 10),
            totalWords: 10,
            currentPage: tOffset <= 0 ? 1 : (tOffset ~/ tLimit) + 1,
            totalPages: (10 / tLimit).ceil(),
            wordsPerPage: tLimit,
          );

          // act
          final result =
              await isarLocalDataSource.getAllWords(limit: 5, offset: 5);

          // assert
          expect(result.totalWords, 10);
          expect(result.words.length, 5);
          expect(result.words, tAllWords.sublist(5, 10));
          expect(result, tWordsResponseModel);
        },
      );
    },
  );

  group(
    "allWordsCount",
    () {
      test(
        "allWordsCount 1",
        () async {
          // arrange
          await isarLocalDataSource.saveAllWords(tAllWords);

          // act
          final count = await isarLocalDataSource.allWordsCount();

          // assert
          expect(count, tAllWords.length);
        },
      );

      test(
        "allWordsCount 2",
        () async {
          // arrange
          final sublist = tAllWords.sublist(0, 5);
          await isarLocalDataSource.saveAllWords(sublist);

          // act
          final count = await isarLocalDataSource.allWordsCount();

          // assert
          expect(count, sublist.length);
        },
      );
    },
  );

  group("getWord", () {
    test("should return word from the isar db", () async {
      // arrange
      final tWord = WordModel(
        value: WordObject("jungle"),
        definition: "jungle is a test word",
        example: "test",
        source: "test",
      );
      await isarLocalDataSource.saveAllWords([tWord]);

      // act
      final result = await isarLocalDataSource.getWord("jungle");

      // assert
      expect(result, tWord);
    });

    test("should throw a WordNotFoundException if word is not in the Words DB",
        () async {
      // arrange
      final tWord = WordModel(
        value: WordObject("jungle"),
        definition: "jungle is a test word",
        example: "test",
        source: "test",
      );
      await isarLocalDataSource.saveAllWords([tWord]);
      // act
      final call = isarLocalDataSource.getWord;

      final count = await isarLocalDataSource.allWordsCount();

      // assert
      expect(count, 1);
      expect(() => call("abandon"), throwsA(isA<WordNotFoundException>()));
    });
  });

  group(
    "markWordAsShown",
    () {
      test("should mark word as shown", () async {
        // arrange
        final tWord = WordModel(
          value: WordObject("jungle"),
          definition: "jungle is a test word",
          example: "test",
          source: "test",
        );
        await isarLocalDataSource.saveAllWords([tWord]);

        // act
        await isarLocalDataSource.markWordAsShown(
          word: tWord.value.getOrCrash(),
        );

        // assert
        final result = await dataBase.isar.wordDetails
            .where()
            .wordEqualTo("jungle")
            .findFirst();

        expect(result, isNotNull);
        expect(result!.shownCount, 1);
      });

      test("should increment shownCount ", () async {
        // arrange
        final tWord = WordModel(
          value: WordObject("jungle"),
          definition: "jungle is a test word",
          example: "test",
          source: "test",
        );
        await isarLocalDataSource.saveAllWords([tWord]);

        // act
        await isarLocalDataSource.markWordAsShown(
          word: tWord.value.getOrCrash(),
        );
        await isarLocalDataSource.markWordAsShown(
          word: tWord.value.getOrCrash(),
        );

        // assert
        final result = await dataBase.isar.wordDetails
            .where()
            .wordEqualTo("jungle")
            .findFirst();

        expect(result, isNotNull);
        expect(result!.shownCount, 2);
      });

      test(
        "should throw a WordNotFoundException if word is not in the Words DB",
        () async {
          // arrange
          final tWord = WordModel(
            value: WordObject("notInDb"),
            definition: "notInDb",
            example: "notInDb",
            source: "notInDb",
          );

          // act
          final call = isarLocalDataSource.markWordAsShown;

          // assert
          expect(
            () => call(word: tWord.value.getOrCrash()),
            throwsA(
              isA<WordNotFoundException>(),
            ),
          );
        },
      );
    },
  );

  group(
    "getAllWordDetails",
    () {
      test(
        "should return all word details from the isar db",
        () async {
          // arrange
          const tOffset = 0;
          const tLimit = 5;
          await isarLocalDataSource.saveAllWords(tAllWords);

          // because word details are a byproduct of interacting with the word model,
          // we need to interact with with some words
          final tWordsResponseModel = GetWordsResponseModel(
            words: tAllWords.sublist(0, 5),
            totalWords: 10,
            currentPage: tOffset <= 0 ? 1 : (tOffset ~/ tLimit) + 1,
            totalPages: (10 / tLimit).ceil(),
            wordsPerPage: tLimit,
          );

          // act
          final result =
              await isarLocalDataSource.getAllWords(limit: 5, offset: 0);

          // assert
          expect(result.words.length, 5);
          expect(result.words, tAllWords.sublist(0, 5));
          expect(result, tWordsResponseModel);
        },
      );
    },
  );
}
