import 'package:dartz/dartz.dart';
import 'package:gre_vocabulary/src/core/common_domains/entities/success.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/core/failures.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/services/vocabulary_service.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/data_source/local_data_source.dart';

import '../wordlists_csv_parsers/csv_parser.dart';

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
      return parsingResponseOrFailure.fold(
        (failure) => left(failure),
        (parsingResponse) async {
          await _localDataSource.saveAllWords(parsingResponse.allWords);
          await _localDataSource
              .saveWordsToSource(parsingResponse.wordsToSource);
          return right(const Success(message: 'Words are loaded'));
        },
      );
    } catch (e) {
      return left(const VocabularyFailure.unexpected());
    }
  }
}
