import 'package:flutter/material.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/widgets/booking_header.dart';
import 'package:travellory/widgets/buttons.dart';

class FlightView extends StatefulWidget {
  @override
  _FlightViewState createState() => _FlightViewState();
}

class _FlightViewState extends State<FlightView> {
  String bannerUrl = 'assets/images/bookings/airline_banner.jpg';
  String headerTitle = 'View Your Flight Bookings';

  void _edit() {
    // TODO
  }

  Row info(IconData icon, String title, String details) {
    return Row(children: <Widget>[
      SizedBox(width: 30.0),
      Icon(
        icon,
        size: 40.0,
        color: Theme.of(context).primaryColor,
      ),
      SizedBox(width: 15.0),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            title,
            style: TextStyle(fontSize: 16.0),
          ),
          Text(
            details,
            style: TextStyle(fontSize: 20.0),
          ),
        ],
      ),
    ]);
  }

  Container bottomBar() {
    return Container(
      padding: EdgeInsets.all(20.0),
      height: 100.0,
      decoration: BoxDecoration(
        color: Theme.of(context).primaryColor,
        borderRadius: BorderRadius.circular(40.0),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          filledButton('EDIT', Colors.white, Theme.of(context).primaryColor,
              Theme.of(context).primaryColor, Colors.white, _edit),
          filledButton('DELETE', Colors.white, Theme.of(context).primaryColor,
              Theme.of(context).primaryColor, Colors.white, _edit),
        ],
      ),
    );
  }

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
                info(Icons.confirmation_number, 'Booking Reference',
                    flightModels[0].bookingReference),
                Divider(),
                info(Icons.today, 'Airline', flightModels[0].airline),
                Divider(),
                info(Icons.group, 'Flight Number', flightModels[0].flightNr),
                Divider(),
                info(Icons.group, 'Seat', flightModels[0].seat),
                Divider(),
                info(Icons.group, 'Departure Location', flightModels[0].departureLocation),
                Divider(),
                info(Icons.group, 'Departure Date', flightModels[0].departureDate),
                Divider(),
                info(Icons.today, 'Departure Time', flightModels[0].departureTime),
                Divider(),
                info(Icons.group, 'Arrival Location', flightModels[0].arrivalLocation),
                Divider(),
                info(Icons.group, 'Arrival Date', flightModels[0].arrivalDate),
                Divider(),
                info(Icons.today, 'Arrival Time', flightModels[0].arrivalTime),
                // TODO enter checkbox details
                Divider(),
                info(Icons.group, 'Notes', flightModels[0].notes),
                SizedBox(height: 10),
                bottomBar(),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
