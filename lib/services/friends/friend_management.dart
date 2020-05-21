import 'package:cloud_functions/cloud_functions.dart';
import 'package:travellory/models/friends_model.dart';

enum SocialActionType {
  sendFriendRequest,
  acceptFriendRequest,
  declineFriendRequest,
  removeFriend,
  receivedFriendRequest
}

class FriendManagement {
  static Future<HttpsCallableResult> performSocialAction(
      String uidSender, String uidReceiver, SocialActionType type) {
    final String functionName = _getFunctionName(type);

    return _callHttpsCallable(uidSender, uidReceiver, functionName);
  }

  static Future<List<FriendsModel>> getFriends(String uid) async {
    final HttpsCallableResult result = await _callHttpsCallable(uid, null, 'friends-getFriends');
    return _generateFriendsListFromResult(result);
  }

  static Future<List<FriendsModel>> getFriendRequests(String uid) async {
    final HttpsCallableResult result =
        await _callHttpsCallable(uid, null, 'friends-getFriendRequests');
    return _generateFriendRequestListFromResult(result);
  }

  static Future<List<FriendsModel>> getSentFriendRequests(String uid) async {
    final HttpsCallableResult result =
    await _callHttpsCallable(uid, null, 'friends-getSentFriendRequests');
    return _generateFriendsListFromResult(result);
  }

  static Future<FriendsModel> getPublicUserInformation(String uid) async {
    final HttpsCallableResult result =
        await _callHttpsCallable(uid, null, 'user-getPublicUserInformation');
    final FriendsModel friend = FriendsModel(result.data['uid'],
        result.data['displayName'], result.data['photoURL'], result.data['homeCountry']);
    return friend;
  }

  static Future<List<FriendsModel>> searchByUsername(String displayName) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'user-searchByUsername',
    );
    final HttpsCallableResult result = await callable.call({'displayName': displayName});
    return _generateFriendsListFromResult(result);
  }

  static Future<bool> areFriends(String uidSender, String uidReceiver) async {
    final HttpsCallableResult result =
    await _callHttpsCallable(uidSender, uidReceiver, 'friends-areFriends');
    return result.data['areFriends'];
  }

  static Future<bool> friendRequestExists(String uidSender, String uidReceiver) async {
    final HttpsCallableResult result =
    await _callHttpsCallable(uidSender, uidReceiver, 'friends-friendRequestExists');
    return result.data['friendRequestExists'];
  }

  static Future<List<FriendsModel>> _generateFriendsListFromResult(
      HttpsCallableResult result) async {
    final List<FriendsModel> friendsList = [];
    if(result.data != null) {
      for (final String uid in result.data) {
        final FriendsModel friend = await getPublicUserInformation(uid);
        friendsList.add(friend);
      }
    }
    return friendsList;
  }

  static Future<List<FriendsModel>> _generateFriendRequestListFromResult(
      HttpsCallableResult result) async {
    final List<FriendsModel> friendsList = [];
    if(result.data != null) {
      for (final String uid in result.data.keys) {
        final FriendsModel friend = await getPublicUserInformation(uid);
        friendsList.add(friend);
      }
    }
    return friendsList;
  }

  static Future<HttpsCallableResult> _callHttpsCallable(
      String uidSender, String uidReceiver, String functionName) {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: functionName,
    );
    if (uidReceiver != null) {
      return callable
          .call({'uidSender': uidSender, 'uidReceiver': uidReceiver});
    } else {
      return callable.call({'uid': uidSender});
    }
  }

  static String _getFunctionName(SocialActionType type) {
    switch (type) {
      case SocialActionType.sendFriendRequest:
        return 'friends-sendFriendRequest';
      case SocialActionType.acceptFriendRequest:
        return 'friends-acceptFriendRequest';
      case SocialActionType.declineFriendRequest:
        return 'friends-declineFriendRequest';
      case SocialActionType.removeFriend:
        return 'friends-removeFriend';
      default:
        return null;
    }
  }
}
