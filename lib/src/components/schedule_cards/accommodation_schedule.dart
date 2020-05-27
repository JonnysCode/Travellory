import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/src/models/accommodation_model.dart';
import 'package:travellory/src/models/schedule_entry.dart';
import 'package:travellory/src/components/booking_cards/bookings_card_specifics.dart';
import 'package:travellory/src/components/shared/font_widgets.dart';

class AccommodationSchedule extends StatelessWidget {
  const AccommodationSchedule(this.scheduleEntry, {Key key}) : super(key: key);

  final ScheduleEntry scheduleEntry;

  @override
  Widget build(BuildContext context) {
    final AccommodationModel accommodation = scheduleEntry.booking;
    final DayType dayType = scheduleEntry.dayType;

    return Row(
      key: Key('accommodation'),
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 16),
          child: AccommodationIcon(model: accommodation),
        ),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FashionFetishText(
                text: accommodation.name,
                size: 13,
                fontWeight: FashionFontWeight.heavy,
                height: 1.2,
                color: Colors.black54,
              ),
              SizedBox(height: 2),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  FaIcon(
                    FontAwesomeIcons.locationArrow,
                    size: 12,
                    color: Colors.white70,
                  ),
                  SizedBox(width: 4),
                  Flexible(
                    fit: FlexFit.loose,
                    child: Text(
                      accommodation.address,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 12,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 2),
              if (dayType == DayType.first && accommodation.checkinTime.isNotEmpty)
                Text(
                  'Check in: ${accommodation.checkinTime}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
              if (dayType == DayType.last && accommodation.checkoutTime.isNotEmpty)
                Text(
                  'Check out: ${accommodation.checkoutTime}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black54,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
