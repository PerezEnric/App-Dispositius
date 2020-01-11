
import 'package:assignment03/songs.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Stream<List<Songs>> getSongs()
{
  return Firestore.instance.collection('songs').snapshots().map(toSongsList);
}