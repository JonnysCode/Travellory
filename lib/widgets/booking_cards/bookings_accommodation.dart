import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/widgets/font_widgets.dart';

import 'bookings_card_specifics.dart';

class AccommodationBookings extends StatelessWidget {
  const AccommodationBookings(this.accommodation, {Key key}) : super(key: key);
  final AccommodationModel accommodation;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: Key('accommodationBookings'),
      children: <Widget>[
        Padding(
            padding: const EdgeInsets.only(left: 10, right: 16),
            child: AccommodationIcon(model: accommodation)),
        Expanded(
          flex: 2,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            FashionFetishText(
              text: accommodation.name,
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
                Expanded(
                  child: Text(
                    accommodation.address,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey[800],
                    ),
                  ),
                ),
              ],
            ),
          ]),
        ),
        Expanded(
          flex: 1,
          child: Column(children: [
            Text(
              'Check-In Date: ${accommodation.checkinDate}',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[800],
              ),
            ),
          ]),
        ),
      ],
    );
  }
}
