import 'package:flutter/material.dart';
import 'package:travellory/models/day_model.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/trip/schedule/accommodation_schedule.dart';
import 'package:travellory/widgets/trip/schedule/flight_schedule.dart';
import 'package:travellory/widgets/trip/schedule/rental_car_schedule.dart';

class DaySchedule extends StatefulWidget {
  const DaySchedule({
    Key key,
    @required this.isExpanded,
    @required this.day,
  }) : super(key: key);

  final bool isExpanded;
  final Day day;

  @override
  _DayScheduleState createState() => _DayScheduleState();
}

class _DayScheduleState extends State<DaySchedule> with SingleTickerProviderStateMixin{
  bool _isExpanded;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 200),
    );
    if(_isExpanded) _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          width: double.infinity,
          child: Stack(
            children: <Widget>[
              Positioned(
                left: 24,
                right: 0,
                top: 0,
                bottom: 0,
                child: Center(
                  child: Container(
                    height: 26,
                    decoration: BoxDecoration(
                      color: Color(0xBBCCD7DD),
                      borderRadius: BorderRadius.circular(13.0),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 20,
                right: 0,
                top: 22,
                child: FashionFetishText(
                  text: DateConverter.format(widget.day.dateString),
                  size: 14,
                  color: Colors.black38,
                  textAlign: TextAlign.center,
                ),
              ),
              Positioned(
                right: 8,
                top: 0,
                bottom: 0,
                child: GestureDetector(
                  onTap: () => _toggleExpanded(),
                  child: Center(
                    child: AnimatedIcon(
                      progress: _controller,
                      color: Colors.black54,
                      size: 20,
                      icon: AnimatedIcons.menu_close,
                    ),
                  ),
                ),
              ),
              DayCircle(day: widget.day.date.weekday),
            ],
          ),
        ),
        if (_isExpanded)
            Container(
              child: Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(23.5, 6, 12.5, 0),
                    child: Container(
                      width: 1,
                      color: Colors.black54,
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: Column(
                        children: <Widget>[
                          FlightSchedule(),
                          const Divider(),
                          RentalCarSchedule(),
                          const Divider(),
                          AccommodationSchedule(),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
      ],
    );
  }

  _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded
          ? _controller.forward()
          : _controller.reverse();
    });
  }

  List<Widget> _getBookings() {
    return [

    ];
  }
}


class DayCircle extends StatefulWidget {

  const DayCircle({Key key, @required this.day}) : super(key: key);

  final int day;

  @override
  _DayCircleState createState() => _DayCircleState();
}

class _DayCircleState extends State<DayCircle> {
  var _days = <String>['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.amber,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(blurRadius: 4, color: Colors.black.withOpacity(.3), offset: Offset(2.0, 2.0))
        ],
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(11, 14, 11, 0),
          child: FashionFetishText(
            text: _days[widget.day-1],
            color: Colors.white,
            textAlign: TextAlign.center,
            size: 22,
            fontWeight: FashionFontWeight.BOLD,
          ),
        ),
      ),
    );
  }
}
