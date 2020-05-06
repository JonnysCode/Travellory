import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:travellory/utils/logger.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';

import 'edit.dart';

final log = getLogger('DatabaseEditor');

class DatabaseEditor {
  DatabaseEditor._privateConstructor();

  factory DatabaseEditor() {
    return _instance;
  }

  static final DatabaseEditor _instance = DatabaseEditor._privateConstructor();

  Future<bool> editModel(Model model, String correspondingFunctionName) async {
    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: correspondingFunctionName);
    try {
      log.d('JSON data for function call $correspondingFunctionName: ${model.toMap()}');
      final HttpsCallableResult result = await callable.call(model.toMap());
      log.i(result.data);
      return Future<bool>.value(true);
    } on CloudFunctionsException catch (e) {
      log.i('caught firebase functions exception');
      log.e(e.code);
      log.e(e.message);
      log.e(e.details);
    } on Exception catch (e) {
      log.i('caught generic exception');
      log.i(e);
    }
    return Future<bool>.value(false);
  }
}

String getEditFunctionNameBasedOn(Model model) {
  String functionName;
  if (model is FlightModel) {
    functionName = 'booking-updateFlight';
  } else if (model is RentalCarModel) {
    functionName = 'booking-updateRentalCar';
  } else if (model is AccommodationModel) {
    functionName = 'booking-updateAccommodation';
  } else if (model is PublicTransportModel) {
    functionName = 'booking-updatePublicTransportation';
  } else if (model is ActivityModel) {
    functionName = 'activity-updateActivity';
  } else {
    functionName = '';
    log.w('No function name was found for model');
  }
  return functionName;
}

void Function() onEditBooking(SingleTripProvider singleTripProvider, Model model,
    BuildContext context, String errorMessage) {
  final String functionName = getEditFunctionNameBasedOn(model);

  const String alertText =
      "You've just edited this entry. Your booking overview has been updated. " +
          "However, it might take a moment to see the changes on your profile. ";

  return () async {
    final bool edited = await singleTripProvider.editBooking(model, functionName);
    if (edited) {
      showEditedBookingDialog(context, alertText);
      log.i('onEditBooking was performed');
    } else {
      addToDataBaseFailedDialog(context, errorMessage);
      log.i('onEditBooking did not work');
    }
  };
}
