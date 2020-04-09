import 'package:flutter/material.dart';
import 'package:travellory/widgets/font_widgets.dart';

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
  static const days = <String>['MO', 'TU', 'WE', 'TH', 'FR', 'SA', 'SU'];
  static const colors = <Color>[
    Colors.amber,
    Colors.orange,
    Colors.redAccent,
    Colors.pink,
    Colors.deepPurpleAccent,
    Colors.blueAccent,
    Colors.green
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 48,
      width: 48,
      decoration: BoxDecoration(
        color: colors[0],
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
            text: days[widget.day-1],
            color: Colors.white,
            textAlign: TextAlign.center,
            size: 22,
            fontWeight: FashionFontWeight.bold,
          ),
        ),
      ),
    );
  }
}