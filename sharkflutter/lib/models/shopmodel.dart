
import 'package:flutter/cupertino.dart';

class MusicItem
{
  final String _title;
  final String _athor;

  MusicItem(this._title,this._athor);

}

class ProductItem{
  final String _name;
  String get name => _name;

  double _price;
  double get price => _price;
  ProductItem(this._name,this._price);
}

class ShopModel with ChangeNotifier
{
  int _totalLogin = 0;
  int get totalLogin => _totalLogin;
  String _user;
  String get user => _user;


  void login(user)
  {
    _totalLogin++;
    _user = user;
    notifyListeners();
  }

  void logout()
  {
    _totalLogin++;
    _user = null;
    notifyListeners();
  }

  List<MusicItem> _musiList = [];
  List<MusicItem> get musics => _musiList;

  void addMusit(title, athor)
  {
    _musiList.add( MusicItem(title, athor));
    notifyListeners();
  }

  final  List<ProductItem> _productList = [];
  List<ProductItem> get products=> _productList;

  void addProduct(name, price)
  {
    _productList.add( ProductItem(name, price));
    notifyListeners();
  }
}