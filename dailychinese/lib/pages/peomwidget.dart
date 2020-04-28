
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

class PeomWidget extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _PeomViewState();
  }
}

enum TtsState { playing, stopped }

class _PeomViewState extends State<PeomWidget> with AutomaticKeepAliveClientMixin{
  @override
  // TODO: implement wantKeepAlive
  bool get wantKeepAlive => true;

  FlutterTts flutterTts;
  TtsState ttsState = TtsState.stopped;

  dynamic languages;
  String language;

  double volume = 0.5;
  double pitch = 1.0;
  double rate = 0.5;

  String _newVoiceText;


  bool _isRecording = false;
  bool _isPlaying = false;
  StreamSubscription _recorderSubscription;
  StreamSubscription _dbPeakSubscription;
  StreamSubscription _playerSubscription;
  FlutterSound flutterSound;

  String _recorderTxt = '00:00:00';
  String _playerTxt = '00:00:00';
  double _dbLevel;

  double slider_current_position = 0.0;
  double max_duration = 1.0;

  Icon rec = Icon(Icons.mic);
  Icon ply = Icon(Icons.play_circle_filled);
  String title = "";
  String peom = "";
  String author = "";
  String desc ="";
  String extension1 ="";
  String extension2 ="";

  String alertTitle;
  String alertContent;


  Future<dynamic> loadAsset({BuildContext context}) async {

    String str =  await DefaultAssetBundle.of(context).loadString('assets/a1.json');
    Map<String, dynamic> user = jsonDecode(str);
    print("3");
    print(user['title']);
    print(user['poem']);

    print("-------");
    title = user['title'];
    peom = user['poem'];
    author = user["author"];
    desc = user["description"];
    extension1 = user["extension1"];
    extension2 = user["extension2"];
    return json.decode(str);

  }

  void startRecorder() async {
    try {

      String path = await flutterSound.startRecorder();
      print("数据$path");

      _recorderSubscription = flutterSound.onRecorderStateChanged.listen((e) {
        DateTime date = new DateTime.fromMillisecondsSinceEpoch(
            e.currentPosition.toInt(),
            isUtc: true);
        // print("时长$date");
        String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);

        this.setState(() {
          this._recorderTxt = txt.substring(0, 8);
          rec = Icon(Icons.stop);
        });
      });


      this.setState(() {
        this._isRecording = true;
        rec = Icon(Icons.stop);
      });
    } catch (err) {
      print('startRecorder error: $err');
    }
  }

  void stopRecorder() async {
    try {
      String result = await flutterSound.stopRecorder();
      print('停止录音返回结果: $result');

      if (_recorderSubscription != null) {
        _recorderSubscription.cancel();
        _recorderSubscription = null;
      }
      if (_dbPeakSubscription != null) {
        _dbPeakSubscription.cancel();
        _dbPeakSubscription = null;
      }

      this.setState(() {
        this._isRecording = false;
        rec = Icon(Icons.mic);
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  void startPlayer() async {
   // path = await playerModule.startPlayer(audioFilePath, codec: _codec, whenFinished: () {
   //   print('Play finished');
   //   setState(() {});
  //  });



    String path = await flutterSound.startPlayer("/data/user/0/com.sharklib.sharkflutter/cache/flauto.aac", whenFinished: () {
      this.setState(() {
        print("end play");
        ply = Icon(Icons.play_circle_filled);
      });
    });
    print("Play -- $path");
    File file= await new File("/data/user/0/com.sharklib.sharkflutter/cache/flauto.aac");
    List contents = await file.readAsBytesSync();

    // return print("file文件：$contents");
    await flutterSound.setVolume(1.0);
    print('startPlayer: $path');

    try {
      _playerSubscription = flutterSound.onPlayerStateChanged.listen((e) {
        if (e != null) {

          slider_current_position = e.currentPosition;
          max_duration = e.duration;

          DateTime date = new DateTime.fromMillisecondsSinceEpoch(
              e.currentPosition.toInt(),
              isUtc: true);
          String txt = DateFormat('mm:ss:SS', 'en_GB').format(date);
          this.setState(() {
            this._isPlaying = true;
            this._playerTxt = txt.substring(0, 8);
            ply = Icon(Icons.stop);
          });
        }
        else
          {
            print("NULL----");
            this.setState(() {
              this._isPlaying = true;
             // this._playerTxt = txt.substring(0, 8);
              ply = Icon(Icons.play_circle_filled);
            });
          }
      });
    } catch (err) {
      print('error: $err');
    }
  }

  void stopPlayer() async {
    try {
      String result = await flutterSound.stopPlayer();
      print('stopPlayer: $result');
      if (_playerSubscription != null) {
        _playerSubscription.cancel();
        _playerSubscription = null;
      }

      this.setState(() {
        this._isPlaying = false;
        ply = Icon(Icons.play_circle_filled);
      });
    } catch (err) {
      print('error: $err');
    }
  }

  void pausePlayer() async {
    String result = await flutterSound.pausePlayer();
    print('pausePlayer: $result');
  }

  void resumePlayer() async {
    String result = await flutterSound.resumePlayer();
    print('resumePlayer: $result');
  }

  void seekToPlayer(int milliSecs) async {
    String result = await flutterSound.seekToPlayer(milliSecs);
    print('seekToPlayer: $result');
  }



  initTts() {
    flutterTts = FlutterTts();

    print("init tts");

    flutterTts.setStartHandler(() {
      setState(() {
        print("playing");
        ttsState = TtsState.playing;
      });
    });

    flutterTts.setCompletionHandler(() {
      setState(() {
        print("Complete");
        ttsState = TtsState.stopped;
      });
    });

    flutterTts.setErrorHandler((msg) {
      setState(() {
        print("error: $msg");
        ttsState = TtsState.stopped;
      });
    });
  }

  Future _getLanguages() async {
    languages = await flutterTts.getLanguages;
    if (languages != null) setState(() => languages);
  }

  Future _speak() async {
    await flutterTts.setVolume(volume);
    await flutterTts.setSpeechRate(rate);
    await flutterTts.setPitch(pitch);

    if (_newVoiceText != null) {
      if (_newVoiceText.isNotEmpty) {
        var result = await flutterTts.speak(_newVoiceText);
        if (result == 1)
          {
            setState(() => ttsState = TtsState.playing);
            print("not 1");
          }
        else
          {
            print("not 1");
          }
      }
    }
  }

  @override
  void initState() {
    super.initState();
    initTts();
    print("1");
    //loadAsset(context);

    print("2");

    flutterSound = new FlutterSound();
    flutterSound.setSubscriptionDuration(0.01);
    flutterSound.setDbPeakLevelUpdate(0.8);
    flutterSound.setDbLevelEnabled(true);
    initializeDateFormatting();

    var now = new DateTime.now();
    Solar solar = Solar(solarYear: now.year, solarMonth: now.month, solarDay: now.day);
    Lunar lunar = LunarSolarConverter.solarToLunar(solar);
    lunar.toString();
    print(lunar);
  }


  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title:  Text(alertTitle),
          content:  SingleChildScrollView(
            child:  Text((alertContent),
          ),
          ),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }


  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final model = Provider.of<ShopModel>(context);
    final textSize = Provider.of<int>(context).toDouble();

    var peomW = FutureBuilder(
      future: loadAsset(context: context),
      builder: (BuildContext context, AsyncSnapshot<dynamic> jsonData) {
        if (jsonData.hasData) {
         return  Column(

            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(title,
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 28.0,
                  color: Colors.deepOrange,
                ),
              ),
              Text( " ",
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 5.0,
                  color: Colors.deepOrange,
                ),
              ),
              Text(peom,
                textAlign: TextAlign.center,
                style: new TextStyle(
                  fontStyle: FontStyle.normal,
                  fontSize: 20.0,
                  color: Colors.deepOrange,
                ),
              ),

            ],
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
                    image: AssetImage("assets/head5.jpg"),
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
            height: 40,
           // width: 180,
            alignment:Alignment.bottomRight,
            child: Padding(

              padding: const EdgeInsets.all(8.0),


              child: Row(
                crossAxisAlignment:CrossAxisAlignment.end,
                //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[

                  FloatingActionButton(
                    heroTag: "btnTTS1",
                    onPressed: () {
                      alertTitle = title;
                      alertContent = desc;
                      _showDialog();
                    },
                    child: Icon(Icons.title),
                  ),
                  FloatingActionButton(
                    heroTag: "btnTTS2",
                    onPressed: () {
                      alertTitle = title;
                      alertContent = extension1;
                      _showDialog();
                    },
                    child: Icon(Icons.email),
                  ),
                  FloatingActionButton(
                    heroTag: "btnTTS3",
                    onPressed: () {
                      alertTitle = title;
                      alertContent = extension2;
                      _showDialog();
                    },
                    child: Icon(Icons.audiotrack),
                  ),
                  FloatingActionButton(
                    heroTag: "btnMic",
                    onPressed: () {
                      if (_isRecording)
                        stopRecorder();
                      else
                        startRecorder();
                    },


                    child: rec,
                  ),
                  FloatingActionButton(
                    heroTag: "btnPlayRecord",
                    onPressed: () {
                          startPlayer();
                    },
                    child:ply,
                  ),
                  FloatingActionButton(
                    heroTag: "btnNext",
                    onPressed: () {
                      _newVoiceText = peom;
                      _speak();
                    },
                    child: Icon(Icons.skip_next),
                  )

                ],
              ),
            )
        ),


      ),

    );
  }

}