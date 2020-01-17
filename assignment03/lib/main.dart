import 'package:assignment03/FavsListPage.dart';
import 'package:flutter/material.dart';
import 'SongsPage.dart';
import 'lyricspage.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Lyric Cloud',
      theme: ThemeData.dark(),
      //home: SongsPage(title: 'Songs Page'),
      initialRoute: '/',
      routes: {
        '/': (_) => SongsPage(),
        '/lyrics': (_) => LyricsPage(),
        '/favs': (_) => FavsListPage(),
      },
    );
  }
}
