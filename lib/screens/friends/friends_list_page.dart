import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/friends_model.dart';
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
  bool _loading = false;

  void _performSocialAction(
      String uidSender, String uidReceiver, SocialActionType type) async {

    setState(() {
      _loading = true;
    });

    await FriendManagement.performSocialAction(uidSender, uidReceiver, type)
        .then((value) async {

      bool success = true;
      String message = _getMessage(type, success);
      _showSnackBar(message, success);

      final FriendsProvider friendsProvider =
          Provider.of<FriendsProvider>(context, listen: false);
      await friendsProvider.update();
    }).catchError((error) {
      bool success = false;
      print(error.toString());
      String message = _getMessage(type, success);
      _showSnackBar(message, success);
    });

    setState(() {
      _loading = false;
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

  Widget _showSnackBar(String message, bool success) {
    return SnackBar(
      content: Flushbar(
          flushbarStyle: FlushbarStyle.FLOATING,
          title: success ? "Success" : "Error",
          message: message,
          backgroundColor:
              success ? Theme.of(context).primaryColor : Colors.redAccent,
          margin: EdgeInsets.all(8),
          borderRadius: 12,
          duration: Duration(seconds: 3))
        ..show(context),
    );
  }

  Widget friendRequestButtons(String uidSender, String uidReceiver) {
    return Wrap(
      children: <Widget>[
        socialButton(
            Key('accept_button'),
            Icons.person_add,
            Colors.green,
            () => _performSocialAction(
                uidSender, uidReceiver, SocialActionType.acceptFriendRequest)),
        socialButton(
            Key('decline_button'),
            Icons.clear,
            Colors.red,
            () => _performSocialAction(
                uidSender, uidReceiver, SocialActionType.declineFriendRequest)),
      ],
    );
  }

  Widget removeFriendButton(String uidSender, String uidReceiver) {
    return Wrap(
      children: <Widget>[
        socialButton(
            Key('remove_button'),
            Icons.delete,
            Colors.red,
            () => _performSocialAction(
                uidSender, uidReceiver, SocialActionType.removeFriend)),
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
        Padding(
          key: Key('friend-requests-list'),
          padding: EdgeInsets.only(
              left: 15,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
//                  flex: 2,
                  child: Scrollbar(
                      child: Consumer<FriendsProvider>(
                        builder: (_, friendsProvider, __) =>
                        friendsProvider.isFetching
                            ? LoadingHeart()
                            : friendsProvider.friendRequests.isEmpty
                            ? Text('No pending friend requests')
                            : ListView.separated(
                          padding: EdgeInsets.only(
                            bottom: 50,
                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                          itemCount: friendsProvider.friendRequests.length,
                          itemBuilder: (context, index) {
                            FriendsModel friend =
                            friendsProvider.friendRequests[index];
                            return friendsCard(
                              context,
                              friend,
                              _loading
                                  ? CircularProgressIndicator()
                                  : friendRequestButtons(
                                  friend.uid, user.uid),
                              10,
                            );
                          },
                        ),
                      )
                  ),
                ),
          ]),
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
        Padding(
          key: Key('friends-list'),
          padding: EdgeInsets.only(
              left: 15,
              right: 20,
              bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Flex(
              direction: Axis.horizontal,
              children: <Widget>[
                Expanded(
//                  flex: 2,
//              height: 0.38 * MediaQuery.of(context).size.height,
                  child: Scrollbar(
                      child: Consumer<FriendsProvider>(
                        builder: (_, friendsProvider, __) =>
                        friendsProvider.isFetching
                            ? LoadingHeart()
                            : friendsProvider.friends.isEmpty
                            ? Text('You have no friends :(')
                            : ListView.separated(
//                          padding: EdgeInsets.only(
//                            bottom: 50,
//                          ),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          separatorBuilder: (context, index) =>
                          const SizedBox(height: 12),
                          itemCount: friendsProvider.friends.length,
                          itemBuilder: (context, index) {
                            FriendsModel friend =
                            friendsProvider.friends[index];
                            return friendsCard(
                              context,
                              friend,
                              _loading
                                  ? CircularProgressIndicator()
                                  : removeFriendButton(
                                  friend.uid, user.uid),
                              10,
                            );
                          },
                        ),
                      )
                  ),
                ),
          ]),
        ),
      ],
    );
  }
}
