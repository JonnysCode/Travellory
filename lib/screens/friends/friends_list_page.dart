import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/providers/screens/friends_page_provider.dart';
import 'package:travellory/services/friends/friend_management.dart';
import 'package:travellory/shared/loading_heart.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/friends/friends_card_widget.dart';

class FriendListPage extends StatefulWidget {
  @override
  _FriendListPageState createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  final _loadingRequests = List();
  final _loadingFriends = List();

  void _performSocialAction(String uidSender, String uidReceiver,
      SocialActionType type, int index) async {
    final loading = _getLoadingList(type);

    setState(() {
      loading[index] = true;
    });

    await FriendManagement.performSocialAction(uidSender, uidReceiver, type)
        .then((value) async {
      final success = true;
      final message = _getMessage(type, success);
      _showSnackBar(message, success);

      final FriendsProvider friendsProvider =
          Provider.of<FriendsProvider>(context, listen: false);
      friendsProvider.update(type);
    }).catchError((error) {
      final success = false;
      final message = _getMessage(type, success);
      _showSnackBar(message, success);
    });

    setState(() {
      loading[index] = false;
    });
  }

  String _getMessage(SocialActionType type, bool success) {
    String message;
    switch (type) {
      case SocialActionType.acceptFriendRequest:
        success
            ? message = 'You got a new friend. Nice!'
            : message = 'Failed to accept friend request. Try again.';
        break;
      case SocialActionType.declineFriendRequest:
        success
            ? message = 'Declined friend request'
            : message = 'Failed to decline friend request. Try again.';
        break;
      case SocialActionType.removeFriend:
        success
            ? message = 'Too bad for them.'
            : message = 'Failed to remove friend. Try again.';
        break;
      default:
        message = '';
    }
    return message;
  }

  List _getLoadingList(SocialActionType type) {
    switch (type) {
      case SocialActionType.declineFriendRequest:
      case SocialActionType.acceptFriendRequest:
        return _loadingRequests;
        break;
      case SocialActionType.removeFriend:
        return _loadingFriends;
        break;
      default:
        return null;
    }
  }

  Widget _showSnackBar(String message, bool success) {
    return SnackBar(
      content: Flushbar(
          flushbarStyle: FlushbarStyle.FLOATING,
          title: success ? 'Success' : 'Error',
          message: message,
          backgroundColor:
              success ? Theme.of(context).primaryColor : Colors.redAccent,
          margin: EdgeInsets.all(8),
          borderRadius: 12,
          duration: Duration(seconds: 3))
        ..show(context),
    );
  }

  Widget friendRequestButtons(String uidSender, String uidReceiver, int index) {
    return Wrap(
      children: <Widget>[
        socialButton(
            Key('accept_button'),
            Icons.person_add,
            Colors.green,
            () => _performSocialAction(uidSender, uidReceiver,
                SocialActionType.acceptFriendRequest, index)),
        socialButton(
            Key('decline_button'),
            Icons.clear,
            Colors.red,
            () => _performSocialAction(uidSender, uidReceiver,
                SocialActionType.declineFriendRequest, index)),
      ],
    );
  }

  Widget removeFriendButton(String uidSender, String uidReceiver, int index) {
    return Wrap(
      children: <Widget>[
        socialButton(
            Key('remove_button'),
            Icons.delete,
            Colors.red,
            () => _performSocialAction(
                uidSender, uidReceiver, SocialActionType.removeFriend, index)),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<FriendsProvider>(context).user;

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        SizedBox(height: 20),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Padding(
            padding: EdgeInsets.only(left: 200, top: 10),
          ),
          FashionFetishText(
            text: 'Add friends',
            size: 16,
            color: Colors.black54,
            fontWeight: FashionFontWeight.bold,
          ),
          GestureDetector(
            onTap: () =>
                Provider.of<FriendsPageProvider>(context, listen: false)
                    .toggleSearching(),
            child: Icon(
              FontAwesomeIcons.search,
              color: Theme.of(context).primaryColor,
              size: 32,
            ),
          ),
        ]),
        SizedBox(height: 20),
        Padding(
          key: Key('friend_requests'),
          padding: EdgeInsets.only(
              top: 10,
              left: 30,
              right: 90,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            child: FashionFetishText(
              text: 'Friend requests',
              size: 22,
              fontWeight: FashionFontWeight.heavy,
            ),
          ),
        ),
        Container(
          constraints: BoxConstraints(minHeight: 35, maxHeight: 150),
          child: Padding(
            key: Key('friend-requests-list'),
            padding: EdgeInsets.only(
                left: 15,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Scrollbar(
                    child: Consumer<FriendsProvider>(
                      builder: (_, friendsProvider, __) => friendsProvider.isFetchingFriendRequests
                          ? LoadingHeart()
                          : friendsProvider.friendRequests.isEmpty
                          ? Padding(
                              padding: EdgeInsets.only(
                                top: 5,
                              ),
                              child: Text('No pending friend requests')
                            )
                          : ListView.separated(
                              padding: EdgeInsets.only(
                                bottom: 30,
                              ),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 12),
                              itemCount: friendsProvider.friendRequests.length,
                              itemBuilder: (context, index) {
                                final friend =
                                    friendsProvider.friendRequests[index];
                                _loadingRequests.add(false);
                                return friendsCard(
                                  context,
                                  friend,
                                  _loadingRequests[index]
                                      ? CircularProgressIndicator()
                                      : friendRequestButtons(
                                          friend.uid, user.uid, index),
                                  10,
                                );
                              },
                            ),
            )),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          key: Key('friends'),
          padding: EdgeInsets.only(
              top: 10,
              left: 30,
              right: 90,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Container(
            height: 30,
            width: MediaQuery.of(context).size.width,
            child: FashionFetishText(
              text: 'Friends',
              size: 22,
              fontWeight: FashionFontWeight.heavy,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            key: Key('friends-list'),
            padding: EdgeInsets.only(
                left: 15,
                right: 20,
                bottom: MediaQuery.of(context).viewInsets.bottom),
            child: Scrollbar(
                child: Consumer<FriendsProvider>(
              builder: (_, friendsProvider, __) =>
                  friendsProvider.isFetchingFriends
                      ? LoadingHeart()
                      : friendsProvider.friends.isEmpty
                      ? Text('You have no friends :(')
                      : ListView.separated(
                          padding: EdgeInsets.only(
                            bottom: 30,
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                            const SizedBox(height: 12),
                          itemCount: friendsProvider.friends.length,
                          itemBuilder: (context, index) {
                            final friend = friendsProvider.friends[index];
                            _loadingFriends.add(false);
                            return friendsCard(
                              context,
                              friend,
                              _loadingFriends[index]
                                  ? CircularProgressIndicator()
                                  : removeFriendButton(
                                  friend.uid, user.uid, index),
                              10,
                            );
                          },
                      ),
                )
            ),
          ),
        ),
        SizedBox(height: 50),
      ],
    );
  }
}
