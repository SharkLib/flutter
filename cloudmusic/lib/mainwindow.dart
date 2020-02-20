import 'package:flutter/material.dart';
import 'linear_percent_indicator.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'package:path_provider/path_provider.dart';

import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';
// Add to the ios/Runner/info.plist:
// <key>io.flutter.embedded_views_preview</key>
// <true/>
// see https://pub.dev/packages/pdf_viewer_plugin

import 'package:path/path.dart';
import 'popup.dart';
import 'package:cloudying/AccountWidget.dart';


class MainWidget extends StatefulWidget {
  MainWidget({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;


  @override
  MainWidgetState createState() => MainWidgetState();
}


class MainWidgetState extends State<MainWidget> {

  final List<int> colorCodes = <int>[10, 20, 30];
  //final List<String> entries = <String>[];//'A', 'B', 'C','d','e','F','G','H','I','P','U','Y'
  final entries = List<String>.generate(
  20,
  (i) =>
  'Todo $i',
  );

  Color bgColor = Colors.grey  ;
  // PDF preview stuff
  final path = 'assets/report.pdf'; // hardcoded file name for testing purposes only
  // get file name from the path to display on widget
  String getFileName(String fullPath) {
      File file = new File(fullPath);
      return basename(file.path);
  }
  // This moves the PDF file from the assets to a place accessible by our PDF viewer.
  // No need to have it if path is accessible by the viewer.
  Future<String> prepareTestPdf(BuildContext context) async {
    final ByteData bytes = await DefaultAssetBundle.of(context).load(path);
    final Uint8List list = bytes.buffer.asUint8List();
    final tempDir = await getTemporaryDirectory();
    final tempDocumentPath = '${tempDir.path}/$path';
    final file = await File(tempDocumentPath).create(recursive: true);
    file.writeAsBytesSync(list);
    return tempDocumentPath;
  }
  // Show popup with PDF file preview
  showPopup(BuildContext context, Widget widget, String title,
      {BuildContext popupContext}) {
    Navigator.push(
      context,
      PopupLayout(
        top: 50,
        left: 50,
        right: 50,
        bottom: 50,
        child: PopupContent(
          content: Scaffold(
            appBar: AppBar(
              title: Text(title),
              leading: new Builder(builder: (context) {
                return IconButton(
                  icon: Icon(Icons.close),
                  onPressed: () {
                    try {
                      Navigator.pop(context); //close the popup
                    } catch (e) {}
                  },
                );
              }),
              brightness: Brightness.light,
            ),
            resizeToAvoidBottomInset: true,
            body: widget,
          ),
        ),
      ),
    );
  }

  // PDF preview stuff: popup widget's body
  Widget popupBody(String path) {
    return Container(
      child: PdfViewer(
        filePath: path,
      ),
    );
  }

  void _incrementCounter()
  {
    setState(()
    {
      entries.add('file'+ entries.length.toString()+'.pdf');
      print("aaaa");
      bgColor = entries.length==0? Colors.grey:Colors.blue;
    });
  }



  // Depending on orientation, creates a list with three widgets:
  // file name, file path, and progress indicator for landscape,
  // or a column with those three, and two empty widgets for portrait,
  // then feeds the three widgets to a row, and then return the row.
  // For web, the default is landscape and this works as well.
  Widget buildRow(context, orientation, index) {

    var fileNameWgt = new Text(
       entries[index],
      style: new TextStyle(
          fontSize: 14.0,
          color: Colors.black87,
          fontWeight: FontWeight.bold),
    );
    var filePathWgt = new Text(
      '/opt/devel/pdf',
      style: new TextStyle(
          fontSize: 14.0,
          color: Colors.black54,
          fontWeight: FontWeight.normal),
    );
    var progressWgt = new LinearPercentIndicator(
      // width: 140.0,
      lineHeight: 14.0,
      percent: (index <=20) ? 0.05*index : 1,
      center: Text(
        (0.05*index*100).toInt().toString()+ "%",
        style: new TextStyle(fontSize: 12.0),
      ),
      //trailing: Icon(Icons.mood),
      linearStrokeCap: LinearStrokeCap.roundAll,
      backgroundColor: Colors.grey,
      progressColor: Colors.blue,
    );

    // default if something's not good
    var nameAndProgressWgt = <Widget>[
      SizedBox.shrink(),
      SizedBox.shrink(),
      SizedBox.shrink()
    ];
    if (orientation == Orientation.portrait) {
      nameAndProgressWgt = <Widget>[ new Expanded(
        child: new Column(
          mainAxisAlignment:
          MainAxisAlignment.start,
          crossAxisAlignment:
          CrossAxisAlignment.start,
          children: <Widget>[fileNameWgt, filePathWgt, progressWgt],
        ),
      ), SizedBox.shrink(), SizedBox.shrink()];
    } else {
      nameAndProgressWgt = <Widget>[
        new SizedBox(
          width: 200.0,
          child: fileNameWgt,
        ),
        new SizedBox(
          width: 200.0,
          child: filePathWgt,
        ),
        Expanded(
          child:progressWgt,
        )
      ];
    }

    return new Row(
      mainAxisAlignment:
      MainAxisAlignment.start,
      crossAxisAlignment:
      CrossAxisAlignment.center,
      children: <Widget>
      [
        nameAndProgressWgt[0],
        nameAndProgressWgt[1],
        nameAndProgressWgt[2],
        new IconButton(
          icon: const Icon(Icons.open_in_new),
          onPressed: () {
            // We need to prepare the test PDF, and then we can display the PDF.
            prepareTestPdf(context).then((pdfPath) {
              showPopup(context, popupBody(pdfPath), getFileName(path)); // path is actual path
            });
          },
          //color: const Color(0x55273A48),
        ),
        new IconButton(
          icon: const Icon(Icons.cancel),
          onPressed: ()
          {
          setState((){
            entries.removeAt(index);
            bgColor = entries.length==0? Colors.grey:Colors.blue;
          });

          },
          //color: const Color(0x55273A48),
        )
      ],

    );
  }

  _navigateAndDisplaySelection(BuildContext context) async {
    // Navigator.push returns a Future that completes after calling
    // Navigator.pop on the Selection Screen.
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => SelectionScreen()),
    );

    // After the Selection Screen returns a result, hide any previous snackbars
    // and show the new result.
    Scaffold.of(context)
      ..removeCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text("$result")));
    setState(()
    {
      entries.add('file'+ "$result" +'.pdf');

      bgColor = entries.length==0? Colors.grey:Colors.blue;
    });
  }


  @override
  Widget build(BuildContext context) {

    final headerList = new OrientationBuilder(
        builder: (context, orientation) {
          return new ListView.builder(
              padding: const EdgeInsets.all(8),
              itemCount: entries.length,
              itemBuilder: (BuildContext context, int index) {
                int ii = index % 2 + 1;
                return Container(
                  color: Colors.amber[colorCodes[ii]],
                  child: buildRow(context, orientation, index),
                );
              }
          );
        }
    );

    final  send = new FloatingActionButton(
      //onPressed: _incrementCounter,
      onPressed:()
      {
        _navigateAndDisplaySelection(context);
      },
      heroTag: "btn2",
      child: Icon(Icons.send),

      backgroundColor:  bgColor,

    );

    return new Scaffold
      (
      body: new Container(
      margin: EdgeInsets.symmetric(vertical: 1.0),
      child: new Stack(
        children: <Widget>[
          new Padding(
              padding: new EdgeInsets.only(top: 10.0),
              child: Column(
                children: <Widget>[
                  Text('Send files to server dfdiscover'),
                  new Expanded(
                    child:headerList,
                  ),

                  new  Padding(

                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        FloatingActionButton(
                          heroTag: "btn3",
                          onPressed: ()
                          {
                            print("aa--bb");
                            _incrementCounter();

                          },

                          child: Icon(Icons.add),
                        ),
                        send
                      ],
                    ),
                  ),

                ],
              )

          ),

        ],
      ),



    ),
    );

  }
}