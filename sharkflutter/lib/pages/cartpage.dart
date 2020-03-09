
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:SharkFlutter/models/shopmodel.dart';
import 'package:provider/provider.dart';

class CartPage extends StatefulWidget
{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return CartPageState();

  }

}

class CartPageState extends State<CartPage>
{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final model = Provider.of<ShopModel>(context);


    return Scaffold(
        appBar: AppBar(
          title: Text("Cart"),

        ),
        body: ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: model.products.length,
            itemBuilder: (BuildContext context, int index) {
              int ii = index % 2 + 1;

              return new ListTile(
                leading: Icon(Icons.add_call),
                title: new Text(model.products[index].name),
                subtitle: new Text(model.products[index].price.toStringAsFixed(3) ),
              );


            }
        )
    );
  }

}