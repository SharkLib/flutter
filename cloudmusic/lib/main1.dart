import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'filewidget.dart';
import 'mainwindow.dart';
import 'LogWidget.dart';
import 'about.dart';
import 'photowidget.dart';
import 'camerawidget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {

    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: MyHomePage(title:"云音乐"),
    );
  }
}

class FirstPage extends StatefulWidget {
  FirstPage({Key key}) : super(key: key);
  @override
  _FavoriteWidgetState createState() => _FavoriteWidgetState();
}


class _FavoriteWidgetState extends State<FirstPage> {
  // ···
  @override
  void initState() {
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: EdgeInsets.all(0),
          child: IconButton(
            icon:  Icon(Icons.star_border),
            color: Colors.red[500],
            onPressed: ()
            {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => MyHomePage(title:"dasd")),
              );
            },
          ),
        ),
        SizedBox(
          width: 18,
          child: Container(
            child: Text('ddfd'),
          ),
        ),
      ],
    );
  }
}


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;


  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  int _currentIndex =0;
  bool visibilityTag = false;
  int _wIndex= 0;

  final txt11 = TextEditingController();
  final List<int> colorCodes = <int>[10, 20, 30];
  final List<String> entries = <String>['A', 'B', 'C','d','e'];

  final List<Widget> _children = [

    MainWidget(),
    CameraWidget(),
    AboutWidget(Colors.white ),


  ];


  static final CREATE_POST_URL = 'https://dfws52.datafax.com:4433/dfws/v5/authorize';

  @override
  void initState() {
    super.initState();

  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _wIndex = index;
    });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      //if (_currentIndex >2)
        {
          _children.add( FileWidget(Colors.red) );
          num height = 10;
          String square ="The square is ${height * height}";


      }
      _wIndex = 3;

    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.

    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),


      ),
        drawer: new Drawer(
          child: ListView(
            children: <Widget>[
              new UserAccountsDrawerHeader(
                accountName: new Text('DFnet'),
                accountEmail: new Text('rong@datafax.com'),
                currentAccountPicture: new CircleAvatar(
                  backgroundImage: new NetworkImage('https://s6q7n2v5.stackpathcdn.com/wp-content/uploads/2016/01/white-logo.png'),
                ),
                onDetailsPressed: (){},
              ),
              new ListTile(
                title: new Text('About Page'),
                onTap: ()
                    {

                      Navigator.pop(context);
                    },

              ),
            ],
          ),
        ),

      body: _children[_wIndex],

      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex, // new
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.archive),
            title: Text('Files'),
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.message),
            title: Text('Logs'),
          ),
          new BottomNavigationBarItem(
              icon: Icon(Icons.help),
              title: Text('Help'),

          )
        ],
      ),
    );

  }
}
