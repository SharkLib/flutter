import 'package:flutter/material.dart';

import 'package:SharkFlutter/pages/aboutpage.dart';
import 'package:SharkFlutter/pages/accountpage.dart';
import 'package:SharkFlutter/pages/gitpage.dart';


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
  final List<String> entries = <String>['A', 'B', 'C','d','e'];





  @override
  bool get wantKeepAlive => true;


  static final CREATE_POST_URL = 'https://dfws52.datafax.com:4433/dfws/v5/authorize';

  @override
  void initState() {
    super.initState();

  }
  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _wIndex = index;

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
        GitPage(),
        AccountWidget(),
    AboutPage(Colors.white ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
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
          title: Text(widget.title),
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.account_box),
              tooltip: 'Show Snackbar',
              onPressed: () {
                // scaffoldKey.currentState.showSnackBar(snackBar);
                Navigator.push<void>(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AccountWidget(),
                    // fullscreenDialog: true,
                  ),
                );
              },
            ),

          ],
        ),


        body: buildPageView(),
        /* body: IndexedStack(
        index: _currentIndex,
        children: _children,
      ),*/


        bottomNavigationBar: BottomNavigationBar(
          onTap: onTabTapped,
          currentIndex: _currentIndex, // new
          items: [
            new BottomNavigationBarItem(
              icon: Icon(Icons.archive),
              title: Text('Flutter'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.message),
              title: Text('Logs'),
            ),
            new BottomNavigationBarItem(
              icon: Icon(Icons.show_chart),
              title: Text('C3'),

            )
          ],
        ),

      );

  }
}
