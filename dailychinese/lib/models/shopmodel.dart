
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  ShopModel()
  {
    init();
  }
  void init() async
  {
    final prefs = await SharedPreferences.getInstance();
    // Try reading data from the counter key. If it doesn't exist, return 0.
    final counter = prefs.getInt('counter') ?? -1;
    print("def value:" + counter.toString());
    if (counter==-1)
      {
        prefs.setInt('counter', 0);
      }
    else
      prefs.setInt('counter', counter+1);
    _totalLogin = counter+1;
  }

  int _totalLogin = 0;
  int get totalLogin => _totalLogin;
  String _user;
  String get user => _user;
  String _email;
  String get Email => _email;
  String _imgUrl;
  String get Img => _imgUrl;

  ImageProvider _UserImg = AssetImage("assets/head1.jpg");
  ImageProvider get UserImg => _UserImg;


  void login(user,email,img)
  {
    _totalLogin++;
    _user = user;
    _email = email;
    _imgUrl = img;

    _UserImg =  Image.network(
        _imgUrl,
        height: 100,
        width: 150
    ).image;

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