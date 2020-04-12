import 'package:flutter/material.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/widgets/booking_header.dart';
import 'package:travellory/widgets/bookings/view_bookings.dart';
import 'package:travellory/widgets/buttons.dart';

class FlightView extends StatefulWidget {
  @override
  _FlightViewState createState() => _FlightViewState();
}

class _FlightViewState extends State<FlightView> {
  String bannerUrl = 'assets/images/bookings/airline_banner.jpg';
  String headerTitle = 'View Your Flight Bookings';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('FlightView'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius:
                  BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(20)),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 6, color: Colors.black.withOpacity(.15), offset: Offset(3.0, 3.0))
              ],
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                BookingHeader(headerTitle, bannerUrl),
                SizedBox(height: 20),
                // TODO add section titles
                fieldView(Icons.confirmation_number, 'Booking Reference',
                    flightModels[0].bookingReference, context),
                Divider(),
                fieldView(Icons.today, 'Airline', flightModels[0].airline, context),
                Divider(),
                fieldView(Icons.group, 'Flight Number', flightModels[0].flightNr, context),
                Divider(),
                fieldView(Icons.group, 'Seat', flightModels[0].seat, context),
                Divider(),
                fieldView(Icons.group, 'Departure Location', flightModels[0].departureLocation, context),
                Divider(),
                fieldView(Icons.group, 'Departure Date', flightModels[0].departureDate, context),
                Divider(),
                fieldView(Icons.today, 'Departure Time', flightModels[0].departureTime, context),
                Divider(),
                fieldView(Icons.group, 'Arrival Location', flightModels[0].arrivalLocation, context),
                Divider(),
                fieldView(Icons.group, 'Arrival Date', flightModels[0].arrivalDate, context),
                Divider(),
                fieldView(Icons.today, 'Arrival Time', flightModels[0].arrivalTime, context),
                // TODO enter checkbox details
                Divider(),
                fieldView(Icons.group, 'Notes', flightModels[0].notes, context),
                SizedBox(height: 10),
                bottomBar(context),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
