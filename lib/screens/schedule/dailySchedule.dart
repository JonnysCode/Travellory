import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';
import 'package:scrolling_day_calendar/scrolling_day_calendar.dart';

class DailySchedule extends StatefulWidget {
  final Function toggleView;

  DailySchedule({this.toggleView});

  @override
  _DailyScheduleState createState() => _DailyScheduleState();
}

class _DailyScheduleState extends State<DailySchedule> {
  DateTime selectedDate = DateTime.now();
  DateTime startDate = DateTime.now().subtract(Duration(days: 10));
  DateTime endDate = DateTime.now().add(Duration(days: 10));
  Map<String, Widget> widgets = Map();
  String widgetKeyFormat = "yyyy-MM-dd";

  Future _signOut(BuildContext context) async {
    final BaseAuthService _auth = AuthProvider
        .of(context)
        .auth;
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        backgroundColor: Theme
            .of(context)
            .scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('travellory'),
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () => _signOut(context),
              icon: Icon(Icons.person),
              label: Text('logout'),
            )
          ],
        ),
        body: ScrollingDayCalendar(
          // this is the pass-in method
          startDate: startDate,
          endDate: endDate,
          selectedDate: selectedDate,
          dateStyle: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          displayDateFormat: "dd, MMM yyyy",
          dateBackgroundColor: Colors.grey,
          forwardIcon: Icons.arrow_forward,
          backwardIcon: Icons.arrow_back,
          pageChangeDuration: Duration(
            milliseconds: 700,
          ),
          widgets: widgets,
          widgetKeyFormat: widgetKeyFormat,
          noItemsWidget: Center(
            child: Text("No items have been added for this date"), // add buttons etc here to add new items for date
          ),
        ),
    );
  }
}