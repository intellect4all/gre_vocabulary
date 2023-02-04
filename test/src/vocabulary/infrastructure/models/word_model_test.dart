import 'package:flutter_test/flutter_test.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/entities/word.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/value_objects/word.dart';
import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/word_model.dart';

void main() {
  final tWordModel = WordModel(
    value: WordObject("test"),
    definition: "test definition",
    example: "test example",
    isHitWord: true,
  );

  final tWordModelJson = {
    "value": "test",
    "definition": "test definition",
    "example": "test example",
    "isHitWord": true,
  };

  final tWordModel2 = WordModel(
    value: WordObject("test 2"),
    definition: "test definition 2",
    example: "test example 2",
    isHitWord: false,
  );

  final tWordModelJson2 = {
    "value": "test 2",
    "definition": "test definition 2",
    "example": "test example 2",
    "isHitWord": false,
  };

  test('should be a subclass of Word entity', () async {
    // assert
    expect(tWordModel, isA<Word>());
  });

  group('fromJson', () {
    test('should return a valid model when the JSON is valid', () async {
      // act
      final result = WordModel.fromJson(tWordModelJson);
      // assert
      expect(result, tWordModel);
    });

    test('should return a valid model when the JSON is valid', () async {
      // act
      final result = WordModel.fromJson(tWordModelJson2);
      // assert
      expect(result, tWordModel2);
    });
  });
}
