
import 'package:cloud_firestore/cloud_firestore.dart';

class Songs
{
  String id;
  String name;
  String album;
  String artist;
  String cover;
  int timeMin;
  int timeSec;

  Songs.fromFirestore(DocumentSnapshot doc)
  : id = doc.documentID,
    name = doc.data['name'],
    album = doc.data['album'],
    artist = doc.data['artist'],
    timeMin = doc.data['time_min'],
    timeSec = doc.data['time_sec'],
    cover = doc.data['cover'];
}

List<Songs> toSongsList(QuerySnapshot query)
{
  return query.documents.map((doc) => Songs.fromFirestore(doc)).toList();
}