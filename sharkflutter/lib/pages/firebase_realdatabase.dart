import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
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

  var _futureBuilderFuture;

  @override
  void initState() {
    //...
    _futureBuilderFuture = getDatabaseData();
     databaseReference.onValue.listen((Event event) {
      setState(() {
        print(  event.snapshot.value );
      });
    });
  }



  @override
  Widget build(BuildContext context) {
    //getData();

    final gitListView = FutureBuilder(
        future: _futureBuilderFuture,

        builder: (BuildContext context, AsyncSnapshot<Map<dynamic, dynamic>> snapShot) {

          switch (snapShot.connectionState)
          {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              print('waiting');
              return Center(child: Text('wait'));
            case ConnectionState.done:
              print('done');
              if (snapShot.hasError) {
                return Center(
                  child: Text('网络请求出错'),
                );
              }
              else if (snapShot.hasData)
              {
                Map<dynamic, dynamic> a = snapShot.data;
                return createList(a);
              }

              return Text("Waiting");
          }
          return null;
        }
    );

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

        Padding(
          padding: const EdgeInsets.all(0.0),
          child:SizedBox(
              child: gitListView,
            height: 200,
              width: 200,
          ),

        )
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

  Future<List> firebaseCalls (DatabaseReference databaseReference) async{
    List recipeList;
    DataSnapshot dataSnapshot = await databaseReference.once();
    Map<dynamic,dynamic> jsonResponse=dataSnapshot.value[0]['content'];
   // recipeList = new RecipeList.fromJSON(jsonResponse);
    //listItems.addAll(recipeList.recipeList);

    return recipeList;
  }

  Future<Map> getDatabaseData() async {

    DataSnapshot snapshot = await  databaseReference.once();
    Map<dynamic, dynamic> values = snapshot.value;
    print("it is me---------");
    values.forEach((key,vv) {
      print(vv);
      print(key);
    });
    print("it is you---------");

    return values;
  }
  void getData ()
  {


    print("key:---${databaseReference.once()}");

    databaseReference.once().then((DataSnapshot snapshot) {
      //print('databaseReference value:  : ${snapshot.value}');
      //print('databaseReference value:  : ${snapshot.value['MyGit']}');
      //print('databaseReference key:  : ${snapshot.key}');

      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,vv) {
        print(vv);
        print(key);
      });
/*
      List responseJson = json.decode(snapshot.value);
      responseJson.forEach((element) {
        //print(element);
        //print(element['html_url'] );
        // entries.add(element['name']);
      });
      */


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


  }

  void deleteData(){
    databaseReference.child('1').remove();
  }



  Widget createList(Map<dynamic, dynamic> values)
  {
      return ListView.builder(

          padding: const EdgeInsets.all(8),
          itemCount: values.length,
          itemBuilder: (BuildContext context, int index) {

            return new ListTile(
              leading: Icon(Icons.add_call),
              title: new Text(values.entries.elementAt(index).key),
              subtitle: new Text(values.entries.elementAt(index).value.toString()),
              trailing: Checkbox(
                value:true,
              ),
            );


          }
      );

  }

}