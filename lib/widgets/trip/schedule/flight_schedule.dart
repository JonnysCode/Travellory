import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/widgets/bookings/bookings_card_specifics.dart';

class FlightSchedule extends StatelessWidget {
  const FlightSchedule(this.flight, {Key key}) : super(key: key);
  final FlightModel flight;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: Key('flight'),
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Airport(
            name: flight.departureLocation,
            code: flight.departureLocation.substring(0, 3).toUpperCase(),
            color: Colors.black54,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              flight.departureTime,
              style: TextStyle(
                color: Colors.white54,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Transform.rotate(
              angle: -0.5,
              child: FaIcon(
                FontAwesomeIcons.plane,
                size: 30,
                color: Colors.black54,
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
              child: Text(
            flight.arrivalTime,
            style: TextStyle(
              color: Colors.white54,
            ),
          )),
        ),
        Expanded(
          flex: 2,
          child: Airport(
            name: flight.arrivalLocation,
            code: flight.arrivalLocation.substring(0, 3).toUpperCase(),
            color: Colors.black54,
          ),
        ),
      ],
    );
  }
}
