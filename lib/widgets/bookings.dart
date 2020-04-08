import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
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
