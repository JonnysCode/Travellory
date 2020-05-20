import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/achievements_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/achievements_provider.dart';
import 'package:travellory/services/database/delete_database.dart';
import 'package:travellory/widgets/achievements_widget.dart';
import 'package:travellory/widgets/bookings/view_booking_header.dart';
import 'package:travellory/widgets/bookings/view_bookings.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:getflutter/getflutter.dart';

class AchievementsView extends StatefulWidget {
  AchievementsView({Key key}) : super(key: key);

  static final route = '/view/achievements';

  @override
  _AchievementsViewState createState() => _AchievementsViewState();
}

class _AchievementsViewState extends State<AchievementsView> {
  final String bannerUrl = 'assets/images/bookings/achievements_banner.jpg';
  final String headerTitle = 'Your Travel Progress';

  UserModel user;
  Achievements achievements;

  final List<String> entries = <String>[
    'World',
    'Europe',
    'Asia',
    'North America',
    'South America',
    'Africa',
    'Australia',
    'Antarctica'
  ];

  SingleChildScrollView achievementsViewPage() {
    achievements ??= Provider.of<AchievementsProvider>(context).achievements;
    log.d("worldpercentage: ${achievements.worldPercentage}");
    final List<int> percentages = <int>[
      achievements.worldPercentage,
      achievements.europePercentage,
      achievements.asiaPercentage,
      achievements.northAmericaPercentage,
      achievements.southAmericaPercentage,
      achievements.africaPercentage,
      achievements.australiaPercentage,
      achievements.antarcticaPercentage
    ];
    return SingleChildScrollView(
      key: Key('AchievementsViewPage'),
      child: Column(children: [
        BookingHeader(headerTitle, bannerUrl),
        achievementsWidget(
            context: context,
            entries: entries,
            percentages: percentages
        ),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final FlightModel flightModel = ModalRoute.of(context).settings.arguments;
    final List<FlightModel> flights = [];
    flights.add(flightModel);
    flightModels = flights;

    return Scaffold(
      key: Key('AchievementsView'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: bookingView(
            achievementsViewPage(),
          ),
        ),
        exitViewPage(context),
      ]),
    );
  }
}
