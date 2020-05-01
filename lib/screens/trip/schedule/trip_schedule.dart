import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/screens/trip/schedule/day_schedule.dart';

class Schedule extends StatelessWidget {
  const Schedule({
    Key key,
    @required this.trip
  }) : super(key : key);

  final SingleTripProvider trip;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      shrinkWrap: false,
      itemCount: trip.days.length+1,
      itemBuilder: (context, index) {
        if(index < trip.days.length){
          return DaySchedule(day: trip.days[index],
          );
        } else {
          return  SizedBox(height: 100);
        }
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}



