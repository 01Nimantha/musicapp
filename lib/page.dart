import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  final String name;
  const NewPage({super.key, required this.name});

  @override
  State<NewPage> createState() => _PageState();
}

class _PageState extends State<NewPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Music page"),
      ),
      body: Center(
        child: Text(
          widget.name,
          style: const TextStyle(fontSize: 40),
        ),
      ),
    );
  }
}
