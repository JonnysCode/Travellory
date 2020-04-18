import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/widgets/trip/schedule/public_transport_schedule.dart';

class PublicTransportBookings extends StatelessWidget {
  const PublicTransportBookings(this.publicTransport, {Key key}) : super(key: key);
  final PublicTransportModel publicTransport;

  @override
  Widget build(BuildContext context) {
    return Row(
      key: Key('publicTransportBookings'),
      children: <Widget>[
        Expanded(
          flex: 1,
          child: Entry(
            name: publicTransport.departureLocation,
            code: publicTransport.departureTime,
          ),
        ),
        Expanded(
          flex: 1,
          child: Center(
            child: Column(children: <Widget>[
              TransportIcon(model: publicTransport),
              Text(
                publicTransport.departureDate,
                style: TextStyle(
                  fontSize: 10.0,
                  color: Colors.white70,
                ),
              ),
            ]),
          ),
        ),
        Expanded(
          flex: 1,
          child: Entry(
            name: publicTransport.arrivalLocation,
            code: publicTransport.arrivalTime,
          ),
        ),
      ],
    );
  }
}

class TransportIcon extends StatelessWidget {
  const TransportIcon({
    @required this.model,
  });

  final PublicTransportModel model;

  IconData getIcon(String type) {
    IconData icon;

    if (type == 'Rail') {
      icon = FontAwesomeIcons.train;
    } else if (type == 'Bus') {
      icon = FontAwesomeIcons.train;
    } else if (type == 'Metro') {
      icon = FontAwesomeIcons.subway;
    } else if (type == 'Ferry') {
      icon = FontAwesomeIcons.ship;
    } else if (type == 'Taxi') {
      icon = FontAwesomeIcons.taxi;
    } else if (type == 'Uber') {
      icon = FontAwesomeIcons.carSide;
    } else {
      icon = FontAwesomeIcons.walking;
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return FaIcon(
      getIcon(model.transportationType),
      size: 30,
      color: Colors.black54,
    );
  }
}
