import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gre_vocabulary/src/core/common_domains/models/success_model.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/core/failures.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/data_source/local_data_source.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/repository/vocabulary_repository.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/repository/wordlists_csv_parsers/csv_parser.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'vocabulary_repository_test.mocks.dart';

@GenerateMocks([LocalDataSource, CSVListsParser])
void main() {
  late MockLocalDataSource localDataSource;
  late MockCSVListsParser csvListsParser;
  late VocabularyRepository vocabularyRepository;
  late CSVParsingResponse tCsvParsingResponse;
  setUp(() {
    localDataSource = MockLocalDataSource();
    csvListsParser = MockCSVListsParser();

    tCsvParsingResponse = const CSVParsingResponse(
      allWords: [],
      wordsToSource: {},
    );

    vocabularyRepository = VocabularyRepository(
      localDataSource: localDataSource,
      csvListsParser: csvListsParser,
    );
  });

  group('loadAllWordsIntoLocalDb', () {
    setUp(() {
      when(localDataSource.saveAllWords(any))
          .thenAnswer((_) async => const SuccessModel());
      when(localDataSource.saveWordsToSource(any))
          .thenAnswer((_) async => const SuccessModel());
    });

    wordsLoadedState({required bool areWordsLoaded}) {
      when(localDataSource.areWordsLoaded())
          .thenAnswer((_) async => areWordsLoaded);
    }

    test(
        'should call the local data source to check if the words are already loaded',
        () async {
      // arrange
      wordsLoadedState(areWordsLoaded: true);
      // act
      await vocabularyRepository.loadAllWordsIntoDb();
      // assert
      verify(localDataSource.areWordsLoaded());
    });

    test('should return a success message when the words are already loaded',
        () async {
      // arrange
      wordsLoadedState(areWordsLoaded: true);
      // act
      final result = await vocabularyRepository.loadAllWordsIntoDb();
      // assert
      expect(result.isRight(), true);
    });

    test('should call the csv parser once to parse the csv file', () async {
      // arrange
      wordsLoadedState(areWordsLoaded: false);
      when(csvListsParser.parse())
          .thenAnswer((_) => Right(tCsvParsingResponse));
      // act
      await vocabularyRepository.loadAllWordsIntoDb();
      // assert
      verify(csvListsParser.parse()).called(1);
    });

    test('should return a failure when the csv parser fails', () async {
      // arrange
      wordsLoadedState(areWordsLoaded: false);
      when(csvListsParser.parse())
          .thenAnswer((_) => left(const VocabularyFailure.unableToParseCSV()));

      // act
      final result = await vocabularyRepository.loadAllWordsIntoDb();
      // assert
      expect(result.isLeft(), true);
    });

    test('should call the local data source to save all words', () async {
      // arrange
      wordsLoadedState(areWordsLoaded: false);
      when(csvListsParser.parse())
          .thenAnswer((_) => Right(tCsvParsingResponse));
      // act
      await vocabularyRepository.loadAllWordsIntoDb();
      // assert
      verify(localDataSource.saveAllWords(tCsvParsingResponse.allWords))
          .called(1);
      verify(localDataSource
              .saveWordsToSource(tCsvParsingResponse.wordsToSource))
          .called(1);
    });

    test(
        'should return a failure when the local data source fails to save the words',
        () async {
      // arrange
      wordsLoadedState(areWordsLoaded: false);
      when(csvListsParser.parse())
          .thenAnswer((_) => Right(tCsvParsingResponse));
      when(localDataSource.saveAllWords(any))
          .thenThrow(Exception('Unable to save words'));
      // act
      final result = await vocabularyRepository.loadAllWordsIntoDb();
      // assert
      expect(result.isLeft(), true);
    });

    test('should return success when everything goes well', () async {
      // arrange
      wordsLoadedState(areWordsLoaded: false);
      when(csvListsParser.parse())
          .thenAnswer((_) => Right(tCsvParsingResponse));
      when(localDataSource.saveWordsToSource(any))
          .thenAnswer((_) async => const SuccessModel());
      // act
      final result = await vocabularyRepository.loadAllWordsIntoDb();
      // assert
      expect(result.isRight(), true);
    });
  });
}
