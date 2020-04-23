import 'package:flushbar/flushbar.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/services/friend_management.dart';
import 'package:travellory/shared/loading.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
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
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
        boxShadow: [
          BoxShadow(
              blurRadius: 20,
              color: Colors.black.withOpacity(.2),
              offset: Offset(0.0, -6.0))
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 20),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            Icon(
              FontAwesomeIcons.addressBook,
              size: 50,
            ),
            Text(
              'FRIENDS',
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            GestureDetector(
              onTap: () => {
                Navigator.pushNamed(context, '/search_friends'),
              },
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
              child: Text(
                'Friend requests',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
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
                145,
                friendsProvider.friendRequests,
//                Wrap(
//                  children: <Widget>[
//                    socialButton(
//                        Key('accept_button'),
//                        Icons.add_circle,
//                        Colors.green,
//                            () => _acceptFriendRequest(
//                            friendsProvider.friendRequests[0].uid,
//                            user.uid)),
//                    socialButton(
//                        Key('decline_button'),
//                        Icons.remove_circle,
//                        Colors.red,
//                            () => _declineFriendRequest(
//                            friendsProvider.friendRequests[0].uid,
//                            user.uid)),
//                  ],
//                ),
                context),
          ),
          SizedBox(height: 40),
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
              child: Text(
                'Friends',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
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
                225,
                friendsProvider.friends,
//                Wrap(
//                  children: <Widget>[
//                    socialButton(
//                        Key('remove_button'),
//                        Icons.remove_circle,
//                        Colors.red,
//                            () => _removeFriend(
//                            friendsProvider.friendRequests[0].uid,
//                            user.uid)),
//                  ],
//                ),
                context),
          ),
        ],
      ),
    );
  }
}