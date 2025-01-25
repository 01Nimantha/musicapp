import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final String name;
  final VoidCallback function;
  const CustomButton({super.key, required this.name, required this.function});

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 53,
      child: TextButton(
        onPressed: widget.function,
        style: ButtonStyle(
          shape: WidgetStatePropertyAll(RoundedRectangleBorder(
            borderRadius:
                BorderRadius.circular(10.0), // Adjust border radius if desired
          )),
          side: const WidgetStatePropertyAll(BorderSide(
            color: Colors.white,
            width: 2,
          )),
        ),
        child: Text(
          widget.name,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
