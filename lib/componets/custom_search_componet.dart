import 'package:flutter/material.dart';

class CustomSearchComponet extends StatelessWidget {
  const CustomSearchComponet({super.key});

  @override
  Widget build(BuildContext context) {
    return const TextField(
      decoration: InputDecoration(
          hintText: "Search...",
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(60.0)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(60.0)),
            borderSide: BorderSide(
              color: Color.fromARGB(255, 0, 0, 0),
            ),
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10.0)),
          ),
          prefixIcon: Icon(Icons.search)),
    );
  }
}
