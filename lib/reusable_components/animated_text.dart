import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

class AnimatedText extends StatelessWidget {
  final String data;
  final Color color;
  final double fontSize;
  final FontWeight fontWeight;
  const AnimatedText(
      {super.key,
      required this.data,
      required this.color,
      required this.fontSize,
      required this.fontWeight});

  @override
  Widget build(BuildContext context) {
    return AnimatedTextKit(
      animatedTexts: [
        TyperAnimatedText(data,
            textStyle: TextStyle(
                fontSize: fontSize, color: color, fontWeight: fontWeight))
      ],
    );
  }
}
