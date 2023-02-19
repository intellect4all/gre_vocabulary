import 'package:freezed_annotation/freezed_annotation.dart';

part 'vocabulary_state.freezed.dart';

@freezed
class VocabularyState with _$VocabularyState {
  const VocabularyState._();
  const factory VocabularyState.initial() = InitialVocabularyState;
  const factory VocabularyState.loading() = LoadingVocabularyState;
  const factory VocabularyState.success({
    required String data,
  }) = SuccessVocabularyState;

  const factory VocabularyState.error({
    required String error,
  }) = ErrorVocabularyState;
}
