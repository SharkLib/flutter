import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'myiconbutton.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';

class Wolf extends StatefulWidget {

  WolfState ss;
  @override
  State<StatefulWidget> createState()
  {
    // TODO: implement createState
    ss = WolfState();
    return ss;
  }

  void reset()
  {
    ss.reset();
  }

}


class WolfState extends State<Wolf>
{
  File _image =null;
 // bool monVal = false;

  bool dead = false;


  var po_img = "assets/pic/wolfs.jpg";
  var type_img = "assets/pic/tag_wolf_6.png";
  final picker = ImagePicker();
  String fie_path ;

  Future getImage(  ) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);
    fie_path = pickedFile.path;
    setState(() {

      _image = File(pickedFile.path);
    });
  }

  void reset()
  {
    setState(() {
      type_img = "assets/pic/tag_wolf_"+ "6.png";
      dead = false;
    });
  }

  void changeHead(int n)
  {
    setState(() {

      print(n);
      type_img = "assets/pic/tag_wolf_"+ n.toString()+ ".png";
    });
  }

  Future mergeTwo() async
  {
    String t_path;
     setState(()
     {


     });


  }

  Widget type_button(int n)
  {

    return Container(
        height: 30.0,
        width: 50.0,

        child:  IconButton(

          icon: new Image.asset("assets/pic/tag_wolf_"+ n.toString()+ ".png"),
          tooltip: 'Closes application',
          onPressed: () {changeHead(n);},//=> exit(0)
        )
    );

    return  IconButton(

      icon: new Image.asset('assets/pic/tag_wolf_1.png'),
      tooltip: 'Closes application',
      onPressed: () {},//=> exit(0)
    );

    return FlatButton(
      onPressed: () {
        /*...*/
      },
      child: Text(
        "Flat Button",
      ),
    );

    return IconButton
      (
      onPressed: () {
        setState(() {
          print("i do");

        });
      },
      color:Colors.white,
      icon: Icon(Icons.skip_next),
      tooltip: "p",
    );

  }


  Container createChoice(int n,String s)
  {

    return Container(
      height: 80.0,
      width: 30.0,
      child:Column(

        children: [
          Radio(
            onChanged: (value)
            {
              setState(() {


              });

              changeHead(n);

            },
            value: n,

            activeColor: Color(0xFF6200EE),
            groupValue: 0,
          ),
          Text(
            s,

          ),
        ],

      ),
    );
  }
  void _incrementCounter() {
    print(  "jhahah" );
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Row(

        children:[
          Container(
              height: 100.0,
              width: 100.0,

              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2.0, color: Colors.lightBlue.shade600),
                  bottom: BorderSide(width: 2.0, color: Colors.lightBlue.shade900),
                ),
                color: Colors.white,
              ),

              child:  FlatButton(

                onPressed:(){
                  getImage( );
                },
                child: dead? Image.asset("assets/pic/d.png"):
                  ( _image == null
                    ? Image.asset(po_img)
                   : Image.file(_image)),
              )
          ),
          Column(

            mainAxisAlignment: MainAxisAlignment.spaceAround,
            //mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.start,

            children: <Widget>[

            Row(
            children: <Widget>[
              //Icon(Icons.pregnant_woman),
            SizedBox(
              height: 33,
              width: 33,
              child: Image.asset(
                type_img,
                height: 25,
               // color: Colors.blue,
              ),
            ),

              SizedBox(width:100,
                  child: TextField(
                decoration: InputDecoration(
                  //border: InputBorder.none,
                    hintText: 'Enter Name'
                ),


              )),
              ]),
              Row(
                children: <Widget>[
/*
                  MyIconButton(
                      Icon(Icons.account_box),
                      _incrementCounter
                  ),

*/
                  type_button(0),
                  type_button(1),
                  type_button(2),
                  type_button(3),


                  Checkbox(
                    onChanged: (bool value) {
                      setState(() {
                        dead = value;
                      });

                    },
                    value: dead,
                    activeColor: Color(0xFF6200EE),
                  ),




                ],
              ),
              Row(
                children: <Widget>[
/*
                  MyIconButton(
                      Icon(Icons.account_box),
                      _incrementCounter
                  ),

*/
                  type_button(4),
                  type_button(5),
                  type_button(6),
                  type_button(7),
                  Text(
                    'Dead ',

                  ),

                ],
              ),

              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                    colors: [const Color(0xFFFFFFEE), const Color(0xFF999999)], // whitish to gray
                    tileMode: TileMode.repeated, // repeats the gradient over the canvas
                  ),
                ),
                width:    (MediaQuery.of(context).size.width)-120,
                height: 2.0,
              )


            ],
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment(0.8, 0.0), // 10% of the width, so there are ten blinds.
                colors: [const Color(0xFFFFFFEE), const Color(0xFF999999)], // whitish to gray
                tileMode: TileMode.repeated, // repeats the gradient over the canvas
              ),
            ),
          )
        ]
    );


  }

}