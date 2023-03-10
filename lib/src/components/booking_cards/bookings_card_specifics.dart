import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/src/models/accommodation_model.dart';
import 'package:travellory/src/models/public_transport_model.dart';
import '../shared/font_widgets.dart';

class AccommodationIcon extends StatelessWidget {
  const AccommodationIcon({
    @required this.model,
  });

  final AccommodationModel model;

  IconData getIcon(String type) {
    IconData icon;

    if (type == 'Hotel') {
      icon = FontAwesomeIcons.hotel;
    } else if (type == 'Airbnb') {
      icon = FontAwesomeIcons.suitcase;
    } else if (type == 'Bed & Breakfast') {
      icon = FontAwesomeIcons.coffee;
    } else {
      icon = FontAwesomeIcons.bed;
    }
    return icon;
  }

  @override
  Widget build(BuildContext context) {
    return FaIcon(
      getIcon(model.type),
      size: 30,
      color: Colors.black54,
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

class Airport extends StatelessWidget {
  const Airport({
    @required this.name,
    @required this.code,
    @required this.color,
  });

  final String name;
  final String code;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FashionFetishText(
          text: code,
          size: 24,
          fontWeight: FashionFontWeight.bold,
          height: 1.1,
          color: Colors.black54,
        ),
        Text(
          name,
          style: TextStyle(
            fontSize: 11,
            color: color,
          ),
        ),
      ],
    );
  }
}

class PublicTransportEntry extends StatelessWidget {
  const PublicTransportEntry({
    @required this.location,
    @required this.time,
  });

  final String location;
  final String time;

  @override
  Widget build(BuildContext context) {
    String displayLocation = location;
    String displayTime = time;

    if (location.isEmpty) {
      displayLocation = 'No location known';
    }

    if (time.isEmpty) {
      displayTime = '?:??';
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        FashionFetishText(
          text: displayTime,
          size: 16,
          fontWeight: FashionFontWeight.bold,
          height: 1.1,
          color: Colors.black54,
        ),
        Text(
          displayLocation,
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            fontSize: 14,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }
}
