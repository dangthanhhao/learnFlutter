import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary(this.questionSummary, {super.key});
  final List<Map<String, Object>> questionSummary;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          children: [
            ...questionSummary.map(
              (e) => SummaryItem(e),
            )
          ],
        ),
      ),
    );
  }
}

class SummaryItem extends StatelessWidget {
  const SummaryItem(
    this.data, {
    super.key,
  });
  final Map<String, Object> data;
  @override
  Widget build(BuildContext context) {
    final isCorrectAnswer = data['user_answer'] == data['correct_answer'];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 30,
            height: 30,
            alignment: Alignment.center,
            decoration: BoxDecoration(
                color: isCorrectAnswer
                    ? const Color.fromARGB(255, 150, 198, 241)
                    : const Color.fromARGB(255, 249, 133, 241),
                borderRadius: BorderRadius.circular(100)),
            child: Text(
              ((data['question_index'] as int) + 1).toString(),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 22, 2, 56),
              ),
            ),
          ),
          const SizedBox(
            width: 20,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  data['question'] as String,
                  style: GoogleFonts.lato(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  data['user_answer'] as String,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 202, 171, 252),
                  ),
                ),
                Text(
                  data['correct_answer'] as String,
                  style: const TextStyle(
                    color: Color.fromARGB(255, 181, 254, 246),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
