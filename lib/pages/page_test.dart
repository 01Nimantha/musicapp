import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/pages/page_test_remote.dart'; // Ensure the correct path

class PageTest extends StatefulWidget {
  const PageTest({super.key});

  @override
  State<PageTest> createState() => _PageTestState();
}

class _PageTestState extends State<PageTest> {
  final nameController = TextEditingController();
  Uint8List? imageBytes;
  List<dynamic> images = [];
  Map<String, Uint8List> imageCache = {}; // Cache for fetched images

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pick Image"),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextButton(
              onPressed: () async {
                imageBytes = await PageTestRemote()
                    .getimage(name: "66af02775f50daee50400741");
                if (kDebugMode) {
                  print("Image bytes: $imageBytes");
                }
                setState(() {}); // Refresh the UI to display the new image
              },
              child: const Text("Get Image from MongoDB"),
            ),
            Text(nameController.text),
            const SizedBox(height: 20),
            CircleAvatar(
              radius: 90,
              backgroundImage: imageBytes != null
                  ? MemoryImage(imageBytes!)
                  : const AssetImage("assets/artist.png") as ImageProvider,
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: 250,
              height: 150,
              child: FutureBuilder<Map<String, dynamic>?>(
                future: PageTestRemote().getAllImages(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text('Error: ${snapshot.error}'),
                      ),
                    );
                  }
                  if (!snapshot.hasData || snapshot.data == null) {
                    return const Card(
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text('No images found.'),
                      ),
                    );
                  }

                  final data = snapshot.data!;
                  images = data['images'] as List<dynamic>;

                  return ListView.builder(
                    itemCount: images.length,
                    itemBuilder: (context, index) {
                      final image = images[index];
                      final fileId = image['file_id'];
                      final filename = image['filename'] ?? 'Unknown';

                      if (imageCache.containsKey(fileId)) {
                        return _buildImageCard(imageCache[fileId]!, filename);
                      }

                      return FutureBuilder<Uint8List?>(
                        future: PageTestRemote().getimage(name: fileId),
                        builder: (context, imageSnapshot) {
                          if (imageSnapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
                          }
                          if (imageSnapshot.hasError) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text('Error: ${imageSnapshot.error}'),
                              ),
                            );
                          }
                          if (!imageSnapshot.hasData ||
                              imageSnapshot.data == null) {
                            return const Card(
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Text('No images found.'),
                              ),
                            );
                          }

                          final Uint8List imageData = imageSnapshot.data!;
                          imageCache[fileId] = imageData; // Cache the image
                          return _buildImageCard(imageData, filename);
                        },
                      );
                    },
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildImageCard(Uint8List imageData, String filename) {
    return SizedBox(
      width: 50,
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            radius: 40,
            backgroundImage: MemoryImage(imageData),
          ),
          title: Text(filename),
        ),
      ),
    );
  }
}
