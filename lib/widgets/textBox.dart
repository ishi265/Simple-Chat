import 'package:flutter/material.dart';

class TextBoxItem extends StatelessWidget {
  final String hintText;
  final bool obscureText;
  final TextEditingController controller;

  const TextBoxItem(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
          border: const OutlineInputBorder(), labelText: hintText),
      controller: controller,
      obscureText: obscureText,
    );
  }
}
