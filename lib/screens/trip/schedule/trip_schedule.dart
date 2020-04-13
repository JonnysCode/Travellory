import 'package:flutter/material.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/screens/trip/schedule/day_schedule.dart';

class Schedule extends StatefulWidget {
  const Schedule({Key key}) : super(key : key);

  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  static TripModel _tripModel = TripModel(
      name: 'Castle Discovery',
      startDate: '2020-05-11',
      endDate: '2020-05-19',
      destination: 'Munich',
      imageNr: 3
  );

  List<bool> _expandedDays;

  @override
  void initState() {
    _tripModel.init();
    _expandedDays = _tripModel.days.map((day) => false).toList();
    //_expandedDays[0] = true;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      shrinkWrap: false,
      itemCount: _tripModel.days.length+1,
      itemBuilder: (context, index) {
        if(index < _tripModel.days.length){
          return DaySchedule(
            isExpanded: _expandedDays[index],
            day: _tripModel.days[index],
          );
        } else {
          return  SizedBox(height: 100);
        }
      },
      separatorBuilder: (context, index) => const SizedBox(height: 8),
    );
  }
}



