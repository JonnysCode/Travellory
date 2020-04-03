import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:travellory/screens/trip/trip_list.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  static const _expandedListHeight = 0.95;
  static const _unexpandedListHeight = 0.58;
  final Color calendarBackgroundColor = Colors.red;
  final DateTime today = DateTime.now();

  bool _tripToggle;

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
  void initState() {
    _tripToggle = false;
    super.initState();
  }

  _toggleList(){
    setState(() {
      _tripToggle = !_tripToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    // this registers the license for the calendar
    // trial period until April 22, 2020
    SyncfusionLicense.registerLicense(
        "NT8mJyc2IWhiZH1nfWN9Z2VoZ3xhYXxhY2Fjc2JhaWBiaWZicwMeaDI9Jzo/KjIgEyAnJjc2PScgfSk7MiR9MDs=");

    return SafeArea(
      child: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: _calendar(),
            ),
          ),
          Positioned(
            left: 5,
            top: MediaQuery.of(context).size.height*0.22,
            child: IconButton(
              iconSize: 32,
              color: Colors.black12,
              icon: FaIcon(FontAwesomeIcons.chevronLeft),
              onPressed: () => {},// TODO: Change month in calendar
            ),
          ),
          Positioned(
            right: 5,
            top: MediaQuery.of(context).size.height*0.22,
            child: IconButton(
              iconSize: 32,
              color: Colors.black12,
              icon: FaIcon(FontAwesomeIcons.chevronRight),
              onPressed: () => {},// TODO: Change month in calendar
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
              height: MediaQuery.of(context).size.height*(_tripToggle ? 0.95 : 0.58),
              child: Stack(
                children: <Widget>[
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(18.0),
                          boxShadow: [
                            BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(.1), offset: Offset(0.0, -5.0))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding:  const EdgeInsets.only(top: 20, left: 6, right: 6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(.1), offset: Offset(0.0, -6.0))
                        ],
                      ),
                      child: TripList(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Container(
                        height: 40,
                        width: 40,
                        alignment: Alignment.topCenter,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topCenter,
                    child: IconButton(
                      tooltip: 'Expand',
                      iconSize: 32,
                      color: Colors.black38,
                      icon: FaIcon(
                          _tripToggle ? FontAwesomeIcons.angleDown : FontAwesomeIcons.angleUp
                      ),
                      onPressed: () => _toggleList(),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _calendar() {
    return Container(
      key: Key('calendar_page'),
      height: MediaQuery.of(context).size.height*0.4,
      width: 300,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(40.0)),
        color: Colors.transparent,
      ),
      child: SfCalendar(
        key: Key('yearly_calendar'),
        view: CalendarView.month,
        cellBorderColor: Colors.transparent,
        todayHighlightColor: Colors.black54,
        initialDisplayDate: DateTime.utc(today.year, today.month, 1),
        dataSource: MeetingDataSource(_getDataSource()),
        initialSelectedDate: today,
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
