import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/core.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final Color calendarBackgroundColor = Colors.green[100];
  static DateTime today = DateTime.now();
  static DateTime firstOfMonth = new DateTime(today.year, today.month, 1);

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
    // activate license here https://help.syncfusion.com/common/essential-studio/licensing/license-key?cs-save-lang=1&cs-lang=csharp
    // TODO get license
    SyncfusionLicense.registerLicense(null);

    return Container(
      key: Key('calendar_page'),
      margin: new EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
      child: SfCalendar(
        view: CalendarView.month,
        todayHighlightColor: Colors.black,
        initialDisplayDate: firstOfMonth,
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
          numberOfWeeksInView: 4,
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
