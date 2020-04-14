import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';

import 'models/shopmodel.dart';
import 'dart:io';


import 'pages/loginpage.dart';
import 'views/internetview.dart';

import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'firebase/firebaseview.dart';



final shopModel = ShopModel();

void main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();


  // Permission check
  Future<void> getPermission() async {
    if (Platform.isAndroid) {
      var status = await Permission.camera.status;
       status = await Permission.storage.status;
       status = await Permission.microphone.status;


    } else if (Platform.isIOS) {

    }
  }



  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();
  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
  await getPermission();
  //final firstCamera = CameraDescription();
  runApp(
    Provider < int>.value(
    value: 10,
    child: ChangeNotifierProvider.value(
      value: shopModel,
      child: MyApp(camera:firstCamera),
    ),
  ),);
}


class MyApp extends StatelessWidget {
  final CameraDescription camera;
  const MyApp({
    Key key,
    @required this.camera,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var routes = <String, WidgetBuilder>{

      '/login': (BuildContext context) => new LoginPage(title:"Login"),

      '/internet': (BuildContext context) => new InternetView(title:"Internet"),

      '/firebase' : (BuildContext context) => new FirebaseView(title:"Firebase"),
      //'/cloudDatabase' : (BuildContext context) => new CloudStorePage(),
      //'/SDCard': (BuildContext context) => new SendPage(title: "DFsend"),

    };
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new InternetView(title: 'DFmain'),
        routes: routes,
        debugShowCheckedModeBanner: false
    );
  }
}