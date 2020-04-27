import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/providers/screens/friends_page_provider.dart';
import 'package:travellory/screens/home/pages/friends_page.dart';
import 'package:travellory/services/friend_management.dart';
import 'package:travellory/shared/loading.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/buttons/option_button.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/friends/friends_list_widget.dart';

class FriendListPage extends StatefulWidget {
  @override
  _FriendListPageState createState() => _FriendListPageState();
}

class _FriendListPageState extends State<FriendListPage> {

  void _acceptFriendRequest(String uidSender, String uidReceiver) async {
    await FriendManagement.acceptFriendRequest(uidSender, uidReceiver)
        .then((value) {
      _showSnackBar('You got a new friend. Nice!', true);
      final friendsProvider =
      Provider.of<FriendsProvider>(context, listen: false);
      friendsProvider.update();
    }).catchError((error) {
      _showSnackBar('Failed to accept friend request. Try again', false);
    });
  }

  void _declineFriendRequest(String uidSender, String uidReceiver) async {
    await FriendManagement.declineFriendRequest(uidSender, uidReceiver)
        .then((value) {
      _showSnackBar('Declined friend request', true);
      final friendsProvider =
      Provider.of<FriendsProvider>(context, listen: false);
      friendsProvider.update();
    }).catchError((error) {
      _showSnackBar('Failed to decline friend request. Try again', false);
    });
  }

  void _removeFriend(String uidA, String uidB) async {
    await FriendManagement.removeFriend(uidA, uidB).then((value) {
      _showSnackBar('Too bad for them.', true);
      final friendsProvider =
      Provider.of<FriendsProvider>(context, listen: false);
      friendsProvider.update();
    }).catchError((error) {
      _showSnackBar('Failed to remove friend. Try again', false);
    });
  }

  Widget _showSnackBar(String message, bool success) {
    return SnackBar(
      content: Flushbar(
          flushbarStyle: FlushbarStyle.FLOATING,
          title: success ? "Success" : "Error",
          message: message,
          backgroundColor:
          success ? Theme
              .of(context)
              .primaryColor : Colors.redAccent,
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
                color: Theme
                    .of(context)
                    .primaryColor,
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
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom),
            child: Container(
              height: 30,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: FashionFetishText(
                text: 'Friend requests',
                size: 22,
                fontWeight: FashionFontWeight.heavy,
              ),
            ),
          ),
          Consumer<FriendsProvider>(
            builder: (_, friendsProvider, __) =>
            friendsProvider.isFetching
                ? Loading()
                : friendsProvider.friendRequests.isEmpty
                ? Text('You have no friend requests :(')
                : friendList(
                Key('friend_requests_list'),
                158,
                friendsProvider.friendRequests,
                OptionButton(
                  optionItems: <OptionItem>[
                    OptionItem(
                        description: 'Accept',
                        icon: FontAwesomeIcons.check,
                        onTab: () => {}
                    ),
                    OptionItem(
                        description: 'Decline',
                        icon: FontAwesomeIcons.times,
                        onTab: () => {}
                    ),
                  ],
                ),
                context),
          ),
          SizedBox(height: 20),
          Padding(
            key: Key('friends'),
            padding: EdgeInsets.only(
                top: 10,
                left: 30,
                right: 90,
                bottom: MediaQuery
                    .of(context)
                    .viewInsets
                    .bottom),
            child: Container(
              height: 30,
              width: MediaQuery
                  .of(context)
                  .size
                  .width,
              child: FashionFetishText(
                text: 'Friends',
                size: 22,
                fontWeight: FashionFontWeight.heavy,
              ),
            ),
          ),
          Consumer<FriendsProvider>(
            builder: (_, friendsProvider, __) =>
            friendsProvider.isFetching
                ? Loading()
                : friendsProvider.friends.isEmpty
                ? Text('You have no friends :(')
                : friendList(
                Key('friends_list'),
                240,
                friendsProvider.friends,
                OptionButton(
                  optionItems: <OptionItem>[
                    OptionItem(
                        description: 'Remove',
                        icon: FontAwesomeIcons.trash,
                        onTab: () => {}
                    ),
                  ],
                ),
                context),
          ),
        ],
      ),
    );
  }
}