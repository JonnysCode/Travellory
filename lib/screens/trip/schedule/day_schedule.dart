import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/day_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/trip/schedule/booking_card.dart';
import 'package:travellory/widgets/trip/schedule/day_circle.dart';

final PublicTransportModel _publicTransport = PublicTransportModel()
  ..transportationType = 'train'
  ..departureLocation = 'Los Angeles'
  ..departureTime = '13:35'
  ..arrivalLocation = 'Las Vegas'
  ..arrivalTime = '15:40';

final AccommodationModel _accommodation = AccommodationModel()
  ..accommodationType = 'hotel'
  ..hotelName = 'Novotel Suites'
  ..address = 'Bluff Street 102, 28343 Los Angeles'
  ..checkinTime = '13:00';

final ActivityModel _activity = ActivityModel()
  ..description = 'Surfing Class'
  ..location = 'Long Beach'
  ..startTime = '14:00'
  ..endTime = '18:00';

final FlightModel _flight = FlightModel()
  ..departureLocation = 'Zürich'
  ..departureTime = '9:30'
  ..arrivalLocation = 'Los Angeles'
  ..arrivalTime = '12:20';

final RentalCarModel _rentalCar = RentalCarModel()
  ..pickupLocation = 'Los Angeles Airport';

List<Model> _models = <Model>[
  _rentalCar,
  _flight,
  _publicTransport,
  _accommodation,
  _activity,
];


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

  List<Widget> bookings = _models.map((model) => BookingCard(
    model: model,
  )).toList();

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


