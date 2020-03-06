import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import 'package:fullflutter/models/shopmodel.dart';

class LoginPage extends StatefulWidget {
  LoginPage({Key key, this.title}) : super(key: key);

  final String title;
  //final BaseAuth auth;

  @override
  _LoginPageState createState() => new _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  TextEditingController unameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  GlobalKey formKey = new GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {



    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
        centerTitle: true,
      ),

      body:    Center(
        child:buildForm(),
        ),

    );
  }




  Widget buildForm() {
    final model = Provider.of<ShopModel>(context);

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
            child: ButtonBar( children: <Widget>[
              FlatButton(
                child: Text('Login'),
                key: Key('MainPageLogin'),
                color: Colors.blue,
                onPressed: () {
                  //login("huang.rong.bj@gmail.com","Good2017!");
                  if ((formKey.currentState as FormState).validate()) {

                    //LoginClickedAction(username: "rong", password: "rong");
                    // signInWithEmailAndPassword("huang",'g');
                    //验证通过提交数据
                    model.login(unameController.text);
                    model.addProduct("CD", 1.22);
                    Navigator.pop(context, 'Sueccess!');
                  }
                },
              ),
              FlatButton(
                child: Text('Cancel'),
                color: Colors.blue,
                onPressed: () {
                  Navigator.pop(context, 'Failed!');
                },
              ),
            ],
                alignment:MainAxisAlignment.center,
                mainAxisSize:MainAxisSize.max

            ),


          )
        ],
      ),
    );
  }
}