import 'package:flutter/material.dart';
import 'package:getflutter/components/progress_bar/gf_progress_bar.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/achievements_model.dart';
import 'package:travellory/models/friends_model.dart';
import 'package:travellory/providers/achievements_provider.dart';
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
//  final List<String> achievements = <String>[
//    'World                  20%',
//    'Europe                50%',
//    'Asia                       5%',
//    'North America   10%',
//    'South America   15%',
//  ];

  @override
  Widget build(BuildContext context) {
    final FriendsModel friend = ModalRoute.of(context).settings.arguments;
    Achievements achievementsProvider = Provider.of<AchievementsProvider>(context).achievements;
//    List<String> achievements = achievementsProvider.achievements;
//    List<int> percentages = achievementsProvider.percentages;
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
      0,1,2,3,4,5,6,7
    ];


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
            SingleChildScrollView(
              child: Column(children: <Widget>[
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                for (int i = 0; i < achievements.length; i++)
                  Container(
                      key: Key(achievements[i]),
                      height: 81,
                      child: Stack(children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Column(children: <Widget>[
                            SizedBox(height: 20),
                            FashionFetishText(
                              text: achievements[i],
                              size: 16,
                              fontWeight: FashionFontWeight.heavy,
                            ),
                            SizedBox(height: 10),
                            GFProgressBar(
                              percentage: (percentages[i] / 100),
                              backgroundColor: Colors.black26,
                              progressBarColor: Theme.of(context).primaryColor,
                              width: MediaQuery.of(context).size.width - 86,
                              lineHeight: 40.0,
                              child: Padding(
                                padding: EdgeInsets.only(top: 7),
                                child: Text(
                                  '${percentages[i]}%',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(fontSize: 22, color: Colors.white),
                                ),
                              ),
                            ),
                          ]),
                        )
                      ])),
              ])
            )

//            Expanded(
//              child: Padding(
//                key: Key('friends_achievements_list'),
//                padding: EdgeInsets.only(
//                    left: 20,
//                    right: 20,
//                    bottom: MediaQuery.of(context).viewInsets.bottom),
//                child: Scrollbar(
//                  child: Visibility(
//                    visible: true,
//                    child: ListView.separated(
//                      padding: EdgeInsets.only(
//                        bottom: 30,
//                      ),
//                      scrollDirection: Axis.vertical,
//                      shrinkWrap: true,
//                      separatorBuilder: (context, index) =>
//                      const SizedBox(height: 12),
//                      itemCount: achievements.length,
//                      itemBuilder: (context, index) {
//                        return Text(
//                          '${achievements[index]}',
//                          style: TextStyle(
//                            fontSize: 18
//                          ),
//                        );
//                      },
//                    ),
//                    replacement: Padding(
//                        key: Key('friends_achievements_list'),
//                        padding: EdgeInsets.only(
//                            top: 5,
//                            bottom: MediaQuery.of(context).viewInsets.bottom
//                        ),
//                        child: Text("Your friend has no archievements so far.")
//                    ),
//                  ),
//                ),
//              ),
//            ),
          ],
        ),
      ),
    );
  }
}
