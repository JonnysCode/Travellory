import 'package:flutter/material.dart';
import 'package:travellory/screens/trip/schedule/day_schedule.dart';
import 'package:travellory/widgets/font_widgets.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  List<bool> _expandedDays = [true, false, false, false, false, false];

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(10),
      shrinkWrap: false,
      itemCount: 6,
      itemBuilder: (context, index) {
        return DaySchedule(expanded: _expandedDays[index]);
      },
      separatorBuilder: (context, index) => const SizedBox(height: 12),
    );
  }
}



