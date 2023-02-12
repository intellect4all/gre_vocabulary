import 'package:isar/isar.dart';

import 'word_details_model.dart';

part 'isar_word_details_model.g.dart';

@Collection(accessor: 'wordDetails')
class IsarWordDetailsModel {
  Id? id;

  // we don't need to store the word itself, because we can get it from the wordId
  @Index()
  String word;

  int shownCount;
  bool show;
  bool isMemorized;
  DateTime lastShownDate;

  IsarWordDetailsModel({
    required this.id,
    required this.word,
    required this.shownCount,
    required this.show,
    required this.isMemorized,
    required this.lastShownDate,
  });

  IsarWordDetailsModel.fresh({
    required this.id,
    required this.word,
  })  : shownCount = 1,
        show = true,
        isMemorized = false,
        lastShownDate = DateTime.now();

  static IsarWordDetailsModel fromWordDetailsModel(WordDetailsModel e) {
    return IsarWordDetailsModel(
      id: e.word.id,
      word: e.word.value.getOrCrash(),
      shownCount: e.shownCount,
      show: e.show,
      isMemorized: e.isMemorized,
      lastShownDate: e.lastShownDate,
    );
  }

  IsarWordDetailsModel copyWith({
    String? word,
    int? shownCount,
    bool? show,
    bool? isMemorized,
    DateTime? lastShownDate,
  }) {
    return IsarWordDetailsModel(
      word: word ?? this.word,
      shownCount: shownCount ?? this.shownCount,
      show: show ?? this.show,
      isMemorized: isMemorized ?? this.isMemorized,
      lastShownDate: lastShownDate ?? this.lastShownDate,
      id: id,
    );
  }
}
