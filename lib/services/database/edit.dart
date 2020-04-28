import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import '../../logger.dart';

final log = getLogger('Edit');

void editModel(Model model, BuildContext context) {
  String changeRoute = '';

  if (model is FlightModel) {
    changeRoute = '/edit/flight';
  } else if (model is RentalCarModel) {
    changeRoute = '/edit/rentalcar';
  } else if (model is AccommodationModel) {
    changeRoute = '/edit/accommodation';
  } else if (model is PublicTransportModel) {
    changeRoute = '/edit/publictransport';
  } else if (model is ActivityModel) {
    changeRoute = '/edit/activity';
  } else {
    log.w('No edit page was found for model');
  }

  Navigator.pushNamed(context, changeRoute, arguments: model);
}
