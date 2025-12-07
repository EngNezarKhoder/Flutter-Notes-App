import 'package:flutter/material.dart';

class MyTextFormFieldEmail extends StatelessWidget {
  const MyTextFormFieldEmail(
      {super.key,
      required this.controller,
      required this.validator,
      required this.hintText,
      required this.icon});
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final IconData icon;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle( fontSize: 14),
        prefixIcon: Icon(
          icon,
          color: const Color.fromARGB(255, 41, 120, 185),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide:
                BorderSide(color: const Color.fromARGB(255, 41, 120, 185), width: 1)),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 41, 120, 185), width: 2),
            borderRadius: BorderRadius.circular(10)),
        disabledBorder:
            OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        errorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(10)),
        focusedErrorBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red, width: 2),
            borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
