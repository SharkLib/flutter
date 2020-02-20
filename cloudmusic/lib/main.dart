import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'mainwindow.dart';
import 'music.dart';
import 'loginWidget.dart';

import 'model/countmodel.dart';

final counter = CounterModel();


void main() => runApp(
  Provider<int>.value(
  value: 10,
  child: ChangeNotifierProvider.value(
    value: counter,
    child: MyApp(),
  ),
),
);



class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var routes = <String, WidgetBuilder>{

      '/send1': (BuildContext context) => new MusicPage(title: "Cloud Music"),
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

