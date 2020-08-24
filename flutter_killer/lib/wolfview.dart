import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_killer/wolf.dart';
import 'package:flutter_killer/myiconbutton.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WolfView extends StatefulWidget
{
  WolfView({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;
  WolfState ws;
  void reset()=>    ws.reset();


  @override
  WolfState createState() =>ws = WolfState();
}

class WolfState extends State<WolfView>  with AutomaticKeepAliveClientMixin{


  File _image = File("assets/v.png");
  TextEditingController nameController = TextEditingController();
  final picker = ImagePicker();
  List<File> img_list = List<File>.generate(10, (index) =>  File(""));

  Future getImage( int n) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
  }
  String dropdownValue = 'One';


  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

    });
  }

  Widget createHead()
  {

    for(int n=0; n< 18; n++)
      all_wolf.add(Wolf());
  }

  void reset()
  {
    for(int n=0; n< all_wolf.length; n++)
      all_wolf[n].reset();
  }

  List<Wolf> all_wolf = [

    Wolf(),
    Wolf(),
    Wolf(),
    Wolf(),

    Wolf(),
    Wolf(),
    Wolf(),
    Wolf(),

    Wolf(),
    Wolf(),
    Wolf(),
    Wolf(),

    Wolf(),
    Wolf(),
    Wolf(),
    Wolf(),

    Wolf(),
    Wolf(),
    Wolf(),
    Wolf()
  ];

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.



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
                    children:  <Widget>[
                      Container(
                        height: 30.0,
                        width: 150.0,
                        child:Row(

                          children: [
                            IconButton
                              (
                              onPressed: () {
                                for(int n=0; n< all_wolf.length; n++)
                                  all_wolf[n].reset();
                              },
                              color:Colors.blue,
                              icon: Icon(Icons.refresh),
                              tooltip: "p",
                            ),

                          ],

                        ),
                      ),
                      all_wolf[0],
                      all_wolf[1],
                      all_wolf[2],
                      all_wolf[3],

                      all_wolf[4],
                      all_wolf[5],
                      all_wolf[6],
                      all_wolf[7],

                      all_wolf[8],
                      all_wolf[9],
                      all_wolf[10],
                      all_wolf[11],

                      all_wolf[12],
                      all_wolf[13],
                      all_wolf[14],
                      all_wolf[15],

                      all_wolf[16],
                      all_wolf[17],
                      all_wolf[18],
                      all_wolf[19],
                    ]
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
