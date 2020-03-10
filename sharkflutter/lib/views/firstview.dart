import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:SharkFlutter/models/shopmodel.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'package:SharkFlutter/widget/linear_percent_indicator.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_github_api/flutter_github_api.dart';
//import 'package:flutter_github_api/entity/index.dart';
//User user;

/*
 //导航到新路由  1)
          Navigator.push( context,
           MaterialPageRoute(builder: (context) {
              return NewRoute();
           }));
           2)
       Navigator.pushNamed(context, '/login')  ;

返回值是一个Future对象
       bool pop(BuildContext context, [ result ])


       在路由页通过RouteSetting对象获取路由参数：

class EchoRoute extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    //获取路由参数
    var args=ModalRoute.of(context).settings.arguments;
    //...省略无关代码
  }
}
在打开路由时传递参数

Navigator.of(context).pushNamed("new_page", arguments: "hi");
* */
class FirstPage extends StatefulWidget {
  FirstPage({Key key, this.title}) : super(key: key);

  final String title;
  //final BaseAuth auth;

  @override
  _FirstPageState createState() => new _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {

  TextEditingController unameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  GlobalKey formKey = new GlobalKey<FormState>();

  Future ListDir(pathStr) async
  {

    //print(pathStr);
    var dir = Directory(pathStr);
    final bExist = await dir.exists();
    if (bExist)
      {
        print(pathStr + " is existed");
        dir.list().listen((FileSystemEntity entity) {
          print(entity.path);
        });
      }
    else
      {
        print(pathStr + " is not existed");
      }
  }
  Future WriteFile() async
  {
    final directory = await getApplicationDocumentsDirectory();

    await ListDir(directory.path);
    await ListDir(directory.parent.path);
    await ListDir('/data/user/0/Downloads');
    await ListDir('/data/user/0/Download');
    await ListDir('/storage/emulated/0/Download');
    await ListDir('/storage/emulated/0/DCIM');
    await ListDir('/storage/emulated/0/Downloads');



    final aa = File('/storage/emulated/0/DCIM/counter.txt');
    bool hh =  await aa.exists();
    if (hh)
      print("File alread exist");
    else
      aa.writeAsStringSync("abcd");
  }

  Future ReadFile() async
  {
    final aa = File('/storage/emulated/0/Download/counter.txt');
    bool hh =  await aa.exists();
    if (hh)
      {
        var s = await aa.readAsString();
        print( s );
      }
  }

  Wrap CreatWrap()
  {
    return Wrap(
      spacing: 8.0, // 主轴(水平)方向间距
      runSpacing: 4.0, // 纵轴（垂直）方向间距
      alignment: WrapAlignment.center, //沿主轴方向居中
      children: <Widget>[
        ActionChip(
            avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('C')),
            label: new Text('Camera'),
            onPressed: () {
              //print("If you stand for nothing, Burr, what’ll you fall for?");
              Navigator.pushNamed(this.context, '/Camera');
            }
        ),
        ActionChip(
            avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('S')),
            label: new Text('Shop'),
            onPressed: () {
              Navigator.pushNamed(this.context, '/shop');
            }
        ),
        ActionChip(
            avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('I')),
            label: new Text('Internet'),
            onPressed: () {
              Navigator.pushNamed(this.context, '/internet');
            }
        ),
        ActionChip(
            avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
            label: new Text('Music'),
            onPressed: () {
              Navigator.pushNamed(this.context, '/musicview');
            }
        ),
        ActionChip(
            avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('F')),
            label: new Text('File'),
          onPressed: () async{
            File file = await FilePicker.getFile();
          },
        ),
        ActionChip(
            avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('F')),
            label: new Text('File Manager'),
            onPressed: () {
              Navigator.pushNamed(this.context, '/fm');
            }
        ),
        ActionChip(
            avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
            label: new Text('Music'),
            onPressed: () {
              Navigator.pushNamed(this.context, '/musicview');
            }
        ),
        ActionChip(
            avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
            label: new Text('Music'),
            onPressed: () {
              Navigator.pushNamed(this.context, '/musicview');
            }
        ),
        ActionChip(
            avatar: new CircleAvatar(backgroundColor: Colors.blue, child: Text('M')),
            label: new Text('Music'),
            onPressed: () {
              Navigator.pushNamed(this.context, '/musicview');
            }
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final model = Provider.of<ShopModel>(context);
    final textSize = Provider.of<int>(context).toDouble();



    var loginButton = new ButtonBar( children: <Widget>[
      FlatButton(
        child: Text( model.user == null? 'Login':"Logout"),
        key: Key('MainPageLogin'),
        color: Colors.blue,
        onPressed: () {
          //login("huang.rong.bj@gmail.com","Good2017!");
          model.user == null?Navigator.pushNamed(context, '/login') : model.logout();
        },
      ),
      FlatButton(
        child: Text('Cancel'),
        color: Colors.blue,
        onPressed: () {
          if ((formKey.currentState as FormState).validate()) {
            //验证通过提交数据
            print("ffff");
          }
        },
      ),
    ],
        alignment:MainAxisAlignment.center,
        mainAxisSize:MainAxisSize.max

    );

    var viewGroup = new ButtonBar( children: <Widget>[
      IconButton(
        icon: const Icon(Icons.camera),
        tooltip: 'Show Firebase',
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/firebase');
        },
      ),
      IconButton(
        icon: const Icon(Icons.shop),
        tooltip: 'shop',
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/shop');
        },
      ),
      IconButton(
        icon: const Icon(Icons.attach_file),
        tooltip: 'Show File ',
        color: Colors.blue,
        onPressed: () async{
          File file = await FilePicker.getFile();
        },
      ),
      IconButton(
        icon: const Icon(Icons.music_video),
        tooltip: 'Show music player',
        key: Key('MusicPlayer'),
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/musicview');
        },
      ),
    ],
        alignment:MainAxisAlignment.center,
        mainAxisSize:MainAxisSize.max

    );

    var TestBar = new ButtonBar( children: <Widget>[
      FlatButton(
        onPressed: () async {
          // obtain shared preferences
          final prefs = await SharedPreferences.getInstance();

// set value
          prefs.setInt('counter', 10);
        },
        color: Colors.blueGrey,
        padding: EdgeInsets.all(10.0),
        child: Column( // Replace with a Row for horizontal icon + text
          children: <Widget>[
            Icon(Icons.filter_1),
            Text("P Write")
          ],
        ),
      ),
      FlatButton(
        onPressed: () async {
          // obtain shared preferences
          final prefs = await SharedPreferences.getInstance();

// set value
          final counter = prefs.getInt('counter') ?? 0;
          print( "cc = $counter");
        },
        color: Colors.blueGrey,
        padding: EdgeInsets.all(10.0),
        child: Column( // Replace with a Row for horizontal icon + text
          children: <Widget>[
            Icon(Icons.filter_1),
            Text("P Read")
          ],
        ),
      ),
      IconButton(
        icon: const Icon(Icons.play_arrow),
        tooltip: 'Show File ',
        color: Colors.blue,
        onPressed: () async{
          Navigator.pushNamed(context, '/fm');
        },
      ),
      FlatButton(
        onPressed: () async {
          WriteFile();
        },
        color: Colors.blueGrey,
        padding: EdgeInsets.all(10.0),
        child: Column( // Replace with a Row for horizontal icon + text
          children: <Widget>[
            Icon(Icons.filter_1),
            Text("Write")
          ],
        ),
      ),

      FlatButton(
        onPressed: () async {
          ReadFile();
        },
        color: Colors.blueGrey,
        padding: EdgeInsets.all(10.0),
        child: Column( // Replace with a Row for horizontal icon + text
          children: <Widget>[
            Icon(Icons.receipt),
            Text("Read")
          ],
        ),
      ),
    ],
        alignment:MainAxisAlignment.center,
        mainAxisSize:MainAxisSize.max

    );


    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
      ),

      body:    Center(
        child: Column(
          children: <Widget>[

            //Text("Logins"),
            loginButton,

            Text(
              'Value: ${model.totalLogin}',
              key: Key('Value'),
            ),
            Text(
              'Welcome: ${model.user}',
              key: Key('User'),
            ),
            CreatWrap(),

            LinearPercentIndicator(
              // width: 140.0,
              lineHeight: 14.0,
              percent: 1,

              //trailing: Icon(Icons.mood),
              linearStrokeCap: LinearStrokeCap.roundAll,
              backgroundColor: Colors.grey,
              progressColor: Colors.blue,
            ),
            TestBar,
            viewGroup,


          ],
        ),
      ),

    );
  }





}