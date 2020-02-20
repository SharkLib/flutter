
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'model/countmodel.dart';

class AccountWidget extends StatelessWidget {
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
                  Navigator.pop(context);
                },
              ),
            ],
          ),
          body: Center(
            child:  Text(
              'Value: ${_counter.value}',
            )
          ),
        ),

    );
  }
}