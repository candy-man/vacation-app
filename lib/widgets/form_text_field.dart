import 'package:flutter/material.dart';
import '../shared/constants.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final bool obscureText;

  const CustomTextField(
      {super.key,
      required this.hintText,
      required this.obscureText,
      required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 10.0),
      child: TextFormField(
        validator: (val) => val!.isEmpty ? 'Input text required' : null,
        controller: controller,
        obscureText: obscureText,
        decoration: textInputDecoration.copyWith(hintText: hintText),
      ),
    );
  }
}
