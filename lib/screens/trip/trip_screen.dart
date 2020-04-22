import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/trip/booking_card.dart';
import 'package:travellory/widgets/trip/trip_header.dart';

class TripScreen extends StatefulWidget {
  const TripScreen({
    Key key,
  }) : super(key: key);

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
  }

  @override
  Widget build(BuildContext context) {
    final TripsProvider tripsProvider = Provider.of<TripsProvider>(context, listen: false);
    final TripModel tripModel = ModalRoute.of(context).settings.arguments;
    tripsProvider.initBookings(tripModel);

    List<Model> _flightModels = tripsProvider.flights;
    List<Model> _accommodationModels = tripsProvider.accommodations;
    List<Model> _activityModels = tripsProvider.activities;
    List<Model> _rentalCarModels = tripsProvider.rentalcars;
    List<Model> _publicTransportModels = tripsProvider.publictransports;

    flightBookings = _flightModels
        .map((model) => BookingCard(
              model: model,
              onTap: () => Navigator.pushNamed(context, '/view/flight', arguments: model),
              color: getBookingColorAccordingTo(model),
              getSchedule: getBookingsAccordingTo(model),
            ))
        .toList();

    accommodationBookings = _accommodationModels
        .map((model) => BookingCard(
              model: model,
              onTap: () => Navigator.pushNamed(context, '/view/accommodation', arguments: model),
              color: getBookingColorAccordingTo(model),
              getSchedule: getBookingsAccordingTo(model),
            ))
        .toList();

    activityBookings = _activityModels
        .map((model) => BookingCard(
              model: model,
              onTap: () => Navigator.pushNamed(context, '/view/activity', arguments: model),
              color: getBookingColorAccordingTo(model),
              getSchedule: getBookingsAccordingTo(model),
            ))
        .toList();

    rentalCarBookings = _rentalCarModels
        .map((model) => BookingCard(
              model: model,
              onTap: () => Navigator.pushNamed(context, '/view/rentalcar', arguments: model),
              color: getBookingColorAccordingTo(model),
              getSchedule: getBookingsAccordingTo(model),
            ))
        .toList();

    publicTransportBookings = _publicTransportModels
        .map((model) => BookingCard(
              model: model,
              onTap: () => Navigator.pushNamed(context, '/view/publictransport', arguments: model),
              color: getBookingColorAccordingTo(model),
              getSchedule: getBookingsAccordingTo(model),
            ))
        .toList();

    void _openAddBooking(String bookingToAddSite) {
      Navigator.pushNamed(context, bookingToAddSite, arguments: tripModel);
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
                onTap: () => _openAddBooking(route),
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
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: bookings
              .map((booking) => Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: booking,
                  ))
              .toList(),
        ),
      );
    }

    return Scaffold(
      key: Key('TripScreen'),
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
                  child: _subsection('Flights', '/booking/flight'),
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
                  child: _subsection('Car rental', '/booking/rentalcar'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _bookings(rentalCarBookings),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _subsection('Transportation', '/booking/publictransport'),
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
