import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class StartScreen extends StatelessWidget {
  final void Function() changeScreen;

  const StartScreen(this.changeScreen, {super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/quiz-logo.png',
            width: 300,
            color: const Color.fromARGB(150, 255, 255, 255),
          ),
          //  Opacity(
          //   opacity: 0.8,
          //   child: Image.asset(
          //     'assets/images/quiz-logo.png',
          //     width: 300,
          //   ),
          // ),
          const SizedBox(
            height: 64,
          ),
          Text(
            'Learn Flutter the fun way!',
            style: GoogleFonts.lato(
              color: const Color.fromARGB(255, 237, 223, 252),
              fontSize: 24,
            ),
          ),
          const SizedBox(
            height: 48,
          ),
          OutlinedButton.icon(
            label: const Text('Start Quiz'),
            icon: const Icon(Icons.arrow_right_alt),
            onPressed: changeScreen,
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.white),
              foregroundColor: Colors.white,
            ),
          )
        ],
      ),
    );
  }
}
