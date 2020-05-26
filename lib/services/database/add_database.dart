import 'package:cloud_functions/cloud_functions.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/providers/trips/temp_bookings_provider.dart';
import 'package:travellory/utils/logger.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:flutter/material.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/widgets/forms/calculate_nights.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';
import '../../utils/logger.dart';

final log = getLogger('DatabaseAdder');

class DatabaseAdder {
  factory DatabaseAdder() {
    return _instance;
  }

  DatabaseAdder._privateConstructor();

  static final DatabaseAdder _instance = DatabaseAdder._privateConstructor();

  static const int _maxCount = 50;
  static const String addTrip = 'trips-addTrip';
  static const String addAccommodation = 'accommodation-addAccommodation';
  static const String addActivity = 'activity-addActivity';
  static const String addFlight = 'flight-addFlight';
  static const String addPublicTransportation = 'publictransportation-addPublicTransportation';
  static const String addRentalCar = 'rentalcar-addRentalCar';

  static int _count = 0;

  final log = getLogger('DatabaseAdder');

  Future<bool> addModel(Model model, String correspondingFunctionName) async {
    if (_count++ >= _maxCount) {
      log.w('maxCount exceeded in AddModel');
      return false;
    }
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

Function() onSubmitBooking(SingleTripProvider singleTripProvider, Model model, String functionName,
    BuildContext context, alertText) {
  return () async {
    showLoadingDialog(context);
    Model submitModel = model;
    if (submitModel is AccommodationModel) {
      submitModel = calculateNightsForAccommodation(submitModel);
    }

    final bool added = await singleTripProvider.addBooking(submitModel, functionName);
    Navigator.pop(context);
    if (added) {
      showSubmittedBookingDialog(context, alertText);
    } else {
      addToDataBaseFailedDialog(context);
      log.i('onSubmitBooking did not work');
    }
  };
}

void Function() onSubmitTrip(
    TripsProvider tripsProvider, TripModel tripModel, BuildContext context, alertText) {
  return () async {
    showLoadingDialog(context);
    final bool added = await tripsProvider.addTrip(tripModel);
    Navigator.pop(context);
    if (added) {
      showSubmittedTripDialog(context, alertText);
    } else {
      addToDataBaseFailedDialog(context);
      log.i('onSubmitTrip did not work');
    }
  };
}

Function() onSubmitTempAccommodation(TempBookingsProvider tempBookingsProvider,
    SingleTripProvider singleTripProvider, Model model, BuildContext context) {
  return () async {
    showLoadingDialog(context);
    final bool added = await tempBookingsProvider.addAccommodationToTrip(model, singleTripProvider);
    Navigator.pop(context);
    if (added) {
      showSubmittedTempBookingDialog(context);
    } else {
      addToDataBaseFailedDialog(context);
      log.i('onSubmitTempaccommodation did not work');
    }
  };
}