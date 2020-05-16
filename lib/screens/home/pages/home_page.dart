import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/screens/trip/schedule/trip_schedule.dart';
import 'package:travellory/services/database/edit.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/utils/weather.dart';
import 'package:travellory/widgets/buttons/speed_dial_button.dart';
import 'package:travellory/widgets/font_widgets.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePage createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserModel>(context);
    final TripsProvider tripsProvider =
        Provider.of<TripsProvider>(context, listen: false);
    final SingleTripProvider trip = tripsProvider.activeTrip;
    TripModel tripModel;
    if (trip != null) tripModel = trip.tripModel;

    ModifyModelArguments passPublicTransportModel() {
      final PublicTransportModel publicTransportModel = PublicTransportModel();
      if (tripModel != null) {
        publicTransportModel.tripUID = tripModel.uid;
      }
      return ModifyModelArguments(
          model: publicTransportModel, isNewModel: true);
    }

    ModifyModelArguments passAccommodationModel() {
      final AccommodationModel accommodationModel = AccommodationModel();
      if (tripModel != null) {
        accommodationModel.tripUID = tripModel.uid;
      }
      return ModifyModelArguments(model: accommodationModel, isNewModel: true);
    }

    final List<Dial> _dials = <Dial>[
      Dial(
          icon: FontAwesomeIcons.envelope,
          description: 'Manage forwarded bookings',
          onTab: () {}),
      Dial(
          icon: FontAwesomeIcons.theaterMasks,
          description: 'Add Activity',
          onTab: () {
            tripsProvider.selectTrip(tripModel);
            Navigator.pushNamed(context, '/booking/activity');
          }),
      Dial(
          icon: FontAwesomeIcons.car,
          description: 'Add Rental Car',
          onTab: () {
            tripsProvider.selectTrip(tripModel);
            Navigator.pushNamed(context, '/booking/rentalcar');
          }),
      Dial(
          icon: FontAwesomeIcons.bus,
          description: 'Add Public Transportation',
          onTab: () {
            tripsProvider.selectTrip(tripModel);
            Navigator.pushNamed(context, '/booking/publictransport',
                arguments: passPublicTransportModel());
          }),
      Dial(
          icon: FontAwesomeIcons.bed,
          description: 'Add Accommodation',
          onTab: () {
            tripsProvider.selectTrip(tripModel);
            Navigator.pushNamed(context, '/booking/accommodation',
                arguments: passAccommodationModel());
          }),
      Dial(
          icon: FontAwesomeIcons.plane,
          description: 'Add Flight',
          onTab: () {
            tripsProvider.selectTrip(tripModel);
            Navigator.pushNamed(context, '/booking/flight');
          }),
    ];

    // TODO weather
    print(tripModel.destination);

    var now;
    var timeTripStart;
    DateTime startDate;
    if (trip != null) {
      now = DateTime.now();
      String startDateFormatted = yyyyMMdd(tripModel.startDate);
      startDate = DateTime.parse(startDateFormatted);
      timeTripStart = startDate.difference(now).inDays + 1;
    }

    String cutUsername(String username) {
      if (username.length > 18) {
        username = username.substring(0, 18) + '...';
      }
      return username;
    }

    return SafeArea(
      child: Container(
        key: Key('home_page'),
        child: Stack(
          children: <Widget>[
            trip == null
                ? Positioned(
                    left: 30,
                    top: 30,
                    child: Image(
                      height: 100,
                      image: AssetImage(
                          'assets/images/home/weather/011-few_clouds.png'),
                    ),
                  )
                : Weather(tripModel.destination),
            trip == null
                ? Positioned(
                    top: 20,
                    left: 170,
                    right: 6,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                              height: 35,
                              child: Text('Hii',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: 'FashionFetish',
                                    fontWeight: FontWeight.w900,
                                  ))),
                          SizedBox(
                              height: 30,
                              child: AutoSizeText(
                                cutUsername(user.displayName),
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: 'FashionFetish',
                                  fontWeight: FontWeight.w900,
                                ),
                                maxLines: 1,
                              )),
                          SizedBox(
                            child: Text(
                              'You have no trips, so plan or add a trip!',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  height: 1.2,
                                  fontFamily: 'FashionFetish',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54),
                            ),
                          )
                        ]))
                : Positioned(
                    top: 20,
                    left: 170,
                    right: 6,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                              height: 35,
                              child: Text('Get Ready',
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: 'FashionFetish',
                                    fontWeight: FontWeight.w900,
                                  ))),
                          SizedBox(
                              height: 25,
                              child: AutoSizeText(
                                cutUsername(user.displayName),
                                style: TextStyle(
                                  fontSize: 30.0,
                                  fontFamily: 'FashionFetish',
                                  fontWeight: FontWeight.w900,
                                ),
                                maxLines: 1,
                              )),
                          SizedBox(
                            child: Text(
                              timeTripStart < 2
                                  ? 'Your trip to ' +
                                      tripModel.destination +
                                      ' starts in ' +
                                      timeTripStart.toString() +
                                      ' day. Pack your bags now.'
                                  : 'Your trip to ' +
                                      tripModel.destination +
                                      ' starts in ' +
                                      timeTripStart.toString() +
                                      ' days.',
                              style: TextStyle(
                                  fontSize: 14.0,
                                  height: 1.2,
                                  fontFamily: 'FashionFetish',
                                  fontWeight: FontWeight.w600,
                                  color: Colors.black54),
                            ),
                          )
                        ])),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.8,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(40.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          blurRadius: 18,
                          color: Colors.black.withOpacity(.2),
                          offset: Offset(0.0, -6.0))
                    ],
                  ),
                  child: trip == null
                      ? Center(
                          child: Text('Create a trip first'),
                        )
                      : Column(
                          children: <Widget>[
                            FashionFetishText(
                              text: trip.tripModel.name,
                              size: 20,
                              height: 1.6,
                              fontWeight: FashionFontWeight.heavy,
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 3),
                              child: Container(
                                height: 1,
                                color: Colors.black12,
                              ),
                            ),
                            Expanded(
                              child: Schedule(
                                key: Key('home_schedule'),
                                trip: trip,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),
            if (trip != null)
              SpeedDialButton(key: Key('home_page_dial'), dials: _dials),
          ],
        ),
      ),
    );
  }
}
