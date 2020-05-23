import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/edit_database.dart';
import 'package:travellory/widgets/buttons/submit_button.dart';
import 'package:travellory/widgets/buttons/booking_button.dart';

/// Returns submit button either for adding or editing a booking
SubmitButton getSubmitButton(
    BuildContext context,
    SingleTripProvider singleTripProvider,
    Model model,
    String submitFunctionName,
    String editFunctionName,
    String alertText,
    bool Function() validationFunction,
    {bool isNewModel}) {
  final void Function() onSubmit = getOnAddEditSubmitFunction(context, singleTripProvider, model,
      submitFunctionName, editFunctionName, alertText, isNewModel: isNewModel);

  return SubmitButton(
    highlightColor: Theme.of(context).primaryColor,
    fillColor: Theme.of(context).primaryColor,
    validationFunction: validationFunction,
    onSubmit: onSubmit,
  );
}

/// Returns either onSubmit method for new submits,
/// or onEdit method for old bookings
void Function() getOnAddEditSubmitFunction(
    BuildContext context,
    SingleTripProvider singleTripProvider,
    Model model,
    String submitFunctionName,
    String editFunctionName,
    String alertText,
    {bool isNewModel}) {
  void Function() onSubmit;

  if (isNewModel) {
    onSubmit = onSubmitBooking(singleTripProvider, model, submitFunctionName, context, alertText);
  } else {
    onSubmit = onEditBooking(singleTripProvider, model, context, editFunctionName);
  }
  return onSubmit;
}

/// Returns CancelButton for Add and Edit bookings
BookingButton getBookingCancelButton(BuildContext context, Function() onPressed) {
  return BookingButton(
    buttonTitle: 'CANCEL',
    highlightColor: Theme.of(context).primaryColor,
    fillColor: Color(0xFFF48FB1),
    onPressed: onPressed,
  );
}
