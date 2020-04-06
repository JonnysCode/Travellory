import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/widgets/font_widgets.dart';

class RentalCarSchedule extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
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
                FontAwesomeIcons.carSide,
                size: 28,
                color: Colors.green,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FashionFetishText(
                  text: 'Pick up your car here:',
                  size: 16,
                  fontWeight: FashionFontWeight.HEAVY,
                  height: 1.2,
                ),
                SizedBox(height: 3),
                Row(
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.locationArrow,
                      size: 14,
                      color: Colors.redAccent,
                    ),
                    SizedBox(width: 6),
                    Text(
                      'Los Angeles Airport',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}