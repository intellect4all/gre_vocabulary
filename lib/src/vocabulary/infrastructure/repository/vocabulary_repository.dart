import 'package:dartz/dartz.dart';
import 'package:gre_vocabulary/src/core/common_domains/entities/success.dart';
import 'package:gre_vocabulary/src/core/errors.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/entities/get_words_response.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/entities/word.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/entities/word_details.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/services/vocabulary_service.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/value_objects/word.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/data_source/local_data_source.dart';

import '../../core/constants.dart';
import '../../core/failures.dart';
import '../../domain/value_objects/value_objects.dart';
import 'wordlists_csv_parsers/csv_parser.dart';

class VocabularyRepository implements VocabularyServiceFacade {
  final LocalDataSource _localDataSource;
  final CSVListsParser _csvListsParser;

  const VocabularyRepository({
    required LocalDataSource localDataSource,
    required CSVListsParser csvListsParser,
  })  : _localDataSource = localDataSource,
        _csvListsParser = csvListsParser;
  @override
  Future<Either<VocabularyFailure, Success>> loadAllWordsIntoDb() async {
    // because the words are coming from a csv file,
    // we need to check if the words are already loaded into the db
    // if they are, then we don't need to load them again
    try {
      final areWordsLoaded = await _localDataSource.areWordsLoaded();
      if (areWordsLoaded) {
        return right(const Success(message: 'Words are already loaded'));
      }
      final parsingResponseOrFailure = _csvListsParser.parse();
      final res = parsingResponseOrFailure
          .fold<Future<Either<VocabularyFailure, Success>>>(
        (failure) async => left(failure),
        (parsingResponse) async {
          try {
            await _localDataSource.saveAllWords(parsingResponse.allWords);

            await _localDataSource
                .saveWordsToSource(parsingResponse.wordsToSource);
          } catch (e) {
            return left(
              const VocabularyFailure.unexpected(),
            );
          }
          return right(const Success(message: 'Words are loaded'));
        },
      );
      return res;
    } catch (e) {
      return left(const VocabularyFailure.unexpected());
    }
  }

  @override
  Future<Either<VocabularyFailure, GetWordsResponse<Word>>> getAllWords({
    required PaginationLimit limit,
    required PaginationOffSet offset,
  }) async {
    return _handleValidateValueObjects(
      () async {
        final res = await _localDataSource.getAllWords(
          limit: limit.getOrCrash(),
          offset: offset.getOrCrash(),
        );
        return right(res);
      },
    );
  }

  @override
  Future<Either<VocabularyFailure, GetWordsResponse<Word>>>
      getAllWordsForSource({
    required PaginationLimit limit,
    required PaginationOffSet offset,
    required WordsListKey source,
  }) async {
    return _handleValidateValueObjects(
      () async {
        final res = await _localDataSource.getAllWordsForSource(
          source: source,
          limit: limit.getOrCrash(),
          offset: offset.getOrCrash(),
        );
        return right(res);
      },
    );
  }

  @override
  Future<Either<VocabularyFailure, GetWordsResponse<WordDetails>>>
      getAllWordDetails({
    required PaginationLimit limit,
    required PaginationOffSet offset,
    required int shownThreshold,
  }) async {
    return _handleValidateValueObjects(
      () async {
        return right(
          await _localDataSource.getAllWordDetails(
            limit: limit.getOrCrash(),
            offset: offset.getOrCrash(),
            shownThreshold: shownThreshold,
          ),
        );
      },
    );
  }

  @override
  Future<Either<VocabularyFailure, WordDetails>> getWordDetails({
    required WordObject word,
  }) async {
    return _handleValidateValueObjects(
      () async {
        return right(
          await _localDataSource.getWordDetails(
            word: word.getOrCrash(),
          ),
        );
      },
    );
  }

  @override
  Future<Either<VocabularyFailure, Success>> markWordAsShown({
    required WordObject word,
  }) async {
    return _handleValidateValueObjects(
      () async {
        return right(
          await _localDataSource.markWordAsShown(
            word: word.getOrCrash(),
          ),
        );
      },
    );
  }

  @override
  Future<Either<VocabularyFailure, Success>> markWordAsToBeRemembered(
      {required WordObject word}) async {
    return _handleValidateValueObjects(
      () async {
        return right(
          await _localDataSource.markWordAsToBeRemembered(
            word: word.getOrCrash(),
          ),
        );
      },
    );
  }

  @override
  Future<Either<VocabularyFailure, Success>> clearWordShowHistory({
    required WordObject word,
  }) async {
    return _handleValidateValueObjects(
      () async {
        return right(
          await _localDataSource.clearWordShowHistory(
            word: word.getOrCrash(),
          ),
        );
      },
    );
  }

  @override
  Future<Either<VocabularyFailure, Success>> markWordAsMemorized({
    required WordObject word,
  }) async {
    return _handleValidateValueObjects(
      () async {
        return right(
          await _localDataSource.markWordAsMemorized(
            word: word.getOrCrash(),
          ),
        );
      },
    );
  }

  @override
  Future<Either<VocabularyFailure, Success>> removeWordFromMemorized({
    required WordObject word,
  }) async {
    return _handleValidateValueObjects(
      () async {
        return right(
          await _localDataSource.removeWordFromMemorized(
            word: word.getOrCrash(),
          ),
        );
      },
    );
  }

  @override
  Future<Either<VocabularyFailure, Success>> removeWordFromToBeRemembered(
      {required WordObject word}) {
    // TODO: implement removeWordFromToBeRemembered
    throw UnimplementedError();
  }

  @override
  Future<Either<VocabularyFailure, GetWordsResponse<WordDetails>>>
      getAllMemorizedWords({
    required PaginationLimit limit,
    required PaginationOffSet offset,
  }) async {
    // TODO: implement getAllMemorizedWords
    throw UnimplementedError();
  }

  @override
  Future<Either<VocabularyFailure, GetWordsResponse<WordDetails>>>
      getAllShownWords(
          {required PaginationLimit limit, required PaginationOffSet offset}) {
    // TODO: implement getAllShownWords
    throw UnimplementedError();
  }

  @override
  Future<Either<VocabularyFailure, GetWordsResponse<WordDetails>>>
      getAllToBeRememberedWords(
          {required PaginationLimit limit, required PaginationOffSet offset}) {
    // TODO: implement getAllToBeRememberedWords
    throw UnimplementedError();
  }

  @override
  Future<Either<VocabularyFailure, GetWordsResponse<WordDetails>>>
      getAllWordsShownToday(
          {required PaginationLimit limit, required PaginationOffSet offset}) {
    // TODO: implement getAllWordsShownToday
    throw UnimplementedError();
  }

  Future<Either<VocabularyFailure, T>> _handleValidateValueObjects<T>(
    Future<Either<VocabularyFailure, T>> Function() f,
  ) async {
    try {
      return await f();
    } on UnexpectedValueError catch (e) {
      final res = e.valueFailure.maybeWhen<String>(
        limitExceedMaxWordsFetch: (String message) => message,
        limitNotUpToMinimum: (String message) => message,
        orElse: () => "Unexpected Error",
      );

      return Future.value(left(VocabularyFailure.unexpected(message: res)));
    } catch (e) {
      return left(const VocabularyFailure.unexpected());
    }
  }
}
