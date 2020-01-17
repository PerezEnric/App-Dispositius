import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:io';


class SongsPage extends StatelessWidget {

@override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Songs Page'),
      ),
      floatingActionButton: SpeedDial(
        marginRight: 20,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22),
        closeManually: true,
        curve: Curves.bounceIn,
        overlayColor: Colors.black,
        overlayOpacity: 0.5,
        onOpen: ()=> print('opening'),
        onClose: ()=> print('closing'),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 10,
        children: [
          SpeedDialChild(
            child: Icon(Icons.favorite),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            onTap:(){
              Navigator.of(context).pushNamed('/favs');
             },
          ),
          SpeedDialChild(
            child: Icon(Icons.close),
            foregroundColor: Colors.white,
            backgroundColor: Colors.yellow,
            onTap:()=>exit(0),
          )
        ],
      ),
      
      /*FloatingActionButton(
        child: Icon(Icons.favorite),
        foregroundColor: Colors.white,
        backgroundColor: Colors.red,
        onPressed:(){
          Navigator.of(context).pushNamed('/favs');
        }
      ),*/
      body: StreamBuilder(
        stream: Firestore.instance.collection('Songs').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          List<DocumentSnapshot> docs = snapshot.data.documents;
          return ListView.separated(
            itemCount: docs.length,
            separatorBuilder: (context, index){
              return Divider(
                height: 1,
                indent: 15,
                endIndent: 15,
              );
            },
            itemBuilder: (context, index){
              return SongsTile(docs[index]);
            }
          );
        }
      ),
    );
  }
}

class SongsTile extends StatelessWidget {
  final DocumentSnapshot snpsht;
  SongsTile(this.snpsht);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: (){
        Navigator.of(context).pushNamed('/lyrics', arguments: snpsht);
      },
      onLongPress: (){
        Firestore.instance.collection('favs').document().setData({
          'name': snpsht.data['name'],
          'artist': snpsht.data['artist'],
          'album': snpsht.data['album'],
          'time_min': snpsht.data['time_min'],
          'time_sec': snpsht.data['time_sec'],
          'cover': snpsht.data['cover']
        });
        final sb = SnackBar(
          content: Text('Song added to Favourites'),
        );
        Scaffold.of(context).showSnackBar(sb);
      },
        leading: Container(
            width: 45,
            height: 45,
            child: Image.network(snpsht.data['cover']),
        ),
      title: Text(snpsht.data['name']),
      subtitle: Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Text(snpsht.data['artist']),
        Text(snpsht.data['album']),
        Text(snpsht.data['time_min'].toString()+':'+snpsht.data['time_sec'].toString()),
       ],
      ),
    );
  }
}