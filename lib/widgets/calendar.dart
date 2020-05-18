import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'package:syncfusion_flutter_core/core.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/utils/date_handler.dart';

class Calendar extends StatefulWidget {
  @override
  _CalendarState createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  static const Color tripColor = Colors.orangeAccent;
  final DateTime today = DateTime.now();

  CalendarController _calendarController;

  List<Meeting> _getDataSource(List<TripModel> trips) {
    final meetings = <Meeting>[];
    for(final trip in trips){
      final Meeting meeting = Meeting(trip.name, getDateTimeFrom(trip.startDate),
          getDateTimeFrom(trip.endDate), tripColor, isAllDay: true);
      meetings.add(meeting);
    }

    return meetings;
  }

  @override
  void initState() {
    _calendarController = CalendarController();
    _calendarController.displayDate = DateTime.now();
    super.initState();
  }

  @override
  void dispose() {
    _calendarController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Community license for the calendar
    SyncfusionLicense.registerLicense(
        "NT8mJyc2IWhia31ifWN9Z2FoYmF8YGJ8ampqanNiYmlmamlmanMDHmg5PD0yJzsyPTQhJiAgEzs8Jz4yOj99MDw+");

    final TripsProvider tripsProvider = Provider.of<TripsProvider>(context);

    return Row(
      children: <Widget>[
        SizedBox(
          width: 40,
          child: Center(
            child: IconButton(
              iconSize: 32,
              color: Colors.black12,
              icon: FaIcon(FontAwesomeIcons.chevronLeft),
              onPressed: () => _calendarController.backward(),
            ),
          ),
        ),
        Expanded(
          child: Container(
            key: Key('calendar_page'),
            height: MediaQuery.of(context).size.height*0.4,
            width: MediaQuery.of(context).size.width - 60,
            child: SfCalendar(
              key: Key('yearly_calendar'),
              controller: _calendarController,
              view: CalendarView.month,
              cellBorderColor: Colors.transparent,
              backgroundColor: Colors.transparent,
              todayHighlightColor: Colors.black54,
              initialDisplayDate: DateTime.utc(today.year, today.month, 1),
              dataSource: MeetingDataSource(_getDataSource(
                  tripsProvider.trips.map((trip) => trip.tripModel).toList()
              )),
              selectionDecoration: BoxDecoration(
                color: Colors.black12,
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(blurRadius: 2, color: Colors.black.withOpacity(.1), offset: Offset(0.0, 0.0))
                ],
              ),
              headerStyle: CalendarHeaderStyle(
                textAlign: TextAlign.left,
                backgroundColor: Colors.transparent,
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
          ),
        ),
        SizedBox(
          width: 40,
          child: Center(
            child: IconButton(
              iconSize: 32,
              color: Colors.black12,
              icon: FaIcon(FontAwesomeIcons.chevronRight),
              onPressed: () => _calendarController.forward(),
            ),
          ),
        ),
      ],
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
  Meeting(this.eventName, this.from, this.to, this.background, {this.isAllDay});

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
}
