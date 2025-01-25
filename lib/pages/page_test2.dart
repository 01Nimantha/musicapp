import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class PageTest2 extends StatefulWidget {
  const PageTest2({super.key});

  @override
  State<PageTest2> createState() => _PageTest2State();
}

class _PageTest2State extends State<PageTest2> {
  @override
  Widget build(BuildContext context) {
    final name = TextEditingController();
    final age = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        title: const Text("Test 2"),
      ),
      body: Column(
        children: [
          TextField(
            controller: name,
            decoration: const InputDecoration(
              hintText: "Enter name",
            ),
          ),
          TextField(
            controller: age,
            decoration: const InputDecoration(
              hintText: "Enter age",
            ),
          ),
          GestureDetector(
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles();
              if (result != null) {
                File file = File(result.files.single.path!);
                if (kDebugMode) {
                  print(file);
                }
              } else {
                // User canceled the picker
              }
            },
            child: const SizedBox(
              width: 250,
              height: 250,
              child: Card(
                child: Icon(Icons.image),
              ),
            ),
          ),
          OutlinedButton(
              onPressed: () {
                if (kDebugMode) {
                  print(name.text);
                  print(age.text);
                }
              },
              child: const Text("Upload to Database"))
        ],
      ),
    );
  }
}
