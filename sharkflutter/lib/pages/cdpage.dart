
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SharkFlutter/models/shopmodel.dart';
import 'package:provider/provider.dart';
import 'package:SharkFlutter/pages/cartpage.dart';

class CDPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CDPageState();

  }

}

class CDPageState extends State<CDPage>
{
  var prs = List<ProductItem>.generate(20, (index) => ProductItem( "Item $index", index*1.1));
  var isChecks =  List<bool>.generate(20, (i) => false);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final model = Provider.of<ShopModel>(context);


    return Scaffold(

      body: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: 20,
          itemBuilder: (BuildContext context, int index) {
            int ii = index % 2 + 1;

            return new ListTile(
              leading: Icon(Icons.add_call),
              title: new Text(prs[index].name),
              subtitle: new Text(prs[index].price.toStringAsFixed(3) ),
              trailing: Checkbox(
                value:isChecks[index],
                onChanged: (bool isss) {
                      setState(() {
                        isChecks[index] = isss;
                        model.addProduct(prs[index].name, prs[index].price);
                      });
                },
              ),
            );


          }
      )
    );
  }

}