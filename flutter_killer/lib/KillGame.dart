import "package:flutter/material.dart";
import 'package:flutter/cupertino.dart';
import 'package:random_color/random_color.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
class Killgame extends StatefulWidget {
  Killgame({Key key}) : super(key: key);

  _DragState ss;

  void reset() =>ss.reset();
  @override
  _DragState createState() => ss = _DragState();
}


class _DragState extends State<Killgame> with AutomaticKeepAliveClientMixin {
  List<MoveableStackItem> movableItems =   List<MoveableStackItem>.generate(16, (int index) {
    double x = (index%6) * 60.0;
    double y =  (index/6).toInt() * 60.0 + 250;
    print(x.toString() + "-" + y.toString());

    return MoveableStackItem(x,y);
  });
  // [MoveableStackItem(),MoveableStackItem()];
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  void reset()
  {
    setState(()
    {

      for(int n=0; n< movableItems.length; n++)
      {  print( n.toString() + " player reset");
      movableItems[n].reset();}
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

       /* body: Stack(
          children: movableItems,
        )*/
       body: Column(
         children:[

           Container(
           height: 30.0,
           //width: 50.0,
           child:Row(
             children: [
             Container(
               width: 60.0,

             child:Text("杀手"),
             ),
               Container(
                 width: 60.0,

                 child:Text("预言家"),
               ),
              Container(
                width: 60.0,

                 child:Text("女巫"),
               ),
               Container(
                 width: 60.0,

                 child:Text("骑士"),
               ),
               Container(
                 width: 60.0,

                 child:Text("猎人"),
               ),
               Container(
                 width: 60.0,

                 child:Text("死人"),
               ),

             ],
           ),
           ),
          Container(
           height: 420.0,
           // width: 300.0,
            child:Stack(
             children: movableItems,
           )
        )
         ]
       )
       );
  }
}


class MoveableStackItem extends StatefulWidget
{
  double xPosition = 0;
  double yPosition = 0;

  _MoveableStackItemState ss;

  void reset()
  {
    ss.reset(xPosition,yPosition);
  }

  MoveableStackItem(double x, double y)
  {
    xPosition = x;
    yPosition = y;
  }

  @override State<StatefulWidget> createState() {
    ss = _MoveableStackItemState(xPosition,yPosition);
    return ss;
  }
}

class _MoveableStackItemState extends State<MoveableStackItem> {
  double xPosition = 0;
  double yPosition = 0;
  _MoveableStackItemState(double x, double y)
  {
    xPosition = x;
    yPosition = y;
  }

  void reset(double x, double y)
  {
    setState(() {
      xPosition = x;
      yPosition = y;
    });
  }
  var po_img = "assets/pic/killers.png";
  File _image =null;
  final picker = ImagePicker();
  String fie_path ;

  Color color;
  @override
  void initState() {
    color = RandomColor().randomColor();
    super.initState();
  }

  Future getImage(  ) async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    fie_path = pickedFile.path;
    setState(() {

      _image = File(pickedFile.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: yPosition,
      left: xPosition,
      child: GestureDetector(
        onPanUpdate: (tapInfo) {
          setState(() {
            xPosition += tapInfo.delta.dx;
            yPosition += tapInfo.delta.dy;
          });
        },
        child:
        /*Container(
          width: 70,
          height: 70,
          color: color,
        ),*/
        Container(
          height: 50.0,
          width: 50.0,
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

      ),
    );
  }
}