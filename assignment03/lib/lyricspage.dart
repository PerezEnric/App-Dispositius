
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class LyricsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot snp = ModalRoute.of(context).settings.arguments;
    return Scaffold(
      appBar: AppBar(title: Text(snp.data["name"]),),
    );
  }
}