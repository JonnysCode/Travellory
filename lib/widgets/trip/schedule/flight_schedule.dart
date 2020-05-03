import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/schedule_entry.dart';
import 'package:travellory/widgets/bookings/bookings_card_specifics.dart';

class FlightSchedule extends StatelessWidget {
  const FlightSchedule(this.scheduleEntry, {Key key}) : super(key: key);

  final ScheduleEntry scheduleEntry;

  @override
  Widget build(BuildContext context) {
    FlightModel flight = scheduleEntry.booking;
    DayType dayType = scheduleEntry.dayType;
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
            child: Column(
              children: <Widget>[
                if(dayType == DayType.last)
                  SizedBox(height: 12),
                Text(
                  flight.departureTime,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
                if(dayType == DayType.last)
                  Text(
                    '-1',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
              ],
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
            child: Column(
              children: <Widget>[
                if(dayType == DayType.first)
                  SizedBox(height: 12),
                Text(
                  flight.arrivalTime,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.black54,
                  ),
                ),
                if(dayType == DayType.first)
                  Text(
                    '+1',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.black54,
                    ),
                  ),
              ],
            ),
          ),
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