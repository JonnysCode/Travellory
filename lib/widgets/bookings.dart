import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/services/add_database.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';

void Function() onSubmitBooking(Model model, String functionName, BuildContext context, alertText) {
  return () async {
    bool added = await DatabaseAdder.addModel(model, functionName);
    if (added) {
      showSubmittedBookingDialog(context, alertText);
    } else {
      // TODO(antilyas): add error message to user
    }
  };
}

void Function() onSubmitTrip(TripModel tripModel, String functionName, BuildContext context, alertText) {
  return () async {
    bool added = await DatabaseAdder.addModel(tripModel, functionName);
    if (added) {
      showSubmittedTripDialog(context, alertText);
    } else {
      // TODO(antilyas): add error message to user
    }
  };
}

List<TripModel> createTrips(trips) {
  // add to
  List<TripModel> model = <TripModel>[];
  for (Object t in trips) {
    TripModel trip = TripModel.fromData(t);
    model.add(trip);
  }
  tripModels = model;
  return tripModels;
}
