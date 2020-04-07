import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/services/add_database.dart';
import 'package:travellory/widgets/show_dialog.dart';

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
