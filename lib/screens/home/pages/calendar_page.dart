import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/core.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final Color calendarBackgroundColor = Colors.red;
  final DateTime today = DateTime.now();

  // TODO this will have to be linked with the backend
  List<Meeting> _getDataSource() {
    var meetings = <Meeting>[];
    final DateTime startDate = today.add(const Duration(days: -3));
    final DateTime endDate = startDate.add(const Duration(days: 6));
    meetings.add(
        Meeting('TestTrip', startDate, endDate, calendarBackgroundColor, false));
    return meetings;
  }

  @override
  Widget build(BuildContext context) {
    // this registers the license for the calendar
    // trial period until April 22, 2020
    SyncfusionLicense.registerLicense(
        "NT8mJyc2IWhiZH1nfWN9Z2VoZ3xhYXxhY2Fjc2JhaWBiaWZicwMeaDI9Jzo/KjIgEyAnJjc2PScgfSk7MiR9MDs=");

    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 10.0),
      child: Column(
        children: <Widget>[
          Center(
            child: Container(
              key: Key('calendar_page'),
              height: 320,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(40.0)),
                color: Colors.transparent,
                //boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black.withOpacity(.15), offset: Offset(4.0, 4.0))],
              ),
              child: SfCalendar(
                view: CalendarView.month,
                cellBorderColor: Colors.transparent,
                todayHighlightColor: Colors.blueGrey,
                initialDisplayDate: DateTime.utc(today.year, today.month, 1),
                dataSource: MeetingDataSource(_getDataSource()),
                selectionDecoration: BoxDecoration(
                  color: Colors.black12,
                  border: Border.all(color: Colors.transparent, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  shape: BoxShape.rectangle,
                ),
                headerStyle: CalendarHeaderStyle(
                    textAlign: TextAlign.left,
                    backgroundColor: Colors.transparent,//Color(0xFFF7C852),
                    textStyle: TextStyle(
                        fontFamily: 'FashionFetish',
                        fontSize: 24,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),
                ),
                monthViewSettings: MonthViewSettings(
                  showAgenda: false,
                  appointmentDisplayMode: MonthAppointmentDisplayMode.indicator,
                  navigationDirection: MonthNavigationDirection.horizontal,
                  numberOfWeeksInView: 6,
                  dayFormat: 'EEE',
                  monthCellStyle: MonthCellStyle(
                    todayTextStyle: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'FashionFetish',
                      height: 1.2,
                    ),
                    textStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.white,
                      fontFamily: 'FashionFetish',
                      height: 1.2,
                    ),
                    trailingDatesTextStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      fontFamily: 'FashionFetish',
                      height: 1.2,
                    ),
                    leadingDatesTextStyle: TextStyle(
                      fontSize: 14,
                      color: Colors.white70,
                      fontFamily: 'FashionFetish',
                      height: 1.2,
                    ),
                  ),
                ),
                viewHeaderStyle: ViewHeaderStyle(
                  dayTextStyle: TextStyle(
                    fontSize: 10,
                    color: Colors.white,
                    fontFamily: 'FashionFetish',
                    fontWeight: FontWeight.bold,
                    height: 1.3,
                  ),
                ),
                firstDayOfWeek: 1, // first day of the week should be monday
              ),
            ),
          ),
        ],
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
