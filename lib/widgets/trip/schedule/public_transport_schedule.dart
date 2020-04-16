import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/trip/schedule/schedule_card.dart';



class PublicTransportSchedule extends StatelessWidget {

  final PublicTransportModel _publicTransportModel = PublicTransportModel()
    ..transportationType = 'train'
    ..departureLocation = 'Los Angeles'
    ..departureTime = '13:35'
    ..arrivalLocation = 'Las Vegas'
    ..arrivalTime = '15:40';

  @override
  Widget build(BuildContext context) {
    return ScheduleCard(
      color: Colors.teal,
      onTab: (){},
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 1,
            child: _Entry(
              name: _publicTransportModel.departureLocation,
              code: _publicTransportModel.departureTime,
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
            child: _Entry(
              name: _publicTransportModel.arrivalLocation,
              code: _publicTransportModel.arrivalTime,
            ),
          ),
        ],
      ),
    );
  }
}

class _Entry extends StatelessWidget {
  const _Entry({
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