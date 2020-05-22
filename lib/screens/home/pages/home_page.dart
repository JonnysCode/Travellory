import 'dart:core';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/models/user_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/screens/bookings/temp_bookings.dart';
import 'package:travellory/screens/bookings/accommodation.dart';
import 'package:travellory/screens/bookings/activity.dart';
import 'package:travellory/screens/bookings/flight.dart';
import 'package:travellory/screens/bookings/public_transport.dart';
import 'package:travellory/screens/bookings/rental_car.dart';
import 'package:travellory/screens/trip/schedule/trip_schedule.dart';
import 'package:travellory/services/api/openWeatherAPI.dart';
import 'package:travellory/utils/date_handler.dart';
import 'package:travellory/utils/weather.dart';
import 'package:travellory/widgets/bookings/edit.dart';
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

    ModifyModelArguments _passPublicTransportModel() {
      final PublicTransportModel publicTransportModel = PublicTransportModel();
      if (tripModel != null) {
        publicTransportModel.tripUID = tripModel.uid;
      }
      return ModifyModelArguments(
          model: publicTransportModel, isNewModel: true);
    }

    ModifyModelArguments _passAccommodationModel() {
      final AccommodationModel accommodationModel = AccommodationModel();
      if (tripModel != null) {
        accommodationModel.tripUID = tripModel.uid;
      }
      return ModifyModelArguments(model: accommodationModel, isNewModel: true);
    }

    ModifyModelArguments _passActivityModel() {
      final ActivityModel activityModel = ActivityModel();
      if (tripModel != null) {
        activityModel.tripUID = tripModel.uid;
      }
      return ModifyModelArguments(model: activityModel, isNewModel: true);
    }

    ModifyModelArguments _passFlightModel() {
      final FlightModel flightModel = FlightModel();
      if (tripModel != null) {
        flightModel.tripUID = tripModel.uid;
      }
      return ModifyModelArguments(model: flightModel, isNewModel: true);
    }

    ModifyModelArguments _passRentalCarModel() {
      final RentalCarModel rentalCarModel = RentalCarModel();
      if (tripModel != null) {
        rentalCarModel.tripUID = tripModel.uid;
      }
      return ModifyModelArguments(model: rentalCarModel, isNewModel: true);
    }

    final List<Dial> _dials = <Dial>[
      Dial(
          icon: FontAwesomeIcons.envelope,
          description: 'Manage forwarded bookings',
          onTab: () {
            Navigator.pushNamed(context, AddTempBookingsScreen.route);
          }),
      Dial(
          icon: FontAwesomeIcons.theaterMasks,
          description: 'Add Activity',
          onTab: () {
            tripsProvider.selectTrip(tripModel);
            Navigator.pushNamed(context, Activity.route,
                arguments: _passActivityModel());
          }),
      Dial(
          icon: FontAwesomeIcons.car,
          description: 'Add Rental Car',
          onTab: () {
            tripsProvider.selectTrip(tripModel);
            Navigator.pushNamed(context, RentalCar.route,
                arguments: _passRentalCarModel);
          }),
      Dial(
          icon: FontAwesomeIcons.bus,
          description: 'Add Public Transportation',
          onTab: () {
            tripsProvider.selectTrip(tripModel);
            Navigator.pushNamed(context, PublicTransport.route,
                arguments: _passPublicTransportModel());
          }),
      Dial(
          icon: FontAwesomeIcons.bed,
          description: 'Add Accommodation',
          onTab: () {
            tripsProvider.selectTrip(tripModel);
            Navigator.pushNamed(context, Accommodation.route,
                arguments: _passAccommodationModel());
          }),
      Dial(
          icon: FontAwesomeIcons.plane,
          description: 'Add Flight',
          onTab: () {
            tripsProvider.selectTrip(tripModel);
            Navigator.pushNamed(context, Flight.route,
                arguments: _passFlightModel);
          }),
    ];

    var now = DateTime(0);
    var timeTripStart = 0;
    var startDateFormatted = '';
    DateTime startDate;

    if (trip != null) {
      now = DateTime(
          DateTime.now().year, DateTime.now().month, DateTime.now().day);
      startDateFormatted = yyyyMMdd(tripModel.startDate);
      startDate = DateTime.parse(startDateFormatted);
      timeTripStart = startDate.difference(now).inDays;
    }

    String cutUsername(String username) {
      var newUsername = username;
      if (username.length > 18) {
        newUsername = '${username.substring(0, 18)}...';
      }
      return newUsername;
    }

    return SafeArea(
      child: Container(
        key: Key('home_page'),
        child: Column(
          children: <Widget>[
            Container(
              height: 150,
              child: Row(
                children: <Widget>[
                  if (tripModel == null || tripModel.destination.isEmpty)
                    Image(
                      height: 100,
                      image: AssetImage(
                          'assets/images/home/weather/011-few_clouds.png'),
                    )
                  else
                    SizedBox(
                      width: 180,
                      child: Weather(tripModel.destination, OpenWeatherAPI())
                    ),
                  if (tripModel == null) Expanded(
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          SizedBox(
                              height: 30,
                              child: AutoSizeText(
                                  'HiHallloooo ${cutUsername(user.displayName)}',
                                  maxLines: 2,
                                  style: TextStyle(
                                    fontSize: 30.0,
                                    fontFamily: 'FashionFetish',
                                    fontWeight: FontWeight.w900,
                                  ))),
                        ]),
                  ) 
                  else 
                    Expanded(
                      child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              if (timeTripStart < 0)
                                Padding(
                                  padding: const EdgeInsets.only(bottom: 10),
                                  child: AutoSizeText('Hi ${cutUsername(user.displayName)}',
                                      maxLines: 2,
                                      textAlign: TextAlign.center,
                                      style: TextStyle(
                                        fontSize: 28,
                                        fontFamily: 'FashionFetish',
                                        fontWeight: FontWeight.w900,
                                        height: 1.2
                                      )),
                                )
                              else Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: AutoSizeText('Get Ready ${cutUsername(user.displayName)}',
                                    maxLines: 2,
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      fontFamily: 'FashionFetish',
                                      fontWeight: FontWeight.w900,
                                    )),
                              ),
                              AutoSizeText(
                                timeTripStart == 1
                                    ? 'Your trip to ${tripModel.destination} starts in ${timeTripStart.toString()} day. Pack your bags now.'
                                    : timeTripStart < 0
                                    ? 'Add some activities and enjoy your trip!'
                                    : timeTripStart == 0
                                    ? 'Your trip to ${tripModel.destination} starts today. Let\'s go.'
                                    : 'Your trip to ${tripModel.destination} starts in ${timeTripStart.toString()} days.',
                                maxFontSize: 26,
                                maxLines: 2,
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontFamily: 'FashionFetish',
                                  fontWeight: FontWeight.w900,
                                  height: 1.3,
                                  color: Colors.black54
                                ),
                              ),
                            ]),
                    ),
                ],
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Container(
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
                      : Stack(
                        children: <Widget>[
                          Column(
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
                          SpeedDialButton(key: Key('home_page_dial'), dials: _dials),
                        ]
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
