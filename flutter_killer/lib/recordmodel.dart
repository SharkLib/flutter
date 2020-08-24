import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';


class RecordpModel with ChangeNotifier
{
  RecordpModel()
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

  }


  int _totalPolice = 0;
  int get totalPolice => _totalPolice;
  set setTotalPolice(int n) { _totalPolice= n;
  notifyListeners();
  }

  int _totalDeadPolice = 0;
  int get totalDeadPolice => _totalDeadPolice;
  set setTotalDeadPolice(int n) => _totalDeadPolice= n;

  int _totalKiller = 0;
  int get totalKiller => _totalKiller;
  void set setTotalKiller(int n) => _totalKiller= n;

  int _totaDeadlKiller = 0;
  int get totalDeadKiller => _totaDeadlKiller;
  set setTotalDeadKiller(int n) => _totaDeadlKiller= n;

  int _totalPopulice = 0;
  int get totalDeadPopulice => _totalPopulice;
  set setTotalDeadPopulice(int n) => _totalPopulice= n;


  String _user;
  String get user => _user;
  String _email;
  String get Email => _email;
  String _imgUrl;
  String get Img => _imgUrl;

  ImageProvider _UserImg = AssetImage("assets/head1.jpg");
  ImageProvider get UserImg => _UserImg;


}