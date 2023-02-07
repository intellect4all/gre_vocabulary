import 'dart:developer';

import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/word_model.dart';
import 'package:isar/isar.dart';

part 'isar_word_model.g.dart';

@Collection(accessor: 'words')
class IsarWordModel {
  Id? id;

  String value;
  String definition;
  String example;
  bool isHitWord;
  String source;

  IsarWordModel({
    this.id,
    required this.value,
    required this.definition,
    required this.example,
    required this.isHitWord,
    required this.source,
  });

  static IsarWordModel fromWordModel(WordModel e) {
    log('fromWordModel: ${e}');
    return IsarWordModel(
      value: e.value.getOrCrash(),
      definition: e.definition,
      example: e.example,
      isHitWord: e.isHitWord,
      source: e.source,
    );
  }
}
