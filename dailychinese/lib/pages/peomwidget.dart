
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
  String file_name = 'assets/ci_json/三五七言.json';
  int index = 0;
  List<String> files= [
    "次北固山下.json",
    "宿王昌龄隐居.json",
    "送魏万之京.json",
    "过故人庄.json",
    "长干行·君家何处住.json",
    "石鱼湖上醉歌.json",
    "酬程延秋夜即事见赠.json",
    "归嵩山作.json",
    "饯别王十一南游.json",
    "西施咏.json",
    "长干行·其一.json",
    "秋夕.json",
    "早秋三首·其一.json",
    "寄扬州韩绰判官.json",
    "感遇十二首·其二.json",
    "咏蝉.json",
    "草 .json",
    "江南曲.json",
    "春宫怨.json",
    "同题仙游观.json",
    "回乡偶书.json",
    "石鼓歌.json",
    "清平调·其一.json",
    "游子吟.json",
    "关山月.json",
    "灞上秋居.json",
    "月下独酌四首·其一.json",
    "琴歌.json",
    "春怨 .json",
    "题大庾岭北驿.json",
    "秋登万山寄张五.json",
    "喜外弟卢纶见宿.json",
    "喜见外弟又言别.json",
    "奉和中书舍人贾至早朝大明宫.json",
    "没蕃故人.json",
    "长相思·其二.json",
    "蝉.json",
    "琵琶行并序.json",
    "已凉.json",
    "泊秦淮.json",
    "登柳州城楼寄漳汀封连四州.json",
    "兵车行.json",
    "桃源行.json",
    "为有.json",
    "送杜少府之任蜀州.json",
    ".DS_Store",
    "贼平后送人北归.json",
    "利州南渡.json",
    "终南别业.json",
    "山石.json",
    "行路难·其一.json",
    "近试上张籍水部.json",
    "玉台体.json",
    "蜀道难.json",
    "题金陵渡.json",
    "九月九日忆山东兄弟.json",
    "嫦娥.json",
    "和张仆射塞下曲·其一.json",
    "无题·来是空言去绝踪.json",
    "清平调·名花倾国两相欢.json",
    "哥舒歌.json",
    "锦瑟.json",
    "送别.json",
    "长沙过贾谊宅.json",
    "书边事.json",
    "天末怀李白.json",
    "登岳阳楼.json",
    "夜泊牛渚怀古.json",
    "宿府.json",
    "塞下曲.json",
    "送陈章甫.json",
    "遣悲怀三首·其三.json",
    "题破山寺后禅院.json",
    "秋日登吴公台上寺远眺.json",
    "遣怀.json",
    "古柏行.json",
    "子夜吴歌·春歌.json",
    "无题·昨夜星辰昨夜风.json",
    "秋日赴阙题潼关驿楼.json",
    "玉阶怨.json",
    "遣悲怀三首·其二.json",
    "江州重别薛六柳八二员外.json",
    "九日登望仙台呈刘明府容.json",
    "集灵台·其一.json",
    "咏怀古迹五首·其一.json",
    "新年作.json",
    "黄鹤楼.json",
    "旅宿.json",
    "丽人行.json",
    "风雨.json",
    "寄人.json",
    "溪居.json",
    "韦讽录事宅观曹将军画马图.json",
    "金陵图.json",
    "子夜吴歌·冬歌.json",
    "酬郭给事.json",
    "静夜思.json",
    "渡汉江.json",
    "赠别二首·其一.json",
    "观公孙大娘弟子舞剑器行.json",
    "宿业师山房期丁大不至.json",
    "落花.json",
    "蜀先主庙.json",
    "寻陆鸿渐不遇.json",
    "春雨.json",
    "听弹琴.json",
    "烈女操.json",
    "八阵图.json",
    "佳人.json",
    "枫桥夜泊.json",
    "送杨氏女.json",
    "与诸子登岘山.json",
    "老将行.json",
    "和贾舍人早朝大明宫之作.json",
    "赤壁.json",
    "问刘十九.json",
    "梦李白二首·其二.json",
    "新嫁娘词.json",
    "听董大弹胡笳声兼寄语弄房给事.json",
    "听筝鸣筝.json",
    "感遇十二首·其四.json",
    "岁暮归南山.json",
    "无题.json",
    "自夏口至鹦鹉洲夕望岳阳寄源中丞.json",
    "秦中感秋寄远上人.json",
    "逢入京使.json",
    "和乐天春词.json",
    "相思.json",
    "送梓州李使君.json",
    "丹青引赠曹将军霸.json",
    "塞下曲·其一.json",
    "奉和圣制从蓬莱向兴庆阁道中留春雨中春望之作应制.json",
    "滁州西涧.json",
    "西塞山怀古.json",
    "春泛若耶溪.json",
    " 送崔九.json",
    "金缕衣.json",
    "送李少府贬峡中王少府贬长沙.json",
    "夕次盱眙县.json",
    "金陵酒肆留别.json",
    "长恨歌.json",
    "渔翁.json",
    "寄全椒山中道士.json",
    "乐游原 .json",
    "云阳馆与韩绅宿别.json",
    "终南望余雪 .json",
    "赠卫八处士.json",
    "渭川田家.json",
    "青溪 .json",
    "宣州谢脁楼饯别校书叔云.json",
    "将赴吴兴登乐游原一绝.json",
    "隋宫.json",
    "瑶瑟怨.json",
    "月夜.json",
    "无题·重帏深下莫愁堂.json",
    "积雨辋川庄作.json",
    "八月十五夜赠张功曹.json",
    "梦游天姥吟留别.json",
    "同从弟南斋玩月忆山阴崔少府.json",
    "贾生.json",
    "野望.json",
    "怨情.json",
    "将进酒.json",
    "和张仆射塞下曲·其二.json",
    "哀江头.json",
    "行宫.json",
    "赠孟浩然.json",
    "遣悲怀三首·其一.json",
    "听安万善吹觱篥歌.json",
    "听蜀僧濬弹琴 .json",
    "咏怀古迹五首·其二.json",
    "集灵台·其二.json",
    "古意.json",
    "出塞.json",
    "送方外上人 .json",
    "白雪歌送武判官归京.json",
    "苏武庙.json",
    "宿建德江.json",
    "咏怀古迹五首·其三.json",
    "蜀相.json",
    "瑶池.json",
    "下终南山过斛斯山人宿置酒.json",
    "谷口书斋寄杨补阙.json",
    "终南山.json",
    "春宫曲.json",
    "初发扬子寄元大校书.json",
    "行路难·其三.json",
    "山居秋暝.json",
    "寄令狐郎中.json",
    "长干行·家临九江水.json",
    "古意呈补阙乔知之.json",
    "过香积寺.json",
    "行路难·其二.json",
    "赠阙下裴舍人.json",
    "闺怨.json",
    "陇西行四首·其二.json",
    "送元二使安西.json",
    "感遇·江南有丹橘.json",
    "奉济驿重送严公四韵.json",
    "清平调·其二.json",
    "鹿柴.json",
    "行经华阴.json",
    "宫词二首·其一.json",
    "望蓟门.json",
    "江南逢李龟年.json",
    "咏怀古迹五首·其五.json",
    "送李中丞之襄州 .json",
    "长相思·其一.json",
    "江雪.json",
    "金谷园.json",
    "辋川闲居赠裴秀才迪.json",
    "送灵澈上人.json",
    "登鹳雀楼.json",
    "寒食.json",
    "登金陵凤凰台.json",
    "登楼.json",
    "北青萝.json",
    "子夜吴歌·秋歌.json",
    "寻南溪常道士.json",
    "登高.json",
    "晨诣超师院读禅经.json",
    "淮上喜会梁川故人 .json",
    "宫词 .json",
    "长信怨.json",
    "无题·飒飒东风细雨来.json",
    "桃花溪.json",
    "感遇十二首·其一.json",
    "送人东游.json",
    "寻西山隐者不遇.json",
    "韩碑.json",
    "贫女.json",
    "渡荆门送别.json",
    "客夜与故人偶集 .json",
    "洛阳女儿行.json",
    "走马川行奉送出师西征 .json",
    "留别王维.json",
    "长安遇冯著.json",
    "和晋陵陆丞早春游望.json",
    "东郊.json",
    "别房太尉墓.json",
    "宿桐庐江寄广陵旧游.json",
    "汉江临泛 .json",
    "杂诗三首·其二.json",
    "寄左省杜拾遗.json",
    "春晓.json",
    "轮台歌奉送封大夫出师西征.json",
    "谒衡岳庙遂宿岳寺题门楼.json",
    "赋得暮雨送李胄 .json",
    "与高适薛据同登慈恩寺浮图.json",
    "寄韩谏议注.json",
    "秋夜寄邱员外.json",
    "哀王孙.json",
    "阁夜.json",
    "阙题.json",
    "杂诗三首·其三.json",
    "黄鹤楼送孟浩然之广陵.json",
    "夏日南亭怀辛大.json",
    "至德二载甫自京金光门出间道归凤翔乾元初…有悲往事.json",
    "和张仆射塞下曲·其四.json",
    "无题·凤尾香罗薄几重.json",
    "春思.json",
    "马嵬坡.json",
    "望岳.json",
    "送友人.json",
    "旅夜书怀.json",
    "楚江怀古三首·其一.json",
    "望月有感.json",
    "送僧归日本.json",
    "后宫词.json",
    "春望.json",
    "咏怀古迹五首·其四.json",
    "清明日宴梅道士房.json",
    "子夜吴歌·夏歌.json",
    "晚次鄂州.json",
    "夜归鹿门山歌 .json",
    "贼退示官吏.json",
    "早寒江上有怀 .json",
    "庐山谣寄卢侍御虚舟.json",
    "经邹鲁祭孔子而叹之.json",
    "凉思.json",
    "竹里馆.json",
    "征怨.json",
    "孤雁二首·其二.json",
    "早发白帝城 .json",
    "章台夜思.json",
    "古从军行.json",
    "乌衣巷.json",
    "客至.json",
    "李端公 .json",
    "梦李白二首·其一.json",
    "酬张少府.json",
    "郡斋雨中与诸文士燕集.json",
    "凉州词.json",
    "月夜忆舍弟.json",
    "秋夜曲.json",
    "登幽州台歌.json",
    "夜上受降城闻笛.json",
    "赠内人.json",
    "望月怀古.json",
    "闻官军收河南河北.json",
    "芙蓉楼送辛渐.json",
    "筹笔驿.json",
    "送綦毋潜落第还乡.json",
    "夜雨寄北.json",
    "春宿左省.json",
    "赠别二首·其二.json",
    "寻隐者不遇.json",
    "燕歌行并序.json",
    "寄李儋元锡.json",
    "除夜 .json",
    "望洞庭湖赠张丞相.json"
    ];

  Future<dynamic> loadAsset({BuildContext context}) async {
    file_name = 'assets/shi_json/' + files[index];

    String str =  await DefaultAssetBundle.of(context).loadString(file_name);
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



    String path = await flutterSound.startPlayer("assets/mp3/123.mp3", whenFinished: () {
      this.setState(() {
        print("end play");
        ply = Icon(Icons.play_circle_filled);
      });
    });
    print("Play -- $path");
    File file= await new File("assets/mp3/123.mp3");
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

    if (peom != null) {
      if (peom.isNotEmpty) {
        var result = await flutterTts.speak(peom);
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
              image: AssetImage("assets/head3.jpeg"),
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
                    image: AssetImage("assets/bc.png"),
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
                ),

              ),

              //Peom
              Container(
                width:  (MediaQuery.of(context).size.width)-50,
               // height: (MediaQuery.of(context).size.height) / 3,
                /*decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage("assets/head4.jpeg"),
                    fit: BoxFit.cover,
                  ),
                ),
                */

                child:  Row(
                  children: <Widget>
                  [
                  Container(
                  width:  (MediaQuery.of(context).size.width)-100,
                  child: peomW,
                ),
                    Column(
                        children: <Widget>[
                          IconButton(

                            onPressed: () {
                              alertTitle = title;
                              alertContent = desc;
                              _showDialog();
                            },
                            color: Colors.blue,
                            icon:Icon(Icons.title),

                          ),
                          IconButton(


                            onPressed: () {
                              alertTitle = title;
                              alertContent = extension1;
                              _showDialog();
                            },
                            color: Colors.blue,
                            icon: Icon(Icons.email),
                          ),
                          IconButton(

                            onPressed: () {
                              alertTitle = title;
                              alertContent = extension2;
                              _showDialog();
                            },
                            color: Colors.blue,
                            icon: Icon(Icons.audiotrack),
                          ),
                         /* IconButton(

                            onPressed: () {
                              if (_isRecording)
                              {
                                stopRecorder();
                                startPlayer();
                              }
                              else
                                startRecorder();
                            },
                            color: Colors.blue,
                            icon: rec,
                          ),*/
                          ]
                    )
                  ]
                ),

              ),

            ],
          ),
        ),
        floatingActionButton: Container(
            height: 80,
          //width: (MediaQuery.of(context).size.width),
          //  alignment:Alignment.bottomCenter,
            child:Column(
              children: <Widget>[

                Container(
                    height: 30.0,
                    child: Slider(
                        value: slider_current_position,
                        min: 0.0,
                        activeColor: Colors.white,
                        max: max_duration,
                        onChanged: (double value) async {
                          await flutterSound.seekToPlayer(value.toInt());
                        },
                        divisions: max_duration.toInt())
                ),
                Row(
                  //crossAxisAlignment:CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    IconButton(
                      onPressed: () {
                        setState(() {
                          print("i do");
                          index--;
                        });
                      },
                      color:Colors.white,
                      icon: Icon(Icons.skip_previous),
                    ),
/*
                    IconButton(
                      onPressed: () {
                        startPlayer();

                      },
                      color: Colors.white,
                      icon: Icon(Icons.play_circle_outline),
                    ),
                    IconButton(
                      onPressed: () {

                      },
                      color:Colors.white,
                      icon: Icon(Icons.pause),
                    ),
                    IconButton(
                      onPressed: () {
                        stopPlayer();
                      },
                      color:Colors.white,
                      icon: Icon(Icons.stop),
                    ),

*/
                    IconButton(
                      onPressed: () {
                        setState(() {
                          print("i do");
                          index++;
                        });
                      },
                      color:Colors.white,
                      icon: Icon(Icons.skip_next),
                    ),


                  ],
                ),

              ],
            ),


        ),

        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      ),

    );
  }

}