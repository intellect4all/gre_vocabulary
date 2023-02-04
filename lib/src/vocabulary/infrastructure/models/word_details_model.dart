import 'package:gre_vocabulary/src/vocabulary/infrastructure/models/word_model.dart';

import '../../domain/entities/word_details.dart';

class WordDetailsModel extends WordDetails {
  const WordDetailsModel({
    required super.word,
    required super.timesShown,
    required super.show,
    required super.isMemorized,
    required super.lastShownDate,
  });

  factory WordDetailsModel.fromJson(Map<String, dynamic> json) {
    return WordDetailsModel(
      word: WordModel.fromJson(json['word'] as Map<String, dynamic>),
      timesShown: json['timesShown'] as int,
      show: json['show'] as bool,
      isMemorized: json['isMemorized'] as bool,
      lastShownDate: DateTime.parse(json['lastShownDate'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'word': word,
      'timesShown': timesShown,
      'show': show,
      'isMemorized': isMemorized,
      'lastShownDate': lastShownDate,
    };
  }
}
