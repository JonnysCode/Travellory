import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/logger.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/widgets/bookings/edit_delete_dialogs.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';

import 'edit.dart';

final log = getLogger('DatabaseEditor');

class DatabaseEditor {
  Future<bool> editModel(Model model, String correspondingFunctionName) async {
    final HttpsCallable callable =
        CloudFunctions.instance.getHttpsCallable(functionName: correspondingFunctionName);
    try {
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
    functionName = 'edit-flight';
  } else if (model is RentalCarModel) {
    functionName = 'edit-rentalCar';
  } else if (model is AccommodationModel) {
    functionName = 'edit-accommodation';
  } else if (model is PublicTransportModel) {
    functionName = 'edit-publicTransport';
  } else if (model is ActivityModel) {
    functionName = 'edit-activity';
  } else {
    functionName = '';
    log.w('No function name was found for model');
  }
  return functionName;
}

// TODO this isn't getting performed, why??
void Function() onEditBooking(Model model, BuildContext context, String errorMessage) {
  final SingleTripProvider singleTripProvider =
      Provider.of<TripsProvider>(context, listen: false).selectedTrip;

  String functionName = getEditFunctionNameBasedOn(model);

  const String alertText =
      "You've just edited this entry. Your booking overview has been updated. " +
          "However, it might take a moment to see the changes on your profile. ";

  return () async {
    final bool edited = await singleTripProvider.editModel(model, functionName);
    if (false) {
      showEditedBookingDialog(context, alertText);
      log.i('onEditBooking was performed');
    } else {
      addToDataBaseFailedDialog(context, errorMessage);
      log.i('onEditBooking did not work');
    }
  };
}
