import '../../domain/entities/word.dart';

class WordModel extends Word {
  WordModel({
    required super.value,
    required super.definition,
    required super.example,
    super.isHitWord = false,
  });

  factory WordModel.fromJson(Map<String, dynamic> json) {
    return WordModel(
      value: json['value'],
      definition: json['definition'],
      example: json['example'] ?? '',
      isHitWord: json['isHitWord'] ?? false,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'definition': definition,
      'example': example,
      'isHitWord': isHitWord,
    };
  }
}
