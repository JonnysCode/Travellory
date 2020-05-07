import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';

import '../../utils/logger.dart';

const String errorMessage = "Seems like there's a connection problem. "
    "Please check your internet connection and try submitting again.";

final log = getLogger('Submit');

Function() onSubmitBooking(SingleTripProvider singleTripProvider, Model model,
    String functionName, BuildContext context, alertText) {
  return () async {
    final bool added = await singleTripProvider.addBooking(model, functionName);
    if (added) {
      showSubmittedBookingDialog(context, alertText);
    } else {
      addToDataBaseFailedDialog(context, errorMessage);
      log.i('onSubmitBooking did not work');
    }
  };
}

void Function() onSubmitTrip(
    TripsProvider tripsProvider,TripModel tripModel, BuildContext context, alertText) {
  return () async {
    final bool added = await tripsProvider.addTrip(tripModel);
    if (added) {
      showSubmittedTripDialog(context, alertText);
    } else {
      addToDataBaseFailedDialog(context, errorMessage);
      log.i('onSubmitTrip did not work');
    }
  };
}
