import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/widgets/font_widgets.dart';


class PublicTransportSchedule extends StatelessWidget {
  const PublicTransportSchedule(this.model, {Key key}) : super(key : key);
  final PublicTransportModel model;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: Key('public_transport'),
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Entry(
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
          child: Entry(
            name: model.arrivalLocation,
            code: model.arrivalTime,
          ),
        ),
      ],
    );
  }
}

class Entry extends StatelessWidget {
  const Entry({
    @required this.name,
    @required this.code,
  });

  final String name;
  final String code;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FashionFetishText(
          text: code,
          size: 19,
          fontWeight: FashionFontWeight.bold,
          height: 1.1,
          color: Colors.black54,
        ),
        Text(
          name,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}