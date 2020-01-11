import 'package:flutter/material.dart';
import 'SongsPage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyric Cloud',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SongsPage(title: 'Songs Page'),
    );
  }
}
