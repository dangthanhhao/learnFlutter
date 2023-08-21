import 'package:adv_basics/question_summary/question_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(this.selectedAnswers, this.onRestartQuiz, {super.key});

  final List<String> selectedAnswers;
  final void Function() onRestartQuiz;

  List<Map<String, Object>> getQuestionSummary() {
    final List<Map<String, Object>> result = [];
    for (var i = 0; i < selectedAnswers.length; i++) {
      result.add({
        'question_index': i,
        'question': questions[i].text,
        'correct_answer': questions[i].answers[0],
        'user_answer': selectedAnswers[i]
      });
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    final questionSummary = getQuestionSummary();

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'You answer ${questionSummary.where((element) => element['correct_answer'] == element['user_answer']).length} out of ${questionSummary.length} questions correctly!',
              style: GoogleFonts.lato(
                  color: const Color.fromARGB(255, 230, 200, 253),
                  fontSize: 20,
                  fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 30,
            ),
            QuestionSummary(questionSummary),
            const SizedBox(
              height: 30,
            ),
            OutlinedButton.icon(
              label: const Text('Restart Quiz!'),
              icon: const Icon(Icons.restart_alt_sharp),
              onPressed: onRestartQuiz,
              style: OutlinedButton.styleFrom(
                  foregroundColor: Colors.white,
                  side: const BorderSide(width: 1, color: Colors.white),
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30))),
            )
          ],
        ),
      ),
    );
  }
}
