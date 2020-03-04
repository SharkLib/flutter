
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:dio/dio.dart';
import 'dart:convert';


class BookList extends StatelessWidget
{


  Future<List> getHttp() async {
    print("start http");
    JsonCodec codec = new JsonCodec();
    try
    {
      Response<String>  response = await Dio().get("https://api.github.com/users/flutter/repos");
      //Response<String> response = await DioUtils.getInstance().get(JSON_API);
      List responseJson = json.decode(response.data);
      return responseJson;
    } catch (e)
    {
      print(e);
    }
  }

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






  @override
  Widget build(BuildContext context)
  {
    var _futureBuilderFuture = getHttp();

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
          }
          return null;
        }
    );

    return gitListView;
  }



}