import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/src/models/flight_model.dart';
import 'bookings_card_specifics.dart';

class FlightBookings extends StatelessWidget {
  const FlightBookings(this.flight, {Key key}) : super(key: key);
  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    final Color textColor = Colors.grey[850];

    return Row(
      key: Key('flightBookings'),
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Airport(
            name: flight.departureLocation,
            code: flight.departureLocation.substring(0, 3).toUpperCase(),
            color: textColor,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              flight.departureTime,
              style: TextStyle(
                fontSize: 15,
                color: textColor,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Column(children: <Widget>[
              Text(
                flight.departureDate,
                style: TextStyle(
                  fontSize: 12.0,
                  color: textColor,
                ),
              ),
              Transform.rotate(
                angle: -0.5,
                child: FaIcon(
                  FontAwesomeIcons.plane,
                  size: 20,
                  color: Colors.blue[900],
                ),
              ),
            ]),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
              child: Text(
            flight.arrivalTime,
            style: TextStyle(
              fontSize: 15,
              color: textColor,
            ),
          )),
        ),
        Expanded(
          flex: 1,
          child: Airport(
            name: flight.arrivalLocation,
            code: flight.arrivalLocation.substring(0, 3).toUpperCase(),
            color: textColor,
          ),
        ),
      ],
    );
  }
}
