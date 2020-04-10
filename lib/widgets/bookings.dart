import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/services/add_database.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';

Function() onSubmitBooking(Model model, String functionName, BuildContext context, alertText) {
  return () async {
    final bool added = await DatabaseAdder.addModel(model, functionName);
    if (added) {
      showSubmittedBookingDialog(context, alertText);
    } else {
      addToDataBaseFailedDialog(
          context,
          "Seems like there's a connection problem. "
          "Please check your internet connection and try submitting again.");
    }
  };
}

void Function() onSubmitTrip(TripModel tripModel, String functionName, BuildContext context, alertText) {
  return () async {
    final bool added = await DatabaseAdder.addModel(tripModel, functionName);
    if (added) {
      showSubmittedTripDialog(context, alertText);
    } else {
      // TODO(antilyas): add error message to user
    }
  };
}

List<TripModel> createTrips(dbTrips) {
  // add to
  List<TripModel> trips = <TripModel>[];
  for (Object dbTrip in dbTrips) {
    TripModel trip = TripModel.fromData(dbTrip);
    trips.add(trip);
  }
  tripModels = trips;
  return tripModels;
}
