import 'package:flutter/material.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:pedantic/pedantic.dart';
import 'package:travellory/services/friend_management.dart';

class FriendsProvider extends ChangeNotifier{
  FriendsProvider(){
    _friends = <FriendsModel>[];
    _friendRequests = <FriendsModel>[];
  }

  bool isFetching = true;

  List<FriendsModel> _friends;
  List<FriendsModel> _friendRequests;
  UserModel _user;

  List<FriendsModel> get friends => _friends;
  List<FriendsModel> get friendRequests => _friendRequests;
  UserModel get user => _user;

  set user(UserModel user){
    _user = user;
  }

  void init(UserModel user){
    _user = user;
    unawaited(_fetchFriends());
  }

  void update() {
    unawaited(_fetchFriends());
  }

  Future<void> _fetchFriends() async {
    isFetching = true;
    _friendRequests = await FriendManagement.getFriendRequests(_user.uid);
    _friends = await FriendManagement.getFriends(_user.uid);

    isFetching = false;
    notifyListeners();
  }
}