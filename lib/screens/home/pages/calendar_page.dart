import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/core.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final Color calendarBackgroundColor = Colors.green[100];
  final DateTime today = DateTime.now();

  // TODO this will have to be linked with the backend
  List<Meeting> _getDataSource() {
    var meetings = <Meeting>[];
    final DateTime startDate = today.add(const Duration(days: -3));
    final DateTime endDate = startDate.add(const Duration(days: 6));
    meetings.add(
        Meeting('TestTrip', startDate, endDate, calendarBackgroundColor, true));
    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    // this registers the license for the calendar
    // trial period until April 22, 2020
    SyncfusionLicense.registerLicense("NT8mJyc2IWhiZH1nfWN9Z2VoZ3xhYXxhY2Fjc2JhaWBiaWZicwMeaDI9Jzo/KjIgEyAnJjc2PScgfSk7MiR9MDs=");

    return Container(
      key: Key('calendar_page'),
      margin: new EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
      child: SfCalendar(
        view: CalendarView.month,
        todayHighlightColor: Colors.black,
        initialDisplayDate:  DateTime.utc(today.year, today.month, 1),
        dataSource: MeetingDataSource(_getDataSource()),
        selectionDecoration: BoxDecoration(
          color: Theme.of(context).primaryColor.withOpacity(0.3),
          border: Border.all(color: Colors.transparent, width: 1),
          borderRadius: const BorderRadius.all(Radius.circular(4)),
          shape: BoxShape.rectangle,
        ),
        monthViewSettings: MonthViewSettings(
          showAgenda: true,
          appointmentDisplayMode: MonthAppointmentDisplayMode.appointment,
          agendaViewHeight: 100,
          agendaItemHeight: 80,
          navigationDirection: MonthNavigationDirection.vertical,
          numberOfWeeksInView: 6,
          dayFormat: 'EEE',
          agendaStyle: AgendaStyle(
            appointmentTextStyle: TextStyle(
                fontSize: 14, fontStyle: FontStyle.italic, color: Colors.black),
            dateTextStyle: TextStyle(
                fontStyle: FontStyle.italic,
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: Colors.black),
            dayTextStyle: TextStyle(
                fontStyle: FontStyle.normal,
                fontSize: 20,
                fontWeight: FontWeight.w600,
                color: Colors.black),
          ),
          monthCellStyle: MonthCellStyle(
              trailingDatesBackgroundColor: Colors.white30,
              todayBackgroundColor:
                  Theme.of(context).primaryColor.withOpacity(0.5),
              todayTextStyle: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Arial')),
        ),
        firstDayOfWeek: 1, // first day of the week should be monday
      ),
    );
  }
}

class MeetingDataSource extends CalendarDataSource {
  MeetingDataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  DateTime getStartTime(int index) {
    return appointments[index].from;
  }

  @override
  DateTime getEndTime(int index) {
    return appointments[index].to;
  }

  @override
  String getSubject(int index) {
    return appointments[index].eventName;
  }

  @override
  Color getColor(int index) {
    return appointments[index].background;
  }

  @override
  bool isAllDay(int index) {
    return appointments[index].isAllDay;
  }
}

class Meeting {
  Meeting(this.eventName, this.from, this.to, this.background, this.isAllDay);

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
}
