import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/screens/trip/schedule/trip_schedule.dart';
import 'package:travellory/shared/loading_heart.dart';
import 'package:travellory/widgets/buttons/speed_dial_button.dart';
import 'package:travellory/widgets/font_widgets.dart';

class HomePage extends StatelessWidget {
  static const List<Dial> _dials = <Dial>[
    Dial(
      icon: FontAwesomeIcons.envelope,
      description: 'Manage forwarded bookings',
    ),
    Dial(
        icon: FontAwesomeIcons.theaterMasks,
        description: 'Add Activity',
        route: '/booking/activity'
    ),
    Dial(
        icon: FontAwesomeIcons.car,
        description: 'Add Rental Car',
        route: '/booking/rentalcar'
    ),
    Dial(
        icon: FontAwesomeIcons.bus,
        description: 'Add Public Transportation',
        route: '/booking/publictransport'

    ),
    Dial(
        icon: FontAwesomeIcons.bed,
        description: 'Add Accommodation',
        route: '/booking/accommodation'
    ),
    Dial(
        icon: FontAwesomeIcons.plane,
        description: 'Add Flight',
        route: '/booking/flight',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    SingleTripProvider trip = Provider.of<TripsProvider>(context, listen: false).activeTrip;
    return SafeArea(
      child: Container(
        key: Key('home_page'),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 30,
              top: 30,
              child: Image(
                height: 100,
                image: AssetImage('assets/images/home/011-cloud.png'),
              ),
            ),
            Positioned(
              top: 100,
              left: 110,
              child: FashionFetishText(
                text: '24\u00B0',
                size: 24,
                color: Colors.black87,
                fontWeight: FashionFontWeight.bold,
              ),
            ),
            Positioned(
              top: 40,
              left: 175,
              right: 20,
              child: FashionFetishText(
                text: 'Get ready Bill!',
                size: 24,
                fontWeight: FashionFontWeight.heavy,
                height: 1.2,
              ),
            ),
            Positioned(
              top: 75,
              left: 175,
              right: 40,
              child: Text(
                'Your trip to Los Angeles starts in 1 day. Pack your bags now.',
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.black54,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.8,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
                    boxShadow: <BoxShadow>[
                      BoxShadow(blurRadius: 18, color: Colors.black.withOpacity(.2), offset: Offset(0.0, -6.0))
                    ],
                  ),
                  child:  Column(
                      children: <Widget>[
                        FashionFetishText(
                          text: trip.tripModel.name,
                          size: 20,
                          height: 1.6,
                          fontWeight: FashionFontWeight.heavy,
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
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
            SpeedDialButton(
              key: Key('home_page_dial'),
              dials: _dials,
              tripModel: trip.tripModel,
            ),
          ],
        ),
      ),
    );
  }
}
