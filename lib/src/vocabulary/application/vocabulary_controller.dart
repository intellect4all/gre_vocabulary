import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../domain/vocabulary_domain.dart';
import 'vocabulary_state.dart';

class VocabularyController extends StateNotifier<VocabularyState> {
  final VocabularyServiceFacade _service;
  VocabularyController({
    required VocabularyServiceFacade service,
  })  : _service = service,
        super(const InitialVocabularyState());

  void initDb() async {
    await _service.loadAllWordsIntoDb();
  }
}
