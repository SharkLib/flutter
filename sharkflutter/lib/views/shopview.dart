
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SharkFlutter/models/shopmodel.dart';
import 'package:provider/provider.dart';
import 'package:SharkFlutter/pages/cartpage.dart';
import 'package:SharkFlutter/pages/cdpage.dart';

class ShopView extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ShopViewState();

  }

}

class ShopViewState extends State<ShopView>
{
  var prs = List<ProductItem>.generate(20, (index) => ProductItem( "Item $index", index*1.1));
  var isChecks =  List<bool>.generate(20, (i) => false);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final model = Provider.of<ShopModel>(context);


    return  DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(

            bottom: TabBar(
              tabs: [

               // Tab(icon: Icon(Icons.directions_car),text:"ad"),
               // Tab(icon: Icon(Icons.directions_transit)),
               // Tab(icon: Icon(Icons.directions_bike)),
                Tab(text:"Git"),
                Tab(text:"CD"),
                Tab(text:"Books"),
              ],
            ),

            title: Text('Demo'),
            centerTitle: true,

            actions: <Widget>[
              IconButton(
                icon: const Icon(Icons.add_shopping_cart),
                tooltip: 'shop',
                // color: Colors.blue,
                onPressed: () async
                {
                  final result = await Navigator.push(
                    context,
                    // Create the SelectionScreen in the next step.
                    MaterialPageRoute(builder: (context) => CartPage()),
                  );
                },

              ),
            ],

          ),
          body: TabBarView(
            children: [
              Icon(Icons.directions_car),
              CDPage(),
              Icon(Icons.directions_bike),
            ],
          ),

            drawer: Drawer(
                child: ListView(
                  // Important: Remove any padding from the ListView.
                  padding: EdgeInsets.zero,
                  children: <Widget>[
                     UserAccountsDrawerHeader(
                      accountName: new Text('DFnet'),
                      accountEmail: new Text('rong@datafax.com'),
                      currentAccountPicture: new CircleAvatar(
                        backgroundImage: new NetworkImage('https://s6q7n2v5.stackpathcdn.com/wp-content/uploads/2016/01/white-logo.png'),
                      ),
                    ),
                    ListTile(
                      title: Text('Item 1'),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                    ListTile(
                      title: Text('Item 2'),
                      onTap: () {
                        // Update the state of the app.
                        // ...
                      },
                    ),
                  ],
                ), // Populate the Drawer in the next step.
            ),

          bottomNavigationBar: BottomNavigationBar(
            //onTap: onTabTapped,
            currentIndex: 0, // new
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
          ),


        ),


    );
  }

}