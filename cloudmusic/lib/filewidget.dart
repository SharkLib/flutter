import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';


class FileWidget extends StatelessWidget {
  final Color color  ;

  FileWidget(this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      height: 130,

      child: new Row(
        mainAxisAlignment:
        MainAxisAlignment.start,
        crossAxisAlignment:
        CrossAxisAlignment.start,

        children: <Widget>
        [
          Expanded(
            child: FormBuilderTextField(
              attribute: "age",
              decoration: InputDecoration(labelText: "Age"),
              //onChanged: _onChanged,
              valueTransformer: (text) => num.tryParse(text),
              validators: [
                FormBuilderValidators.numeric(),
                FormBuilderValidators.max(70),
              ],
              initialValue: "看看",
            ),
          ),
          Expanded(
            child: FormBuilderSlider(
              attribute: "slider",
              validators: [FormBuilderValidators.min(6)],
              //onChanged: _onChanged,
              min: 0.0,
              max: 100.0,
              initialValue: 1.0,
              divisions: 20,
              decoration:
              InputDecoration(labelText: "Number of things"),
            ),
          ),
          Expanded(
            child: FittedBox(

              fit: BoxFit.contain, // otherwise the logo will be tiny
              child:   Image.asset('assets/a.jpg'),
            ),
          ),
        ],
      ),
    );
  }
}