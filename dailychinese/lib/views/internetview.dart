import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:SharkFlutter/pages/peomwidget.dart';
import 'package:SharkFlutter/pages/gitpage.dart';
import 'package:SharkFlutter/models/shopmodel.dart';
import 'package:SharkFlutter/pages/record.dart';
import 'package:SharkFlutter/firebase/clouddbpage.dart';
import 'package:SharkFlutter/pages/devicepage.dart';

class InternetView extends StatefulWidget {
  InternetView({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;


  @override
  _InternetViewState createState() => _InternetViewState();
}

class _InternetViewState extends State<InternetView> with AutomaticKeepAliveClientMixin{
  int _counter = 0;
  int _currentIndex =0;
  bool visibilityTag = false;
  int _wIndex= 0;

  var curPage;

  final txt11 = TextEditingController();
  final List<int> colorCodes = <int>[10, 20, 30];
  final List<String> entries = <String>["诗词","谚语","精读"];

  String title = "诗词";

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
      _wIndex = index;
      title = entries[index];

      pageController.animateToPage(index, duration: Duration(milliseconds: 500), curve: Curves.ease);


    });
  }

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      //if (_currentIndex >2)

      _wIndex = 3;

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
        GitPage(),
        //RecorderPage( ),

        DevicePage(),
        //CloudStorePage(),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {

    final model = Provider.of<ShopModel>(context);
    String uu = model.user==null?"No":model.user;
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
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
        /* body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),*/

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
          currentIndex: _currentIndex, // new
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              title: Text('诗词'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text('谚语'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              title: Text('精读'),

            )
          ],
        ),

      );

  }
}
