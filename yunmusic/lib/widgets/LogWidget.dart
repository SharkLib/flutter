import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import 'dart:convert';

class LogWidget extends StatefulWidget {
  LogWidget({Key key, this.title}) : super(key: key);

  final String title;
  //final BaseAuth auth;

  void initState() {
  }

  @override
  _LogWidgetState createState() => new _LogWidgetState();
}

class _LogWidgetState extends State<LogWidget> with AutomaticKeepAliveClientMixin {

  final List<int> colorCodes = <int>[10, 20, 30];
  final List<String> entries = List<String>.generate(10000, (i) => "Item $i");


  @override
  bool get wantKeepAlive => true;

  var _futureBuilderFuture;
  @override
  void initState() {
    print('22222222222');
    _futureBuilderFuture =getHttp();
    super.initState();
  }

  Future<List> getHttp() async {
    print("start http");
    JsonCodec codec = new JsonCodec();


    try {
      Response<String>  response = await Dio().get("https://api.github.com/users/flutter/repos");
      //Response<String> response = await DioUtils.getInstance().get(JSON_API);
      List responseJson = json.decode(response.data);
      setState(() {
        responseJson.forEach((element) {
          print(element['name'] );
          print(element['html_url'] );
         // entries.add(element['name']);
        });
      });

      return responseJson;

      /*
      print(response.toString().length);
      Map<String, dynamic> user =response.extra;
      //Map<String, String> user =  jsonDecode(response.toString());
      var decoded = codec.decode(response.data.toString());
      print("Decoded 1: $decoded");
      //print(response.toString());

      //print(user);
      print(user.length);
      user.forEach((key, value) {
        print("Each:"  + value.toJson());
      });*/

    } catch (e) {
      print(e);
    }
  }

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

    ListView createListView(List lt)
    {
      var lv = new ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: lt.length,
          itemBuilder: (BuildContext context, int index) {
            int ii = index % 2 + 1;

            return new ListTile(
              leading: FlutterLogo(size: 56.0),
              title: new Text(lt[index]['name']),
              subtitle: new Text(lt[index]['html_url'] ),
              trailing: new IconButton(
                  icon: new Icon(
                    Icons.navigate_next,
                    color: Colors.grey,
                  ),
                  onPressed: () {}),
            );


          }
      );
      return lv;
    }

    final gitListView = FutureBuilder(
        future: _futureBuilderFuture,
        builder: (BuildContext context, AsyncSnapshot<List> snapShot) {

          switch (snapShot.connectionState)
          {
            case ConnectionState.none:
            case ConnectionState.active:
            case ConnectionState.waiting:
              print('waiting');
              return Center(child: Text('wait'));
            case ConnectionState.done:
              print('done');
              if (snapShot.hasError) {
                return Center(
                  child: Text('网络请求出错'),
                );
              }
              else if (snapShot.hasData)
                {
                  List a = snapShot.data;
                  return createListView(a);
                }

              return logList;
          }
          return null;
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
      margin: EdgeInsets.symmetric(vertical: 2.0),
      child: new Stack(
        children: <Widget>[
          new Padding(
              padding: new EdgeInsets.only(top: 10.0),
              child:   Expanded(
                child:gitListView,
              ),

          ),

        ],
      ),



    );

  }
}