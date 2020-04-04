import 'package:flutter/material.dart';
import 'package:travellory/models/day_model.dart';
import 'package:travellory/widgets/font_widgets.dart';

class DaySchedule extends StatefulWidget {
  const DaySchedule({
    Key key,
    @required this.expanded,
    @required this.day,
  }) : super(key: key);

  final bool expanded;
  final Day day;

  @override
  _DayScheduleState createState() => _DayScheduleState();
}

class _DayScheduleState extends State<DaySchedule> with SingleTickerProviderStateMixin{
  bool _expanded;
  AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _expanded = widget.expanded;
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 200),
    );
    if(_expanded) _controller.forward();
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
              DayCircle(day: 'MO'),
            ],
          ),
        ),
        !_expanded
            ? SizedBox()
            : Container(
              color: Colors.blue,
              height: 300,
              child: Row(
                children: <Widget>[
                  Container(
                    width: 40,
                  ),
                  Expanded(
                    child: ListView.separated(
                      itemCount: 6,
                      itemBuilder: (context, index) {
                        return Container(
                          height: 50,
                          color: Colors.red,
                        );
                      },
                      separatorBuilder: (context, index) => const SizedBox(height: 12),
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }

  _toggleExpanded() {
    setState(() {
      _expanded = !_expanded;
      _expanded
          ? _controller.forward()
          : _controller.reverse();
    });
  }
}

class DayCircle extends StatefulWidget {
  const DayCircle({Key key, @required this.day}) : super(key: key);

  final String day;

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
        color: Colors.amber,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(blurRadius: 4, color: Colors.black.withOpacity(.3), offset: Offset(2.0, 2.0))
        ],
      ),
      child: Align(
        alignment: Alignment.topCenter,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 14, 10, 0),
          child: FashionFetishText(
            text: widget.day,
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
