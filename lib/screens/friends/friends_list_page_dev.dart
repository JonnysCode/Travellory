import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/screens/friends_page_provider.dart';
import 'package:travellory/widgets/buttons/option_button.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/friends/friends_list_widget.dart';


class FriendListPageDev extends StatefulWidget {
  @override
  _FriendListPageDevState createState() => _FriendListPageDevState();
}

class _FriendListPageDevState extends State<FriendListPageDev> {
  final List<FriendsModel> friendRequests = [];
  final List<FriendsModel> friends = [];

  @override
  void initState() {
    super.initState();
    setState(() {
      //TODO(hessgia1): create dynamic list according to logged in user.
      friendRequests
        ..add(FriendsModel("1", "doejohn"))
        ..add(FriendsModel("2", "doejane"))
        ..add(FriendsModel("3", "doejames",))
        ..add(FriendsModel("4", "doejessy",))
        ..add(FriendsModel("5", "doejason",));

      friends
        ..add(FriendsModel("11", "hessgia1"))
        ..add(FriendsModel("12", "schinsev"))
        ..add(FriendsModel("13", "grussjon"))
        ..add(FriendsModel("14", "bertaben"))
        ..add(FriendsModel("15", "stadena1"))
        ..add(FriendsModel("16", "antilyas"))
        ..add(FriendsModel("17", "gubleet1"))
        ..add(FriendsModel("18", "isztldav"));
    });
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
            IconButton(
              onPressed: () => Provider.of<FriendsPageProvider>(context, listen: false).toggleSearching(),
              icon: Icon(
                FontAwesomeIcons.search,
                color: Theme.of(context).primaryColor,
                size: 32,
              ),
              padding: EdgeInsets.fromLTRB(5, 5, 20,5),
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
          friendList(
              Key('friend_requests_list'),
              158,
              friendRequests,
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
          friendList(
              Key('friends_list'),
              240,
              friends,
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
        ],
      ),
    );
  }
}