import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/widgets/booking_header.dart';

class FlightView extends StatefulWidget {
  @override
  _FlightViewState createState() => _FlightViewState();
}

class _FlightViewState extends State<FlightView> {
  String bannerUrl = 'assets/images/bookings/airline_banner.jpg';
  String headerTitle = 'View Your Flight Bookings';

  @override
  Widget build(BuildContext context) {
    // TODO correct this model
    final Model _model = ModalRoute.of(context).settings.arguments;

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
                SizedBox(height: 10),
                ListTile(
                  leading: Icon(Icons.confirmation_number),
                  title: Text('Booking Reference'),
                  subtitle: Text('Booking Reference'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.today),
                  title: Text('Airline'),
                  subtitle: Text('Airline'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.group),
                  title: Text('Flight Number'),
                  subtitle: Text('Flight Number'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.group),
                  title: Text('Seat'),
                  subtitle: Text('Seat'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.group),
                  title: Text('Departure Location'),
                  subtitle: Text('Departure Location'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.group),
                  title: Text('Departure Date'),
                  subtitle: Text('Departure Date'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.today),
                  title: Text('Departure Time'),
                  subtitle: Text('Departure Time'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.today),
                  title: Text('Arrival Location'),
                  subtitle: Text('Arrival Location'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.today),
                  title: Text('Arrival Date'),
                  subtitle: Text('Arrival Date'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.today),
                  title: Text('Arrival Time'),
                  subtitle: Text('Arrival Time'),
                ),
                Divider(),
                ListTile(
                  leading: Icon(Icons.today),
                  title: Text('Notes'),
                  subtitle: Text('Notes'),
                ),
                SizedBox(height: 40),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
