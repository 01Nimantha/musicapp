import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:musicapp/componets/custom_search_componet.dart';
import 'package:musicapp/page.dart';
import 'package:musicapp/pages/main_remote.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Discover",
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: const [
          SizedBox(width: 250, height: 45, child: CustomSearchComponet()),
          SizedBox(
            width: 6,
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: FutureBuilder(
          future: MainRemote().singer(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            if (snapshot.hasError) {
              if (kDebugMode) {
                print(snapshot.hasError);
              }
            }
            final List data = snapshot.data;
            if (kDebugMode) {
              print(data);
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // const Text(
                //   "Create your music list",
                //   style: TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //   ),
                // ),
                // Expanded(
                //   child: ListView.builder(
                //     scrollDirection: Axis.horizontal,
                //     itemCount: 3,
                //     itemBuilder: (context, index) {
                //       return const Padding(
                //         padding: EdgeInsets.all(8.0),
                //         child: Chip(
                //             label: SizedBox(
                //           width: 120,
                //           height: 120,
                //           child: Column(
                //             children: [
                //               Text("List"),
                //             ],
                //           ),
                //         )),
                //       );
                //     },
                //   ),
                // ),

                const Text(
                  "Artists",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: 150,
                  width: double.infinity,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: NetworkImage(
                                    data[index]["Picture_Location"]),
                              ),
                            ),
                            Text(data[index]["Singer_Name"])
                          ],
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text(
                  "songs",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: 5,
                    itemBuilder: (context, index) {
                      final count = index + 1;
                      return Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: GestureDetector(
                          onTap: () {
                            if (kDebugMode) {
                              print(count);
                            }
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => NewPage(name: "$count"),
                                ));
                          },
                          child: Chip(
                            label: ListTile(
                              leading: const CircleAvatar(
                                radius: 30,
                                backgroundImage:
                                    AssetImage("assets/artist.png"),
                              ),
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.more_vert)),
                              title: Text("Song name $count"),
                              subtitle: const Text("Artist name"),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            );
          },
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                const ListTile(
                  leading: CircleAvatar(
                    child: Image(image: AssetImage("assets/artist.png")),
                  ),
                  title: Text("User name"),
                ),
                GestureDetector(
                  onTap: () {
                    if (kDebugMode) {
                      print("Home");
                    }
                  },
                  child: const ListTile(
                    leading: Icon(
                      Icons.home_outlined,
                      size: 27,
                    ),
                    title: Text("Home"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (kDebugMode) {
                      print("About us");
                    }
                  },
                  child: const ListTile(
                    leading: Icon(Icons.people_alt_outlined),
                    title: Text("About us"),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (kDebugMode) {
                      print("Feedback");
                    }
                  },
                  child: const ListTile(
                    leading: Icon(Icons.feedback),
                    title: Text("Feedback"),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () {
                    if (kDebugMode) {
                      print("Setting");
                    }
                  },
                  child: const ListTile(
                    leading: Icon(Icons.settings_outlined),
                    title: Text("Setting"),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                    border: Border(top: BorderSide(color: Colors.grey)),
                  ),
                  child: GestureDetector(
                    onTap: () {
                      if (kDebugMode) {
                        print("Exit");
                      }
                    },
                    child: const ListTile(
                      leading: Icon(Icons.exit_to_app),
                      title: Text("Exit"),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
