import 'package:flutter/material.dart';

class MyIconButton extends StatefulWidget {

  Icon _ic;
  final GestureTapCallback onPressed;

  MyIconButton(Icon ic,this.onPressed)
  {
   _ic = ic;
  }
  @override
  State<StatefulWidget> createState()
  {
    // TODO: implement createState
    return MyButtonState(_ic,onPressed);
  }

}


class MyButtonState extends State<MyIconButton>
{
  Icon _ic;
  final GestureTapCallback onPressedFun;
  Color clr = Colors.blue;
  bool _set = false;

  MyButtonState(Icon ic,this.onPressedFun)
  {
    _ic = ic;
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
        icon: _ic,
        color: clr,
        highlightColor: Colors.red,
        hoverColor: Colors.green,
        focusColor: Colors.purple,
        splashColor: Colors.yellow,
        disabledColor: Colors.amber,
        iconSize: 24,
        //key: ,

        onPressed: onPressedFun,
    );


  }
  
}