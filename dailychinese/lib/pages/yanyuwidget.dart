
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'dart:io';
import 'package:intl/intl.dart';

import 'dart:async';
import 'package:flutter_sound/flutter_sound.dart';

import 'package:SharkFlutter/models/shopmodel.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:lunar_calendar_converter/lunar_solar_converter.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

import 'package:flutter/foundation.dart';

class YanyuWidget extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _YanyuWidgetState();
  }
}

enum TtsState { playing, stopped }

class _YanyuWidgetState extends State<YanyuWidget> with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;


  String peom = "";

  String file_name = 'assets/yanyu.txt';
  int index = 0;

  List<String> lines;


  Future<String> loadAsset({BuildContext context}) async {

    String str =  await DefaultAssetBundle.of(context).loadString(file_name);
    lines = str.split("\n");
    peom = lines[index];
    print ("yanyu");
    print(peom);
    return (peom);

  }

  @override
  void initState() {
    super.initState();

    print("2");


    var now = new DateTime.now();
    Solar solar = Solar(solarYear: now.year, solarMonth: now.month, solarDay: now.day);
    Lunar lunar = LunarSolarConverter.solarToLunar(solar);
    lunar.toString();
    print(lunar);
  }



  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final model = Provider.of<ShopModel>(context);
    final textSize = Provider.of<int>(context).toDouble();

    var peomW = FutureBuilder(
      future: loadAsset(context: context),
      builder: (BuildContext context, AsyncSnapshot<String> jsonData) {
        if (jsonData.toString().isNotEmpty) {
          return RichText(
            text: TextSpan(
              text: peom,
              style: DefaultTextStyle
                  .of(context)
                  .style,
              children: <TextSpan>[
              ],
            ),
          );
        }
       else
         return Text('no loaded'); // here you want to process your data
      },
    );


    var now = new DateTime.now();
    Solar solar = Solar(solarYear: now.year, solarMonth: now.month, solarDay: now.day);
    Lunar lunar = LunarSolarConverter.solarToLunar(solar);
    lunar.toString();
    String formattedDate =  lunar.toString();


    // Remove the MediaQuery padding because the demo is rendered inside of a
    // different page that already accounts for this padding.
    return MediaQuery.removePadding(
      context: context,
      //removeTop: true,
      removeBottom: true,

      child: Scaffold(

        body: Container(
          width: double.infinity,
          height: double.infinity,

          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage("assets/head1.jpg"),
              fit: BoxFit.cover,
            ),
          ),


          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            //crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //calendar
              Container(
                width:  (MediaQuery.of(context).size.width)-50,
                height: (MediaQuery.of(context).size.height) / 5,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/head7.jpg"),
                    fit: BoxFit.cover,
                  ),
                ),
                // child:Text(formattedDate),
                child: Column(
                  children: <Widget>[
                    Text(formattedDate,
                      textAlign: TextAlign.center,
                      style: new TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0,
                        color: Colors.amber,
                      ),
                    ),
                    Container(
                      //padding: const EdgeInsets.all(6.0),
                      width: (MediaQuery.of(context).size.width)-200,
                      alignment:Alignment.bottomRight,

                      child:Row(

                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text(now.day.toString(),
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 40.0,
                            color: Colors.deepOrange,
                          ),
                        ),
                        Text( " ",
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 25.0,
                            color: Colors.deepOrange,
                          ),
                        ),
                        Text(DateFormat('EEEE').format(now),
                          textAlign: TextAlign.center,
                          style: new TextStyle(
                            fontStyle: FontStyle.normal,
                            fontSize: 20.0,
                            color: Colors.deepOrange,
                          ),
                        ),
                      ],
                    ),
                    ),

                    Text(DateFormat("yyyy-MM").format(now),
                      textAlign: TextAlign.left,
                      style: new TextStyle(
                        fontStyle: FontStyle.normal,
                        fontSize: 20.0,
                        color: Colors.deepPurpleAccent,
                      ),
                    )

                  ],
                )

               ,


              ),

              //Peom
              Container(
                width:  (MediaQuery.of(context).size.width)-50,
               // height: (MediaQuery.of(context).size.height) / 3,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/head4.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
                child: peomW,

              ),



            ],
          ),
        ),

        floatingActionButton: Container(
          height: 80,
          //width: (MediaQuery.of(context).size.width),
          //  alignment:Alignment.bottomCenter,
          child: Row(
                //crossAxisAlignment:CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  IconButton(
                    onPressed: () {
                      setState(() {
                        print("i do");
                        index--;
                        peom = lines[index];
                      });
                    },
                    color:Colors.white,
                    icon: Icon(Icons.skip_previous),
                  ),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        print("i do");
                        index++;
                        peom = lines[index];
                      });
                    },
                    color:Colors.white,
                    icon: Icon(Icons.skip_next),
                  ),

                ],
              ),

        ),

      ),

    );
  }

}