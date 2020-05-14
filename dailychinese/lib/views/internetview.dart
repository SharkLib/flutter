import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SharkFlutter/pages/peomwidget.dart';
import 'package:SharkFlutter/pages/gitpage.dart';
import 'package:SharkFlutter/models/shopmodel.dart';
import 'package:SharkFlutter/pages/ciwidget.dart';
import 'package:SharkFlutter/pages/record.dart';
import 'package:SharkFlutter/pages/yanyuwidget.dart';
import 'package:SharkFlutter/pages/mp3widget.dart';

class InternetView extends StatefulWidget {
  InternetView({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _InternetViewState createState() => _InternetViewState();
}

class _InternetViewState extends State<InternetView> with AutomaticKeepAliveClientMixin{

  int _currentIndex =0;
  bool visibilityTag = false;

  final List<String> entries = <String>["唐诗","宋词","谚语","精读","其他"];

  String title = "唐诗";

  ImageProvider img = AssetImage("assets/head1.jpg");

  @override
  bool get wantKeepAlive => true;


  @override
  void initState() {
    super.initState();

  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      title = entries[index];
      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);
    });
  }

  void pageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }


  PageController pageController = PageController(
    initialPage: 0,
    keepPage: true,
  );

  Widget buildPageView() {
    return PageView(
      controller: pageController,
      onPageChanged: (index)
      {
        pageChanged(index);

      },
      children: <Widget>[
        PeomWidget(),
        CiWidget(),
        YanyuWidget(),

      //  Mp3Player(),
      //  RecorderPage( ),

      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final model = Provider.of<ShopModel>(context);
    String uu = model.user==null?"No":model.user;

//willpopscope to skip back key
    return
      Scaffold(
        appBar: AppBar(
          // Here we take the value from the MyHomePage object that was created by
          // the App.build method, and use it to set our appbar title.
          leading: Builder(
            builder: (BuildContext context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () { Scaffold.of(context).openDrawer(); },
                tooltip: MaterialLocalizations.of(context).openAppDrawerTooltip,
              );
            },
          ),

          title: Text(title),
          backgroundColor: Colors.blueGrey,

          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.account_box),
              tooltip: 'Show Snackbar',
              onPressed: () {
                // scaffoldKey.currentState.showSnackBar(snackBar);
                model.user == Navigator.pushNamed(context, '/login') ;//null?Navigator.pushNamed(context, '/login') : model.logout();
              },
            ),

          ],
        ),


        body: buildPageView(),

        drawer: Container(

            width: 180,
          // Add a ListView to the drawer. This ensures the user can scroll
          // through the options in the drawer if there isn't enough vertical
          // space to fit everything.
          child:Drawer(

            child: ListView(

              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: <Widget>[
                DrawerHeader(
                  /* decoration: BoxDecoration(

                  image: DecorationImage
                    (
                  image:  model.UserImg,
                  fit: BoxFit.cover
                  ),
                borderRadius: new BorderRadius.all(new Radius.circular(150.0)),
               ),*/
                  child:  new Container(
                    width: 100.0,
                    height: 100.0,
                    decoration: new BoxDecoration(
                      color: const Color(0xff7c94b6),
                      image: new DecorationImage(
                        image:  model.UserImg,
                        fit: BoxFit.cover,
                      ),
                      borderRadius: new BorderRadius.all(new Radius.circular(300.0)),
                      border: new Border.all(
                        color: Colors.red,
                        width: 4.0,
                      ),
                    ),
                  ),
                ),
                ListTile(
                  title: Text('Item 1'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
                ListTile(
                  title: Text('Item 2'),
                  onTap: () {
                    // Update the state of the app
                    // ...
                    // Then close the drawer
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          )
        ),


        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          //backgroundColor: Colors.red,
          showUnselectedLabels:true,
          currentIndex: _currentIndex, // new
          items: [

            new BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              backgroundColor: Colors.blue,
              title: Text('唐诗'),
            ),


            new BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              backgroundColor: Colors.blue,
              title: Text('宋词'),
            ),

            new BottomNavigationBarItem(
              icon: Icon(Icons.audiotrack),
              backgroundColor: Colors.blue,

              title: Text('谚语'),
            ),
           /* new BottomNavigationBarItem(
              icon: Icon(Icons.audiotrack),
              backgroundColor: Colors.blue,

              title: Text('精读'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.audiotrack),
              backgroundColor: Colors.blue,

              title: Text('其他'),
            ),*/
          ],
        ),

      );

  }
}
