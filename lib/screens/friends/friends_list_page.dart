import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/providers/screens/friends_page_provider.dart';
import 'package:travellory/services/friends/friend_management.dart';
import 'package:travellory/shared/loading.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/friends/friends_list_widget.dart';

class FriendListPage extends StatefulWidget {
  @override
  _FriendListPageState createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {
  void _performSocialAction(
      String uidSender, String uidReceiver, SocialActionType type) async {
    await FriendManagement.performSocialAction(uidSender, uidReceiver, type)
        .then((value) {
      bool success = true;
      String message = _getMessage(type, success);
      _showSnackBar(message, success);
    }).catchError((error) {
      bool success = false;
      String message = _getMessage(type, success);
      _showSnackBar(message, success);
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

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Padding(
              padding: EdgeInsets.only(left: 200, top: 10),
            ),
            FashionFetishText(
              text: 'Add Friends',
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
          Consumer<FriendsProvider>(
            builder: (_, friendsProvider, __) => friendsProvider.isFetching
                ? Loading()
                : friendsProvider.friendRequests.isEmpty
                    ? Text('You have no friend requests :(')
                    : friendList(
                        Key('friend_requests_list'),
                        158,
                        friendsProvider.friendRequests,
                        Wrap(
                          children: <Widget>[
                            socialButton(
                                Key('accept_button'),
                                Icons.person_add,
                                Colors.green,
                                () => _performSocialAction(
                                    friendsProvider.friendRequests[0].uid,
                                    user.uid,
                                    SocialActionType.acceptFriendRequest)),
                            socialButton(
                                Key('decline_button'),
                                Icons.clear,
                                Colors.red,
                                () => _performSocialAction(
                                    friendsProvider.friendRequests[0].uid,
                                    user.uid,
                                    SocialActionType.declineFriendRequest)),
                          ],
                        ),
                        10,
                        context),
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
          Consumer<FriendsProvider>(
            builder: (_, friendsProvider, __) => friendsProvider.isFetching
                ? Loading()
                : friendsProvider.friends.isEmpty
                    ? Text('You have no friends :(')
                    : friendList(
                        Key('friends_list'),
                        240,
                        friendsProvider.friends,
                        Wrap(
                          children: <Widget>[
                            socialButton(
                                Key('remove_button'),
                                Icons.delete,
                                Colors.red,
                                () => _performSocialAction(
                                    friendsProvider.friends[0].uid,
                                    user.uid,
                                    SocialActionType.removeFriend)),
                          ],
                        ),
//                OptionButton(
//                  optionItems: <OptionItem>[
//                    OptionItem(
//                        description: 'Remove',
//                        icon: FontAwesomeIcons.trash,
//                        onTab: () => _removeFriend(
//                            friendsProvider
//                                .friends[0]
//                                .uid,
//                            user.uid
//                        ),
//                        color: Colors.red
//                    ),
//                  ],
//                ),
                        6,
                        context),
          ),
        ],
      ),
    );
  }
}
