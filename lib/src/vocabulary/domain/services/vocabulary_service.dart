import 'package:dartz/dartz.dart';
import 'package:gre_vocabulary/src/core/common_domains/entities/success.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/entities/word.dart';

import '../../core/constants.dart';
import '../../core/failures.dart';
import '../entities/get_words_response.dart';
import '../entities/word_details.dart';
import '../value_objects/limit.dart';
import '../value_objects/offset.dart';

abstract class VocabularyServiceFacade {
  Future<Either<VocabularyFailure, Success>> loadAllWordsIntoDb();
  Future<Either<VocabularyFailure, GetWordsResponse<Word>>> getAllWords({
    required PaginationLimit limit,
    required PaginationOffSet offset,
  });

  Future<Either<VocabularyFailure, GetWordsResponse<Word>>>
      getAllWordsForSource({
    required PaginationLimit limit,
    required PaginationOffSet offset,
    required WordsListKey source,
  });

  Future<Either<VocabularyFailure, GetWordsResponse<WordDetails>>>
      getAllWordDetails({
    required PaginationLimit limit,
    required PaginationOffSet offset,

    /// words shown times above this threshold will not be shown
    required int shownThreshold,
  });

  Future<Either<VocabularyFailure, WordDetails>> markWordAsMemorized({
    required String word,
  });

  Future<Either<VocabularyFailure, WordDetails>> removeWordFromMemorized({
    required String word,
  });

  Future<Either<VocabularyFailure, GetWordsResponse<WordDetails>>>
      getAllMemorizedWords({
    required int limit,
    required int offset,
  });

  Future<Either<VocabularyFailure, WordDetails>> markWordAsShown({
    required String word,
  });

  Future<Either<VocabularyFailure, WordDetails>> markWordAsNotShown({
    required String word,
  });

  Future<Either<VocabularyFailure, GetWordsResponse<WordDetails>>>
      getAllShownWords({
    required PaginationLimit limit,
    required PaginationOffSet offset,
  });

  Future<Either<VocabularyFailure, WordDetails>> markWordAsToBeRemembered({
    required int word,
  });

  Future<Either<VocabularyFailure, WordDetails>> removeWordFromToBeRemembered({
    required int word,
  });

  Future<Either<VocabularyFailure, GetWordsResponse<WordDetails>>>
      getAllToBeRememberedWords({
    required int limit,
    required int offset,
  });

  Future<Either<VocabularyFailure, GetWordsResponse<WordDetails>>>
      getAllWordsShownToday({
    required int limit,
    required int offset,
  });
}
