import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/widgets/font_widgets.dart';

class FlightSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.blueGrey,
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(.2), offset: Offset(0.0, 6.0))
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Airport(
              name: 'Zürich',
              code: 'ZRH',
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                '9:30',
                style: TextStyle(
                    color: Colors.white54,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Transform.rotate(
                angle: -0.5,
                child: FaIcon(
                  FontAwesomeIcons.plane,
                  size: 30,
                  color: Colors.black54,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                '12:20',
                style: TextStyle(
                  color: Colors.white54,
                ),
              )
            ),
          ),
          Expanded(
            flex: 2,
            child: Airport(
              name: 'Los Angeles',
              code: 'LRX',
            ),
          ),
        ],
      ),
    );
  }
}

class Airport extends StatelessWidget {
  const Airport({
    @required this.name,
    @required this.code,
  });

  final String name;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FashionFetishText(
          text: code,
          size: 24,
          fontWeight: FashionFontWeight.bold,
          height: 1.1,
          color: Colors.black54,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 11,
            color: Colors.white54
          ),
        ),
      ],
    );
  }
}

