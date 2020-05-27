import 'package:flutter/material.dart';
import 'package:travellory/src/models/abstract_model.dart';
import 'package:travellory/src/models/accommodation_model.dart';
import 'package:travellory/src/models/activity_model.dart';
import 'package:travellory/src/models/flight_model.dart';
import 'package:travellory/src/models/public_transport_model.dart';
import 'package:travellory/src/models/rental_car_model.dart';
import 'package:travellory/src/models/schedule_entry.dart';
import 'package:travellory/src/screens/accommodation/view_accommodation.dart';
import 'package:travellory/src/screens/activity/view_activity.dart';
import 'package:travellory/src/screens/flight/view_flight.dart';
import 'package:travellory/src/screens/public_transport/view_public_transport.dart';
import 'package:travellory/src/screens/rental_car/view_rental_car.dart';
import 'package:travellory/src/components/schedule_cards/accommodation_schedule.dart';
import 'package:travellory/src/components/schedule_cards/activity_schedule.dart';
import 'package:travellory/src/components/schedule_cards/flight_schedule.dart';
import 'package:travellory/src/components/schedule_cards/public_transport_schedule.dart';
import 'package:travellory/src/components/schedule_cards/rental_car_schedule.dart';

class ScheduleEntryCard extends StatelessWidget {
  const ScheduleEntryCard({
    Key key,
    @required this.scheduleEntry,
  }) : super(key: key);

  final ScheduleEntry scheduleEntry;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key('schedule_entry_card'),
      onTap: () => Navigator.pushNamed(
          context, getRouteAccordingTo(scheduleEntry),
          arguments: scheduleEntry.booking),
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: getColorAccordingTo(scheduleEntry),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(
                blurRadius: 6,
                color: Colors.black.withOpacity(.2),
                offset: Offset(0.0, 6.0))
          ],
        ),
        child: getScheduleAccordingTo(scheduleEntry),
      ),
    );
  }
}

Widget getScheduleAccordingTo(ScheduleEntry scheduleEntry) {
  final Model model = scheduleEntry.booking;
  Widget widget;
  if (model is FlightModel) {
    widget = FlightSchedule(scheduleEntry);
  } else if (model is RentalCarModel) {
    widget = RentalCarSchedule(scheduleEntry);
  } else if (model is AccommodationModel) {
    widget = AccommodationSchedule(scheduleEntry);
  } else if (model is PublicTransportModel) {
    widget = PublicTransportSchedule(scheduleEntry);
  } else if (model is ActivityModel) {
    widget = ActivitySchedule(scheduleEntry);
  } else {
    widget = Container();
  }
  return widget;
}

Color getColorAccordingTo(ScheduleEntry scheduleEntry) {
  final Model model = scheduleEntry.booking;
  Color color;
  if (model is FlightModel) {
    color = Colors.blue[100];
  } else if (model is RentalCarModel) {
    color = Colors.yellow[600];
  } else if (model is AccommodationModel) {
    color = Colors.deepOrange[200];
  } else if (model is PublicTransportModel) {
    color = Colors.blueGrey;
  } else if (model is ActivityModel) {
    color = Colors.teal[300];
  } else {
    color = Colors.grey;
  }
  return color;
}

String getRouteAccordingTo(ScheduleEntry scheduleEntry) {
  final Model model = scheduleEntry.booking;
  String route;
  if (model is FlightModel) {
    route = FlightView.route;
  } else if (model is RentalCarModel) {
    route = RentalCarView.route;
  } else if (model is AccommodationModel) {
    route = AccommodationView.route;
  } else if (model is PublicTransportModel) {
    route = PublicTransportView.route;
  } else if (model is ActivityModel) {
    route = ActivityView.route;
  } else {
    route = '';
  }
  return route;
}
