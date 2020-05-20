import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/achievements_model.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/services/authentication/user_management.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'friends_profile_picture.dart';

Future<void> _openFriendsProfile(BuildContext context, FriendsModel friend) async {
  dynamic result = await UserManagement.getAchievements(friend.uid);
  Achievements friendsAchievements = Achievements.fromData(result);
  List<Object> arguments = List<Object>();
  arguments.add(friend);
  arguments.add(friendsAchievements);
//  print("achi: "+friendsAchievements.worldPercentage.toString());
  await Navigator.pushNamed(context, '/friends/friends_profile', arguments: arguments);
}

@override
Widget friendsCard({@required BuildContext context, @required FriendsModel friend,
  @required Widget button, @required double topPadding}) {
  const double cardSize = 70;

  return Container(
    height: cardSize,
    child: Stack(
      children: <Widget>[
        Positioned(
          left: 20,
          right: 0,
          child: GestureDetector(
              onTap: () => _openFriendsProfile(context, friend),
            child: Container(
              height: cardSize,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                color: Color(0xBBCCD7DD),
              ),
              padding: const EdgeInsets.only(
                  left: 65.0, top: 10.0, bottom: 14.0, right: 14.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FashionFetishText(
                          text: friend.username,
                          size: 18.0,
                          fontWeight: FashionFontWeight.heavy,
                          height: 1.1,
                        ),
                        Spacer(),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.home,
                              size: 14,
                              color: Theme.of(context).primaryColor,
                            ),
                            Flexible(
                              child: Padding(
                                padding: const EdgeInsets.only(top: 6, left: 3),
                                child: Text(
                                  // TODO(fluetfab): BUG not showing N/A when empty
                                  friend.homeCountry?? 'N/A',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  softWrap: false,
                                  style: TextStyle(
                                    height: 1.1,
                                    fontSize: 13,
                                    fontFamily: 'FashionFetish',
                                    color: Colors.black54,
                                    fontWeight: FontWeight.w900,
                                    letterSpacing: -1,
                                  ),
                                ),
                              )
                            )
                          ],
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: 15, top: topPadding),
                    child: button,
                  ),
                ],
              ),
            ),
          ),
        ),
        Align(
            alignment: Alignment.centerLeft,
            child: friend.photoURL != null
                ? profilePicture(friend.photoURL, cardSize: cardSize)
                : standardPicture(cardSize: cardSize)
        ),
      ],
    ),
  );
}