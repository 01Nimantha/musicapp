import 'dart:io';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/componets/custom_button.dart';
import 'package:musicapp/pages/add_singer.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

class MusicPage extends StatefulWidget {
  const MusicPage({super.key});

  @override
  State<MusicPage> createState() => _MusicPageState();
}

class _MusicPageState extends State<MusicPage> {
  final nameController = TextEditingController();
  final urlController = TextEditingController();
  final isClicked = TextEditingController();
  String musicUrl = '';
  String musicName = '';
  String? imagePath;

  @override
  void dispose() {
    nameController.dispose();
    urlController.dispose();
    super.dispose();
  }

  final AudioPlayer _audioPlayer = AudioPlayer();
  String? _filePath;

  Future<void> _pickAndSaveFile() async {
    // Pick the audio file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.audio,
    );

    if (result != null) {
      // Get the path of the selected file
      String? selectedFilePath = result.files.single.path;

      if (selectedFilePath != null) {
        // Get the app's document directory
        Directory appDocDir = await getApplicationDocumentsDirectory();

        // Copy the selected file to the app's document directory
        String newFilePath = '${appDocDir.path}/${result.files.single.name}';
        File(selectedFilePath).copy(newFilePath).then((_) {
          setState(() {
            _filePath = newFilePath;
          });
        });
      }
    }
  }

  Future<void> _playAudio() async {
    if (_filePath != null) {
      // Play the audio file from the saved path
      await _audioPlayer.play(DeviceFileSource(
          "/data/user/0/com.example.musicapp/app_flutter/Eminem-Not-Afraid.mp3"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Add Music Page"),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          // Make the content scrollable
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: Stack(
                  children: [
                    Positioned(
                      child: CircleAvatar(
                        radius: 80,
                        backgroundImage: imagePath != null
                            ? FileImage(File(imagePath!))
                            : const AssetImage("assets/icon.png")
                                as ImageProvider,
                      ),
                    ),
                    Positioned(
                      left: 110,
                      top: 110,
                      child: IconButton(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.image,
                          );
                          if (result != null) {
                            setState(() {
                              imagePath = result.files.first.path;
                            });
                          }
                        },
                        icon: const Icon(
                          Icons.add_photo_alternate_outlined,
                          size: 40,
                          color: Colors.black,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                autofocus: true,
                controller: nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter music Name',
                  hintStyle: TextStyle(color: Colors.black),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    borderSide: BorderSide(
                      color: Colors.black,
                    ),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10.0)),
                  ),
                  prefixIcon: Icon(
                    Icons.person,
                    color: Colors.black,
                    size: 32,
                  ),
                ),
                onSubmitted: (String value) {
                  setState(() {
                    musicName = nameController.text;
                  });
                },
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickAndSaveFile,
                child: const Text("Pick and Save Audio File"),
              ),
              const SizedBox(height: 20),
              Text(_filePath != null ? _filePath! : "No file selected"),
              Text(imagePath != null ? imagePath! : "No image selected"),
              ElevatedButton(
                onPressed: _playAudio,
                child: const Text("Play Saved Audio"),
              ),
              const SizedBox(height: 20),
              const Text(
                "Select Your Singer",
                style: TextStyle(
                  fontFamily: "Roboto",
                  fontSize: 20,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                height: 100,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: 9,
                  itemBuilder: (context, index) {
                    return SizedBox(
                      width: 125,
                      child: GestureDetector(
                        onTap: () {
                          setState(() {
                            isClicked.text = index.toString();
                          });
                          if (kDebugMode) {
                            print(isClicked.text);
                          }
                        },
                        child: Card(
                          color: (isClicked.text == index.toString())
                              ? Colors.blue.shade200
                              : Colors.black,
                          child: Column(
                            children: [
                              const SizedBox(height: 10),
                              const CircleAvatar(
                                radius: 30,
                                backgroundImage: NetworkImage(
                                  "https://variety.com/wp-content/uploads/2022/07/Armaan-Malik.jpg?w=1000&h=564&crop=1&resize=681%2C383",
                                ),
                              ),
                              Text(
                                "Singer Name",
                                style: TextStyle(
                                  color: (isClicked.text == index.toString())
                                      ? Colors.black
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              CustomButton(
                name: "Add Singer",
                function: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SingerSelect(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
