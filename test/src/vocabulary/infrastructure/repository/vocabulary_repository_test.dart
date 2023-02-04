import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gre_vocabulary/src/core/common_domains/entities/success.dart';
import 'package:gre_vocabulary/src/core/common_domains/models/success_model.dart';
import 'package:gre_vocabulary/src/vocabulary/core/failures.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/entities/get_words_response.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/entities/word.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/entities/word_details.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/value_objects/value_objects.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/value_objects/word.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/data_source/local_data_source.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/get_words_response_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/word_details_model.dart';
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

  final tWordModels = [
    // generate 10 random Words
    for (var i = 0; i < 10; i++)
      WordModel(
        value: WordObject('word$i'),
        definition: 'meaning$i',
        example: 'example$i',
        isHitWord: i % 2 == 0,
      )
  ];

  final tGetWordsResponseModel = GetWordsResponseModel<WordModel>(
    words: tWordModels,
    totalWords: 100,
    currentPage: 1,
    totalPages: 10,
    wordsPerPage: 10,
  );
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

  /// Test for loadAllWordsIntoDb()
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
    test(
        'should return [VocabularyFailure] when limit is more than maxWordsFetchLimit',
        () async {
      // arrange
      final tLimit = PaginationLimit(101);
      final tOffset = PaginationOffSet(0);

      // act
      final result = await vocabularyRepository.getAllWords(
        limit: tLimit,
        offset: tOffset,
      );
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
        limit: tLimit,
        offset: tOffset,
      );

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
        limit: tLimit,
        offset: tOffset,
      );

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
      expect(
          (result.fold(id, id) as GetWordsResponse<Word>).words, tWordModels);
    });
  });

  /// getAllWordsForSource
  group('getAllWordsForSource', () {
    const tSource = 'source';

    test(
        'should return [VocabularyFailure] when limit is more than maxWordsFetchLimit',
        () async {
      // arrange
      final tLimit = PaginationLimit(101);
      final tOffset = PaginationOffSet(0);

      // act
      final result = await vocabularyRepository.getAllWordsForSource(
        source: tSource,
        limit: tLimit,
        offset: tOffset,
      );
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
      final result = await vocabularyRepository.getAllWordsForSource(
        source: tSource,
        limit: tLimit,
        offset: tOffset,
      );

      // assert
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<VocabularyFailure>());
    });

    test('should return [VocabularyFailure] when offset is negative', () async {
      // arrange
      final tLimit = PaginationLimit(10);
      final tOffset = PaginationOffSet(-1);

      // act
      final result = await vocabularyRepository.getAllWordsForSource(
        source: tSource,
        limit: tLimit,
        offset: tOffset,
      );

      // assert
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<VocabularyFailure>());
    });

    test('should call local data source once to get all words for source',
        () async {
      // arrange
      final tLimit = PaginationLimit(10);
      final tOffset = PaginationOffSet(0);

      when(
        localDataSource.getAllWordsForSource(
          source: anyNamed('source'),
          limit: anyNamed('limit'),
          offset: anyNamed(
            'offset',
          ),
        ),
      ).thenAnswer((_) async => tGetWordsResponseModel);

      // act
      final result = await vocabularyRepository.getAllWordsForSource(
          source: tSource, limit: tLimit, offset: tOffset);

      // assert
      verify(
        localDataSource.getAllWordsForSource(
          source: tSource,
          limit: tLimit.getOrElse(10),
          offset: tOffset.getOrElse(0),
        ),
      ).called(1);
    });

    test('should return a [VocabularyFailure] when the local data source fails',
        () async {
      // arrange
      final tLimit = PaginationLimit(10);
      final tOffset = PaginationOffSet(0);

      when(
        localDataSource.getAllWordsForSource(
          source: anyNamed('source'),
          limit: anyNamed('limit'),
          offset: anyNamed(
            'offset',
          ),
        ),
      ).thenThrow(Exception('Unable to get words'));

      // act
      final result = await vocabularyRepository.getAllWordsForSource(
          source: tSource, limit: tLimit, offset: tOffset);

      // assert
      expect(result.isLeft(), true);
    });

    test(
        'should return a GetWordsResponse<Word> of words when everything goes well',
        () async {
      // arrange
      final tLimit = PaginationLimit(10);
      final tOffset = PaginationOffSet(0);

      when(
        localDataSource.getAllWordsForSource(
          source: anyNamed('source'),
          limit: anyNamed('limit'),
          offset: anyNamed(
            'offset',
          ),
        ),
      ).thenAnswer((_) async => tGetWordsResponseModel);

      // act
      final result = await vocabularyRepository.getAllWordsForSource(
          source: tSource, limit: tLimit, offset: tOffset);

      // assert
      expect(result.isRight(), true);

      expect(result.fold(id, id), isA<GetWordsResponse<Word>>());
      expect(
          (result.fold(id, id) as GetWordsResponse<Word>).words, tWordModels);
    });
  });

  group('getAllWordDetails', () {
    const tShownThreshold = 5;

    final tWordDetailsModels = tWordModels
        .map(
          (e) => WordDetailsModel(
            word: e,
            timesShown: 0,
            show: false,
            isMemorized: false,
            lastShownDate: DateTime.now(),
          ),
        )
        .toList();
    final tGetWordDetailsResponseModel =
        GetWordsResponseModel<WordDetailsModel>(
      words: tWordDetailsModels,
      totalWords: 100,
      currentPage: 1,
      totalPages: 10,
      wordsPerPage: 10,
    );

    final tLimit = PaginationLimit(10);
    final tOffset = PaginationOffSet(0);

    setUp(() {
      when(
        localDataSource.getAllWordDetails(
            limit: anyNamed('limit'),
            offset: anyNamed('offset'),
            shownThreshold: anyNamed('shownThreshold')),
      ).thenAnswer((_) async => tGetWordDetailsResponseModel);
    });

    test(
        'should return [VocabularyFailure] when limit is more than maxWordsFetchLimit',
        () async {
      // arrange
      final tLimit = PaginationLimit(101);
      final tOffset = PaginationOffSet(0);

      // act
      final result = await vocabularyRepository.getAllWordDetails(
        limit: tLimit,
        offset: tOffset,
        shownThreshold: tShownThreshold,
      );
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
      final result = await vocabularyRepository.getAllWordDetails(
        limit: tLimit,
        offset: tOffset,
        shownThreshold: tShownThreshold,
      );

      // assert
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<VocabularyFailure>());
    });

    test('should return [VocabularyFailure] when offset is negative', () async {
      // arrange

      final tOffset = PaginationOffSet(-1);

      // act
      final result = await vocabularyRepository.getAllWordDetails(
        limit: tLimit,
        offset: tOffset,
        shownThreshold: tShownThreshold,
      );

      // assert
      expect(result.isLeft(), true);
      expect(result.fold(id, id), isA<VocabularyFailure>());
    });

    test(
        'should call local data source getAllWordDetails once to get all words details',
        () async {
      // act
      final result = await vocabularyRepository.getAllWordDetails(
        limit: tLimit,
        offset: tOffset,
        shownThreshold: tShownThreshold,
      );

      // assert
      verify(
        localDataSource.getAllWordDetails(
          limit: tLimit.getOrElse(10),
          offset: tOffset.getOrElse(0),
          shownThreshold: tShownThreshold,
        ),
      ).called(1);
    });

    test('should return a failure when getAllWordDetails throws an exception',
        () async {
      // arrange

      when(
        localDataSource.getAllWordDetails(
            limit: anyNamed('limit'),
            offset: anyNamed('offset'),
            shownThreshold: anyNamed('shownThreshold')),
      ).thenThrow(Exception('Unable to get words'));

      // act
      final res = await vocabularyRepository.getAllWordDetails(
        limit: tLimit,
        offset: tOffset,
        shownThreshold: tShownThreshold,
      );

      // assert
      expect(res.isLeft(), true);
      expect(res.fold(id, id), isA<VocabularyFailure>());
    });

    test(
        'should return a GetWordsResponse<WordDetails> of words when everything goes well',
        () async {
      // act
      final result = await vocabularyRepository.getAllWordDetails(
        limit: tLimit,
        offset: tOffset,
        shownThreshold: tShownThreshold,
      );

      // assert
      expect(result.isRight(), true);

      expect(result.fold(id, id), isA<GetWordsResponse<WordDetails>>());
      expect((result.fold(id, id) as GetWordsResponse<WordDetails>).words,
          tWordDetailsModels);
    });
  });

  group('getWordDetails', () {
    final tWordModel = WordModel(
      value: WordObject('test'),
      definition: "test",
      example: "test",
      isHitWord: false,
    );

    final tWordDetailsModel = WordDetailsModel(
      word: tWordModel,
      timesShown: 0,
      show: false,
      isMemorized: false,
      lastShownDate: DateTime.now(),
    );

    setUp(() {
      when(localDataSource.getWordDetails(word: anyNamed('word')))
          .thenAnswer((_) async => tWordDetailsModel);
    });

    test('should return a failure if word is not valid', () async {
      // act
      final t1 = await vocabularyRepository.getWordDetails(
        word: WordObject(''),
      );

      final t2 = await vocabularyRepository.getWordDetails(
        word: WordObject('a445dd'),
      );
      final t3 = await vocabularyRepository.getWordDetails(
        word: WordObject('8308_4'),
      );

      // assert
      expect(t1.isLeft(), true);
      expect(t1.fold(id, id), isA<VocabularyFailure>());
      expect(t2.isLeft(), true);
      expect(t2.fold(id, id), isA<VocabularyFailure>());
      expect(t3.isLeft(), true);
      expect(t3.fold(id, id), isA<VocabularyFailure>());
    });

    test(
        'should call local data source getWordDetails once to get word details',
        () async {
      // act
      final result = await vocabularyRepository.getWordDetails(
        word: tWordModel.value,
      );

      // assert
      verify(
        localDataSource.getWordDetails(word: "test"),
      ).called(1);
    });

    test('should return a failure when getWordDetails throws an exception',
        () async {
      // arrange

      when(localDataSource.getWordDetails(word: anyNamed('word')))
          .thenThrow(Exception('Unable to get word details'));

      // act
      final res = await vocabularyRepository.getWordDetails(
        word: tWordModel.value,
      );

      // assert
      expect(res.isLeft(), true);
      expect(res.fold(id, id), isA<VocabularyFailure>());
    });

    test('should return a WordDetails when everything goes well', () async {
      // act
      final result = await vocabularyRepository.getWordDetails(
        word: tWordModel.value,
      );

      // assert
      expect(result.isRight(), true);

      expect(result.fold(id, id), isA<WordDetails>());
      expect((result.fold(id, id) as WordDetails).word, tWordDetailsModel.word);
    });
  });

  group("markWordAsShown", () {
    final tWordModel = WordModel(
      value: WordObject('test'),
      definition: "test",
      example: "test",
      isHitWord: false,
    );

    final tWordDetailsModel = WordDetailsModel(
      word: tWordModel,
      timesShown: 0,
      show: false,
      isMemorized: false,
      lastShownDate: DateTime.now(),
    );

    setUp(() {
      when(localDataSource.markWordAsShown(word: anyNamed('word')))
          .thenAnswer((_) async => const SuccessModel());
    });

    test('should return a failure if word is not valid', () async {
      // act
      final t1 = await vocabularyRepository.markWordAsShown(
        word: WordObject(''),
      );

      final t2 = await vocabularyRepository.markWordAsShown(
        word: WordObject('a445dd'),
      );
      final t3 = await vocabularyRepository.markWordAsShown(
        word: WordObject('8308_4'),
      );

      // assert
      expect(t1.isLeft(), true);
      expect(t1.fold(id, id), isA<VocabularyFailure>());
      expect(t2.isLeft(), true);
      expect(t2.fold(id, id), isA<VocabularyFailure>());
      expect(t3.isLeft(), true);
      expect(t3.fold(id, id), isA<VocabularyFailure>());
    });

    test(
        'should call local data source markWordAsShown once to mark word as shown',
        () async {
      // act
      await vocabularyRepository.markWordAsShown(
        word: tWordModel.value,
      );

      // assert
      verify(
        localDataSource.markWordAsShown(word: "test"),
      ).called(1);
    });

    test('should return a failure when markWordAsShown throws an exception',
        () async {
      // arrange

      when(localDataSource.markWordAsShown(word: anyNamed('word')))
          .thenThrow(Exception('Unable to mark word as shown'));

      // act
      final res = await vocabularyRepository.markWordAsShown(
        word: tWordModel.value,
      );

      // assert
      expect(res.isLeft(), true);
      expect(res.fold(id, id), isA<VocabularyFailure>());
    });

    test('should return a SuccessModel when everything goes well', () async {
      // act
      final result = await vocabularyRepository.markWordAsShown(
        word: tWordModel.value,
      );

      // assert
      expect(result.isRight(), true);

      expect(result.fold(id, id), isA<SuccessModel>());
    });
  });

  group("markWordAsToBeRemembered", () {
    final tWordModel = WordModel(
      value: WordObject('test'),
      definition: "test",
      example: "test",
      isHitWord: false,
    );

    final tWordDetailsModel = WordDetailsModel(
      word: tWordModel,
      timesShown: 0,
      show: false,
      isMemorized: false,
      lastShownDate: DateTime.now(),
    );

    setUp(() {
      when(localDataSource.markWordAsToBeRemembered(word: anyNamed('word')))
          .thenAnswer((_) async => const SuccessModel());
    });

    test('should return a failure if word is not valid', () async {
      // act
      final t1 = await vocabularyRepository.markWordAsToBeRemembered(
        word: WordObject(''),
      );

      final t2 = await vocabularyRepository.markWordAsToBeRemembered(
        word: WordObject('a445dd'),
      );
      final t3 = await vocabularyRepository.markWordAsToBeRemembered(
        word: WordObject('8308_4'),
      );

      // assert
      expect(t1.isLeft(), true);
      expect(t1.fold(id, id), isA<VocabularyFailure>());
      expect(t2.isLeft(), true);
      expect(t2.fold(id, id), isA<VocabularyFailure>());
      expect(t3.isLeft(), true);
      expect(t3.fold(id, id), isA<VocabularyFailure>());
    });

    test('should call local data source markWordAsToBeRemembered once',
        () async {
      // act
      await vocabularyRepository.markWordAsToBeRemembered(
        word: tWordModel.value,
      );

      // assert
      verify(
        localDataSource.markWordAsToBeRemembered(word: "test"),
      ).called(1);
    });

    test(
        'should return a failure when markWordAsToBeRemembered throws an exception',
        () async {
      // arrange

      when(localDataSource.markWordAsToBeRemembered(word: anyNamed('word')))
          .thenThrow(Exception('Unable to mark word as to be remembered'));

      // act
      final res = await vocabularyRepository.markWordAsToBeRemembered(
        word: tWordModel.value,
      );

      // assert
      expect(res.isLeft(), true);
      expect(res.fold(id, id), isA<VocabularyFailure>());
    });

    test('should return a Success when everything goes well', () async {
      // act
      final result = await vocabularyRepository.markWordAsToBeRemembered(
        word: tWordModel.value,
      );

      // assert
      expect(result.isRight(), true);

      expect(result.fold(id, id), isA<Success>());
    });
  });

  group("clearWordShowHistory", () {
    final tWordModel = WordModel(
      value: WordObject('test'),
      definition: "test",
      example: "test",
      isHitWord: false,
    );

    final tWordDetailsModel = WordDetailsModel(
      word: tWordModel,
      timesShown: 0,
      show: false,
      isMemorized: false,
      lastShownDate: DateTime.now(),
    );

    setUp(() {
      when(localDataSource.clearWordShowHistory(word: anyNamed('word')))
          .thenAnswer((_) async => const SuccessModel());
    });

    test('should return a failure if word is not valid', () async {
      // act
      final t1 = await vocabularyRepository.clearWordShowHistory(
        word: WordObject(''),
      );

      final t2 = await vocabularyRepository.clearWordShowHistory(
        word: WordObject('a445dd'),
      );
      final t3 = await vocabularyRepository.clearWordShowHistory(
        word: WordObject('8308_4'),
      );

      // assert
      expect(t1.isLeft(), true);
      expect(t1.fold(id, id), isA<VocabularyFailure>());
      expect(t2.isLeft(), true);
      expect(t2.fold(id, id), isA<VocabularyFailure>());
      expect(t3.isLeft(), true);
      expect(t3.fold(id, id), isA<VocabularyFailure>());
    });

    test('should call local data source clearWordShowHistory once', () async {
      // act
      await vocabularyRepository.clearWordShowHistory(
        word: tWordModel.value,
      );

      // assert
      verify(
        localDataSource.clearWordShowHistory(word: "test"),
      ).called(1);
    });

    test(
        'should return a failure when clearWordShowHistory throws an exception',
        () async {
      // arrange

      when(localDataSource.clearWordShowHistory(word: anyNamed('word')))
          .thenThrow(Exception('Unable to clear word show history'));

      // act
      final res = await vocabularyRepository.clearWordShowHistory(
        word: tWordModel.value,
      );

      // assert
      expect(res.isLeft(), true);
      expect(res.fold(id, id), isA<VocabularyFailure>());
    });

    test('should return a Success when everything goes well', () async {
      // act
      final result = await vocabularyRepository.clearWordShowHistory(
        word: tWordModel.value,
      );

      // assert
      expect(result.isRight(), true);

      expect(result.fold(id, id), isA<Success>());
    });
  });
}
