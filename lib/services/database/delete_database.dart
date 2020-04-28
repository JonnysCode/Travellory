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
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/widgets/bookings/edit_delete_dialogs.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';

final log = getLogger('DatabaseDeleter');

class DatabaseDeleter {
  Future<bool> deleteModel(Model model, String correspondingFunctionName) async {
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

// method to get database function names for delete function based on model
String getDeleteFunctionNameBasedOn(Model model) {
  String functionName;
  if (model is FlightModel) {
    functionName = 'delete-flight';
  } else if (model is RentalCarModel) {
    functionName = 'delete-rentalCar';
  } else if (model is AccommodationModel) {
    functionName = 'delete-accommodation';
  } else if (model is PublicTransportModel) {
    functionName = 'delete-publicTransport';
  } else if (model is ActivityModel) {
    functionName = 'delete-activity';
  } else {
    functionName = '';
  }
  return functionName;
}

void Function() onDeleteBooking(Model model, BuildContext context, String errorMessage) {
  final TripsProvider tripsProvider = Provider.of<TripsProvider>(context, listen: false);

  String functionName = getDeleteFunctionNameBasedOn(model);

  const String alertText =
      "You've just deleted this entry. Your booking overview has been updated. ";

  return () async {
    final bool deleted = await tripsProvider.deleteModel(model, functionName);
    if (deleted) {
      showDeletedBookingDialog(context, alertText);
      log.i('onDeleteBooking was performed');
    } else {
      addToDataBaseFailedDialog(context, errorMessage);
      log.i('onDeleteBooking did not work');
    }
  };
}
