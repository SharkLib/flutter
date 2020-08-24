import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'myiconbutton.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter/services.dart' show rootBundle;
import 'package:image/image.dart' as Img;
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'recordmodel.dart';

class Killer extends StatefulWidget {

  KillerState ks;
  @override
  State<StatefulWidget> createState()
  {
    // TODO: implement createState
    ks = KillerState();
    return ks;
  }

  void reset()
  {
    ks.reset();
  }

  int getRole()
  {
    return ks.role;
  }
  bool isDead()
  {
    return ks.isDead;
  }

}


class KillerState extends State<Killer>
{
  File _image =null;

  bool dead = false;
  int _radioValue = 2;
  int get role=> _radioValue;
  bool get isDead => dead;

  var po_img = "assets/pic/killers.png";
  var type_img = "assets/pic/n.png";
  final picker = ImagePicker();
  String fie_path ;
  final isSelected = <bool>[false, false, false];

  Future getImage(  ) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    fie_path = pickedFile.path;
    setState(() {

      _image = File(pickedFile.path);
    });
  }

  void reset()
  {
    setState(() {

        type_img = "assets/pic/n.png";
        _radioValue = 2;
        dead = false;
      }
      );
  }

  void changeHead(int n,RecordpModel model)
  {
    setState(() {

      if(_radioValue==0)
        {
          model.setTotalPolice =  model.totalPolice-1;
          if(dead)
            model.setTotalDeadPolice =  model.totalDeadPolice-1;
        }
      else if (_radioValue == 1)
      {
        model.setTotalKiller = model.totalKiller - 1;
        if(dead)
          model.setTotalDeadKiller =  model.totalDeadKiller-1;
      }

          if(n==0)
          {
            type_img = "assets/pic/p1.png";
            _radioValue = 0;
            model.setTotalPolice =  model.totalPolice+1;
            if(dead)
              model.setTotalDeadPolice =  model.totalDeadPolice+1;
          }
          else if(n==1)
          {
            type_img = "assets/pic/kiil.jpeg";
            _radioValue = 1;
            model.setTotalKiller = model.totalKiller + 1;
            if(dead)
              model.setTotalDeadKiller =  model.totalDeadKiller+1;

          }
          else
          {
            type_img = "assets/pic/n.png";
            _radioValue = 2;
          }

    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final model = Provider.of<RecordpModel>(context);
    return Row(
        children:[
          Container(
              height: 100.0,
              width: 100.0,
              //color: Colors.green,
              //margin: EdgeInsets.all(100.0),

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

            mainAxisAlignment: MainAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
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

                  IconButton(

                    icon: new Image.asset("assets/pic/police.png"),
                    tooltip: 'Closes application',
                    onPressed: () {changeHead(0,model);},//=> exit(0)
                  ),

                  IconButton(

                    icon: new Image.asset("assets/pic/killer.png"),
                    tooltip: 'Closes application',
                    onPressed: () {changeHead(1,model);},//=> exit(0)
                  ),
                  IconButton(

                    icon: new Image.asset("assets/pic/populace.png"),
                    tooltip: 'Closes application',
                    onPressed: () {changeHead(2,model);},//=> exit(0)
                  ),

/*
                  ToggleButtons(
                    children: const [
                      Icon(Icons.ac_unit),
                      Icon(Icons.call),
                      //Text("Police"),
                      ImageIcon(

                        AssetImage("assets/pic/populace.png"),
                        size: 36,
                        //color: Colors.blue,

                      ),

                    ],
                    onPressed: (index) {
                      setState(() {
                        isSelected[0] = false;
                        isSelected[1] = false;
                        isSelected[2] = false;
                        isSelected[index] = true;
                        _radioValue = index;
                      });
                    },
                    isSelected: isSelected,
                  ),
*/
                  Checkbox(
                    onChanged: (bool value) {
                      setState(() {
                        int num = dead? -1:1;
                        if(_radioValue==0)
                          model.setTotalDeadPolice = model.totalDeadPolice + num;
                        else if (_radioValue==1)
                          model.setTotalDeadKiller = model.totalDeadKiller + num;

                        dead = value;

                      });

                    },
                    value: dead,
                    activeColor: Color(0xFF6200EE),
                  ),
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