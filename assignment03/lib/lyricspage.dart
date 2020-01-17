
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LyricsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot snp = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text(snp.data["name"]),),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Container(
              width: 70,
              height: 70,
              child: Image.network(snp.data["cover"]),
            ),
            SizedBox(height: 16,),
            Text(snp.data["lyrics"],
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
    );
  }
}