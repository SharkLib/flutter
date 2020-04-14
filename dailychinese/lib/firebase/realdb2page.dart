import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

//this is demo for realtime database

class RealDB2Page extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RealDB2PageState();
  }

}

class RealDB2PageState extends State<RealDB2Page>
{
  final databaseReference = FirebaseDatabase.instance.reference();
  final DatabaseReference _counterRef = FirebaseDatabase.instance.reference().child('MySkill');
  //_counterRef = FirebaseDatabase.instance.reference().child('MySkill');
  var dd = FirebaseDatabase.instance.reference();

  Map<dynamic, dynamic> values;

  @override
  void initState() {
    //...
    getDatabaseData();
     databaseReference.onValue.listen((Event event) {
      setState(() {
        print(  event.snapshot.value );
        getDatabaseData();
      });
    });
    databaseReference.onChildAdded.listen((event) {
      setState(() {
        print("OnAdded");
        print(  event.snapshot.value );
        getDatabaseData();
      });
    });


  }



  @override
  Widget build(BuildContext context) {
    //getData();



    return Scaffold(

      body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[


              RaisedButton(
                child: Text('Record'),
                onPressed: () {

                },
              ),

        Padding(
          padding: const EdgeInsets.all(0.0),
          child:SizedBox(
              child: createList(values),
            height: 200,
              width: 200,
          ),

        )
            ],
          )
      ), //center
    );
  }



  Future<Map> getDatabaseData() async {

    DataSnapshot snapshot = await  databaseReference.once();

    setState(() {
      if (values != null)
        values.clear();
      values = snapshot.value;
    });


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


      Map<dynamic, dynamic> values = snapshot.value;
      values.forEach((key,vv) {
        print(vv);
        print(key);
      });

    });

  }




  Widget createList(Map<dynamic, dynamic> values)
  {
    if (values == null)
      return Text("waiting");

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