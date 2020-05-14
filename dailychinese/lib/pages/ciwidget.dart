
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

class CiWidget extends StatefulWidget {


  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CiViewState();
  }
}

enum TtsState { playing, stopped }

class _CiViewState extends State<CiWidget> with AutomaticKeepAliveClientMixin{
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
    "鹤冲天·黄金榜上.json",
    "更漏子·柳丝长.json",
    "浣溪沙·游蕲水清泉寺.json",
    "定风波·自春来.json",
    "醉花阴·薄雾浓云愁永昼.json",
    "武陵春·春晚.json",
    "鹧鸪天·小令尊前见玉箫.json",
    "小重山·昨夜寒蛩不住鸣.json",
    "霜天晓角·题采石蛾眉亭.json",
    "菩萨蛮·红楼别夜堪惆怅.json",
    "八声甘州·对潇潇暮雨洒江天.json",
    "满庭芳·山抹微云.json",
    "调笑令·边草.json",
    "阮郎归·旧香残粉似当初.json",
    "宴清都·初春.json",
    "蝶恋花·槛菊愁烟兰泣露.json",
    "昭君怨·赋松上鸥.json",
    "捣练子令·深院静.json",
    "满江红·写怀.json",
    "千秋岁·水边沙外.json",
    "鹊踏枝·几日行云何处去.json",
    "减字木兰花·竞渡.json",
    "渔家傲·花底忽闻敲两桨.json",
    "破阵子·四十年来家国.json",
    "点绛唇·感兴.json",
    "南柯子·山冥云阴重.json",
    "花非花.json",
    "洞仙歌·雪云散尽.json",
    "迷仙引·才过笄年.json",
    "秋波媚·七月十六日晚登高兴亭望长安南山.json",
    "长相思·一重山.json",
    "桂枝香·金陵怀古.json",
    "天仙子·水调数声持酒听.json",
    "秦楼月·芳菲歇.json",
    "渔家傲·小雨纤纤风细细.json",
    "念奴娇·断虹霁雨.json",
    "钗头凤·世情薄.json",
    "鹧鸪天·有客慨然谈功名因追念少年时事戏作.json",
    "渔家傲·秋思.json",
    "西江月·问讯湖边春色.json",
    ".DS_Store",
    "满江红·送李御带珙.json",
    "暗香·旧时月色.json",
    "饮马歌·边头春未到.json",
    "望江南·天上月.json",
    "南柯子·十里青山远.json",
    "忆江南·衔泥燕.json",
    "莺啼序·春晚感怀.json",
    "梦江南·兰烬落.json",
    "卜算子·见也如何暮.json",
    "绮罗香·咏春雨.json",
    "忆秦娥·箫声咽.json",
    "卜算子·不是爱风尘.json",
    "浣溪沙·门隔花深梦旧游.json",
    "卜算子·片片蝶衣轻.json",
    "南乡子·乘彩舫.json",
    "蝶恋花·庭院深深深几许.json",
    "相见欢·金陵城上西楼.json",
    "鹧鸪天·己酉之秋苕溪记所见.json",
    "蝶恋花·春涨一篙添水面.json",
    "南歌子·天上星河转.json",
    "渔家傲·近日门前溪水涨.json",
    "一剪梅·舟过吴江.json",
    "西江月·阻风山峰下.json",
    "忆王孙·春词.json",
    "苏幕遮·燎沉香.json",
    "采桑子·恨君不似江楼月.json",
    "六丑·落花.json",
    "永遇乐·彭城夜宿燕子楼.json",
    "蝶恋花·伫倚危楼风细细.json",
    "苍梧谣·天.json",
    "钗头凤·红酥手.json",
    "酒泉子·长忆观潮.json",
    "渔家傲·平岸小桥千嶂抱.json",
    "贺新郎·甚矣吾衰矣.json",
    "瑞龙吟·大石春景.json",
    "临江仙·夜登小阁，忆洛中旧游.json",
    "永遇乐·京口北固亭怀古.json",
    "点绛唇·绍兴乙卯登绝顶小亭.json",
    "柳梢青·茅舍疏篱.json",
    "安公子·远岸收残雨.json",
    "诉衷情·宝月山作.json",
    "湘春夜月·近清明.json",
    "行香子·树绕村庄.json",
    "齐天乐·蟋蟀.json",
    "清平乐·留人不住.json",
    "乌夜啼·昨夜风兼雨.json",
    "双双燕·咏燕.json",
    "清平乐·村居.json",
    "谒金门·花过雨.json",
    "忆江南词三首.json",
    "浣溪沙·漠漠轻寒上小楼.json",
    "青玉案·元夕.json",
    "菩萨蛮·书江西造口壁.json",
    "蝶恋花·送春.json",
    "浣溪沙·五两竿头风欲平.json",
    "风入松·听风听雨过清明.json",
    "摸鱼儿·更能消几番风雨.json",
    "卖花声·题岳阳楼.json",
    "玉楼春·戏林推.json",
    "太常引·建康中秋夜为吕叔潜赋.json",
    "贺圣朝·留别.json",
    "长命女·春日宴.json",
    "踏莎行·春暮.json",
    "杵声齐·砧面莹.json",
    "水调歌头·明月几时有.json",
    "谒金门·风乍起.json",
    "临江仙·梦后楼台高锁.json",
    "渔家傲·天接云涛连晓雾.json",
    "水调歌头·平山堂用东坡韵.json",
    "浣溪沙·一向年光有限身.json",
    "盐角儿·亳社观梅.json",
    "虞美人·春花秋月何时了.json",
    "鹧鸪天·一点残红欲尽时.json",
    "青门引·春思.json",
    "三台·清明应制.json",
    "江城子·西城杨柳弄春柔.json",
    "如梦令·昨夜雨疏风骤.json",
    "蓦山溪·自述.json",
    "踏莎行·候馆梅残.json",
    "清平乐·雨晴烟晚.json",
    "离亭燕·一带江山如画.json",
    "蝶恋花·早行.json",
    "鹧鸪天·重过阊门万事非.json",
    "玉楼春·桃溪不作从容住.json",
    "踏莎行·郴州旅舍.json",
    "念奴娇·赤壁怀古.json",
    "贺新郎·送胡邦衡待制赴新州.json",
    "江城子·示表侄刘国华.json",
    "踏莎行·秋入云山.json",
    "秋蕊香·帘幕疏疏风透.json",
    "清平乐·宫怨.json",
    "清平乐·春晚.json",
    "青玉案·年年社日停针线.json",
    "鹧鸪天·西都作.json",
    "江神子·杏花村馆酒旗风.json",
    "蓦山溪·梅.json",
    "卜算子·黄州定慧院寓居作.json",
    "水调歌头·和庞佑父.json",
    "风入松·一春长费买花钱.json",
    "水龙吟·次韵章质夫杨花词.json",
    "浣溪沙·蓼岸风多橘柚香.json",
    "西江月·堂上谋臣尊俎.json",
    "解语花·上元.json",
    "唐多令·惜别.json",
    "眼儿媚·杨柳丝丝弄轻柔.json",
    "南乡子·登京口北固亭有怀.json",
    "洞仙歌·冰肌玉骨.json",
    "八六子·倚危亭.json",
    "蝶恋花·暖雨晴风初破冻.json",
    "长相思·花深深.json",
    "石州慢·薄雨收寒.json",
    "清平乐·红笺小字.json",
    "望海潮·洛阳怀古.json",
    "浣溪沙·一曲新词酒一杯.json",
    "长相思·汴水流.json",
    "苏幕遮·怀旧.json",
    "鹊桥仙·华灯纵博.json",
    "满江红·题南京夷山驿.json",
    "瑞鹤仙·郊原初过雨.json",
    "一剪梅·红藕香残玉簟秋.json",
    "诉衷情·永夜抛人何处去.json",
    "采莲子·菡萏香莲十顷陂.json",
    "谒金门·春半.json",
    "菩萨蛮·其二.json",
    "三五七言.json",
    "醉垂鞭·双蝶绣罗裙.json",
    "沁园春·答九华叶贤良.json",
    "浣溪沙·簌簌衣巾落枣花.json",
    "巫山一段云·古庙依青嶂.json",
    "蝶恋花·春景.json",
    "西江月·顷在黄州.json",
    "扬州慢·淮左名都.json",
    "水龙吟·楚天千里无云.json",
    "江城子·密州出猎.json",
    "虞美人·听雨.json",
    "浪淘沙·借问江潮与海水.json",
    "贺新郎·九日.json",
    "清平乐·别来春半.json",
    "望海潮·东南形胜.json",
    "鹊踏枝·谁道闲情抛掷久.json",
    "渔歌子·西塞山前白鹭飞.json",
    "虞美人·疏篱曲径田家小.json",
    "菩萨蛮·劝君今夜须沉醉.json",
    "相见欢·无言独上西楼.json",
    "点绛唇·新月娟娟.json",
    "霜天晓角·仪真江上夜泊.json",
    "玉楼春·春景.json",
    "西河·金陵怀古.json",
    "鹧鸪天·座中有眉山隐客史应之和前韵即席答之.json",
    "清平乐·独宿博山王氏庵.json",
    "声声慢·寻寻觅觅.json",
    "唐多令·芦叶满汀洲.json",
    "生查子·元夕.json",
    "踏莎行·自沔东来丁未元日至金陵江上感梦而作.json",
    "水调歌头·送章德茂大卿使虏.json",
    "眼儿媚·迟迟春日弄轻柔.json",
    "六州歌头·长淮望断.json",
    "水调歌头·秋色渐将晚.json",
    "破阵子·为陈同甫赋壮词以寄之.json",
    "破阵子·春景.json",
    "临江仙·未遇行藏谁肯信.json",
    "凤凰台上忆吹箫·香冷金猊.json",
    "诉衷情·当年万里觅封侯.json",
    "疏影·苔枝缀玉.json",
    "卜算子·咏梅.json",
    "惜分飞·泪湿阑干花著露.json",
    "潇湘神·斑竹枝.json",
    "长亭怨慢·渐吹尽.json",
    "念奴娇·闹红一舸.json",
    "西江月·夜行黄沙道中.json",
    "兰陵王·柳.json",
    "菩萨蛮·平林漠漠烟如织.json",
    "贺新郎·寄李伯纪丞相.json",
    "宫中调笑·团扇.json",
    "忆江南.json",
    "贺新郎·西湖.json",
    "浪淘沙·莫上玉楼看.json",
    "西江月·世事一场大梦.json",
    "诉衷情·眉意.json",
    "菩萨蛮·小山重叠金明灭.json",
    "浪淘沙·把酒祝东风.json",
    "菩萨蛮·枕前发尽千般愿.json",
    "满庭芳·夏日溧水无想山作.json",
    "鹧鸪天·彩袖殷勤捧玉钟.json",
    "夜游宫·记梦寄师伯浑.json",
    "减字木兰花·题雄州驿.json",
    "少年游·并刀如水.json",
    "西江月·遣兴.json",
    "水龙吟·春恨.json",
    "浪淘沙令·伊吕两衰翁.json",
    "相见欢·林花谢了春红.json",
    "女冠子·昨夜夜半.json",
    "临江仙·暮春.json",
    "鹧鸪天·寒日萧萧上琐窗.json",
    "山亭柳·赠歌者.json",
    "永遇乐·落日熔金.json",
    "青玉案·凌波不过横塘路.json",
    "摸鱼儿·东皋寓居.json",
    "减字木兰花·莎衫筠笠.json",
    "蝶恋花·醉别西楼醒不记.json",
    "丑奴儿·书博山道中壁.json",
    "凤箫吟·锁离愁.json",
    "点绛唇·蹴罢秋千.json",
    "雨霖铃·寒蝉凄切.json",
    "卜算子·我住长江头.json",
    "点绛唇·丁未冬过吴松作.json",
    "夜游宫·叶下斜阳照水.json",
    "兰陵王·丙子送春.json",
    "念奴娇·过洞庭.json",
    "水龙吟·过南剑双溪楼.json",
    "贺新郎·送陈真州子华.json",
    "贺新郎·别茂嘉十二弟.json",
    "虞美人·风回小院庭芜绿.json",
    "定风波·莫听穿林打叶声.json",
    "卜算子·送鲍浩然之浙东.json",
    "六州歌头·少年侠气.json",
    "思越人·紫府东风放夜时.json",
    "女冠子·四月十七.json",
    "长相思·吴山青.json",
    "生查子·新月曲如眉.json",
    "宴山亭·北行见杏花.json",
    "清平乐·年年雪里.json",
    "如梦令·常记溪亭日暮.json",
    "江城子·乙卯正月二十日夜记梦.json",
    "水调歌头·游览.json",
    "长相思·惜梅.json",
    "好事近·摇首出红尘.json",
    "卜算子·独自上层楼.json",
    "好事近·七月十三日夜登万花川谷望月作.json",
    "思帝乡·春日游.json",
    "玉楼春·春思.json",
    "定风波·南海归赠王定国侍人寓娘.json",
    "竹枝词·山桃红花满上头.json",
    "江城子·画楼帘幕卷新晴.json",
    ".json",
    "西江月·新秋写兴.json",
    "浣溪沙·红蓼渡头秋正雨.json",
    "摊破浣溪沙·菡萏香销翠叶残.json",
    "青门饮·寄宠人.json",
    "临江仙·夜饮东坡醒复醉.json",
    "踏莎行·杨柳回塘.json",
    "鹊桥仙·纤云弄巧.json",
    "清平乐·春归何处.json",
    "柳梢青·岳阳楼.json",
    "千秋岁·数声鶗鴂.json",
    "浪淘沙令·帘外雨潺潺.json",
    "望江南·梳洗罢.json",
    "鹊踏枝·叵耐灵鹊多谩语.json",
    "忆秦娥·与君别.json"
  ];


  Future<dynamic> loadAsset({BuildContext context}) async {
    file_name = 'assets/ci_json/' + files[index];
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
                      if (_isRecording) {
                        stopRecorder();
                        startPlayer();
                      }
                      else
                        startRecorder();
                    },


                    child: rec,
                  ),
                  FloatingActionButton(
                    heroTag: "btnPlayRecord",
                    onPressed: () {
                      _speak();
                    },
                    child:ply,
                  ),
                  FloatingActionButton(
                    heroTag: "btnNext",
                    onPressed: () {
                     setState(() {
                       print("i do");
                       file_name = 'assets/a2.json';
                     });
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