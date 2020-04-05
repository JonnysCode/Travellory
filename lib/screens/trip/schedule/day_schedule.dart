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
  List<GlobalKey<_ItemFaderState>> keys;

  List<Widget> bookings = <Widget>[FlightSchedule(), RentalCarSchedule(), AccommodationSchedule()];

  @override
  void initState() {
    super.initState();

    keys = List.generate(
      bookings.length,
      (_) => GlobalKey<_ItemFaderState>(),
    );

    _isExpanded = widget.isExpanded;
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 200),
    );
    if(_isExpanded){
      _controller.forward();
      _showBookings();
    }
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
                      crossAxisAlignment: CrossAxisAlignment.start,
                        children: fadingBookings(),
                      ),
                    ),
                  )
                ],
              ),
            ),
      ],
    );
  }

  List<Widget> fadingBookings(){
    int index = 0;
    var fadingBookings = <Widget>[];

    for(Widget widget in bookings){
      fadingBookings.add(ItemFader(child: widget, key: keys[index]));
      if(index+1 < bookings.length){
        fadingBookings.add(const Divider());
      }
      index++;
    }
    return fadingBookings;
  }

  _toggleExpanded() async {
    if(_isExpanded){
      _hideBookings();
      _controller.reverse();
    }
    await Future.delayed(Duration(milliseconds: 260));
    setState(() {
      _isExpanded = !_isExpanded;
      if(_isExpanded){
        _controller.forward();
        _showBookings();
      }
    });
  }

  Future _hideBookings() async {
    for (GlobalKey<_ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState.hide();
    }
  }

  void _showBookings() async {
    for (GlobalKey<_ItemFaderState> key in keys) {
      await Future.delayed(Duration(milliseconds: 40));
      key.currentState.show();
    }
  }

}


class DayCircle extends StatefulWidget {

  const DayCircle({
    Key key,
    @required this.day
  }) : super(key: key);

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

class ItemFader extends StatefulWidget {
  final Widget child;

  const ItemFader({Key key, @required this.child}) : super(key: key);

  @override
  _ItemFaderState createState() => _ItemFaderState();
}

class _ItemFaderState extends State<ItemFader>
    with SingleTickerProviderStateMixin {
  //1 means its below, -1 means its above
  int position = 1;
  AnimationController _animationController;
  Animation _animation;

  void show() {
    setState(() => position = -1);
    _animationController.forward();
  }

  void hide() {
    setState(() => position = -1);
    _animationController.reverse();
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 200),
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, 32 * position * (1 - _animation.value)),
          child: Opacity(
            opacity: _animation.value,
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
