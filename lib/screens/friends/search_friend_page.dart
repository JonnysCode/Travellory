import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:flappy_search_bar/search_bar_style.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/friend_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/friends_provider.dart';
import 'package:travellory/providers/screens/friends_page_provider.dart';
import 'package:travellory/services/friends/friend_management.dart';
import 'package:travellory/shared/loading_heart.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/friends/friends_card_widget.dart';
import 'package:travellory/widgets/snack_bar_widget.dart';

class SearchFriendsPage extends StatefulWidget {
  @override
  _SearchFriendsPageState createState() => _SearchFriendsPageState();
}

class _SearchFriendsPageState extends State<SearchFriendsPage> {
  String searchWord = '';
  final _isLoadingResult = [];
  final _isLoadingRequest = [];

  void _sendFriendRequest(
      String uidSender, String uidReceiver, int index) async {

    final FriendsProvider friendsProvider =
    Provider.of<FriendsProvider>(context, listen: false);

    String messageToDisplay;
    bool isSuccessful;

    setState(() {
      _isLoadingResult[index] = true;
    });

    await friendsProvider.management.performSocialAction(
            uidSender, uidReceiver, SocialActionType.sendFriendRequest)
        .then((value) async {
      messageToDisplay = "Friend request sent";
      isSuccessful = true;
      await friendsProvider.update(SocialActionType.sendFriendRequest);
    }).catchError((error) {
      messageToDisplay = "There was an error. Try again.";
      isSuccessful = false;
    });

    setState(() {
      _isLoadingResult[index] = false;
    });
    showSnackBar(messageToDisplay, isSuccessful, context);
  }

  void _withdrawFriendRequest(
      String uidSender, String uidReceiver, int index) async {

    final FriendsProvider friendsProvider =
    Provider.of<FriendsProvider>(context, listen: false);

    String messageToDisplay;
    bool isSuccessful;

    setState(() {
      _isLoadingRequest[index] = true;
    });

    await friendsProvider.management.performSocialAction(
            uidReceiver, uidSender, SocialActionType.declineFriendRequest)
        .then((value) async {
      messageToDisplay = "Friend request withdrawn";
      isSuccessful = true;
      await friendsProvider.update(SocialActionType.declineFriendRequest);
    }).catchError((error) {
      messageToDisplay = "There was an error. Try again.";
      isSuccessful = false;
    });

    setState(() {
      _isLoadingRequest[index] = false;
    });
    showSnackBar(messageToDisplay, isSuccessful, context);
  }

  bool _isFriendOrHasFriendRequest(FriendModel friend) {
    final FriendsProvider friendsProvider =
        Provider.of<FriendsProvider>(context, listen: false);

    final friends = friendsProvider.friends;
    final friendRequests = friendsProvider.friendRequests;
    final sentFriendRequests = friendsProvider.sentFriendRequests;

    final areFriends = friends.firstWhere(
        (itemToCheck) => itemToCheck.uid == friend.uid,
        orElse: () => null);

    final hasRequest = friendRequests.firstWhere(
        (itemToCheck) => itemToCheck.uid == friend.uid,
        orElse: () => null);

    final sentRequest = sentFriendRequests.firstWhere(
        (itemToCheck) => itemToCheck.uid == friend.uid,
        orElse: () => null);

    return areFriends != null || hasRequest != null || sentRequest != null;
  }

  Widget sendFriendRequestButton(
      String uidSender, String uidReceiver, int index) {
    return Wrap(
      children: <Widget>[
        socialButton(Key('send_request_button'), Icons.person_add, Colors.green,
            () => _sendFriendRequest(uidSender, uidReceiver, index)),
      ],
    );
  }

  Widget withdrawFriendRequestButton(
      String uidSender, String uidReceiver, int index) {
    return Wrap(
      children: <Widget>[
        socialButton(Key('withdraw_button'), Icons.clear, Colors.red,
            () => _withdrawFriendRequest(uidSender, uidReceiver, index)),
      ],
    );
  }

  @override
  void initState() {
    super.initState();
  }

  Future<List<FriendModel>> search(String search) async {
    setState(() {
      searchWord = search;
    });

    final FriendsProvider friendsProvider =
    Provider.of<FriendsProvider>(context, listen: false);

    return friendsProvider.management.searchByUsername(search);
  }

  @override
  Widget build(BuildContext context) {
    final UserModel user = Provider.of<FriendsProvider>(context).user;

    return SafeArea(
        key: Key('search_friends'),
        child: Column(
          children: <Widget>[
            Container(
                margin: EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Row(mainAxisSize: MainAxisSize.max, children: <Widget>[
                  Material(
                    child: IconButton(
                      onPressed: () => Provider.of<FriendsPageProvider>(context,
                              listen: false)
                          .toggleSearching(),
                      icon: Icon(FontAwesomeIcons.arrowLeft),
                      iconSize: 28,
                      color: Colors.black38,
                    ),
                  ),
                  FashionFetishText(
                    text: 'Add friends',
                    size: 22,
                    fontWeight: FashionFontWeight.heavy,
                  ),
                ])),
            Expanded(
              child: Padding(
                padding: EdgeInsets.only(
                  left: 15,
                  right: 20,
                ),
                child: Material(
                  child: SearchBar(
                    key: Key('search_bar'),
                    onSearch: search,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 10,
                    onItemFound: (FriendModel friend, int index) {
                      _isLoadingResult.add(false);
                      return friendsCard(
                          context: context,
                          friend: friend,
                          button: _isLoadingResult[index]
                              ? CircularProgressIndicator()
                              : (user.uid == friend.uid ||
                                      _isFriendOrHasFriendRequest(friend))
                                  ? null
                                  : sendFriendRequestButton(
                                      user.uid, friend.uid, index),
                          topPadding: 10);
                    },
                    loader: LoadingHeart(),
                    minimumChars: 1,
                    emptyWidget: Center(
                      child:
                          Text('No user starting with $searchWord was found'),
                    ),
                    hintText: 'Add friends',
                    hintStyle: TextStyle(
                      color: Colors.black45,
                    ),
                    icon: Icon(
                      FontAwesomeIcons.search,
                      size: 24.0,
                    ),
                    iconActiveColor: Colors.black54,
                    searchBarStyle: SearchBarStyle(
                      backgroundColor: Colors.black12,
                      padding: EdgeInsets.fromLTRB(15, 5, 5, 5),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    cancellationWidget: Text(
                      'Cancel',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              key: Key('sent_friend_requests'),
              padding: EdgeInsets.only(
                  top: 10,
                  left: 30,
                  right: 90,
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: Container(
                height: 18,
                width: MediaQuery.of(context).size.width,
                child: Text(
                  'Sent friend requests',
                  style: TextStyle(fontSize: 18, color: Colors.grey),
                ),
              ),
            ),
            Divider(
              thickness: 1,
              indent: 25,
              endIndent: 25,
              color: Colors.grey,
            ),
            Container(
              constraints: BoxConstraints(minHeight: 50, maxHeight: 150),
              child: Padding(
                key: Key('sent_friend_requests_list'),
                padding: EdgeInsets.only(
                    left: 15,
                    right: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Scrollbar(
                    child: Consumer<FriendsProvider>(
                  builder: (_, friendsProvider, __) => friendsProvider
                          .isFetchingSentFriendRequests
                      ? LoadingHeart()
                      : friendsProvider.sentFriendRequests.isEmpty
                          ? Text('No sent friend requests')
                          : ListView.separated(
                              padding: EdgeInsets.only(
                                bottom: 30,
                              ),
                              scrollDirection: Axis.vertical,
                              shrinkWrap: true,
                              separatorBuilder: (context, index) =>
                                  const SizedBox(height: 12),
                              itemCount:
                                  friendsProvider.sentFriendRequests.length,
                              itemBuilder: (context, index) {
                                final friend =
                                    friendsProvider.sentFriendRequests[index];
                                _isLoadingRequest.add(false);
                                return friendsCard(
                                    context: context,
                                    friend: friend,
                                    button: _isLoadingRequest[index]
                                        ? CircularProgressIndicator()
                                        : withdrawFriendRequestButton(
                                            friend.uid, user.uid, index),
                                    topPadding: 10);
                              },
                            ),
                )),
              ),
            ),
            SizedBox(height: 50),
          ],
        ));
  }
}
