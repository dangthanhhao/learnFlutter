import 'package:adv_basics/question_screen.dart';
import 'package:adv_basics/results_screen.dart';
import 'package:adv_basics/start_screen.dart';
import 'package:flutter/material.dart';

import 'data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({
    super.key,
  });

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  Widget? currentScreen;
  List<String> selectedAnswers = [];
  void startQuizScreen() {
    setState(() {
      currentScreen = QuestionScreen(onSelectedAnswer: onSelectedAnswer);
    });
  }

  @override
  void initState() {
    currentScreen = StartScreen(startQuizScreen);
    super.initState();
  }

  void onSelectedAnswer(String answer) {
    selectedAnswers.add(answer);
    print('Answer ${selectedAnswers.toString()}');
    if (selectedAnswers.length == questions.length) {
      // selectedAnswers = [];
      setState(() {
        currentScreen = ResultScreen(selectedAnswers, () {
          setState(() {
            selectedAnswers = [];
            currentScreen = StartScreen(startQuizScreen);
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromARGB(255, 48, 0, 100),
                Color.fromARGB(255, 98, 1, 161),
              ],
            ),
          ),
          child: currentScreen,
        ),
      ),
    );
  }
}
