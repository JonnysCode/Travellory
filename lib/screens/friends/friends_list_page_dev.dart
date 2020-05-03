import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/providers/screens/friends_page_provider.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
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
        ..add(FriendsModel("1", "doejohn", null))
        ..add(FriendsModel("2", "doejane", null))
        ..add(FriendsModel("3", "doejames", null))
        ..add(FriendsModel("4", "doejessy", null))
        ..add(FriendsModel("5", "doejason", null));

      friends
        ..add(FriendsModel("11", "hessgia1", null))
        ..add(FriendsModel("12", "schinsev", null))
        ..add(FriendsModel("13", "grussjon", null))
        ..add(FriendsModel("14", "bertaben", null))
        ..add(FriendsModel("15", "stadena1", null))
        ..add(FriendsModel("16", "antilyas", null))
        ..add(FriendsModel("17", "gubleet1", null))
        ..add(FriendsModel("18", "isztldav", null));
    });
  }

  @override
  Widget build(BuildContext context) {
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
                bottom: MediaQuery.of(context).viewInsets.bottom
            ),
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
              Wrap(
                children: <Widget>[
                  socialButton(
                      Key('accept_button'),
                      Icons.person_add,
                      Colors.green,
                          () => {}
                  ),
                  socialButton(
                    Key('decline_button'),
                    Icons.clear,
                    Colors.red,
                        () => {},
                  )
                ],
              ),
              10,
              context
          ),
          SizedBox(height: 20),
          Padding(
            key: Key('friends'),
            padding: EdgeInsets.only(
                top: 10,
                left: 30,
                right: 90,
                bottom: MediaQuery.of(context).viewInsets.bottom
            ),
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
                      onTab: () => {},
                      color: Colors.red
                  ),
                ],
              ),
              6,
              context
          ),
        ],
      ),
    );
  }
}