import 'package:flutter/material.dart';
import 'linear_percent_indicator.dart';

class LogWidget extends StatelessWidget {
  final Color color  ;
  final List<int> colorCodes = <int>[10, 20, 30];
  final List<String> entries = <String>['A', 'B', 'C','d','e','F','G','H'];



  LogWidget(this.color);

  @override
  Widget build(BuildContext context) {



    final logList = new ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: entries.length,
        itemBuilder: (BuildContext context, int index) {
          int ii = index % 2 + 1;
          return Container(
              height: 30,
              color: Colors.amber[colorCodes[ii]],
              child: new Row(
                mainAxisAlignment:
                MainAxisAlignment.start,
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: <Widget>
                [
                Text('/opt/devel/pdf/'+ entries[index]+ '.pdf'),
                ],
              )
          );
        }
    );

    final nav = new Padding(
      padding: const EdgeInsets.all(38.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          FloatingActionButton(
            //onPressed: _incrementCounter,
            heroTag: "btn4",
            child: Icon(Icons.refresh),
          ),
          FloatingActionButton(
            heroTag: "btn5",
            //onPressed: _incrementCounter,
            onPressed:()async
            {
            },
            child: Icon(Icons.clear_all),
          )
        ],
      ),
    );


    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.0),
      child: new Stack(
        children: <Widget>[
          new Padding(
              padding: new EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  Text('Send files to server dfdiscover'),

                  new Expanded(
                    child:logList,
                  ),


                ],
              )

          ),

        ],
      ),



    );

  }
}