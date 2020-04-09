import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/widgets/trip/trip_list.dart';
import 'package:travellory/widgets/calendar.dart';

class CalendarPage extends StatefulWidget {
  @override
  _CalendarPageState createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {

  bool _tripToggle;

  @override
  void initState() {
    _tripToggle = false;
    super.initState();
  }

  void _toggleList() {
    setState(() {
      _tripToggle = !_tripToggle;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Container(
                height: MediaQuery.of(context).size.height*0.4,
                width: MediaQuery.of(context).size.width,
                child: Calendar(),
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: AnimatedContainer(
              duration: Duration(milliseconds: 200),
              curve: Curves.ease,
              height: MediaQuery
                  .of(context)
                  .size
                  .height * (_tripToggle ? 0.95 : 0.58),
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
                            BoxShadow(blurRadius: 18,
                                color: Colors.black.withOpacity(.2),
                                offset: Offset(0.0, -5.0))
                          ],
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20, left: 6, right: 6),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.vertical(
                            top: Radius.circular(40.0)),
                        boxShadow: [
                          BoxShadow(blurRadius: 18, color: Colors.black
                              .withOpacity(.2), offset: Offset(0.0, -6.0))
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
                          _tripToggle
                              ? FontAwesomeIcons.angleDown
                              : FontAwesomeIcons.angleUp
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
}
