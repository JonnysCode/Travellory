import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/screens/trip/schedule/trip_schedule.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'dart:math' as math;

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with SingleTickerProviderStateMixin{
  static const List<IconData> _icons = <IconData>[
    FontAwesomeIcons.theaterMasks,
    FontAwesomeIcons.car,
    FontAwesomeIcons.bed,
    FontAwesomeIcons.plane,
  ];
  AnimationController _controller;
  bool _isPressed = false;

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 200),
    );
    //_isPressed = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        key: Key('home_page'),
        child: Stack(
          children: <Widget>[
            Positioned(
              left: 30,
              top: 30,
              child: Image(
                height: 100,
                image: AssetImage('assets/images/home/011-cloud.png'),
              ),
            ),
            Positioned(
              top: 100,
              left: 110,
              child: FashionFetishText(
                text: '24\u00B0',
                size: 24,
                color: Colors.black87,
                fontWeight: FashionFontWeight.BOLD,
              ),
            ),
            Positioned(
              top: 40,
              left: 175,
              right: 20,
              child: Container(
                child: FashionFetishText(
                  text: 'Get ready Bill!',
                  size: 24,
                  fontWeight: FashionFontWeight.HEAVY,
                  height: 1.2,
                ),
              ),
            ),
            Positioned(
              top: 75,
              left: 175,
              right: 40,
              child: Container(
                child: Text(
                  "Your trip to Los Angeles starts in 1 day. Pack your luggage now.",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black54,
                  ),
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 6.0),
                child: Container(
                  height: MediaQuery.of(context).size.height*0.8,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.symmetric(horizontal: 6.0),
                  decoration: BoxDecoration(
                    color: Colors.white,//Color(0xFFeff5f7),
                    borderRadius: BorderRadius.vertical(top: Radius.circular(40.0)),
                    boxShadow: [
                      BoxShadow(blurRadius: 18, color: Colors.black.withOpacity(.2), offset: Offset(0.0, -6.0))
                    ],
                  ),
                  child: Schedule(),
                ),
              ),
            ),
            Positioned(
              left: 0,
              bottom: 0,
              child: GestureDetector(
                onTap: () => _toggleFloatingButton(),
                child: AnimatedContainer(
                  width: MediaQuery.of(context).size.width,
                  height: _isPressed ? MediaQuery.of(context).size.height : 0,
                  duration: Duration(milliseconds: 100),
                  color: Colors.black54,
                ),
              ),
            ),
            Positioned(
              right: 8,
              bottom: 52,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(_icons.length, (int index) {
                  Widget child = Container(
                    height: 66.0,
                    width: 56.0,
                    alignment: FractionalOffset.topCenter,
                    child: ScaleTransition(
                      scale: CurvedAnimation(
                        parent: _controller,
                        curve: Interval(
                            0.0,
                            1.0 - index / _icons.length / 2.0,
                            curve: Curves.easeOut
                        ),
                      ),
                      child: FloatingActionButton(
                        backgroundColor: Colors.white,
                        mini: true,
                        child: FaIcon(
                            _icons[index],
                            color: Colors.black54
                        ),
                        onPressed: () {}, // TODO: Open Add bookings for current trip
                      ),
                    ),
                  );
                  return child;
                }).toList()..add(
                  FloatingActionButton(
                    child: AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, Widget child) {
                        return Transform(
                          transform: Matrix4.rotationZ(_controller.value * 0.75 * math.pi),
                          alignment: FractionalOffset.center,
                          child: FaIcon(FontAwesomeIcons.plus),
                        );
                      },
                    ),
                    onPressed: () => _toggleFloatingButton(),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _toggleFloatingButton() {
    _controller.isDismissed
        ? _controller.forward()
        : _controller.reverse();
    setState(() {
      _isPressed = !_isPressed;
    });
  }
}
