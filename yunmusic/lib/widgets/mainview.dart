import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/services.dart';
import 'musicpage.dart';
import 'about.dart';
import 'package:yunmusic/widgets/LogWidget.dart';
import 'package:yunmusic/widgets/AccountWidget.dart';


class MainView extends StatefulWidget {
  MainView({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;


  @override
  _MainViewState createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int _counter = 0;
  int _currentIndex =0;
  bool visibilityTag = false;
  int _wIndex= 0;

  final txt11 = TextEditingController();
  final List<int> colorCodes = <int>[10, 20, 30];
  final List<String> entries = <String>['A', 'B', 'C','d','e'];

  final List<Widget> _children = [

    MusicPage(),
    LogWidget(Colors.white),
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
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_box),
            tooltip: 'Show Snackbar',
            onPressed: () {
             // scaffoldKey.currentState.showSnackBar(snackBar);
              Navigator.push<void>(
                context,
                MaterialPageRoute(
                  builder: (context) => AccountWidget(),
                 // fullscreenDialog: true,
                ),
              );

            },
          ),

        ],



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
