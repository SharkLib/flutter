import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
//import 'package:flutter_html_view/flutter_html_view.dart';
import 'package:html/parser.dart' show parse;
import 'package:html/dom.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'dart:convert';

class AboutWidget extends StatelessWidget {
  final Color color  ;
  WebViewController _controller;

  AboutWidget(this.color);



  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      //height: 130,
      child:    WebView
        (
        //initialUrl: 'https://www.ctvnews.ca/video?playlistId=1.4816476',
        initialUrl: 'https://www.dfnetresearch.com/wp-content/uploads/dfdiscover/5.2.0doc/sendman/html/sendman.html',
        //javascriptMode: JavascriptMode.unrestricted,
        ),

    );

  }
}