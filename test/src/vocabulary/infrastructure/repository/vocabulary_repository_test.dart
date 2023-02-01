import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gre_vocabulary/src/core/common_domains/models/success_model.dart';
import 'package:gre_vocabulary/src/vocabulary/core/failures.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/entities/get_words_response.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/entities/word.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/value_objects/value_objects.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/data_source/local_data_source.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/get_words_response_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/word_model.dart';
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

  group('getAllWords', () {
    final tData = [
      // generate 10 random Words
      for (var i = 0; i < 10; i++)
        WordModel(
          value: 'word$i',
          definition: 'meaning$i',
          example: 'example$i',
          isHitWord: i % 2 == 0,
        )
    ];

    final tGetWordsResponseModel = GetWordsResponseModel<WordModel>(
      words: tData,
      totalWords: 100,
      currentPage: 1,
      totalPages: 10,
      wordsPerPage: 10,
    );

    test(
        'should return [VocabularyFailure] when limit is more than maxWordsFetchLimit',
        () async {
      // arrange
      final tLimit = PaginationLimit(101);
      final tOffset = PaginationOffSet(0);

      // act
      final result = await vocabularyRepository.getAllWords(
          limit: tLimit, offset: tOffset);
      // assert

      expect(result.isLeft(), true);

      expect(result.fold(id, id), isA<VocabularyFailure>());
    });

    test(
        'should return [VocabularyFailure] when limit is less than minWordsFetchLimit',
        () async {
      // arrange
      final tLimit = PaginationLimit(4);
      final tOffset = PaginationOffSet(0);

      // act
      final result = await vocabularyRepository.getAllWords(
          limit: tLimit, offset: tOffset);

      // assert
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<VocabularyFailure>());
    });

    test('should return [VocabularyFailure] when offset is negative', () async {
      // arrange
      final tLimit = PaginationLimit(10);
      final tOffset = PaginationOffSet(-1);

      // act
      final result = await vocabularyRepository.getAllWords(
          limit: tLimit, offset: tOffset);

      // assert
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<VocabularyFailure>());
    });

    test('should call local data source once to get all words', () async {
      // arrange
      final tLimit = PaginationLimit(10);
      final tOffset = PaginationOffSet(0);

      when(localDataSource.getAllWords(
              limit: anyNamed('limit'), offset: anyNamed('offset')))
          .thenAnswer((_) async => tGetWordsResponseModel);

      // act
      final result = await vocabularyRepository.getAllWords(
          limit: tLimit, offset: tOffset);

      // assert
      verify(
        localDataSource.getAllWords(
          limit: tLimit.getOrElse(10),
          offset: tOffset.getOrElse(0),
        ),
      ).called(1);
    });

    test('should return a failure when the local data source fails', () async {
      // arrange
      final tLimit = PaginationLimit(10);
      final tOffset = PaginationOffSet(0);

      when(localDataSource.getAllWords(
              limit: anyNamed('limit'), offset: anyNamed('offset')))
          .thenThrow(Exception('Unable to get words'));

      // act
      final result = await vocabularyRepository.getAllWords(
          limit: tLimit, offset: tOffset);

      // assert
      expect(result.isLeft(), true);
    });

    test(
        'should return a GetWordsResponse<Word> of words when everything goes well',
        () async {
      // arrange
      final tLimit = PaginationLimit(10);
      final tOffset = PaginationOffSet(0);

      when(localDataSource.getAllWords(
              limit: anyNamed('limit'), offset: anyNamed('offset')))
          .thenAnswer((_) async => tGetWordsResponseModel);

      // act
      final result = await vocabularyRepository.getAllWords(
          limit: tLimit, offset: tOffset);

      // assert
      expect(result.isRight(), true);

      expect(result.fold(id, id), isA<GetWordsResponse<Word>>());
      expect((result.fold(id, id) as GetWordsResponse<Word>).words, tData);
    });
  });
}
