import 'package:flutter/material.dart';
// import 'package:musicapp/page.dart';
// import 'package:musicapp/pages/page_test.dart';
import 'package:musicapp/pages/page_test2.dart';

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
      home: PageTest2(),
    );
  }
}
