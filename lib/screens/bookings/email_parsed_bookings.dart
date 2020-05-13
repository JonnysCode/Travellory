import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/widgets/bookings/booking_card.dart';
import 'package:travellory/widgets/buttons/option_button.dart';

class EmailParsedBookingsScreen extends StatelessWidget {
  static final String route = '/booking/emailparsed';

  @override
  Widget build(BuildContext context) {
    TripsProvider tripsProvider = Provider.of<TripsProvider>(context);

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Forward your booking confirmation mails to',
                style: TextStyle(
                  fontFamily: 'fashionFetish',
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.4,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                  height: 6
              ),
              Text(
                'travellory@gmail.com',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'fashionFetish',
                  fontWeight: FontWeight.bold,
                  color: Colors.amberAccent,
                  height: 1.2,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                  height: 6
              ),
              Text(
                'and add them to a trip here.',
                style: TextStyle(
                  fontFamily: 'fashionFetish',
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.2,
                  fontSize: 18,
                ),
              ),
              const SizedBox(
                  height: 16
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          blurRadius: 6, color: Colors.black.withOpacity(.15), offset: Offset(3.0, 3.0))
                    ],
                  ),
                  child: ListView.separated(
                    separatorBuilder: (_, __) => const Divider(),
                    itemCount: bookings.length,
                    itemBuilder: (context, index) => Row(
                      children: <Widget>[
                        Expanded(
                          child: BookingCard(
                            model: bookings[index],
                          ),
                        ),
                        SizedBox(
                          width: 30,
                          child: OptionButton(
                            icon: FontAwesomeIcons.plus,
                            optionItems: tripsProvider.trips.map((trip) => OptionItem(
                              description: trip.tripModel.name
                            )).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


List<Model> bookings = <Model>[
  _publicTransport,
  _accommodation,
  _activity,
  _rentalCar,
  _flight
];

final PublicTransportModel _publicTransport = PublicTransportModel()
  ..transportationType = 'train'
  ..departureLocation = 'Los Angeles'
  ..departureTime = '13:35'
  ..arrivalLocation = 'Las Vegas'
  ..arrivalTime = '15:40';

final AccommodationModel _accommodation = AccommodationModel()
  ..type = 'hotel'
  ..name = 'Novotel Suites'
  ..address = 'Bluff Street 102, 28343 Los Angeles'
  ..checkinTime = '13:00';

final ActivityModel _activity = ActivityModel()
  ..description = 'Surfing Class'
  ..location = 'Long Beach'
  ..startTime = '14:00'
  ..endTime = '18:00';

final FlightModel _flight = FlightModel()
  ..departureLocation = 'Zürich'
  ..departureTime = '9:30'
  ..arrivalLocation = 'Los Angeles'
  ..arrivalTime = '12:20';

final RentalCarModel _rentalCar = RentalCarModel()
  ..pickupLocation = 'Los Angeles Airport'
    ..pickupDate = '08-05-2020';