import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'package:cloudying/user.dart';
import 'package:redux/redux.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'app_state.dart';
import 'login_state.dart';
import 'login_action.dart';

import 'package:flutter/material.dart';



/// 全局的ProgressBar
class ProgressBar extends StatelessWidget {
  final bool visibility;

  ProgressBar({
    Key key,
    this.visibility = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Offstage(
      offstage: (!visibility),
      child: CircularProgressIndicator(
        strokeWidth: 3.0,
      ),
    );
  }
}


typedef void LoginSuccessCallback(
    final BuildContext context,
    final User user,
    final String token,
    );
/// 取消登录的回调函数
/// [context] 上下文对象
typedef void LoginCancelCallback(
    final BuildContext context,
    );

class LoginForm extends StatefulWidget {

   loginCancelCallback (  BuildContext context  )
  {
  print('用户取消了登录');
  }


   loginSuccessCallback (
   BuildContext context,
   User user,
   String token,
  )
  {
  print('登录成功，跳转主页面');
  Navigator.pop(context);
  Navigator.pushNamed(context, '/Send1');
  }


  LoginForm();

  @override
  _LoginFormState createState() =>
      _LoginFormState(loginSuccessCallback, loginCancelCallback);
}

class _LoginFormState extends State<LoginForm> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final LoginSuccessCallback loginSuccessCallback;
  final LoginCancelCallback loginCancelCallback;

  _LoginFormState(this.loginSuccessCallback, this.loginCancelCallback);

  bool _isFirstLoad = true;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isFirstLoad) {
      _isFirstLoad = false;
      StoreProvider.of<AppState>(context);
    }
  }

  @override
  Widget build(BuildContext context)
  {
    AppState.initial();
    return StoreConnector<AppState, LoginState>(
      converter: (store) {
        final state = store.state.loginState;

        final User user = state.user;
        // 登录成功
        if (user != null && loginSuccessCallback != null) {
          loginSuccessCallback(context, user, user.token);
        }
        // 取消登录
        if (state.isLoginCancel) {
          loginCancelCallback(context);
        }
        // 异常事件
        final Exception error = state.error;
        if (error != null) {
        print(error.toString());
        }
        return state;
      },
      builder: (context, LoginState state) => Container(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: EdgeInsets.fromLTRB(16.0, 38.0, 16.0, 8.0),
          child: Stack(
            alignment: Alignment.center,
            fit: StackFit.loose,
            children: <Widget>[
              SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    /// 顶部图标和标题
                    Row(
                      children: <Widget>[

                        Container(
                          margin: EdgeInsets.only(left: 32.0),
                          child: Text(
                            'Sign into GitHub',
                            style: TextStyle(
                              fontSize: 24.0,
                              fontWeight: FontWeight.normal,
                              color: Colors.blue,
                            ),
                            maxLines: 1,
                            textAlign: TextAlign.start,
                          ),
                        ),
                      ],
                    ),
                    _usernameInput(),
                    _passwordInput(),
                    _signInButton()
                  ],
                ),
              ),
              StoreConnector<AppState, bool>(
                converter: (store) => store.state.loginState.isLoading,
                builder: (context, visibility) =>
                    ProgressBar(visibility: visibility),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// 用户名输入框
  Widget _usernameInput() {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final String username = store.state.loginState.username ?? '';
    userNameController.text = username;
    return Container(
      margin: EdgeInsets.only(top: 24.0),
      child: TextField(
        controller: userNameController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          labelText: 'Username or email address',
        ),
      ),
    );
  }

  /// 密码输入框
  Widget _passwordInput() {
    final Store<AppState> store = StoreProvider.of<AppState>(context);
    final String password = store.state.loginState.password ?? '';
    passwordController.text = password;
    return Container(
      margin: EdgeInsets.only(top: 8.0),
      child: TextField(
        controller: passwordController,
        keyboardType: TextInputType.text,
        obscureText: true,
        decoration: InputDecoration(
          contentPadding: EdgeInsets.only(top: 10.0, bottom: 10.0),
          labelText: 'Password',
        ),
      ),
    );
  }

  /// 登录按钮
  Widget _signInButton()
  {
    final Store<AppState> store = StoreProvider.of<AppState>(context);

    /// 登录按钮点击事件
    void _onLoginButtonClicked(Store<AppState> store) {
      final String username = userNameController.text ?? '';
      final String password = passwordController.text ?? '';

      store
          .dispatch(LoginClickedAction(username: username, password: password));
    }

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.only(top: 32.0),
      width: double.infinity,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: double.infinity,
          minHeight: 50.0,
        ),
        child: FlatButton(
          onPressed: () => _onLoginButtonClicked(store),
          color: Colors.blue,
          highlightColor: Colors.grey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(7.0)),
          ),
          child: Text(
            'Sign in',
            style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}



/*

class DioWidget extends  StatefulWidget {

  DioWidget({Key key, this.title}) : super(key: key);

final String title;
//final BaseAuth auth;

@override
_DioPageState createState() => new _DioPageState();
}

class _DioPageState extends State<DioWidget> {
  int _counter = 0;

  Dio _dio = new Dio();

  @override
  Widget build(BuildContext context) {
    return Container(

      //height: 130,
      child:  FutureBuilder(
        future: _dio.get("https://api.github.com/orgs/huangatone/repos"),
    builder: (BuildContext context, AsyncSnapshot snapshot) {
    //请求完成
    if (snapshot.connectionState == ConnectionState.done) {
    Response response = snapshot.data;
    //发生错误
    if (snapshot.hasError) {
    return Text(snapshot.error.toString());
    }
    print(response.toString());
    //请求成功，通过项目信息构建用于显示项目名称的ListView
    return Text(
     "dsd",
    );
    }
    //请求未完成时弹出loading
    return CircularProgressIndicator();
    }
      )


    );

  }
}*/