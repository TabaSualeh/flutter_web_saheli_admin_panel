import 'package:flutter/material.dart';

import '../../../../constants.dart';

class LoginTextField extends StatelessWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final bool readOnly;
  final ValueChanged<String>? onSubmitted;
  final TextInputType? textInputType;

  const LoginTextField({super.key, required this.hintText, required this.icon, required this.controller, required this.readOnly, this.onSubmitted, this.textInputType});

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      style: const TextStyle(color: Colors.white),
      textInputAction: TextInputAction.done,
      keyboardType: textInputType,
      readOnly: readOnly,
      onSubmitted: onSubmitted, // 👈 ENTER key callback

      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.white54),
        prefixIcon: Icon(icon, color: Colors.white54),
        filled: true,
        fillColor: bgColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
