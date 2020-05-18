import 'package:flutter/material.dart';
import 'package:travellory/models/friends_model.dart';
import '../../widgets/font_widgets.dart';
import '../../widgets/friends/friends_profile_header.dart';

class FriendsProfile extends StatefulWidget {
  FriendsProfile({
    Key key,
  }) : super(key: key);

  static final route = '/friends/friends_profile';

  @override
  _FriendsProfileState createState() => _FriendsProfileState();
}

class _FriendsProfileState extends State<FriendsProfile> {
  final List<String> achievements = <String>[
    'World     20%',
    'Europe   50%',
    'Asia',
    'North America',
    'South America',
    'South Africa'
  ];

  @override
  Widget build(BuildContext context) {
    final FriendsModel friend = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: Key('friends_profile'),
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FriendsProfileHeader(friend: friend),
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
                  child: Text("Your friend hasn't created any trips yet.")
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
            Expanded(
              child: Padding(
                key: Key('friends_achievements_list'),
                padding: EdgeInsets.only(
                    left: 20,
                    right: 20,
                    bottom: MediaQuery.of(context).viewInsets.bottom),
                child: Scrollbar(
                  child: Visibility(
                    visible: true,
                    child: ListView.separated(
                      padding: EdgeInsets.only(
                        bottom: 30,
                      ),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      separatorBuilder: (context, index) =>
                      const SizedBox(height: 12),
                      itemCount: achievements.length,
                      itemBuilder: (context, index) {
                        return Text(
                          '${achievements[index]}',
                          style: TextStyle(
                            fontSize: 18
                          ),
                        );
                      },
                    ),
                    replacement: Padding(
                        key: Key('friends_achievements_list'),
                        padding: EdgeInsets.only(
                            top: 5,
                            bottom: MediaQuery.of(context).viewInsets.bottom
                        ),
                        child: Text("Your friend has no archievements so far.")
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
