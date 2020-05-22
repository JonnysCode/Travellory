import 'package:cloud_functions/cloud_functions.dart';
import 'package:travellory/models/friend_model.dart';

enum SocialActionType {
  sendFriendRequest,
  acceptFriendRequest,
  declineFriendRequest,
  removeFriend,
  receivedFriendRequest
}

class FriendManagement {
  factory FriendManagement() {
    return _instance;
  }

  FriendManagement._privateConstructor();

  static final FriendManagement _instance =
      FriendManagement._privateConstructor();

  Future<HttpsCallableResult> performSocialAction(
      String uidSender, String uidReceiver, SocialActionType type) {
    final String functionName = _getFunctionName(type);

    return _callHttpsCallable(uidSender, uidReceiver, functionName);
  }

  Future<List<FriendModel>> getFriends(String uid) async {
    final HttpsCallableResult result =
        await _callHttpsCallable(uid, null, 'friends-getFriends');
    return _generateFriendsListFromResult(result);
  }

  Future<List<FriendModel>> getFriendRequests(String uid) async {
    final HttpsCallableResult result =
        await _callHttpsCallable(uid, null, 'friends-getFriendRequests');
    return _generateFriendRequestListFromResult(result);
  }

  Future<List<FriendModel>> getSentFriendRequests(String uid) async {
    final HttpsCallableResult result =
        await _callHttpsCallable(uid, null, 'friends-getSentFriendRequests');
    return _generateFriendsListFromResult(result);
  }

  Future<FriendModel> getPublicUserInformation(String uid) async {
    final HttpsCallableResult result =
        await _callHttpsCallable(uid, null, 'user-getPublicUserInformation');
    final FriendModel friend = FriendModel.fromData(result.data);
    return friend;
  }

  Future<List<FriendModel>> searchByUsername(String displayName) async {
    final HttpsCallable callable = CloudFunctions.instance.getHttpsCallable(
      functionName: 'user-searchByUsername',
    );
    final HttpsCallableResult result =
        await callable.call({'displayName': displayName});
    return _generateFriendsListFromResult(result);
  }

  Future<List<FriendModel>> _generateFriendsListFromResult(
      HttpsCallableResult result) async {
    final List<FriendModel> friendsList = [];
    if (result.data != null) {
      for (final String uid in result.data) {
        final FriendModel friend = await getPublicUserInformation(uid);
        friendsList.add(friend);
      }
    }
    return friendsList;
  }

  Future<List<FriendModel>> _generateFriendRequestListFromResult(
      HttpsCallableResult result) async {
    final List<FriendModel> friendsList = [];
    if (result.data != null) {
      for (final String uid in result.data.keys) {
        final FriendModel friend = await getPublicUserInformation(uid);
        friendsList.add(friend);
      }
    }
    return friendsList;
  }

  Future<HttpsCallableResult> _callHttpsCallable(
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

  String _getFunctionName(SocialActionType type) {
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
