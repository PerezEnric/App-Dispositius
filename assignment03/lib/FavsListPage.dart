import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'dart:io';


class FavsListPage extends StatelessWidget{

  @override

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Lyrics'),
        backgroundColor: Colors.red,
      ),
      floatingActionButton: SpeedDial(
        marginRight: 20,
        marginBottom: 20,
        animatedIcon: AnimatedIcons.menu_close,
        animatedIconTheme: IconThemeData(size: 22),
        closeManually: false,
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
            child: Icon(Icons.close),
            foregroundColor: Colors.white,
            backgroundColor: Colors.red,
            onTap:()=>exit(0),
          )
        ],
      ),
      body: StreamBuilder(
        stream: Firestore.instance.collection('favs').snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return Center(
              child: Text('There are no favourite songs yet!'),
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
              return FavsTile(docs[index]);
            },
          );
        }
      ),
    );
  }
}

class FavsTile extends StatelessWidget {
  final DocumentSnapshot snpsht;
  FavsTile(this.snpsht);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onLongPress: (){
        Firestore.instance.collection('favs').document(snpsht.documentID).delete();
        final sb = SnackBar(
          content: Text('Song deleted from Favourites'),
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