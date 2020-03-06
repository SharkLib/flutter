import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';
import 'storelogin.dart';
import 'booklist.dart';

//final result = await Navigator.push(
//            context,
//            // Create the SelectionScreen in the next step.
//            MaterialPageRoute(builder: (context) => ShopLogin()),
//          );

enum Actions{
  Increase,
  Login,
  LoginSuccess,
  LogoutSuccess
}

/// 这个类用来管理登录状态
class AuthState{
  bool isLogin;     //是否登录
  String account;   //用户名
  AuthState({this.isLogin:false,this.account});

  @override
  String toString() {
    return "{account:$account,isLogin:$isLogin}";
  }
}

/// 管理主页状态
class MainPageState{
  int counter;
  MainPageState({this.counter:0});

  @override
  String toString() {
    return "{counter:$counter}";
  }
}

class DDD
{
  DDD()
  {
    print("Test DDD");
  }
}
/// 定义所有action的基类
class Action{
  final Actions type;
  Action({this.type});
}

/// 定义Login成功action
class LoginSuccessAction extends Action{

  final String account;

  LoginSuccessAction({
    this.account
  }):super( type:Actions.LoginSuccess );
}

/// 应用程序状态
class AppState{
  AuthState auth;     //登录
  MainPageState main; //主页

  AppState({this.main,this.auth});

  @override
  String toString() {
    return "{auth:$auth,main:$main}";
  }
}

AppState mainReducer(AppState state, dynamic action){


  print("state charge :$action ");
  if(Actions.Increase==action){
    state.main.counter+=1;
  }

  if(Actions.LogoutSuccess == action){

    state.auth.isLogin = false;
    //state.auth.account = null;
  }

  if(Actions.LoginSuccess == action){

    state.auth.isLogin = true;
   // state.auth.account = null;
  }

  if(action is LoginSuccessAction){
    state.auth.isLogin = true;
    state.auth.account = action.account;
  }

  print("state changed:$state");

  return state;
}
loggingMiddleware(Store<AppState> store, action, NextDispatcher next) {
  print('${new DateTime.now()}: $action');

  next(action);
}


class ShopView extends StatelessWidget {

  Store<AppState> store = new Store<AppState>(mainReducer,initialState: new AppState(
    main: new MainPageState(),
    auth: new AuthState(),
  ),middleware: [
    loggingMiddleware
  ]);


  ShopView();

  @override
  Widget build(BuildContext context) {
    return new StoreProvider(store: store, child: new MaterialApp(
      title: 'Flutter Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:  new StoreConnector<AppState,AppState>(builder: (BuildContext context,AppState state){
        print("isLogin:${state.auth.isLogin}");
        return new MyHomePage(title: 'Flutter Store Demo',
            counter:state.main.counter,isLogin: state.auth.isLogin,account:state.auth.account);
      }, converter: (Store<AppState> store){
        return store.state;
      }) ,
      debugShowCheckedModeBanner: false,
    ));
  }
}




class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title,this.counter,this.isLogin,this.account}) : super(key: key);
  final String title;
  final int counter;
  final bool isLogin;
   String account = 'aaa';
  int _currentIndex =0;


  final lt = <Widget>[
    Text("abc"),
    BookList(),
    Text("Two"),
    Text("last"),
  ];


  void pageChanged(int index) {
    _currentIndex = index;
  }

  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );




  Widget buildPageView() {



    if (isLogin)
    return PageView(
      controller: pageController,
      onPageChanged: (index)
      {
        pageChanged(index);
      },
      children:lt,
    );

    Widget loginPane =  new StoreConnector<AppState,VoidCallback>(
        key:new ValueKey("logout"),
        builder: (BuildContext context,VoidCallback login){
          return new RaisedButton(onPressed:login,child: new Text("登录"),);
        }, converter: (Store<AppState> store){
      return ()=>
          store.dispatch(
            //new LoginSuccessAction(account: "Ro account!")
              Actions.LoginSuccess
          );
    });

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'You have pushed the button this many times:',
        ),
        Text(
          '$counter',
        ),

        /// 有登录，展示你好:xxx,没登录，展示登录按钮
        loginPane,

      ],
    );
  }


  @override
  Widget build(BuildContext context) {

    void onTabTapped(int index) {
      _currentIndex = index;
      pageController.jumpToPage(index);
      print("Curent:$_currentIndex");

    }

    BottomNavigationBar bar = BottomNavigationBar(
      onTap: onTabTapped,
      currentIndex: _currentIndex, // new
      items: [
        new BottomNavigationBarItem(
          icon: Icon(Icons.archive),
          title: Text('Files'),
        ),
        new BottomNavigationBarItem(
          icon: Icon(Icons.message),
          title: Text('Logs'),
        ),
        new BottomNavigationBarItem(
          icon: Icon(Icons.help),
          title: Text('Help'),

        )
      ],
    );

    print("build:$isLogin");
    Widget loginPane;
    if(isLogin){
      loginPane = new StoreConnector(
          key:new ValueKey("login"),
          builder: (BuildContext context,VoidCallback logout){
            return new RaisedButton(onPressed: logout,child: new Text("您好:$account,点击退出"),);
          },
          converter: (Store<AppState> store){
        return ()=>
            store.dispatch(
                Actions.LogoutSuccess
            );
      });
    }else{
      loginPane =  new StoreConnector<AppState,VoidCallback>(
          key:new ValueKey("logout"),
          builder: (BuildContext context,VoidCallback login){
            return new RaisedButton(onPressed:login,child: new Text("登录"),);
          }, converter: (Store<AppState> store){
        return ()=>
            store.dispatch(
                //new LoginSuccessAction(account: "Ro account!")
                Actions.LoginSuccess
            );
      });
    }

    return  Scaffold(
      appBar:  AppBar(
        title:  Text(title),
        actions: <Widget>[

          IconButton(
              icon: const Icon(Icons.account_circle),
              tooltip: 'shop',
             // color: Colors.blue,
            onPressed: () async
            {
              final result = await Navigator.push(
                context,
                // Create the SelectionScreen in the next step.
                MaterialPageRoute(builder: (context) => ShopLogin()),
              );
            },

            ),


        ],
      ),

      body:  Center(
        child: buildPageView(),

      ),


      floatingActionButton: new StoreConnector<AppState,VoidCallback>(builder: ( BuildContext context,VoidCallback callback )
      {
        return new FloatingActionButton(
          onPressed:callback,
          tooltip: 'Increment',
          child: new Icon(Icons.add),

        );

      },

          converter: (Store<AppState> store){
        return ()=>store.dispatch(Actions.Increase);
      }),

      //floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,

      bottomNavigationBar: bar,


    );
  }
}
