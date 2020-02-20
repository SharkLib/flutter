import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'model/countmodel.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;



  void _incrementCounter() {
    Navigator.pushNamed(context, '/send1');
  }

  @override
  Widget build(BuildContext context) {

    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<int>(context).toDouble();

    var button = new ButtonBar( children: <Widget>[
      FlatButton(
        child: Text('Login'),
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/send1');
        },
      ),
      FlatButton(
        child: Text('Cancel'),
        color: Colors.blue,
        onPressed: () {/** */},
      ),
    ],
        alignment:MainAxisAlignment.center,
        mainAxisSize:MainAxisSize.max

    );

    var shareBtn = new ButtonBar( children: <Widget>[
      IconButton(
        icon: const Icon(Icons.help),
        tooltip: 'Show Snackbar',
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/DFsend');
        },
      ),
      IconButton(
        icon: const Icon(Icons.add_location),
        tooltip: 'Show Snackbar',
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/DFsend');
        },
      ),
      IconButton(
        icon: const Icon(Icons.share),
        tooltip: 'Show Snackbar',
        color: Colors.blue,
        onPressed: () {
          Navigator.pushNamed(context, '/DFsend');
        },
      ),
      IconButton(
        icon: const Icon(Icons.work),
        tooltip: 'Show Snackbar',
        color: Colors.blue,
        onPressed: () {
          _counter.increment();
        },
      ),
    ],
        alignment:MainAxisAlignment.center,
        mainAxisSize:MainAxisSize.max

    );

    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body:    Center(
      child: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CupertinoTextField(
              placeholder: 'Email',
              keyboardType: TextInputType.emailAddress,
              clearButtonMode: OverlayVisibilityMode.editing,
              autocorrect: false,
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CupertinoTextField(
              placeholder:'Password',
              clearButtonMode: OverlayVisibilityMode.editing,
              obscureText: true,
              autocorrect: false,
            ),
          ),
          button,
          shareBtn,
      Text(
        'Value: ${_counter.value}',
      )


        ],
      ),
      ),
      /*floatingActionButton: new FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: new Icon(Icons.add),
      ),
      */
    );
  }

  void _onButtonPressed() {
    Navigator.pushNamed(context, '/send1');
  }
}