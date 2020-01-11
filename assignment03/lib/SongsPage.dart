import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:assignment03/FavsListPage.dart';

class SongsPage extends StatefulWidget {
  SongsPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _SongsPageState createState() => _SongsPageState();
}

class _SongsPageState extends State<SongsPage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
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
              return ListTile(
                leading: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: Colors.blueGrey,
                  ),
                ),
                title: Text(docs[index].data['name']),
                subtitle: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Text(docs[index].data['artist']),
                    Text(docs[index].data['album']),
                    Text(docs[index].data['time_min'].toString()+':'+docs[index].data['time_sec'].toString()),
                  ],
                ),
              );
            }
          );
        }
      ),
      );
  }
}