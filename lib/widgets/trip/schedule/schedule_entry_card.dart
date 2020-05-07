import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/schedule_entry.dart';
import 'package:travellory/widgets/trip/schedule/accommodation_schedule.dart';
import 'package:travellory/widgets/trip/schedule/activity_schedule.dart';
import 'package:travellory/widgets/trip/schedule/flight_schedule.dart';
import 'package:travellory/widgets/trip/schedule/public_transport_schedule.dart';
import 'package:travellory/widgets/trip/schedule/rental_car_schedule.dart';

class ScheduleEntryCard extends StatelessWidget {
  const ScheduleEntryCard({
    Key key,
    @required this.scheduleEntry,
    this.onTap,
  }) : super(key: key);

  final ScheduleEntry scheduleEntry;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key('schedule_entry_card'),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: getColorAccordingTo(scheduleEntry),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(.2), offset: Offset(0.0, 6.0))
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
