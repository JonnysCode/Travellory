import 'package:flutter/material.dart';
import 'package:travellory/widgets/font_widgets.dart';

class Schedule extends StatefulWidget {
  @override
  _ScheduleState createState() => _ScheduleState();
}

class _ScheduleState extends State<Schedule> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Stack(
        children: <Widget>[
          Container(
            width: 50,
            height: 400,
            color: Colors.yellow.withOpacity(0.0),
            child: Column(
              children: <Widget>[
                SizedBox(height: 20),
                DayCircle(day: 'MO'),
                Container(
                  height: 16,
                  width: 16,
                  decoration: BoxDecoration(
                    color: Colors.black,
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                ),
                Expanded(
                  child: Container(
                    width: 2,
                    color: Colors.black,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 50,
            right: 0,
            top: 0,
            child: Container(
              height: 600,
            ),
          ),
        ],
      ),
    );
  }
}

class DayCircle extends StatefulWidget {
  final String day;

  const DayCircle({Key key, @required this.day}) : super(key: key);
  @override
  _DayCircleState createState() => _DayCircleState();
}

class _DayCircleState extends State<DayCircle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: Colors.black12,
        //border: Border.all(width: 2.0),
        borderRadius: BorderRadius.circular(25.0),
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 12, 10, 0),
          child: FashionFetishText(
            text: widget.day,
            textAlign: TextAlign.center,
            size: 24,
            fontWeight: FashionFontWeight.BOLD,
          ),
        ),
      ),
    );
  }
}



