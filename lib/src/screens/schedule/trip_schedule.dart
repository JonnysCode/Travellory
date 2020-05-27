import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/src/providers/schedule_provider.dart';
import 'package:travellory/src/providers/single_trip_provider.dart';
import 'package:travellory/src/screens/schedule/day_schedule.dart';

class Schedule extends StatelessWidget {
  const Schedule({Key key, @required this.trip}) : super(key: key);

  final SingleTripProvider trip;

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ScheduleProvider>(
      create: (_) => ScheduleProvider(trip),
      child: Consumer<ScheduleProvider>(
        builder: (_, schedule, __) => ListView.separated(
          padding: const EdgeInsets.symmetric(horizontal: 8.0),
          shrinkWrap: false,
          itemCount: schedule.days.length + 1,
          itemBuilder: (context, index) {
            if (index < schedule.days.length) {
              return DaySchedule(
                day: schedule.days[index],
              );
            } else {
              return SizedBox(height: 100);
            }
          },
          separatorBuilder: (context, index) => const SizedBox(height: 8),
        ),
      ),
    );
  }
}
