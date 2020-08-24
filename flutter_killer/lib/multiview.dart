import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_killer/killer.dart';
import 'package:flutter_killer/myiconbutton.dart';
import 'package:flutter_killer/recordmodel.dart';
import 'package:flutter_killer/player.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GameView extends StatefulWidget
{
  GameView({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  PlayerState ps;
  void reset() => ps.reset();

  void setPlayNumer(int n) => ps.playerNumber=n;



  @override
  PlayerState createState() => ps = PlayerState();
}

class PlayerState extends State<GameView>  with AutomaticKeepAliveClientMixin{


  File _image = File("assets/v.png");
  TextEditingController nameController = TextEditingController();
  final picker = ImagePicker();
  List<File> img_list = List<File>.generate(10, (index) =>  File(""));


  String dropdownValue = 'One';
  String _result = "No record";
  int numOfPlayer = 18;

  set playerNumber(int n) {
    all_killer=[];
    setState(() {
    numOfPlayer = n;
//    all_killer   = List<Player>.generate(numOfPlayer, (int index) {
//      var a = Player();
//      return a;
//    });
    for(int n=0; n< numOfPlayer; n++)
      all_killer.add(Player());
  });
  }

  List<Player> all_killer   = List<Player>.generate(16, (int index) {
  var a = Player();
  //all_killer .add(a);
  return a;
  });


  void reset()
  {
//    int a = numOfPlayer;
//    playerNumber=0;
//    playerNumber = a;
//    print ("totla:" + all_killer.length.toString());
    setState(()
    {

      for(int n=0; n< all_killer.length; n++)
      {  print( n.toString() + " player reset");
       all_killer[n].reset();}
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

    final model = Provider.of<RecordpModel>(context);


    return Scaffold(

        body: Center(
          // Center is a layout widget. It takes a single child and positions it
          // in the middle of the parent.
          child:
          LayoutBuilder(
            builder: (BuildContext context, BoxConstraints viewportConstraints) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: viewportConstraints.maxHeight,
                  ),
                  child:  Wrap(
                    spacing: 1, // set spacing here
                    //children: all_killer,
                    children:   all_killer ,

                    alignment: WrapAlignment.center,
                  ),
                ),
              );
            },
          ),
        )




      //------------------

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;
}
