import 'package:flutter/material.dart';
import 'package:travellory/models/day_model.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/trip/schedule/accommodation_schedule.dart';
import 'package:travellory/widgets/trip/schedule/day_circle.dart';
import 'package:travellory/widgets/trip/schedule/flight_schedule.dart';
import 'package:travellory/widgets/trip/schedule/public_transport_schedule.dart';
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

  List<Widget> bookings = <Widget>[
    FlightSchedule(),
    RentalCarSchedule(),
    AccommodationSchedule(),
    PublicTransportSchedule(),
  ];

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.isExpanded;
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 200),
    )
      ..forward();

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
                  text: toShortenedMonthDateFrom(widget.day.dateString),
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: bookings.map((booking) => Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: booking,
                        )).toList(),
                      ),
                    ),
                  )
                ],
              ),
            ),
      ],
    );
  }

  void _toggleExpanded() async {
    setState(() {
      _isExpanded = !_isExpanded;
      _isExpanded
          ? _controller.forward()
          : _controller.reverse();
    });
  }
}


