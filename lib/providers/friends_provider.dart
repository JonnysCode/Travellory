import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travellory/logger.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:pedantic/pedantic.dart';
import 'package:travellory/services/friends/friend_management.dart';

class FriendsProvider extends ChangeNotifier{
  FriendsProvider(){
    _friends = <FriendsModel>[];
    _friendRequests = <FriendsModel>[];
    _sentFriendRequests = <FriendsModel>[];
  }

  final log = getLogger('FriendsProvider');

  bool isFetchingFriends = false;
  bool isFetchingFriendRequests = false;
  bool isFetchingSentFriendRequests = false;

  List<FriendsModel> _friends;
  List<FriendsModel> _friendRequests;
  List<FriendsModel> _sentFriendRequests;
  UserModel _user;

  List<FriendsModel> get friends => _friends;
  List<FriendsModel> get friendRequests => _friendRequests;
  List<FriendsModel> get sentFriendRequests => _sentFriendRequests;
  UserModel get user => _user;

  set user(UserModel user){
    _user = user;
  }

  void init(UserModel user){
    _user = user;
    unawaited(_fetchFriendRequests());
    unawaited(_fetchFriends());
    unawaited(_fetchSentFriendRequests());
  }

  void update(SocialActionType type) async {
    switch(type) {
      case SocialActionType.sendFriendRequest:
      case SocialActionType.declineFriendRequest:
        await _fetchFriendRequests();
        await _fetchSentFriendRequests();
        break;
      case SocialActionType.removeFriend:
        await _fetchFriends();
        break;
      case SocialActionType.acceptFriendRequest:
        await _fetchFriendRequests();
        await _fetchFriends();
        break;
      default:
        // do nothing
    }
  }


  Future<void> _fetchFriends() async {
    isFetchingFriends = true;
    try {
      _friends = await FriendManagement.getFriends(_user.uid);
    } on PlatformException catch (error) {
      log.e(error.message);
    }
    isFetchingFriends = false;
    notifyListeners();
  }

  Future<void> _fetchFriendRequests() async {
    isFetchingFriendRequests = true;
    try {
      _friendRequests = await FriendManagement.getFriendRequests(_user.uid);
    } on PlatformException catch (error) {
        log.e(error.message);
    }

    isFetchingFriendRequests = false;
    notifyListeners();
  }

  Future<void> _fetchSentFriendRequests() async {
    isFetchingSentFriendRequests = true;
    try {
      _sentFriendRequests = await FriendManagement.getSentFriendRequests(_user.uid);
    } on PlatformException catch (error) {
      log.e(error.message);
    }
    isFetchingSentFriendRequests = false;
    notifyListeners();
  }
}