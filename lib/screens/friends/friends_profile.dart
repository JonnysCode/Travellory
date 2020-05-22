import 'package:flutter/material.dart';
import 'package:travellory/models/achievements_model.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/widgets/achievements_widget.dart';
import '../../widgets/font_widgets.dart';
import '../../widgets/friends/friends_profile_header.dart';

class FriendsProfile extends StatefulWidget {
  const FriendsProfile({
    Key key,
  }) : super(key: key);

  static final route = '/friends/friends_profile';

  @override
  _FriendsProfileState createState() => _FriendsProfileState();
}

class _FriendsProfileState extends State<FriendsProfile> {
  @override
  Widget build(BuildContext context) {
    final List<Object> arguments = ModalRoute.of(context).settings.arguments;
    final FriendsModel friend = arguments[0];
    final Achievements friendAchievements = arguments[1];

    final  List<String> achievements = <String>[
      'World',
      'Europe',
      'Asia',
      'North America',
      'South America',
      'Africa',
      'Australia',
      'Antarctica'
    ];

    final List<int> percentages = <int>[
      friendAchievements.worldPercentage,
      friendAchievements.europePercentage,
      friendAchievements.asiaPercentage,
      friendAchievements.northAmericaPercentage,
      friendAchievements.southAmericaPercentage,
      friendAchievements.africaPercentage,
      friendAchievements.australiaPercentage,
      friendAchievements.antarcticaPercentage
    ];

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
                      child: Text("This user hasn't any trips to show yet.")
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
                        entries: achievements,
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
