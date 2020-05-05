import 'dart:math' as math;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


class SpeedDialButton extends StatefulWidget {
  const SpeedDialButton({
    Key key,
    this.dials
  }) : super(key: key);

  final List<Dial> dials;

  @override
  _SpeedDialButtonState createState() => _SpeedDialButtonState();
}

class _SpeedDialButtonState extends State<SpeedDialButton> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  bool _isPressed = false;

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
    final _dials = widget.dials;

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
          bottom: 54,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(_dials.length, (int index) {
              final Widget dial = _dial(index, _dials);
              return dial;
            }).toList()
              ..add(
                FloatingActionButton(
                  heroTag: 'trip_image',
                  key: Key('dial_button'),
                  highlightElevation: 3.0,
                  onPressed: () => _toggleFloatingButton(),
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
                ),
              ),
          ),
        ),
      ],
    );
  }

  void _toggleFloatingButton() {
    _controller.isDismissed ? _controller.forward() : _controller.reverse();
    setState(() {
      _isPressed = !_isPressed;
    });
  }

  Widget _dial(int index, List<Dial> dials) => Container(
        height: 66.0,
        alignment: FractionalOffset.topCenter,
        child: ScaleTransition(
          scale: CurvedAnimation(
            parent: _controller,
            curve: Interval(0.0, 1.0 - index / dials.length / 2.0, curve: Curves.easeOut),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                  color: Colors.white54,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  dials[index].description,
                  style: TextStyle(
                    color: Colors.black87,
                  ),
                ),
              ),
              const SizedBox(width: 6),
              FloatingActionButton(
                heroTag: 'dial${index.toString()}',
                backgroundColor: Colors.white,
                mini: true,
                onPressed: dials[index].onTab,
                child: Icon(dials[index].icon, color: Colors.black54),
              ),
              const SizedBox(width: 6),
            ],
          ),
        ),
      );
}

class Dial {
  Dial({
    @required this.icon,
    @required this.description,
    @required this.onTab,
  });

  final IconData icon;
  final String description;
  final Function onTab;
}
