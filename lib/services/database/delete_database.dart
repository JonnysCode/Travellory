import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:travellory/logger.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/widgets/bookings/edit_delete_dialogs.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';

final log = getLogger('DatabaseDeleter');

class DatabaseDeleter {
  Future<bool> deleteModel(Model model, String correspondingFunctionName) async {
    // TODO(nadine): implement database function
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

void Function() onDeleteBooking(BuildContext context, String errorMessage) {
  const String alertText =
      "You've just deleted this entry. Your booking overview has been updated. ";

  const String errorMessage = "Seems like there's a connection problem. "
      "Please check your internet connection and try submitting again.";

  // TODO (nadine): implement delete booking function maybe similar to onSubmitTrip ?
  return () async {
    // TODO (nadine): implement correct bool
    final bool added = false;
    if (added) {
      showDeletedBookingDialog(context, alertText);
      log.i('onDeleteBooking was performed');
    } else {
      addToDataBaseFailedDialog(context, errorMessage);
      log.i('onDeleteBooking did not work');
    }
  };
}
