import 'package:assignment03/songs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:assignment03/FavsListPage.dart';

class SongsPage extends StatelessWidget {

@override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Songs Page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.favorite),
        onPressed:(){
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context)=>FavsListPage(),
            )
          );
        }
      ),
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
        leading: Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
            color: Colors.blueGrey,
          ),
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