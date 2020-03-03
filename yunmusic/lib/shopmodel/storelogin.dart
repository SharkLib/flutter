
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'shopview.dart';




class ShopLogin extends StatelessWidget
{
  TextEditingController unameController = new TextEditingController();
  TextEditingController pwdController = new TextEditingController();
  GlobalKey formKey = new GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      appBar:  AppBar(
        title:  Text("Store Login"),

      ),

      body:  Center(
          child:Form(
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

                              Navigator.pop(context,"rong" );
                              //LoginClickedAction(username: "rong", password: "rong");
                              // signInWithEmailAndPassword("huang",'g');
                              //验证通过提交数据
                            }
                          },
                        ),
                      ),

                      new StoreConnector<AppState,VoidCallback>(builder: ( BuildContext context,VoidCallback callback )
                      {
                        return new FloatingActionButton(
                          onPressed:callback,
                          tooltip: 'Increment',
                          child: new Icon(Icons.add),
                        );

                      },
                          converter: (Store<AppState> store){

                            return () {

                              Navigator.pop(context);
                              store.dispatch(
                                  new LoginSuccessAction(account: unameController.text)
                              );
                            };
                          }),

                    ],
                  ),
                )
              ],
            ),
          ),
      ),






    );


  }

}