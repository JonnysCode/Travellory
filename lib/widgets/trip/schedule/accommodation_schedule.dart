import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/widgets/font_widgets.dart';

class AccommodationSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Color(0xFFeff5f7),
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(.1), offset: Offset(0.0, 6.0))
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(6.0),
        child: Row(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 16),
              child: FaIcon(
                FontAwesomeIcons.bed,
                size: 28,
                color: Colors.blueGrey,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FashionFetishText(
                  text: 'Novotel Suites',
                  size: 13,
                  fontWeight: FashionFontWeight.HEAVY,
                  height: 1.2,
                ),
                SizedBox(height: 2),
                Row(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.locationArrow,
                      size: 12,
                      color: Colors.redAccent,
                    ),
                    SizedBox(width: 4),
                    Text(
                      'Bluff Street 102',
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  'Check in: 13:00',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
