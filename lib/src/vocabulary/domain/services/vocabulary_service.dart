import 'package:dartz/dartz.dart';
import 'package:gre_vocabulary/src/core/common_domains/entities/success.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/entities/word.dart';

import '../core/constants.dart';
import '../core/failures.dart';
import '../entities/get_words_response.dart';
import '../entities/word_details.dart';

abstract class VocabularyServiceFacade {
  Future<Either<VocabularyFailure, Success>> loadAllWordsIntoDb();
  Future<Either<VocabularyFailure, GetWordsResponse<Word>>> getAllWords({
    required int limit,
    required int offset,
  });

  Future<Either<VocabularyFailure, GetWordsResponse<Word>>>
      getAllWordsForSource({
    required int limit,
    required int offset,
    required WordsListKey source,
  });

  Future<Either<VocabularyFailure, GetWordsResponse<WordDetails>>>
      getAllWordDetails({
    required int limit,
    required int offset,

    /// words shown times above this threshold will not be shown
    required int shownThreshold,
  });

  Future<Either<VocabularyFailure, WordDetails>> markWordAsMemorized({
    required int word,
  });

  Future<Either<VocabularyFailure, WordDetails>> removeWordFromMemorized({
    required int word,
  });

  Future<Either<VocabularyFailure, GetWordsResponse<WordDetails>>>
      getAllMemorizedWords({
    required int limit,
    required int offset,
  });

  Future<Either<VocabularyFailure, WordDetails>> markWordAsShown({
    required int word,
  });

  Future<Either<VocabularyFailure, WordDetails>> markWordAsNotShown({
    required int word,
  });

  Future<Either<VocabularyFailure, GetWordsResponse<WordDetails>>>
      getAllShownWords({
    required int limit,
    required int offset,
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
