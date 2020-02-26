import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'model/countmodel.dart';
import 'package:file_picker/file_picker.dart';
import 'dart:io';
import 'package:cloudying/login_action.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:firebase_auth/firebase_auth.dart';
//import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'dart:async';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:google_sign_in/google_sign_in.dart';
//import 'package:flutter_twitter_login/flutter_twitter_login.dart';


class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;
  //final BaseAuth auth;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  TextEditingController unameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  GlobalKey formKey = new GlobalKey<FormState>();



  void _incrementCounter() {
    Navigator.pushNamed(context, '/send1');
  }
/*
  Future<String> signInWithEmailAndPassword(String email, String password) async
  {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    final FirebaseAuth _auth = FirebaseAuth.instance;

    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    final FirebaseUser user = (await _auth.signInWithCredential(credential)).user;
  print("signed in " + user.displayName);
    return user.uid;
  }*/

  @override
  Widget build(BuildContext context) {

    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<int>(context).toDouble();



    var button = new ButtonBar( children: <Widget>[
      FlatButton(
        child: Text('Login'),
        key: Key('Login'),
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/send1');
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

    var shareBtn = new ButtonBar( children: <Widget>[
      IconButton(
        icon: const Icon(Icons.camera),
        tooltip: 'Show Camera',
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/Camera');
        },
      ),
      IconButton(
        icon: const Icon(Icons.compare_arrows),
        tooltip: 'Show Select',
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/Select');
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
        icon: const Icon(Icons.work),
        tooltip: 'Show Snackbar',
        key: Key('Add'),
        color: Colors.blue,
        onPressed: () {
          _counter.increment();
        },
      ),
    ],
        alignment:MainAxisAlignment.center,
        mainAxisSize:MainAxisSize.max

    );



    var TestBar = new ButtonBar( children: <Widget>[
      IconButton(
        icon: const Icon(Icons.cloud),
        tooltip: 'Show Camera',
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/DIO');
        },
      ),
      IconButton(
        icon: const Icon(Icons.security),
        tooltip: 'Show Select',
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/Select');
        },
      ),
      IconButton(
        icon: const Icon(Icons.ac_unit),
        tooltip: 'Show File ',
        color: Colors.blue,
        onPressed: () async{
          File file = await FilePicker.getFile();
        },
      ),
      IconButton(
        icon: const Icon(Icons.all_inclusive),
        tooltip: 'Show Snackbar',
        key: Key('Add'),
        color: Colors.blue,
        onPressed: () {
          _counter.increment();
        },
      ),
    ],
        alignment:MainAxisAlignment.center,
        mainAxisSize:MainAxisSize.max

    );


    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body:    Center(
      child: Column(
        children: <Widget>[
          buildForm(),
          button,
          shareBtn,
          TestBar,
      Text(
        'Value: ${_counter.value}',
        key: Key('Value'),
      )


        ],
      ),
      ),
      /*floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
      */
    );
  }

  void _onButtonPressed() {


      //在这里不能通过此方式获取FormState，context不对
      //print(Form.of(context));
      // 通过_formKey.currentState 获取FormState后，
      // 调用validate()方法校验用户名密码是否合法，校验
      // 通过后再提交数据。





    Navigator.pushNamed(context, '/send1');
  }


  Widget buildForm() {
    return Form(
      //设置globalKey，用于后面获取FormState
      key: formKey,
      //开启自动校验
      autovalidate: true,
      child: Column(
        children: <Widget>[
          TextFormField(
              autofocus: false,
              keyboardType: TextInputType.number,
              //键盘回车键的样式
              textInputAction: TextInputAction.next,
              controller: unameController,
              decoration: InputDecoration(
                  labelText: "用户名或邮箱",
                  hintText: "用户名或邮箱",
                  icon: Icon(Icons.person)),
              // 校验用户名
              validator: (v) {
                return v.trim().length > 0 ? null : "用户名不能为空";
              }),
          TextFormField(
              autofocus: false,
              controller: pwdController,
              decoration: InputDecoration(
                  labelText: "密码", hintText: "您的登录密码", icon: Icon(Icons.lock)),
              obscureText: true,
              //校验密码
              validator: (v) {
                return v.trim().length > 5 ? null : "密码不能少于6位";
              }),
          // 登录按钮
          Padding(
            padding: const EdgeInsets.only(top: 28.0),
            child: Row(
              children: <Widget>[
                Expanded(
                  child: RaisedButton(
                    padding: EdgeInsets.all(15.0),
                    child: Text("登录"),
                    color: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    onPressed: () {
                      //在这里不能通过此方式获取FormState，context不对
                      //print(Form.of(context));
                      // 通过_formKey.currentState 获取FormState后，
                      // 调用validate()方法校验用户名密码是否合法，校验
                      // 通过后再提交数据。
                      if ((formKey.currentState as FormState).validate()) {

                        //LoginClickedAction(username: "rong", password: "rong");
                       // signInWithEmailAndPassword("huang",'g');
                        //验证通过提交数据
                      }
                    },
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}