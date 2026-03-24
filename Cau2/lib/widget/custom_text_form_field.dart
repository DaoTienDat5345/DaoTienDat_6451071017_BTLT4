import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final bool obscureText;
  final String? Function(String?)? validator;
  final void Function(String)? onChanged;

  CustomTextFormField({
    required this.controller,
    required this.label,
    this.obscureText = false,
    this.validator,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      validator: validator,
      onChanged: onChanged,
      decoration: InputDecoration(
        labelText: label,
        border: OutlineInputBorder(),
      ),
    );
  }
}
