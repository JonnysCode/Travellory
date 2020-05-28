import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/src/models/public_transport_model.dart';
import 'package:travellory/src/models/schedule_entry.dart';
import 'package:travellory/src/components/booking_cards/bookings_card_specifics.dart';

class PublicTransportSchedule extends StatelessWidget {
  const PublicTransportSchedule(this.scheduleEntry, {Key key}) : super(key: key);

  final ScheduleEntry scheduleEntry;

  @override
  Widget build(BuildContext context) {
    final PublicTransportModel publicTransport = scheduleEntry.booking;
    final DayType dayType = scheduleEntry.dayType;

    return Row(
      key: Key('public_transport'),
      children: <Widget>[
        Expanded(
          flex: 3,
          child: PublicTransportEntry(
            location: publicTransport.departureLocation,
            time: publicTransport.departureTime,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              dayType == DayType.last ? '-1' : '',
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black54
              ),
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.train,
              size: 30,
              color: Colors.black54,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Text(
              dayType == DayType.first ? '+1' : '',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black54
              ),
            ),
          ),
        ),
        Expanded(
          flex: 3,
          child: PublicTransportEntry(
            location: publicTransport.arrivalLocation,
            time: publicTransport.arrivalTime,
          ),
        ),
      ],
    );
  }
}
