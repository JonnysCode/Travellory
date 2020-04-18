import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/widgets/bookings/card_specifics.dart';

class PublicTransportSchedule extends StatelessWidget {
  const PublicTransportSchedule(this.model, {Key key}) : super(key: key);
  final PublicTransportModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: Key('public_transport'),
      children: <Widget>[
        Expanded(
          flex: 1,
          child: PublicTransportEntry(
            name: model.departureLocation,
            code: model.departureTime,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: FaIcon(
              FontAwesomeIcons.train,
              size: 30,
              color: Colors.black54,
            ),
          ),
        ),
        Expanded(
          flex: 1,
          child: PublicTransportEntry(
            name: model.arrivalLocation,
            code: model.arrivalTime,
          ),
        ),
      ],
    );
  }
}
