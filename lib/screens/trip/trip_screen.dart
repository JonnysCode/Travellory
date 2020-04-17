import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/trip/schedule/booking_card.dart';
import 'package:travellory/widgets/trip/trip_header.dart';

final PublicTransportModel _metro = PublicTransportModel()
  ..transportationType = 'Metro'
  ..departureLocation = 'Gatwick Airport'
  ..departureDate = '2020-05-01'
  ..departureTime = '10:55'
  ..arrivalLocation = 'London City'
  ..arrivalDate = '2020-05-01'
  ..arrivalTime = '11:40';

final PublicTransportModel _taxi = PublicTransportModel()
  ..transportationType = 'Taxi'
  ..departureLocation = 'London City'
  ..departureDate = '2020-05-04'
  ..departureTime = '10:55'
  ..arrivalLocation = 'Gatwick Airport'
  ..arrivalDate = '2020-05-04'
  ..arrivalTime = '11:30';

final AccommodationModel _accommodation = AccommodationModel()
  ..type = 'hotel'
  ..name = 'Travelodge'
  ..address = "100 King's Cross Rd, London WC1X 9DT"
  ..checkinTime = '12:00';

final ActivityModel _cinema = ActivityModel()
  ..description = 'Cinema'
  ..location = 'London Odeon'
  ..startTime = '20:00'
  ..endTime = '22:00';

final FlightModel _flightOne = FlightModel()
  ..departureLocation = 'Zürich'
  ..departureDate = '2020-05-01'
  ..departureTime = '7:30'
  ..arrivalLocation = 'London'
  ..arrivalDate = '2020-05-01'
  ..arrivalTime = '8:35';

final FlightModel _flightTwo = FlightModel()
  ..departureLocation = 'London'
  ..departureDate = '2020-05-04'
  ..departureTime = '12:30'
  ..arrivalLocation = 'Zürich'
  ..arrivalDate = '2020-05-04'
  ..arrivalTime = '13:55';

final RentalCarModel _rental = RentalCarModel()..pickupLocation = 'Gatwick Airport';

List<Model> _flightModels = <Model>[
  _flightOne,
  _flightTwo,
];

List<Model> _accommodationModels = <Model>[
  _accommodation,
];

List<Model> _publicTransportModels = <Model>[
  _metro,
  _taxi,
];

List<Model> _activityModels = <Model>[
  _cinema,
];

List<Model> _rentalCarModels = <Model>[
  _rental,
];

class TripScreen extends StatefulWidget {
  const TripScreen({
    Key key,
//    @required this.model,
  }) : super(key: key);

//  final TripModel model;

  @override
  _TripScreenState createState() => _TripScreenState();
}

class _TripScreenState extends State<TripScreen> {
  List<Widget> flightBookings;
  List<Widget> accommodationBookings;
  List<Widget> publicTransportBookings;
  List<Widget> activityBookings;
  List<Widget> rentalCarBookings;

  @override
  void initState() {
    super.initState();
    flightBookings = _flightModels
        .map((model) => BookingCard(
              model: model,
              color: getColorAccordingTo(model),
              getSchedule: getScheduleAccordingTo(model),
            ))
        .toList();

    accommodationBookings = _accommodationModels
        .map((model) => BookingCard(
              model: model,
              color: getColorAccordingTo(model),
              getSchedule: getScheduleAccordingTo(model),
            ))
        .toList();

    publicTransportBookings = _publicTransportModels
        .map((model) => BookingCard(
              model: model,
              color: getColorAccordingTo(model),
              getSchedule: getScheduleAccordingTo(model),
            ))
        .toList();

    activityBookings = _activityModels
        .map((model) => BookingCard(
              model: model,
              color: getColorAccordingTo(model),
              getSchedule: getScheduleAccordingTo(model),
            ))
        .toList();

    rentalCarBookings = _rentalCarModels
        .map((model) => BookingCard(
              model: model,
              color: getColorAccordingTo(model),
              getSchedule: getScheduleAccordingTo(model),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final TripModel tripModel = ModalRoute.of(context).settings.arguments;

    void _openBooking(String bookingSite) {
      Navigator.pushNamed(context, bookingSite, arguments: tripModel);
    }

    Widget _subsection(String title, String route) {
      return Container(
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 16,
              width: 240,
              child: FashionFetishText(
                text: title,
                size: 24,
                fontWeight: FashionFontWeight.heavy,
              ),
            ),
            Positioned(
              top: 17,
              right: 34,
              child: FashionFetishText(
                text: 'Add',
                size: 16,
                fontWeight: FashionFontWeight.bold,
                color: Colors.black45,
              ),
            ),
            Positioned(
              top: 6,
              right: 0,
              child: GestureDetector(
                onTap: () => _openBooking(route),
                child: Container(
                  height: 28,
                  width: 28,
                  padding: EdgeInsets.only(top: 20, right: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/home/trip/add.png'),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    Widget _bookings(List<Widget> bookings) {
      return Container(
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.fromLTRB(5.5, 6, 5.5, 0),
              child: Container(
                width: 1,
                color: Colors.black54,
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(right: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: bookings
                      .map((booking) => Padding(
                            padding: const EdgeInsets.only(bottom: 10),
                            child: booking,
                          ))
                      .toList(),
                ),
              ),
            )
          ],
        ),
      );
    }

    Widget _cardCarousel() {
      return Container(
        height: 80,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemCount: 3,
          itemBuilder: (context, index) => Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Container(
              height: 50,
              width: 200,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).scaffoldBackgroundColor,
              ),
              child: Center(child: Text('Entry')),
            ),
          ),
          separatorBuilder: (context, index) => const Divider(),
        ),
      );
    }

    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            TripHeader(tripModel),
            Expanded(
                child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _subsection('Flight', '/booking/flight'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _bookings(flightBookings),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _subsection('Accommodation', '/booking/accommodation'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _bookings(accommodationBookings),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _subsection('Activities', '/booking/activity'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _bookings(activityBookings),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _subsection('Car rental', '/booking/rentalCar'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _bookings(rentalCarBookings),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _subsection('Transportation', '/booking/publicTransport'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _bookings(publicTransportBookings),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
