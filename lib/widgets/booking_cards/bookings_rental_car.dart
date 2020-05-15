import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/widgets/font_widgets.dart';

class RentalCarBookings extends StatelessWidget {
  const RentalCarBookings(this.rentalCar, {Key key}) : super(key: key);
  final RentalCarModel rentalCar;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: Key('rentalCarBookings'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 16),
          child: FaIcon(
            FontAwesomeIcons.carSide,
            size: 28,
            color: Colors.brown[600],
          ),
        ),
        Expanded(
          flex: 2,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
            FashionFetishText(
              text: 'Rental Car',
              size: 16,
              fontWeight: FashionFontWeight.heavy,
              height: 1.2,
              color: Colors.brown[600],
            ),
            SizedBox(height: 2),
            Row(children: <Widget>[
              FaIcon(
                FontAwesomeIcons.locationArrow,
                size: 12,
                color: Colors.white70,
              ),
              SizedBox(width: 6),
              Text(
                'Pick Up Location: ',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[800],
                ),
              ),
            ]),
            Row(children: <Widget>[
              // for same indentations as the line above
              FaIcon(
                FontAwesomeIcons.locationArrow,
                size: 14,
                color: Colors.transparent,
              ),
              SizedBox(width: 6),
              Expanded(
                child: Text(
                rentalCar.pickupLocation,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[800],
                ),
              ),
              ),
            ]),
          ]),
        ),
        Expanded(
          flex: 1,
          child: Column(
            children: <Widget>[
              SizedBox(height: 21),
              Text(
                'Pick Up Date: ${rentalCar.pickupDate}',
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey[800],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
