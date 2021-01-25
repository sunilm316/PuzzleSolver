import 'package:flutter/material.dart';
import 'package:puzzlesolver/Screens/PuzzleScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'B2CFLutter',
        home: PuzzleScreen());
  }
}
