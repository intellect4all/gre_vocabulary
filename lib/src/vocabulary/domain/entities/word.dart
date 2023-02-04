import 'package:equatable/equatable.dart';
import 'package:gre_vocabulary/src/vocabulary/domain/value_objects/word.dart';

/// this is more like a value object
class Word extends Equatable {
  final WordObject value;
  final String definition;
  final String example;
  final bool isHitWord;

  Word({
    required this.value,
    required this.definition,
    required this.example,
    this.isHitWord = false,
  }) : assert(definition.isNotEmpty);

  @override
  List<Object?> get props => [value, definition, example, isHitWord];
}
