import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class NewPage extends StatefulWidget {
  const NewPage({super.key});

  @override
  State<NewPage> createState() => _NewPageState();
}

class _NewPageState extends State<NewPage> {
  final name = TextEditingController();
  String? imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick image"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.image,
                );
                if (result != null) {
                  setState(() {
                    imagePath = result.files.first.path;
                    name.text = result.files.first.path.toString();
                  });
                }
              },
              child: const Text("Upload file"),
            ),
            Text(name.text),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 90,
              backgroundImage: imagePath != null
                  ? FileImage(File(imagePath!))
                  : const AssetImage("assets/icon.png") as ImageProvider,
            ),
          ],
        ),
      ),
    );
  }
}
