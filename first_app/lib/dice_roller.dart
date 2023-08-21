import 'dart:math';

import 'package:flutter/material.dart';

final randomizer = Random();

class DiceRoller extends StatefulWidget {
  const DiceRoller({
    super.key,
  });

  @override
  State<DiceRoller> createState() => _DiceRollerState();
}

class _DiceRollerState extends State<DiceRoller> {
  void onClick() {
    setState(() {
      currentPicture = randomizer.nextInt(5) + 1;
    });
  }

  var currentPicture = 1;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(
            'assets/images/dice-$currentPicture.png',
            alignment: Alignment.center,
            width: 200,
          ),
          const SizedBox(
            height: 18,
          ),
          TextButton(
            onPressed: onClick,
            style: TextButton.styleFrom(
                foregroundColor: Colors.white,
                // padding: const EdgeInsets.only(top: 30),
                textStyle: const TextStyle(fontSize: 28)),
            child: const Text('Hello world'),
          ),
        ],
      ),
    );
  }
}
