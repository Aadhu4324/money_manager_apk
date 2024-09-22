import 'package:flutter/material.dart';

class CustomFormField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final TextInputType? type;

  const CustomFormField({
    super.key,
    required this.controller,
    required this.hintText,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: TextFormField(
        keyboardType: type ?? TextInputType.emailAddress,
        controller: controller,
        validator: (value) {
          return value!.isEmpty ? "Please Enter ${hintText}" : null;
        },
        decoration: InputDecoration(
            hintText: hintText,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(
                0,
              ),
            ),
            enabledBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
            focusedBorder:
                OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
      ),
    );
  }
}
