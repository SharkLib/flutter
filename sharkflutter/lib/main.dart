import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:camera/camera.dart';

import 'models/shopmodel.dart';
import 'dart:io';
import 'views/firstview.dart';
import 'views/musicview.dart';
import 'views/shopview.dart';
import 'views/TakePictureScreen.dart';

import 'pages/loginpage.dart';
import 'views/internetview.dart';
import 'pages/file_manager_page.dart';
import 'pages/common.dart';
import 'package:path_provider/path_provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:permission_handler/permission_handler.dart';
import 'pages/firebase_database.dart';


final shopModel = ShopModel();

void main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  Future<void> getSDCardDir() async {
    Common().sDCardDir = (await getExternalStorageDirectory()).path;
  }

  // Permission check
  Future<void> getPermission() async {
    if (Platform.isAndroid) {
      PermissionStatus permission = await PermissionHandler().checkPermissionStatus(PermissionGroup.storage);
      if (permission != PermissionStatus.granted) {
        await PermissionHandler().requestPermissions([PermissionGroup.storage]);
      }
      await getSDCardDir();
    } else if (Platform.isIOS) {
      await getSDCardDir();
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
      '/Camera': (BuildContext context) => new TakePictureScreen(camera: camera,),
      '/musicview': (BuildContext context) => new MusicView(),
      '/login': (BuildContext context) => new LoginPage(title:"Login"),
      '/shop': (BuildContext context) => new ShopView(),
      '/internet': (BuildContext context) => new InternetView(title:"Internet"),
      '/fm': (BuildContext context) => new FileManager(),
      '/firebase' : (BuildContext context) => new FBDatabasePage(),
      //'/SDCard': (BuildContext context) => new SendPage(title: "DFsend"),

    };
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new FirstPage(title: 'DFmain'),
        routes: routes,
        debugShowCheckedModeBanner: false
    );
  }
}