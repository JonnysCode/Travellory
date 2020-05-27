import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/src/models/rental_car_model.dart';
import 'package:travellory/src/models/schedule_entry.dart';
import 'package:travellory/src/components/shared/font_widgets.dart';

class RentalCarSchedule extends StatelessWidget {
  const RentalCarSchedule(this.scheduleEntry, {Key key}) : super(key: key);

  final ScheduleEntry scheduleEntry;

  @override
  Widget build(BuildContext context) {
    final RentalCarModel rentalCar = scheduleEntry.booking;
    final DayType dayType = scheduleEntry.dayType;

    Widget firstDay() => 
        Expanded(
          child: Column(
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
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.locationArrow,
                    size: 14,
                    color: Colors.white70,
                  ),
                  SizedBox(width: 6),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      rentalCar.pickupLocation,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );

    Widget middleDay() => FashionFetishText(
          text: 'You have a car today',
          size: 16,
          fontWeight: FashionFontWeight.heavy,
          height: 1.2,
          color: Colors.black54,
        );

    Widget lastDay() => Expanded(
      child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FashionFetishText(
                text: rentalCar.returnLocation.isEmpty ? 'Return your car' : 'Return your car here:',
                size: 16,
                fontWeight: FashionFontWeight.heavy,
                height: 1.2,
                color: Colors.black54,
              ),
              SizedBox(height: 3),
              if (rentalCar.returnLocation.isNotEmpty)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    FaIcon(
                      FontAwesomeIcons.locationArrow,
                      size: 14,
                      color: Colors.white70,
                    ),
                    SizedBox(width: 6),
                    Flexible(
                      fit: FlexFit.loose,
                      child: Text(
                        rentalCar.returnLocation,
                        overflow: TextOverflow.ellipsis,
                        maxLines: 2,
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
            ],
          ),
    );

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
        if (dayType == DayType.first || dayType == DayType.single) firstDay(),
        if (dayType == DayType.middle) middleDay(),
        if (dayType == DayType.last) lastDay(),
      ],
    );
  }
}
