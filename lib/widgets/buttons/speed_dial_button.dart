import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'dart:math' as math;

class SpeedDialButton extends StatefulWidget {

  const SpeedDialButton({
    Key key,
    this.dials,
  }) : super(key: key);

  final List<Dial> dials;

  @override
  _SpeedDialButtonState createState() => _SpeedDialButtonState();
}

class _SpeedDialButtonState extends State<SpeedDialButton> with SingleTickerProviderStateMixin{
  AnimationController _controller;
  bool _isPressed = false;

  _toggleFloatingButton() {
    _controller.isDismissed
        ? _controller.forward()
        : _controller.reverse();
    setState(() {
      _isPressed = !_isPressed;
    });
  }

  @override
  void initState() {
    _controller = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 200),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _dials = widget.dials;

    return Stack(
      children: <Widget>[
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
            children: List.generate(_dials.length, (int index) {
              Widget child = Container(
                height: 66.0,
                width: 56.0,
                alignment: FractionalOffset.topCenter,
                child: ScaleTransition(
                  scale: CurvedAnimation(
                    parent: _controller,
                    curve: Interval(
                        0.0,
                        1.0 - index / _dials.length / 2.0,
                        curve: Curves.easeOut
                    ),
                  ),
                  child: FloatingActionButton(
                    backgroundColor: Colors.white,
                    mini: true,
                    child: FaIcon(
                        _dials[index].icon,
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
    );
  }
}

class Dial {
  const Dial({
    @required this.icon,
    @required this.description
  });

  final IconData icon;
  final String description;
}