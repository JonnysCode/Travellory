import 'package:flutter/material.dart';

import 'banner.dart';

class FlightView extends StatefulWidget {
  @override
  _FlightViewState createState() => _FlightViewState();
}

class _FlightViewState extends State<FlightView> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('FlightView'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
            child: Container(
              padding: const EdgeInsets.all(5.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                      blurRadius: 6, color: Colors.black.withOpacity(.15), offset: Offset(3.0, 3.0))
                ],
              ),
              child: SingleChildScrollView(
                child: Column(children: <Widget>[
                  ListTile(
                    leading: Icon(Icons.confirmation_number),
                    title: Text('Booking Reference'),
                    subtitle: Text('Booking Reference'),
                  ),
                  ListTile(
                    leading: Icon(Icons.today),
                    title: Text('Airline'),
                    subtitle: Text('Airline'),
                  ),
                  ListTile(
                    leading: Icon(Icons.group),
                    title: Text('Flight Number'),
                    subtitle: Text('Flight Number'),
                  ),
                  ListTile(
                    leading: Icon(Icons.group),
                    title: Text('Seat'),
                    subtitle: Text('Seat'),
                  ),
                  ListTile(
                    leading: Icon(Icons.group),
                    title: Text('Departure Location'),
                    subtitle: Text('Departure Location'),
                  ),
                  ListTile(
                    leading: Icon(Icons.group),
                    title: Text('Departure Date'),
                    subtitle: Text('Departure Date'),
                  ),
                  ListTile(
                    leading: Icon(Icons.today),
                    title: Text('Departure Time'),
                    subtitle: Text('Departure Time'),
                  ),
                  ListTile(
                    leading: Icon(Icons.today),
                    title: Text('Arrival Location'),
                    subtitle: Text('Arrival Location'),
                  ),
                  ListTile(
                    leading: Icon(Icons.today),
                    title: Text('Arrival Date'),
                    subtitle: Text('Arrival Date'),
                  ),
                  ListTile(
                    leading: Icon(Icons.today),
                    title: Text('Arrival Time'),
                    subtitle: Text('Arrival Time'),
                  ),
                  ListTile(
                    leading: Icon(Icons.today),
                    title: Text('Notes'),
                    subtitle: Text('Notes'),
                  ),
                ]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
