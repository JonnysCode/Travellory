import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/widgets/font_widgets.dart';

class AccommodationSchedule extends StatelessWidget {
  final AccommodationModel _accommodationModel = AccommodationModel()
    ..accommodationType = 'hotel'
    ..hotelName = 'Novotel Suites'
    ..address = 'Bluff Street 102, 28343 Los Angeles'
    ..checkinTime = '13:00';

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(12.0),
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
                color: Colors.black54,
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                FashionFetishText(
                  text: _accommodationModel.hotelName,
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
                      _accommodationModel.address,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 2),
                Text(
                  'Check in: ${_accommodationModel.checkinTime}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
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
