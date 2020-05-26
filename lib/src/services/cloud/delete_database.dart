import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/src/components/dialogs/database_fail_dialog.dart';
import 'package:travellory/src/providers/single_trip_provider.dart';
import 'package:travellory/src/providers/trips_provider.dart';
import 'package:travellory/src/models/abstract_model.dart';
import 'package:travellory/src/models/trip_model.dart';
import 'package:travellory/src/utils/logger.dart';
import 'package:travellory/src/components/dialogs/delete_dialogs.dart';
import 'package:travellory/src/components/dialogs/show_dialog.dart';

final log = getLogger('DatabaseDeleter');

class DatabaseDeleter {
  factory DatabaseDeleter() {
    return _instance;
  }

  DatabaseDeleter._privateConstructor();

  static final DatabaseDeleter _instance = DatabaseDeleter._privateConstructor();

  static const deleteTrip = 'trips-deleteTrip';
  static const deleteTempAccommodation = 'accommodation-deleteTempAccommodation';
  static const deleteTripName = 'trips-deleteTrip';
  static const deleteFlight = 'flight-deleteFlight';
  static const deleteRentalCar = 'rentalcar-deleteRentalCar';
  static const deleteAccommodation = 'accommodation-deleteAccommodation';
  static const deletePublicTransportation = 'publictransportation-deletePublicTransportation';
  static const deleteActivity = 'activity-deleteActivity';

  Future<bool> deleteModel(Model model, String correspondingFunctionName) async {
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

void Function() onDeleteBooking(Model model, BuildContext context, String functionName) {
  final SingleTripProvider singleTripProvider =
      Provider.of<TripsProvider>(context, listen: false).selectedTrip;

  const String alertText =
      "You've just deleted this entry. Your booking overview has been updated. ";

  return () async {
    showLoadingDialog(context);
    final bool deleted = await singleTripProvider.deleteBooking(model, functionName);
    Navigator.pop(context);
    if (deleted) {
      showDeletedBookingDialog(context, alertText);
      log.i('onDeleteBooking was performed');
    } else {
      addToDataBaseFailedDialog(context);
      log.i('onDeleteBooking did not work');
    }
  };
}

void Function() onDeleteTrip(TripModel tripModel, BuildContext context) {
  final TripsProvider tripsProvider = Provider.of<TripsProvider>(context, listen: false);

  const String alertText = "You've just deleted this trip and all corresponding bookings ";

  return () async {
    showLoadingDialog(context);
    final bool deleted = await tripsProvider.deleteTrip(tripModel);
    Navigator.pop(context);
    if (deleted) {
      showDeletedBookingDialog(context, alertText, hasBackButton: false);
      log.i('onDeleteBooking was performed');
    } else {
      addToDataBaseFailedDialog(context);
      log.i('onDeleteBooking did not work');
    }
  };
}
