import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:yunmusic/model/countmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';

import 'dart:async';
import 'package:path_provider/path_provider.dart';
//import 'package:flutter_github_api/flutter_github_api.dart';
//import 'package:flutter_github_api/entity/index.dart';
//User user;

class MainPage extends StatefulWidget {
  MainPage({Key key, this.title}) : super(key: key);

  final String title;
  //final BaseAuth auth;

  @override
  _MainPageState createState() => new _MainPageState();
}

class _MainPageState extends State<MainPage> {
  int _counter = 0;

  TextEditingController unameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  GlobalKey formKey = new GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {

    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<int>(context).toDouble();



    var button = new ButtonBar( children: <Widget>[
      FlatButton(
        child: Text('Login'),
        key: Key('MainPageLogin'),
        color: Colors.blue,
        onPressed: () {
          //login("huang.rong.bj@gmail.com","Good2017!");
          Navigator.pushNamed(context, '/main1');
        },
      ),
      FlatButton(
        child: Text('Cancel'),
        color: Colors.blue,
        onPressed: () {
          if ((formKey.currentState as FormState).validate()) {
            //验证通过提交数据
            print("ffff");
          }
        },
      ),
    ],
        alignment:MainAxisAlignment.center,
        mainAxisSize:MainAxisSize.max

    );

    var shareBtn = new ButtonBar( children: <Widget>[
      IconButton(
        icon: const Icon(Icons.camera),
        tooltip: 'Show Camera',
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/Camera');
        },
      ),
      IconButton(
        icon: const Icon(Icons.shop),
        tooltip: 'shop',
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/shop');
        },
      ),
      IconButton(
        icon: const Icon(Icons.attach_file),
        tooltip: 'Show File ',
        color: Colors.blue,
        onPressed: () async{
          File file = await FilePicker.getFile();
        },
      ),
      IconButton(
        icon: const Icon(Icons.music_video),
        tooltip: 'Show music player',
        key: Key('MusicPlayer'),
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/musicview');
        },
      ),
    ],
        alignment:MainAxisAlignment.center,
        mainAxisSize:MainAxisSize.max

    );

    var TestBar = new ButtonBar( children: <Widget>[
      IconButton(
        icon: const Icon(Icons.cloud),
        tooltip: 'Camera',
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/DIO');
        },
      ),
      IconButton(
        icon: const Icon(Icons.security),
        tooltip: 'Select',
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/Select');
        },
      ),
      IconButton(
        icon: const Icon(Icons.play_arrow),
        tooltip: 'Show File ',
        color: Colors.blue,
        onPressed: () async{
          Navigator.pushNamed(context, '/player');
        },
      ),
      IconButton(
        icon: const Icon(Icons.filter_1),
        tooltip: 'Show Snackbar',
        key: Key('Add'),
        color: Colors.blue,
        onPressed: () async {
          final directory = await getApplicationDocumentsDirectory();

          print("Document:" + directory.path);
          print("Doc ->p->p:" + directory.parent.parent.path);
          directory.parent.list().listen((FileSystemEntity entity) {
            print(entity.path);
          });

          var dicm = Directory('/storage/emulated/0/Downloads');
          final down = await getExternalStorageDirectories();

          final isd = await dicm.exists();
          if( isd) dicm.list().listen((FileSystemEntity entity) {
            print(entity.path);
          });

          print('downloads');
          for (var ll in down)
            print (ll.path);

          final aa = File('/storage/emulated/0/DCIM/counter.txt');
          aa.writeAsStringSync("abcd");

        },
      ),
    ],
        alignment:MainAxisAlignment.center,
        mainAxisSize:MainAxisSize.max

    );


    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
      ),

      body:    Center(
        child: Column(
          children: <Widget>[

            //Text("Logins"),
            button,
            Text("Group view"),
            shareBtn,
            Text("Single Views"),
            TestBar,
            //Text("Provider"),
            Text(
              'Value: ${_counter.value}',
              key: Key('Value'),
            )


          ],
        ),
      ),

    );
  }





}