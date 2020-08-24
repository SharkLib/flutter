import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_killer/killer.dart';
import 'package:flutter_killer/myiconbutton.dart';
import 'package:image_picker/image_picker.dart';
import 'killview.dart';
import 'wolfview.dart';
import 'recordmodel.dart';
import 'multiview.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter_killer/MulItemsView.dart';
import "package:flutter_killer/KillGame.dart";


final recordM = RecordpModel();

void main() {
  //runApp(MyApp());

  runApp(
    Provider < int>.value(
      value: 10,
      child: ChangeNotifierProvider.value(
        value: recordM,
        child: MyApp(),
      ),
    ),);

}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: InternetView(title: 'Killer Record'),
        debugShowCheckedModeBanner: false
    );
  }
}



class InternetView extends StatefulWidget {
  InternetView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _InternetViewState createState() => _InternetViewState();
}

class _InternetViewState extends State<InternetView> with AutomaticKeepAliveClientMixin{

  int _currentIndex =0;
  bool visibilityTag = false;

  final List<String> entries = <String>["杀人","狼人杀","测试","m"];

  String title = "杀人";

  ImageProvider img = AssetImage("assets/head1.jpg");

  final KillView w1 = KillView(title: 'Killer Record');
  GameView w2 = GameView(title: 'Killer Record');

  Killgame w3 = Killgame();
  MultiItemView w4 =MultiItemView();

  @override
  bool get wantKeepAlive => true;


  @override
  void initState() {
    super.initState();

  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      title = entries[index];
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  _showDialog() async {
    int teamName = 14;
    await showDialog<int>(
        context: context,
        barrierDismissible: false, // user must tap button!
        builder: (BuildContext context)
    {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(16.0),
        content: Row(
          children: <Widget>[
            Expanded(
              child: new TextField(
                autofocus: true,
                decoration: InputDecoration(
                    labelText: 'Number of Player', hintText: '14'),
                onChanged: (value) {
                  teamName = int.parse(value);
                },
              ),

            )
          ],
        ),
        actions: <Widget>[
          FlatButton(
              child: const Text('CANCEL'),
              onPressed: () {

                Navigator.pop(context);
              }),
          FlatButton(
              child: const Text('OK'),
              onPressed: () {
                w2.setPlayNumer(teamName);
                Navigator.of(context).pop();

              })
        ],
      );
    });

}


  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index)
      {
        setState(() {
          _currentIndex = index;
        });

      },
      children: <Widget>[
        w1,
        w2,
       w3,w4

        //  Mp3Player(),
        //  RecorderPage( ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {



//willpopscope to skip back key
    return
      Scaffold(
       appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () { Scaffold.of(context).openDrawer(); },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),

          title: Text(title),
          backgroundColor: Colors.blueGrey,
         actions: <Widget>[
           IconButton(
             icon: const Icon(Icons.autorenew),
             tooltip: 'Show Snackbar',
             onPressed: () {
               setState(() {
                 print("tap here");
                 print(w1==null);
                 if(_currentIndex==0)
                   w1.reset();
                 else
                   w2.reset();
               });

             },
           ),
           IconButton(
             icon: const Icon(Icons.settings),
             tooltip: 'Next page',
             onPressed: () {
              // _showDialog();
             },
           ),
         ],


        ),


        body: buildPageView(),




        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          //backgroundColor: Colors.red,
          showUnselectedLabels:true,
          currentIndex: _currentIndex, // new
          items: [

            new BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              backgroundColor: Colors.blue,
              label: ('A'),
            ),



            new BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              backgroundColor: Colors.blue,
              label: ('B'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              backgroundColor: Colors.blue,
              label: ('C'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              backgroundColor: Colors.blue,
              label: ('M'),
            ),

          ],
        ),

      );

  }
}