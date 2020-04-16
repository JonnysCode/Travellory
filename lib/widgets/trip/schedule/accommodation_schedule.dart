import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/widgets/font_widgets.dart';

class AccommodationSchedule extends StatelessWidget {
  const AccommodationSchedule(this.accommodation, {Key key}) : super(key : key);
  final AccommodationModel accommodation;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 16),
          child: FaIcon(
            FontAwesomeIcons.bed,
            size: 28,
            color: Colors.black54,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FashionFetishText(
              text: accommodation.hotelName,
              size: 13,
              fontWeight: FashionFontWeight.heavy,
              height: 1.2,
              color: Colors.black54,
            ),
            SizedBox(height: 2),
            Row(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.locationArrow,
                  size: 12,
                  color: Colors.white70,
                ),
                SizedBox(width: 4),
                Text(
                  accommodation.address,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
            SizedBox(height: 2),
            Text(
              'Check in: ${accommodation.checkinTime}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.white70,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
