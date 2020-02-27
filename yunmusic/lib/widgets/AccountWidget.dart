
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yunmusic/model/countmodel.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:flutter/services.dart';



class AccountWidget extends StatelessWidget {

  _navigateAndDisplaySelection(BuildContext context) async {
    print("test pop in pop");
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen()),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
  }



  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<int>(context).toDouble();

        // Remove the MediaQuery padding because the demo is rendered inside of a
    // different page that already accounts for this padding.
    return MediaQuery.removePadding(
      context: context,
      //removeTop: true,
      removeBottom: true,

        child: Scaffold(
          appBar: AppBar(
            title: Text('Account'),
            actions: [
              FlatButton(
                child: Text(
                  'Save',
                  style: theme.textTheme.body1.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                onPressed: () {
                  _navigateAndDisplaySelection(context);
                },
              ),
            ],
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
               // Navigator.pop(context, 'Yep!');
                _navigateAndDisplaySelection(context);
              },
              child: Text('Yep!'),
            ),
          ),

             Text(
              'Value: ${_counter.value}',
            ),
            RaisedButton(
              onPressed: () {
                // Close the screen and return "Yep!" as the result.
                // Navigator.pop(context, 'Yep!');
                _counter.increment();
              },
              child: Text('Add +1'),
            ),

          ],
          ),
    ),
        ),

    );
  }
}



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
      sdPath= (await getExternalStorageDirectory()).path;
    } else if (Platform.isIOS) {
      sdPath = (await getExternalStorageDirectory()).path;
    }
  }

  @override
  Widget build(BuildContext context) {
    final _counter = Provider.of<CounterModel>(context);

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
                    final a2 = await getExternalStorageDirectory();
                    print( "External storage:"+ a2.path );
                    final a3 =await getExternalStorageDirectory();
                    Directory extDir = Directory("/sdcard");

                  for (var v in a3.listSync()) {
                    // 去除以 .开头的文件/文件夹
                    if (p.basename(v.path).substring(0, 1) == '.') {
                      continue;
                    }
                    if (FileSystemEntity.isFileSync(v.path))
                      print(v.path);
                    else
                      print(v.path);
                  }

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
                 _counter.increment();
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


class Wechat {
  static const MethodChannel _channel =
  const MethodChannel('wechat');

  static Future<String> get platformVersion async {
    final String version = await _channel.invokeMethod('getPlatformVersion');
    return version;
  }
}