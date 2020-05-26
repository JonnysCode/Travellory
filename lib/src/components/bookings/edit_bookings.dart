import 'package:flutter/material.dart';
import 'package:travellory/src/components/bookings/new_booking_models.dart';
import 'package:travellory/src/models/abstract_model.dart';
import 'package:travellory/src/models/accommodation_model.dart';
import 'package:travellory/src/models/activity_model.dart';
import 'package:travellory/src/models/flight_model.dart';
import 'package:travellory/src/models/public_transport_model.dart';
import 'package:travellory/src/models/rental_car_model.dart';
import 'package:travellory/src/screens/accommodation/accommodation.dart';
import 'package:travellory/src/screens/activity/activity.dart';
import 'package:travellory/src/screens/public_transport/public_transport.dart';
import 'package:travellory/src/screens/rental_car/rental_car.dart';
import 'package:travellory/src/screens/flight/flight.dart';
import 'package:travellory/src/components/shared/logger.dart';

final log = getLogger('Edit');

void editModel(Model model, BuildContext context) {
  String changeRoute = '';

  if (model is FlightModel) {
    changeRoute = Flight.route;
  } else if (model is RentalCarModel) {
    changeRoute = RentalCar.route;
  } else if (model is AccommodationModel) {
    changeRoute = Accommodation.route;
  } else if (model is PublicTransportModel) {
    changeRoute = PublicTransport.route;
  } else if (model is ActivityModel) {
    changeRoute = Activity.route;
  } else {
    log.w('No edit page was found for model');
  }

  Navigator.pushNamed(context, changeRoute, arguments: ModifyModelArguments(model: model, isNewModel: false));
}