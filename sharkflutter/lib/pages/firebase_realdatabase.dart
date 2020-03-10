import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//this is demo for realtime database

class FBDatabasePage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return FBDatabasePageState();
  }

}

class FBDatabasePageState extends State<FBDatabasePage>
{
  final databaseReference = FirebaseDatabase.instance.reference();
  final DatabaseReference _counterRef = FirebaseDatabase.instance.reference().child('MySkill');
  //_counterRef = FirebaseDatabase.instance.reference().child('MySkill');
  var dd = FirebaseDatabase.instance.reference();



  @override
  Widget build(BuildContext context) {
    getData();
    return Scaffold(
      appBar: AppBar(
        title: Text('Firebase Connect'),
      ),
      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[

              RaisedButton(
                child: Text('Create Record'),
                onPressed: () {
                  createRecord();
                },
              ),

              RaisedButton(
                child: Text('View Record'),
                onPressed: () {
                  getData();
                },
              ),
              RaisedButton(
                child: Text('Udate Record'),
                onPressed: () {
                  updateData();
                },
              ),
              RaisedButton(
                child: Text('Delete Record'),
                onPressed: () {
                  deleteData();
                },
              ),
            ],
          )
      ), //center
    );
  }

  void createRecord(){
    databaseReference.child("1").set({
      'Name': 'Mastering EJB',
      'Version': 'Programming Guide for J2EE'
    });
    databaseReference.child("2").set({
      'title': 'Flutter in Action',
      'description': 'Complete Programming Guide to learn Flutter'
    });
  }
  void getData(){


    print("key:---${databaseReference.once()}");
    databaseReference.once().then((DataSnapshot snapshot) {
      print('key:  : ${snapshot.value}');
    });


    print("ALL:--");
    _counterRef.once().then((DataSnapshot snapshot) {
      print('Data : ${snapshot.value}');
    });
  }

  void updateData(){
    //_counterRef = FirebaseDatabase.instance.reference().child('MySkill');
    _counterRef.child('1').update({
      'name': 'J2EE',
      'value':'2'
    });
    _counterRef.child('c++').update({
      'name': 'Pro',
      'value':'2'
    });

    print(databaseReference..child('MyGit').child("io").update({
      'name':"web",
      "url":"ww.abc.com"
    }));

    /*
    * var playersRef = ref.child("players");
playersRef.push ({
   name: "John",
   number: 1,
   age: 30
});

playersRef.push ({
   name: "Amanda",
   number: 2,
   age: 20
});
* */


  }

  void deleteData(){
    databaseReference.child('1').remove();
  }
  
}