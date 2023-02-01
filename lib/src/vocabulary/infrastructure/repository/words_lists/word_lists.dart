import 'package:freezed_annotation/freezed_annotation.dart';

import 'base_words_list.dart';

part 'word_lists.freezed.dart';

@freezed
class WordsList extends BaseWordsList with _$WordsList {
  const factory WordsList.economicsHitList() = _EconomicsWordsList;

  const factory WordsList.grePrepList() = _GrePrepWordsList;

  const factory WordsList.onlinePrepList() = _OnlinePrepWordsList;

  const factory WordsList.manya() = _ManyaWordsList;

  const factory WordsList.manyaPrinceton() = _ManyaPrincetonWordsList;

  const factory WordsList.barrenHitList() = _BarrenHitWordsList;

  const factory WordsList.manyaHitList() = _ManyaHitWordsList;
}
