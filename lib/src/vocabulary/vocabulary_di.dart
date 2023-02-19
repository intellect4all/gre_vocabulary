import 'dart:developer';

import 'package:csv/csv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gre_vocabulary/src/vocabulary/application/vocabulary_controller.dart';
import 'package:gre_vocabulary/src/vocabulary/application/vocabulary_state.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/vocabulary_domain.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/data_source/isar_local_data_source.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/data_source/local_data_source.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/isar_word_details_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/isar_word_model.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/repository/wordlists_csv_parsers/csv_parser.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:isar/isar.dart';

import 'infrastructure/repository/vocabulary_repository.dart';

final isarProvider = FutureProvider<Isar>(
  (ref) async => await Isar.open(
    [
      IsarWordModelSchema,
      IsarWordDetailsModelSchema,
    ],
    name: "isar_db",
  ),
);

final vocabularyLocalDataSourceProvider =
    FutureProvider<LocalDataSource>((ref) async {
  final isar = await ref.watch(isarProvider.future);
  return IsarLocalDataSource(
    hiveBoxes: DB(generalDataBox: await Hive.openBox("name"), isar: isar),
  );
});

final csvListsParserProvider = Provider<CSVListsParser>(
  (ref) => const CSVListsParserImpl(
    wordsLists: [],
    csvToListConverter: CsvToListConverter(),
  ),
);

final vocabularyServiceFacadeProvider = FutureProvider<VocabularyServiceFacade>(
  (ref) async => VocabularyRepository(
    localDataSource: await ref.watch(vocabularyLocalDataSourceProvider.future),
    csvListsParser: ref.read(csvListsParserProvider),
  ),
);

final vocabularyControllerProvider =
    StateNotifierProvider<VocabularyController, VocabularyState>((ref) {
  final serviceFacade = ref.watch(vocabularyServiceFacadeProvider);
  return serviceFacade.maybeWhen(
    data: (data) {
      return VocabularyController(
        service: data,
      );
    },
    orElse: () {
      log("Thorwing provider error");
      throw Exception("basted");
    },
  );
});
