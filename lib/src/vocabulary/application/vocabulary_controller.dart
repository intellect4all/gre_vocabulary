import 'dart:developer';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/data_source/db_keys.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../domain/vocabulary_domain.dart';
import 'vocabulary_state.dart';

class VocabularyController extends StateNotifier<VocabularyState> {
  final VocabularyServiceFacade _service;
  VocabularyController({
    required VocabularyServiceFacade service,
  })  : _service = service,
        super(const InitialVocabularyState());

  Future<void> init() async {
    log("init");
    final box = await Hive.openBox(DBKeys.generalBox);
    await box.clear();
    await _service.loadAllWordsIntoDb();
  }

  Future<void> searchWord(String text) async {
    log("searchWord: $text");
    final result = await _service.searchWord(text);
    result.fold(
      (failure) => state = SearchErrorVocabularyState(
        error: failure.maybeWhen(
          orElse: () => "Something went wrong",
          unexpected: (message) => message,
        ),
      ),
      (words) => state = SearchSuccessVocabularyState(words: words),
    );
  }

  void clearSearch() {
    state = const SearchSuccessVocabularyState(words: []);
  }
}
