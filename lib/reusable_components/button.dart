import 'package:flutter/material.dart';
import 'package:personal_money_manager_apk/reusable_components/my_text.dart';

class Button extends StatelessWidget {
  final Color color;
  final Color boxcolor;
  final GestureTapCallback onTap;

  final String data;

  const Button(
      {super.key,
      required this.color,
      required this.data,
      required this.boxcolor,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return InkWell(
      onTap: onTap,
      child: Container(
        width: size.width * 0.90,
        height: size.height * 0.15,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          color: boxcolor,
        ),
        child: Center(
            child: MyText(
          fontSize: size.height * 0.04,
          data: data,
          color: color,
          fontWeight: FontWeight.bold,
        )),
      ),
    );
  }
}
