import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/shared/loading.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/services/friend_management.dart';
import 'package:travellory/widgets/friends_list_widget.dart';


class FriendsPage extends StatefulWidget {
  @override
  _FriendsPageState createState() => _FriendsPageState();
}

class _FriendsPageState extends State<FriendsPage> {
  void _acceptFriendRequest(String uidSender, String uidReceiver) async {
    await FriendManagement.acceptFriendRequest(uidSender, uidReceiver)
        .then((value) {
      _showSnackBar('You got a new friend. Nice!', true);
      final FriendsProvider friendsProvider =
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
      final FriendsProvider friendsProvider =
          Provider.of<FriendsProvider>(context, listen: false);
      friendsProvider.update();
    }).catchError((error) {
      _showSnackBar('Failed to decline friend request. Try again', false);
    });
  }

  void _removeFriend(String uidA, String uidB) async {
    await FriendManagement.removeFriend(uidA, uidB)
        .then((value) {
      _showSnackBar('Too bad for them.', true);
      final FriendsProvider friendsProvider =
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
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<UserModel>(context);
    return SafeArea(
      child: Container(
        key: Key('friends_page'),
        child: Stack(
          children: <Widget>[
            SizedBox.expand(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(6, 40, 6, 0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40.0)),
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
                      Text(
                        'FRIENDS',
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
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
                        builder: (_, friendsProvider, __) =>
                            friendsProvider.isFetching
                                ? Loading()
                                : friendsProvider.friendRequests.isEmpty
                                    ? Text('You have no friend requests :(')
                                    : friendList(
                                        Key('friend_requests_list'),
                                        145,
                                        friendsProvider.friendRequests,
                                        Wrap(
                                          children: <Widget>[
                                            socialButton(
                                                Key('accept_button'),
                                                Icons.add_circle,
                                                Colors.green,
                                                () => _acceptFriendRequest(
                                                    friendsProvider
                                                        .friendRequests[0]
                                                        .uid,
                                                    user.uid)),
                                            socialButton(
                                                Key('decline_button'),
                                                Icons.remove_circle,
                                                Colors.red,
                                                    () => _declineFriendRequest(
                                                    friendsProvider
                                                        .friendRequests[0]
                                                        .uid,
                                                    user.uid)),
                                          ],
                                        ),
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
                        builder: (_, friendsProvider, __) =>
                            friendsProvider.isFetching
                                ? Loading()
                                : friendsProvider.friends.isEmpty
                                    ? Text('You have no friends :(')
                                    : friendList(
                                        Key('friends_list'),
                                        225,
                                        friendsProvider.friends,
                                        Wrap(
                                          children: <Widget>[
                                            socialButton(
                                                Key('remove_button'),
                                                Icons.remove_circle,
                                                Colors.red,
                                                    () => _removeFriend(
                                                    friendsProvider
                                                        .friendRequests[0]
                                                        .uid,
                                                    user.uid)),
                                          ],
                                        ),
                                        context),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
              top: 50,
              left: 30,
              child: Icon(
                FontAwesomeIcons.addressBook,
                size: 50,
              ),
            ),
            Positioned(
              top: 50,
              right: 30,
              child: Icon(
                Icons.search,
                size: 50,
              ),
            )
          ],
        ),
      ),
    );
  }
}
