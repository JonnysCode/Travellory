import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/src/components/profile/profile_picture.dart';
import 'package:travellory/src/models/achievements_model.dart';
import 'package:travellory/src/models/friend_model.dart';
import 'package:travellory/src/screens/friends/friends_profile.dart';
import 'package:travellory/src/services/authentication/user_management.dart';
import 'package:travellory/src/components/shared/font_widgets.dart';
import 'friends_profile_picture.dart';

Future<void> _openFriendsProfile(BuildContext context, FriendModel friend) async {
  final dynamic result = await UserManagement().getAchievements(friend.uid);
  final Achievements friendsAchievements = Achievements.fromData(result);
  final List<Object> arguments = [];
  arguments.add(friend);
  arguments.add(friendsAchievements);
  await Navigator.pushNamed(context, FriendsProfile.route, arguments: arguments);
}

@override
Widget friendsCard({@required BuildContext context, @required FriendModel friend,
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
                                  friend.homeCountry == '' ? 'N/A' : friend.homeCountry,
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