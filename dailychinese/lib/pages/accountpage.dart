
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'package:intl/intl.dart';
import 'package:path/path.dart' as p;
import 'package:shared_preferences/shared_preferences.dart';

import 'package:SharkFlutter/models/shopmodel.dart';

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
    final model = Provider.of<ShopModel>(context);
    final textSize = Provider.of<int>(context).toDouble();

    var now = new DateTime.now();
    String formattedDate = DateFormat('yyyy/m/d kk:mm:ss \n EEE d MMM').format(now);


        // Remove the MediaQuery padding because the demo is rendered inside of a
    // different page that already accounts for this padding.
    return MediaQuery.removePadding(
      context: context,
      //removeTop: true,
      removeBottom: true,

        child: Scaffold(

          body: Container(
            width: double.infinity,
            height: double.infinity,

            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/bc.png"),
                fit: BoxFit.cover,
              ),
            ),


            child: Column(
               // mainAxisAlignment: MainAxisAlignment.center,
              //crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(formattedDate,
                    textAlign: TextAlign.center,
                    style: new TextStyle(
                      fontStyle: FontStyle.normal,
                      fontSize: 30.0,
                      color: Colors.amber,
                    ),
                  ),
                  Container(
                    width:  (MediaQuery.of(context).size.width)-50,
                    height: (MediaQuery.of(context).size.height) / 5,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/head5.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
               // child:Text(formattedDate),


                  ),

            Container(
            width:  (MediaQuery.of(context).size.width)-50,
              height: (MediaQuery.of(context).size.height) / 3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/head4.jpeg"),
                  fit: BoxFit.cover,
                ),
              ),
              child:Text(
                "【临洛水】李世民\n "
                    "春搜驰骏骨，总辔俯长河。\n霞处流萦锦，风前漾卷罗。"
                    "\n水花翻照树，堤兰倒插波。\n岂必汾阴曲，秋云发棹歌。",
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.red,

                ),
                textAlign: TextAlign.center,
              ),

            ),
/*
                  Container(

                    width:  (MediaQuery.of(context).size.width)-100,

                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/timg.jpeg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                    child:Text(
                      "这首诗写的是",
                      style: TextStyle(
                        fontSize: 20.0,
                        color: Colors.red,
                      ),
                    ),

                  ),
*/
              ],
          ),
    ),
          floatingActionButton: Container(
            height: 120,

             child: Padding(

                padding: const EdgeInsets.all(2.0),

                child: Column(

                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.navigate_before),
                    ),
                    FloatingActionButton(
                      onPressed: () {},
                      child: Icon(Icons.navigate_next),
                    )
                  ],
                ),
              )
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

    }

    @override
    Widget build(BuildContext context) {
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
                  onPressed: () async {
                    await getPermission();
                    print("get sdCard path" + sdPath);
                    // final directory = await getApplicationDocumentsDirectory();
                    // For your reference print the AppDoc directory
                    //  print("DocumentsDirectory:" +  directory.path);
                    // final a1 = await getDownloadsDirectory();
                    //  print("Download:" + a1.path);
                    final a2 = await getExternalStorageDirectory();
                    print("External storage:" + a2.path);
                    final a3 = await getExternalStorageDirectory();
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

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }


}