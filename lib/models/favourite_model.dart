import 'package:flutter/cupertino.dart';
class favourite with ChangeNotifier{
  List <Map<String, dynamic>> addfavourite=[];
  List <Map<String, dynamic>> get newfavourites => addfavourite;
  void add(Map<String, dynamic> item) {
    addfavourite.add(item);
    notifyListeners();
  }
  void remove(int index) {
    addfavourite.removeAt(index);
    notifyListeners();
  }
}