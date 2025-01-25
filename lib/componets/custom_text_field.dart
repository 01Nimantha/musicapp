import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintTextValue;
  final IconData iconValue;
  final TextEditingController controller;
  final bool isobscureText;
  const CustomTextField(
      {super.key,
      required this.hintTextValue,
      required this.iconValue,
      required this.controller,
      this.isobscureText = false});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: TextField(
        obscureText: widget.isobscureText,
        controller: widget.controller,
        style: const TextStyle(color: Colors.white),
        decoration: InputDecoration(
          hintText: widget.hintTextValue,
          hintStyle: const TextStyle(color: Colors.white),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
            borderSide: BorderSide(
              color: Colors.white,
            ),
          ),
          border: const OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          prefixIcon: Icon(
            widget.iconValue,
            color: Colors.white,
            size: 32,
          ),
        ),
      ),
    );
  }
}
