import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/word.dart';

part 'word_model.freezed.dart';

@freezed
class WordModel extends Word with _$WordModel {
  const factory WordModel() = _WordModel;
}
