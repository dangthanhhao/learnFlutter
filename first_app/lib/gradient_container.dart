import 'package:flutter/material.dart';

import 'dice_roller.dart';

const topLeftAlign = Alignment.topLeft;
const bottomRightAlign = Alignment.bottomRight;

class GradientContainer extends StatelessWidget {
  const GradientContainer(this.colors, {super.key});
  const GradientContainer.defaultInit({super.key})
      : colors = const [Colors.black, Colors.blue];

  final List<Color> colors;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: colors,
          begin: topLeftAlign,
          end: bottomRightAlign,
        ),
      ),
      child: const DiceRoller(),
    );
  }
}
