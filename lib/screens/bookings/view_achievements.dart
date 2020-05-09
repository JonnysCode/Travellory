import 'package:flutter/material.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/widgets/bookings/view_booking_header.dart';
import 'package:travellory/widgets/bookings/view_bookings.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:getflutter/getflutter.dart';

class AchievementsView extends StatefulWidget {
  const AchievementsView({Key key}) : super(key: key);

  static final route = '/view/achievements';

  @override
  _AchievementsViewState createState() => _AchievementsViewState();
}

class _AchievementsViewState extends State<AchievementsView> {
  final String bannerUrl = 'assets/images/bookings/achievements_banner.jpg';
  final String headerTitle = 'Your Travel Progress';

  final List<String> entries = <String>[
    'World',
    'Europe',
    'Asia',
    'North America',
    'South America',
    'South Africa'
  ];

  final List<double> percentages = <double>[0.13, 0.23, 0.12, 0.04, 0.00, 0.39];

  SingleChildScrollView achievementsViewPage() {
    return SingleChildScrollView(
      key: Key('AchievementsViewPage'),
      child: Column(children: [
        BookingHeader(headerTitle, bannerUrl),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        for (int i = 0; i < entries.length; i++)
          Container(
              key: Key(entries[i]),
              height: 81,
              child: Stack(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                  child: Column(children: <Widget>[
                    SizedBox(height: 20),
                    FashionFetishText(
                      text: entries[i],
                      size: 16,
                      fontWeight: FashionFontWeight.heavy,
                    ),
                    SizedBox(height: 10),
                    GFProgressBar(
                      percentage: percentages[i],
                      backgroundColor: Colors.black26,
                      progressBarColor: Theme.of(context).primaryColor,
                      width: MediaQuery.of(context).size.width - 86,
                      lineHeight: 40.0,
                      child: Padding(
                        padding: EdgeInsets.only(top: 7),
                        child: Text(
                          '${(percentages[i] * 100.0).round()}%',
                          textAlign: TextAlign.start,
                          style: TextStyle(fontSize: 22, color: Colors.white),
                        ),
                      ),
                    ),
                  ]),
                )
              ])),
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
