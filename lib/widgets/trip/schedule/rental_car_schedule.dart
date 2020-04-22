import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/widgets/font_widgets.dart';

class RentalCarSchedule extends StatelessWidget {
  const RentalCarSchedule(this.rentalCar, {Key key}) : super(key : key);
  final RentalCarModel rentalCar;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: Key('rental_car'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 16),
          child: FaIcon(
            FontAwesomeIcons.carSide,
            size: 28,
            color: Colors.black54,
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FashionFetishText(
              text: 'Pick up your car here:',
              size: 16,
              fontWeight: FashionFontWeight.heavy,
              height: 1.2,
              color: Colors.black54,
            ),
            SizedBox(height: 3),
            Row(
              children: <Widget>[
                FaIcon(
                  FontAwesomeIcons.locationArrow,
                  size: 14,
                  color: Colors.white70,
                ),
                SizedBox(width: 6),
                Text(
                  rentalCar.pickupLocation,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}