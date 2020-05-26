import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travellory/src/models/achievements_model.dart';
import 'package:travellory/src/models/friend_model.dart';
import 'package:travellory/src/models/user_model.dart';
import 'package:pedantic/pedantic.dart';
import 'package:travellory/src/services/cloud/friend_management.dart';
import 'package:travellory/src/utils/logger.dart';

class FriendsProvider extends ChangeNotifier {
  FriendsProvider({this.management}) {
    _friends = <FriendModel>[];
    _friendRequests = <FriendModel>[];
    _sentFriendRequests = <FriendModel>[];
  }

  final FriendManagement management;

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

  set user(UserModel user) {
    _user = user;
  }

  void init(UserModel user) {
    _user = user;
    unawaited(_fetchFriends());
    unawaited(_fetchFriendRequests());
    unawaited(_fetchSentFriendRequests());
  }

  Future update(SocialActionType type) async {
    switch (type) {
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
      _friends = await management.getFriends(_user.uid);
    } on PlatformException catch (error) {
      log.e(error.message);
    }
    isFetchingFriends = false;
    notifyListeners();
  }

  Future<void> _fetchFriendRequests() async {
    isFetchingFriendRequests = true;
    try {
      _friendRequests = await management.getFriendRequests(_user.uid);
    } on CloudFunctionsException catch (e) {
      log.i('caught firebase functions exception');
      log.e(e.code);
      log.e(e.message);
      log.e(e.details);
    } on Exception catch (e) {
      log.i('caught generic exception');
      log.i(e);
    }

    isFetchingFriendRequests = false;
    notifyListeners();
  }

  Future<void> _fetchSentFriendRequests() async {
    isFetchingSentFriendRequests = true;
    try {
      _sentFriendRequests = await management.getSentFriendRequests(_user.uid);
    } on CloudFunctionsException catch (e) {
      log.i('caught firebase functions exception');
      log.e(e.code);
      log.e(e.message);
      log.e(e.details);
    } on Exception catch (e) {
      log.i('caught generic exception');
      log.i(e);
    }
    isFetchingSentFriendRequests = false;
    notifyListeners();
  }
}
