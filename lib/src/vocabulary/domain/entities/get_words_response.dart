class GetWordsResponse<T> {
  final List<T> words;
  final int totalWords;
  final int currentPage;
  final int totalPages;
  final int wordsPerPage;

  const GetWordsResponse({
    required this.words,
    required this.totalWords,
    required this.currentPage,
    required this.totalPages,
    required this.wordsPerPage,
  });
}
