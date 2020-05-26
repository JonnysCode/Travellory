import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/utils/logger.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/widgets/forms/calculate_nights.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';
import '../../widgets/bookings/edit.dart';

final log = getLogger('DatabaseEditor');

class DatabaseEditor {
  factory DatabaseEditor() {
    return _instance;
  }

  DatabaseEditor._privateConstructor();

  static final DatabaseEditor _instance = DatabaseEditor._privateConstructor();

  static const String editAccommodation = 'accommodation-updateAccommodation';
  static const String editActivity = 'activity-updateActivity';
  static const String editFlight = 'flight-updateFlight';
  static const String editPublicTransportation = 'publictransportation-updatePublicTransportation';
  static const String editRentalCar = 'rentalcar-updateRentalCar';
  static const String editTripName = 'trips-updateTrip';

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

const String onEditSuccessfulText =
    "You've just edited this entry. Your trip overview has been updated. "
        "However, it might take a moment to see the changes on your profile. ";

void Function() onEditBooking(
    SingleTripProvider singleTripProvider, Model model, BuildContext context, String functionName) {

  return () async {
    showLoadingDialog(context);
    Model submitModel = model;
    if (submitModel is AccommodationModel) {
      submitModel = calculateNightsForAccommodation(submitModel);
    }

    final bool edited = await singleTripProvider.editBooking(submitModel, functionName);
    Navigator.pop(context);
    if (edited) {
      showEditedBookingDialog(context, onEditSuccessfulText);
      log.i('onEditBooking was performed');
    } else {
      addToDataBaseFailedDialog(context);
      log.i('onEditBooking did not work');
    }
  };
}

void Function() onEditTrip(TripsProvider trips, Model model,
    BuildContext context) {

  return () async {
    showLoadingDialog(context);
    final bool edited = await trips.editTrip(model);
    Navigator.pop(context);
    if (edited) {
      showEditedBookingDialog(context, onEditSuccessfulText);
      log.i('onEditBooking was performed');
    } else {
      addToDataBaseFailedDialog(context);
      log.i('onEditBooking did not work');
    }
  };
}