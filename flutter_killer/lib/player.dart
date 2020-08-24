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

class Player extends StatefulWidget {

  PlayerState ks;
  @override
  State<StatefulWidget> createState()
  {
    // TODO: implement createState
    ks = PlayerState();
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


class PlayerState extends State<Player>
{
  PlayerState()
  {
    type_img = "assets/pic/tag_wolf_6.png";
    _radioValue = 2;
    dead = false;
  }
  File _image =null;

  bool dead = false;
  int _radioValue = 2;
  int get role=> _radioValue;
  bool get isDead => dead;

  var po_img = "assets/pic/killers.png";
  var type_img = "assets/pic/tag_wolf_6.png";
  final picker = ImagePicker();
  String fie_path ;
  final isSelected = <bool>[false, false, false];
  String type_name="";

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

      type_img = "assets/pic/tag_wolf_6.png";
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
        type_img = "assets/pic/kill.jpeg";
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
    return  Container(
        height: 190.0,
        width: 140.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.black,
            width: 1,
          ),
      /*    image: new DecorationImage(
            image: AssetImage(po_img),
            fit: BoxFit.cover,
          ),
*/
        ),
    child: Column(
       // crossAxisAlignment: CrossAxisAlignment.stretch,
       // spacing: 1, // set spacing here
        mainAxisAlignment:MainAxisAlignment.spaceAround,
        children:[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 2),
            child: CupertinoTextField(
              placeholder: "name",
              keyboardType: TextInputType.emailAddress,
              clearButtonMode: OverlayVisibilityMode.editing,
              autocorrect: false,
            ),
          ),

          Container(
              height: 100.0,
              width: 100.0,
              //margin:1,
              decoration: BoxDecoration(
                border: Border.all(
                  color: Colors.black,
                  width: 1,
                )
              ),

              padding: EdgeInsets.all(0),

              child:  FlatButton(
                padding: EdgeInsets.all(0),
                onPressed:(){
                  getImage( );
                },
                child:_image == null
                    ? Image.asset(po_img)
                    : Image.file(_image)),
          ),




    // This is the type used by the popup menu below.
          Row(
            mainAxisAlignment:MainAxisAlignment.spaceAround,
            children: <Widget>[
              SizedBox(
                height: 28,
                width: 28,
                child: Image.asset(
                  type_img,
                  height: 25,
                  // color: Colors.blue,
                ),
              ),
              PopupMenuButton<int>(
                padding: EdgeInsets.all(0),
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 1,
                    child: Text("杀手"),
                  ),
                  PopupMenuItem(
                    value: 2,
                    child: Text("女巫"),
                  ),
                  PopupMenuItem(
                    value: 3,
                    child: Text("预言家"),
                  ),
                  PopupMenuItem(
                    value: 4,
                    child: Text("骑士"),
                  ),
                  PopupMenuItem(
                    value: 5,
                    child: Text("猎人"),
                  ),
                  PopupMenuItem(
                    value: 6,
                    child: Text("平民"),
                  ),
                  PopupMenuItem(
                    value: 7,
                    child: Text("死"),
                  ),
                ],
                initialValue: _radioValue,
                onCanceled: () {
                  print("You have canceled the menu.");
                },
                onSelected: (value) {
                  print("value:$value");
                  setState(() {
                    type_img = "assets/pic/tag_wolf_"+ value.toString()+ ".png";
                    if(value == 7 && !dead) {
                      type_img = "assets/pic/d.png";
                      dead = true;
                      return;
                    }
                    else if(value == 7 && dead) {
                      type_img = "assets/pic/tag_wolf_"+ _radioValue.toString()+ ".png";
                      dead = false;
                      return;
                    }
                    _radioValue = value;
                      switch( value )
                      {
                        case 1:
                          type_name = "杀手";
                          break;
                        case 2:
                          type_name = "女巫";
                          break;
                        case 3:
                          type_name = "预言家";
                          break;
                        case 4:
                          type_name = "骑士";
                          break;
                        case 5:
                          type_name = "猎人";
                          break;
                        case 6:
                          type_name = "平民";
                          break;
                       /* case 7:
                          type_name = "杀手";
                          break;
                        case 8:
                          type_name = "杀手";
                          break;
                        case 9:
                          type_name = "杀手";
                          break;
                        case 10:
                          type_name = "杀手";
                          break;*/
                      }
                  });
                },
                icon: Icon(Icons.list),


              ),
              Text(type_name),


            ],
          ),



        ]
    )
    );


  }

}