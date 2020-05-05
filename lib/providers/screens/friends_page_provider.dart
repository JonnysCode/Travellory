import 'package:flutter/material.dart';

class FriendsPageProvider extends ChangeNotifier {

  FriendsPageProvider(){
    isSearching = false;
  }

  bool isSearching;

  void toggleSearching(){
    isSearching = !isSearching;
    notifyListeners();
  }

}