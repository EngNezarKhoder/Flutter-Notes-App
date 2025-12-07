import 'package:flutter/material.dart';

class MyTextFormFieldPassword extends StatefulWidget {
  const MyTextFormFieldPassword(
      {super.key,
      required this.controller,
      required this.validator,
      required this.hintText,
      required this.icon,
      required this.obscureText,
      required this.onPressed});
  final TextEditingController controller;
  final String? Function(String?)? validator;
  final String hintText;
  final IconData icon;
  final bool obscureText;
  final void Function()? onPressed;

  @override
  State<MyTextFormFieldPassword> createState() =>
      _MyTextFormFieldPasswordState();
}

class _MyTextFormFieldPasswordState extends State<MyTextFormFieldPassword> {
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: widget.controller,
      validator: widget.validator,
      obscureText: widget.obscureText,
      decoration: InputDecoration(
        hintText: widget.hintText,
        hintStyle: TextStyle(fontSize: 14),
        prefixIcon: Icon(
          widget.icon,
          color: const Color.fromARGB(255, 41, 120, 185),
        ),
        suffixIcon: IconButton(
          icon: Icon(Icons.remove_red_eye),
          onPressed: widget.onPressed,
          color: const Color.fromARGB(255, 41, 120, 185),
        ),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(
                color: const Color.fromARGB(255, 41, 120, 185), width: 1)),
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
