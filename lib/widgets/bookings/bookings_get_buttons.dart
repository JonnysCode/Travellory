import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/services/database/edit_database.dart';
import 'package:travellory/services/database/submit.dart';
import 'package:travellory/widgets/buttons/buttons.dart';

/* returns either submit new activity booking or edit old booking button */
SubmitButton getSubmitButton(
    BuildContext context,
    SingleTripProvider singleTripProvider,
    Model model,
    bool isNewModel,
    String functionName,
    String alertText,
    String errorMessage,
    bool Function() validationFunction) {
  void Function() onSubmit = getOnAddEditSubmitFunction(
      context, singleTripProvider, model, isNewModel, functionName, alertText, errorMessage);

  return SubmitButton(
    highlightColor: Theme.of(context).primaryColor,
    fillColor: Theme.of(context).primaryColor,
    validationFunction: validationFunction,
    onSubmit: onSubmit,
  );
}

void Function() getOnAddEditSubmitFunction(
    BuildContext context,
    SingleTripProvider singleTripProvider,
    Model model,
    bool isNewModel,
    String functionName,
    String alertText,
    String errorMessage) {
  void Function() onSubmit;
  if (isNewModel) {
    onSubmit = onSubmitBooking(singleTripProvider, model, functionName, context, alertText);
  } else {
    onSubmit = onEditBooking(singleTripProvider, model, context, errorMessage);
  }
  return onSubmit;
}
