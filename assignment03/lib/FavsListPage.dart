import 'package:flutter/material.dart';

class FavsListPage extends StatefulWidget{

  final List<Favs> bfavs = List<Favs>();
  @override

  _FavsListPageState createState() => _FavsListPageState();
}

class Favs {
  String what;
  bool done;
  Favs(this.what) : done = false;

  Favs.fromJson(Map<String, dynamic> json)
      : what = json['what'],
        done = json['done'];

  Map<String, dynamic> toJson() => {
        'what': what,
        'done': done,
  };
}

class _FavsListPageState extends State<FavsListPage>{

  @override

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
      ),
      body: ListView.separated(
        separatorBuilder: (contex, index) => Divider(
        thickness: 1,
        height: 1,
        ),
        itemCount: widget.bfavs.length,
        itemBuilder: (context, index){
          return ListTile(
            title: Text(widget.bfavs[index].what),
          );
        },
      ),
    );
  }
}