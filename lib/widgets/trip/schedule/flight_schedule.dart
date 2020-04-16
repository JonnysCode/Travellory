import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/trip/schedule/schedule_card.dart';

class FlightSchedule extends StatelessWidget {
  final FlightModel _flight = FlightModel()
    ..departureLocation = 'Zürich'
    ..departureTime = '9:30'
    ..arrivalLocation = 'Los Angeles'
    ..arrivalTime = '12:20';

  @override
  Widget build(BuildContext context) {
    return ScheduleCard(
      color: Colors.blueGrey,
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Airport(
              name: _flight.departureLocation,
              code: _flight.departureLocation.substring(0,3).toUpperCase(),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                _flight.departureTime,
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
                _flight.arrivalTime,
                style: TextStyle(
                  color: Colors.white54,
                ),
              )
            ),
          ),
          Expanded(
            flex: 2,
            child: Airport(
              name: _flight.arrivalLocation,
              code: _flight.arrivalLocation.substring(0,3).toUpperCase(),
            ),
          ),
        ],
      ),
    );
  }
}

class Airport extends StatelessWidget {
  const Airport({
    @required this.name,
    @required this.code,
  });

  final String name;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FashionFetishText(
          text: code,
          size: 24,
          fontWeight: FashionFontWeight.bold,
          height: 1.1,
          color: Colors.black54,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white54
          ),
        ),
      ],
    );
  }
}

