import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travellory/models/achievements_model.dart';
import 'package:travellory/models/friend_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:pedantic/pedantic.dart';
import 'package:travellory/services/authentication/user_management.dart';
import 'package:travellory/services/friends/friend_management.dart';
import 'package:travellory/utils/logger.dart';

class FriendsProvider extends ChangeNotifier{
  FriendsProvider(){
    _friends = <FriendModel>[];
    _friendRequests = <FriendModel>[];
    _sentFriendRequests = <FriendModel>[];
  }

  final log = getLogger('FriendsProvider');

  bool isFetchingFriends = false;
  bool isFetchingFriendRequests = false;
  bool isFetchingSentFriendRequests = false;
  bool isFetchingFriendsAchievements = false;

  List<FriendModel> _friends;
  List<FriendModel> _friendRequests;
  List<FriendModel> _sentFriendRequests;
  Achievements _friendsAchievements;
  UserModel _user;

  List<FriendModel> get friends => _friends;
  List<FriendModel> get friendRequests => _friendRequests;
  List<FriendModel> get sentFriendRequests => _sentFriendRequests;
  Achievements get friendsAchievements => _friendsAchievements;
  UserModel get user => _user;

  set user(UserModel user){
    _user = user;
  }

  void init(UserModel user){
    _user = user;
    unawaited(_fetchFriends());
    unawaited(_fetchFriendRequests());
    unawaited(_fetchSentFriendRequests());
  }

  Future update(SocialActionType type) async {
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
        await _fetchFriends();
        await _fetchFriendRequests();
        break;
      case SocialActionType.receivedFriendRequest:
        await _fetchFriendRequests();
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