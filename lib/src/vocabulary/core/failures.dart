import 'package:freezed_annotation/freezed_annotation.dart';

part 'failures.freezed.dart';

@freezed
class VocabularyFailure with _$VocabularyFailure {
  const VocabularyFailure._();
  const factory VocabularyFailure.unexpected({
    @Default('Some error occurred') String message,
  }) = _UnexpectedFailure;
  const factory VocabularyFailure.unableToParseCSV() = _UnableToParseCSVFailure;
  const factory VocabularyFailure.valueError({
    required String message,
  }) = _VocabularyValueError;
}
