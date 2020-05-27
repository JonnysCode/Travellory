import 'package:flutter/material.dart';
import 'package:travellory/src/components/profile/achievements_widget.dart';
import 'package:travellory/src/models/achievements_model.dart';
import 'package:travellory/src/models/friend_model.dart';
import '../../components/friends/friends_profile_header.dart';
import '../../components/shared/font_widgets.dart';

class FriendsProfile extends StatefulWidget {
  const FriendsProfile({
    Key key,
  }) : super(key: key);

  static const route = '/friends/friends_profile';

  @override
  _FriendsProfileState createState() => _FriendsProfileState();
}

class _FriendsProfileState extends State<FriendsProfile> {
  @override
  Widget build(BuildContext context) {
    final List<Object> arguments = ModalRoute.of(context).settings.arguments;
    final FriendModel friend = arguments[0];
    final Achievements friendAchievements = arguments[1];
    final List<int> percentages = friendAchievements.toList();

    return Scaffold(
      key: Key('friends_profile'),
      body: Container(
        padding: EdgeInsets.only(bottom: 10),
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FriendsProfileHeader(friend: friend),
            Expanded(
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  Padding(
                    key: Key('friends_trips'),
                    padding: EdgeInsets.only(
                      top: 30,
                      left: 20,
                      right: 90,
                      bottom: MediaQuery.of(context).viewInsets.bottom
                    ),
                    child: Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: FashionFetishText(
                        text: 'Trips' ,
                        size: 22,
                        fontWeight: FashionFontWeight.heavy,
                      ),
                    ),
                  ),
                  Container(
                    constraints: BoxConstraints(minHeight: 20, maxHeight: 300),
                    child: Padding(
                      key: Key('friends_trips_list'),
                      padding: EdgeInsets.only(
                        top: 5,
                        left: 20,
                        bottom: MediaQuery.of(context).viewInsets.bottom
                      ),
                      child: Text("This user doesn't have any trips to display yet.")
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    key: Key('friends_achievements'),
                    padding: EdgeInsets.only(
                      top: 30,
                      left: 20,
                      right: 90,
                      bottom: MediaQuery.of(context).viewInsets.bottom
                    ),
                    child: Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width,
                      child: FashionFetishText(
                        text: 'Achievements' ,
                        size: 22,
                        fontWeight: FashionFontWeight.heavy,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 15),
                    child:
                    achievementsWidget(
                        context: context,
                        entries: Achievements.continents,
                        percentages: percentages
                    ),
                  ),
                  Padding(padding: EdgeInsets.only(bottom: 50)),
                ])
              ),
            )
          ],
        ),
      ),
    );
  }
}
