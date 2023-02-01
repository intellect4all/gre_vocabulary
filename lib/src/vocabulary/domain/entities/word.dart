import 'package:equatable/equatable.dart';

/// this is more like a value object
class Word extends Equatable {
  final String value;
  final String definition;
  final String example;
  final bool isHitWord;

  Word({
    required this.value,
    required this.definition,
    required this.example,
    this.isHitWord = false,
  })  : assert(value.isNotEmpty),
        assert(definition.isNotEmpty);

  @override
  List<Object?> get props => [value, definition, example, isHitWord];
}
