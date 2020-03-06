import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'widgets/loginpage.dart';
import 'package:camera/camera.dart';

import 'widgets/selectiopage.dart';
import 'widgets/TakePictureScreen.dart';
import 'model/countmodel.dart';
import 'widgets/mainview.dart';
import 'musicmodel/player.dart';
import 'musicmodel/musicview.dart';
import 'shopmodel/shopview.dart';
import 'mainpage.dart';
final counter = CounterModel();

void main() async {
  // Ensure that plugin services are initialized so that `availableCameras()`
  // can be called before `runApp()`
  WidgetsFlutterBinding.ensureInitialized();


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

     // '/': (BuildContext context) => new MainPage(title: "DFmain"),
      '/main1': (BuildContext context) => new MainView(title: "Main"),
      '/Camera': (BuildContext context) => new TakePictureScreen(camera: camera,),
      '/Select': (BuildContext context) => new SelectionScreen(),
      '/musicview': (BuildContext context) => new MusicView(),
      '/shop': (BuildContext context) => new ShopView(),
      '/player': (BuildContext context) => new PlayerWidget(url:"assets/audios/1.wav"),


      //'/SDCard': (BuildContext context) => new SendPage(title: "DFsend"),
    };
    return new MaterialApp(
        title: 'Flutter Demo',
        theme: new ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: new MainPage(title: 'DFmain'),
        routes: routes,
        debugShowCheckedModeBanner: false
    );
  }
}