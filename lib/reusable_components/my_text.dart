import 'package:flutter/material.dart';

class MyText extends StatelessWidget {
  final double fontSize;
  final String data;
  final FontWeight? fontWeight;
  final Color? color;

  const MyText(
      {super.key,
      required this.fontSize,
      required this.data,
      this.fontWeight,
      this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      data,
      style: TextStyle(
          fontSize: fontSize,
          fontWeight: fontWeight ?? FontWeight.normal,
          color: color ?? Colors.black),
    );
  }
}
