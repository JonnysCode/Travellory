import 'package:cloud_functions/cloud_functions.dart';
import 'package:travellory/models/friends_model.dart';

enum SocialActionType {
  sendFriendRequest,
  acceptFriendRequest,
  declineFriendRequest,
  removeFriend
}

class FriendManagement {
  static Future<HttpsCallableResult> performSocialAction(
      String uidSender, String uidReceiver, SocialActionType type) {
    String functionName = _getFunctionName(type);

    return _callHttpsCallable(uidSender, uidReceiver, functionName);
  }

  static Future<List<FriendsModel>> getFriends(String uid) async {
    final result = await _callHttpsCallable(uid, null, 'friends-getFriends');
    return _generateFriendsListFromHttpsCallableResult(result);
  }

  static Future<List<FriendsModel>> getFriendRequests(String uid) async {
    final result =
        await _callHttpsCallable(uid, null, 'friends-getFriendRequests');
    return _generateFriendsListFromHttpsCallableResult(result);
  }

  static Future<FriendsModel> getPublicUserInformation(String uid) async {
    final result =
        await _callHttpsCallable(uid, null, 'user-getPublicUserInformation');
    FriendsModel friend =
        FriendsModel(result.data['uid'], result.data['displayName']);
    return friend;
  }

  static Future<List<FriendsModel>> _generateFriendsListFromHttpsCallableResult(
      HttpsCallableResult result) async {
    List<FriendsModel> friendsList = List();
    for (String uid in result.data) {
      FriendsModel friend = await getPublicUserInformation(uid);
      friendsList.add(friend);
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
        return 'friends-declineFriendRequest';
      default:
        return null;
    }
  }
}
