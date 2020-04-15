import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/widgets/font_widgets.dart';

class PublicTransportSchedule extends StatelessWidget {
  final PublicTransportModel _publicTransportModel = PublicTransportModel()
  ..transportationType = 'train'
  ..departureLocation = 'Winterthur'
  ..departureTime = '13:31'
  ..arrivalLocation = 'Dozwil'
  ..arrivalTime = '14:18';

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(6.0),
      decoration: BoxDecoration(
        color: Colors.teal,
        borderRadius: BorderRadius.circular(16.0),
        boxShadow: [
          BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(.2), offset: Offset(0.0, 6.0))
        ],
      ),
      child: Row(
        children: <Widget>[
          Expanded(
            flex: 2,
            child: Airport(
              name: _publicTransportModel.departureLocation,
              code: _publicTransportModel.departureTime,
            ),
          ),
          Expanded(
            flex: 1,
            child: Center(
              child: Text(
                '',
                style: TextStyle(
                  color: Colors.white54,
                ),
              ),
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
            child: Center(
                child: Text(
                  '',
                  style: TextStyle(
                    color: Colors.white54,
                  ),
                )
            ),
          ),
          Expanded(
            flex: 2,
            child: Airport(
              name: _publicTransportModel.arrivalLocation,
              code: _publicTransportModel.arrivalTime,
            ),
          ),
        ],
      ),
    );
  }
}

class Airport extends StatelessWidget {
  const Airport({
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
          style: TextStyle(
              fontSize: 14,
              color: Colors.white70
          ),
        ),
      ],
    );
  }
}