import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/achievements_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/achievements_provider.dart';
import 'package:travellory/widgets/achievements_widget.dart';
import 'package:travellory/widgets/bookings/view_booking_header.dart';
import 'package:travellory/widgets/bookings/view_bookings.dart';

/// The achievements view, which can be opened from the user profile page.
class AchievementsView extends StatefulWidget {
  const AchievementsView({Key key}) : super(key: key);

  static const route = '/view/achievements';

  @override
  _AchievementsViewState createState() => _AchievementsViewState();
}

class _AchievementsViewState extends State<AchievementsView> {
  final String bannerUrl = 'assets/images/bookings/achievements_banner.jpg';
  final String headerTitle = 'Your Travel Progress';

  UserModel user;
  Achievements achievements;

  SingleChildScrollView achievementsViewPage() {
    achievements ??= Provider.of<AchievementsProvider>(context).achievements;
    final List<int> percentages = achievements.toList();

    return SingleChildScrollView(
      key: Key('AchievementsViewPage'),
      child: Column(children: [
        BookingHeader(headerTitle, bannerUrl),
        achievementsWidget(
            context: context,
            entries: Achievements.continents,
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
            achievementsViewPage(), /// creating achievements page
          ),
        ),
        exitViewPage(context),
      ]),
    );
  }
}
