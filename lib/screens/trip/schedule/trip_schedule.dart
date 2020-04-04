import 'package:flutter/material.dart';
import 'package:travellory/screens/trip/schedule/day_schedule.dart';
import 'package:travellory/widgets/font_widgets.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      itemCount: 6,
      itemBuilder: (context, index) {
        return DaySchedule(expanded: false);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }
}



