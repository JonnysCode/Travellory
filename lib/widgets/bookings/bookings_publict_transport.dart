import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:travellory/models/public_transport_model.dart';

import 'card_specifics.dart';

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
          child: PublicTransportEntry(
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
          child: PublicTransportEntry(
            name: publicTransport.arrivalLocation,
            code: publicTransport.arrivalTime,
          ),
        ),
      ],
    );
  }
}
