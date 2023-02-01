/// this is more like a value object
class Word {
  final String value;
  final String meaning;
  final String example;
  final bool isHitWord;

  Word({
    required this.value,
    required this.meaning,
    required this.example,
    this.isHitWord = false,
  })  : assert(value.isNotEmpty),
        assert(meaning.isNotEmpty);
}
