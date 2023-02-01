import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class VocabularyFailure with _$VocabularyFailure {
  const VocabularyFailure._();
  const factory VocabularyFailure.unexpected() = _Unexpected;
  const factory VocabularyFailure.unableToParseCSV() = _UnableToParseCSV;
}
