
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import 'package:SharkFlutter/models/shopmodel.dart';

class SelectionScreen extends StatelessWidget {

  String sdPath = "";

  // Permission check
  Future<void> getPermission() async {

    // obtain shared preferences
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the counter key. If it doesn't exist, return 0.
    final counter = prefs.getInt('counter') ?? -1;
    print("def value:" + counter.toString());

// set value
    prefs.setInt('counter', 5);

    if (Platform.isAndroid) {
      PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      }
    } else if (Platform.isIOS) {

    }
  }

  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<ShopModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Close the screen and return "Yep!" as the result.
                  Navigator.pop(context, 'Yep!');
                },
                child: Text('Yep!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () async  {


                  await getPermission();
                  print("get sdCard path" + sdPath);
                  // final directory = await getApplicationDocumentsDirectory();
                  // For your reference print the AppDoc directory
                  //  print("DocumentsDirectory:" +  directory.path);
                  // final a1 = await getDownloadsDirectory();
                  //  print("Download:" + a1.path);

                  Directory extDir = Directory("/sdcard");



                  // Close the screen and return "Nope!" as the result.
                  //Navigator.pop(context, 'Nope.');
                },
                child: Text('Nope.'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Close the screen and return "Yep!" as the result.
                  _counter.login("You");
                },
                child: Text('Add+1!'),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
