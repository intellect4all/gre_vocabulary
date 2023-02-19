import 'package:csv/csv.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/services.dart';

import '../../../domain/core/failures.dart';
import '../../models/word_model.dart';
import '../words_lists/base_words_list.dart';

abstract class CSVListsParser {
  final List<BaseWordsList> wordsLists;

  const CSVListsParser(
    this.wordsLists,
  );

  Future<Either<VocabularyFailure, List<WordModel>>> parse();

  Future<String> getCsvStringData(String filePath) async {
    return await rootBundle.loadString(filePath);
  }
}

class CSVListsParserImpl extends CSVListsParser {
  final CsvToListConverter csvToListConverter;
  const CSVListsParserImpl({
    required List<BaseWordsList> wordsLists,
    required this.csvToListConverter,
  }) : super(wordsLists);

  @override
  Future<Either<VocabularyFailure, List<WordModel>>> parse() async {
    final words = <WordModel>[];
    for (final wordsList in wordsLists) {
      final rawCsv = await getCsvStringData(wordsList.path);
      final convertedCsv = csvToListConverter.convert(rawCsv);
      final words = wordsList.wordsParser.getWords(
          rawList: convertedCsv, wordsListKey: wordsList.wordsListKey);
      words.addAll(words);
    }

    return right(words);
  }
}
