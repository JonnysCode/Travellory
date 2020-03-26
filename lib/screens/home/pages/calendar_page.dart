import 'package:flutter/cupertino.dart';
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
    SyncfusionLicense.registerLicense(
        "NT8mJyc2IWhiZH1nfWN9Z2VoZ3xhYXxhY2Fjc2JhaWBiaWZicwMeaDI9Jzo/KjIgEyAnJjc2PScgfSk7MiR9MDs=");

    return Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 30.0, 10.0, 90.0),
      child: Column(
        children: <Widget>[
          Container(
            height: 10,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(10.0)),
              color: Color(0xFFF7C852),
              ),
          ),
          Expanded(
            child: Container(
              key: Key('calendar_page'),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.vertical(bottom: Radius.circular(40.0)),
                color: Colors.white,
                boxShadow: [BoxShadow(blurRadius: 3, color: Colors.black.withOpacity(.15), offset: Offset(3.0, 3.0))],
              ),
              child: SfCalendar(
                key: Key('yearly_calendar'),
                view: CalendarView.month,
                todayHighlightColor: Colors.black.withOpacity(0.5),
                initialDisplayDate: DateTime.utc(today.year, today.month, 1),
                dataSource: MeetingDataSource(_getDataSource()),
                selectionDecoration: BoxDecoration(
                  color: Theme.of(context).primaryColor.withOpacity(0.3),
                  border: Border.all(color: Colors.transparent, width: 1),
                  borderRadius: const BorderRadius.all(Radius.circular(4)),
                  shape: BoxShape.rectangle,
                ),
                headerStyle: CalendarHeaderStyle(
                    textAlign: TextAlign.center,
                    backgroundColor: Color(0xFFF7C852),
                    textStyle: TextStyle(
                        fontFamily: 'FashionFetish',
                        fontSize: 25,
                        fontStyle: FontStyle.normal,
                        color: Colors.white,
                        fontWeight: FontWeight.w600
                    ),
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
                        fontFamily: 'FashionFetish',
                        fontSize: 14,
                        height: 1.2,
                        color: Colors.black
                    ),
                    dateTextStyle: TextStyle(
                        fontFamily: 'FashionFetish',
                        fontSize: 15,
                        height: 1.3,
                        fontWeight: FontWeight.w400,
                        color: Colors.black),
                    dayTextStyle: TextStyle(
                        fontFamily: 'FashionFetish',
                        fontStyle: FontStyle.normal,
                        fontSize: 18,
                        height: 1.2,
                        fontWeight: FontWeight.w600,
                        color: Colors.black),
                  ),
                  monthCellStyle: MonthCellStyle(
                      trailingDatesBackgroundColor: Colors.white30,
                      todayTextStyle: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Arial'
                      )
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
