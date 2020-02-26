import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mainwindow.dart';
import 'music.dart';
import 'loginWidget.dart';
import 'package:camera/camera.dart';
import 'model/countmodel.dart';
import 'package:cloudying/TakePictureScreen.dart';
import "package:cloudying/AccountWidget.dart";
import 'package:cloudying/DioTestWidget.dart';

final counter = CounterModel();


void main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();

  AppState.initial();
  // Obtain a list of the available cameras on the device.
  final cameras = await availableCameras();

  // Get a specific camera from the list of available cameras.
  final firstCamera = cameras.first;
 // final firstCamera = CameraDescription();
  runApp(
    Provider < int>.value(
    value: 10,
    child: ChangeNotifierProvider.value(
      value: counter,
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

      '/send1': (BuildContext context) => new MusicPage(title: "Cloud Music"),
      '/Camera': (BuildContext context) => new TakePictureScreen(camera: camera,),
      '/Select': (BuildContext context) => new SelectionScreen(),
      '/DIO': (BuildContext context) => new LoginForm(),
      //'/SDCard': (BuildContext context) => new SendPage(title: "DFsend"),
    };
    return new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'DFsend'),
      routes: routes,
      debugShowCheckedModeBanner: false
    );
  }
}

