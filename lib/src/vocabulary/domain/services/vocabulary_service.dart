import 'package:dartz/dartz.dart';
import 'package:gre_vocabulary/src/core/common_domains/entities/success.dart';

import '../core/failures.dart';

abstract class VocabularyServiceFacade {
  Future<Either<VocabularyFailure, Success>> loadAllWordsIntoDb();
}
