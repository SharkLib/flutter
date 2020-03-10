
import 'package:flutter/cupertino.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';

class CloudStorePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CloudStaorePageState();
  }
  
}

class CloudStaorePageState extends State<CloudStorePage>
{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        body:
        StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection('MyGit').snapshots(),

      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError)
          return new Text('Error: ${snapshot.error}');
        switch (snapshot.connectionState) {
          case ConnectionState.waiting: return new Text('Loading...');
          default:
            return new ListView(
              children: snapshot.data.documents.map((DocumentSnapshot document) {
                return new ListTile(
                  title: new Text(document['value'].toString()),
                  subtitle: new Text(document.documentID),
                );
              }).toList(),
            );
        }
      },
    )
    );


  }

}