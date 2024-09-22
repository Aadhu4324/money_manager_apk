import 'package:flutter/material.dart';
import 'package:personal_money_manager_apk/reusable_components/my_text.dart';

class CustomButton extends StatelessWidget {
  final GestureTapCallback ontap;
  final String name;
  final Color? color;
  CustomButton(
      {super.key, required this.ontap, required this.name, this.color});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: ontap,
      child: Container(
        height: 50,
        width: 150,
        decoration: BoxDecoration(
            color: color ?? const Color.fromARGB(255, 60, 192, 209),
            borderRadius: BorderRadius.circular(20)),
        child: Center(
            child: MyText(
          fontSize: 20,
          data: name,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        )),
      ),
    );
  }
}
