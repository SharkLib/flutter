import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_killer/killer.dart';
import 'package:flutter_killer/myiconbutton.dart';
import 'package:flutter_killer/recordmodel.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:provider/provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class KillView extends StatefulWidget
{
  KillView({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  KillState ks = KillState();

  void reset()
  {
    print("I am here");
    ks.reset();
  }

  @override
  KillState createState(){  return ks;}
}

class KillState extends State<KillView>  with AutomaticKeepAliveClientMixin{


  File _image = File("assets/v.png");
  TextEditingController nameController = TextEditingController();
  final picker = ImagePicker();
  List<File> img_list = List<File>.generate(10, (index) =>  File(""));


  String dropdownValue = 'One';
  String _result = "No record";

  List<Killer> all_killer = [
    Killer(),
    Killer(),
    Killer(),
    Killer(),

    Killer(),
    Killer(),
    Killer(),
    Killer(),

    Killer(),
    Killer(),
    Killer(),
    Killer(),

    Killer(),
    Killer(),
    Killer(),
    Killer(),

    Killer(),
    Killer(),];


  void reset()
  {
    for(int n=0; n< all_killer.length; n++)
      all_killer[n].reset();

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
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children:<Widget>[
                      Container(
                        height: 20.0,
                        width: 150.0,
                        child: Text("Police:"+model.totalDeadPolice.toString()+"/"+ model.totalPolice.toString()
                            + " Killer:"+model.totalKiller.toString()+"/"+ model.totalDeadKiller.toString()),
                      ),
                      all_killer[0],
                      all_killer[1],
                      all_killer[2],
                      all_killer[3],

                      all_killer[4],
                      all_killer[5],
                      all_killer[6],
                      all_killer[7],

                      all_killer[8],
                      all_killer[9],
                      all_killer[10],
                      all_killer[11],

                      all_killer[12],
                      all_killer[13],
                      all_killer[14],
                      all_killer[15],

                      all_killer[16],
                      all_killer[17],
                      //all_killer[18],
                      //all_killer[19],
                    ],

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
