class QuizQuestion {
  final String text;
  final List<String> answers;
  const QuizQuestion(this.text, this.answers);

  List<String> getSufflledAnswers() {
    final result = List.of(answers);
    result.shuffle();
    return result;
  }
}
