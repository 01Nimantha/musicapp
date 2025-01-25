import 'package:flutter/material.dart';
//import 'package:musicapp/pages/new_page.dart';

//import 'package:musicapp/pages/music_page.dart';
import 'package:musicapp/pages/player_screen.dart';
//import 'package:musicapp/pages/loging_page.dart';
// import 'package:musicapp/pages/sign_up_page.dart';
// import 'package:musicapp/pages/main_page.dart';
// import 'package:musicapp/page.dart';
// import 'package:musicapp/pages/page_test.dart';
// import 'package:musicapp/pages/page_test2.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      // home: PageTest(),
      // // home: PageTest2(),
      // home: MainPage(),
      // home: SignUpPage(),
      //home: LogingPage(),
      title: 'Music App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      // home: const MusicPage(),
      // home: const NewPage(),

      home: const PlayerScreen(
        imageList: [
          "assets/Houdini.jpeg",
          "assets/Houdini.jpeg",
          "assets/Houdini.jpeg",
          "assets/Houdini.jpeg",
          "assets/Houdini.jpeg",
          "assets/Houdini.jpeg",
          "assets/Houdini.jpeg",
          "assets/Houdini.jpeg",
          "assets/Houdini.jpeg",
          "assets/Houdini.jpeg",
          "assets/Houdini.jpeg",
        ],
        songList: [
          "Eminem/Eminem-Houdini.mp3",
          "Eminem/Eminem-The_real_slim_shady.mp3",
          "Eminem/Eminem-Not-Afraid.mp3",
          "Armaan_Malik/Bas_Tujhse_Pyaar_Ho.mp3",
          "Armaan_Malik/Dil_Malanga.mp3",
          "Armaan_Malik/Kya_Yehi_Pyaar_Hai.mp3",
          "Armaan_Malik/Mujhe_Pyaar_Pyaar_Hai.mp3",
          "Sonu_Nigam/Main_Agar_Kahoon.mp3",
          "Sonu_Nigam/Meri_Duniya_Hai.mp3",
          "Sonu_Nigam/Pyaar_Ki_Ek_Kahani.mp3",
          "Sonu_Nigam/Sun_Zara.mp3",
        ],
        artistList: [
          "Eminem1",
          "Eminem2",
          "Eminem3",
          "Armaan_Malik1",
          "Armaan_Malik3",
          "Armaan_Malik3",
          "Armaan_Malik4",
          "Sonu_Nigam1",
          "Sonu_Nigam2",
          "Sonu_Nigam3",
          "Sonu_Nigam4",
        ],
      ),
    );
  }
}
