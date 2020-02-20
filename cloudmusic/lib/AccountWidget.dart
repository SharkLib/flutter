
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/countmodel.dart';

class AccountWidget extends StatelessWidget {

  _navigateAndDisplaySelection(BuildContext context) async {
    print("test pop in pop");
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
  }

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = Theme.of(context);
    final _counter = Provider.of<CounterModel>(context);
    final textSize = Provider.of<int>(context).toDouble();

    // Remove the MediaQuery padding because the demo is rendered inside of a
    // different page that already accounts for this padding.
    return MediaQuery.removePadding(
      context: context,
      //removeTop: true,
      removeBottom: true,

        child: Scaffold(
          appBar: AppBar(
            title: Text('Account'),
            actions: [
              FlatButton(
                child: Text(
                  'Save',
                  style: theme.textTheme.body1.copyWith(
                    color: theme.colorScheme.onPrimary,
                  ),
                ),
                onPressed: () {
                  _navigateAndDisplaySelection(context);
                },
              ),
            ],
          ),
          body: Center(

            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
            Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: () {
                // Close the screen and return "Yep!" as the result.
               // Navigator.pop(context, 'Yep!');
                _navigateAndDisplaySelection(context);
              },
              child: Text('Yep!'),
            ),
          ),

             Text(
              'Value: ${_counter.value}',
            ),
          ],
          ),
    ),
        ),

    );
  }
}



class SelectionScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pick an option'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Close the screen and return "Yep!" as the result.
                  Navigator.pop(context, 'Yep!');
                },
                child: Text('Yep!'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: RaisedButton(
                onPressed: () {
                  // Close the screen and return "Nope!" as the result.
                  Navigator.pop(context, 'Nope.');
                },
                child: Text('Nope.'),
              ),
            )
          ],
        ),
      ),
    );
  }
}