import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/services/database/delete_database.dart';
import 'package:travellory/widgets/buttons/buttons.dart';

import '../font_widgets.dart';

void showDeleteDialog(Model model, BuildContext context, String alertText) {
  const String errorMessage = "Seems like there's a connection problem. "
      "Please check your internet connection and try submitting again.";

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        key: Key('ShowDeleteDialog'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: FashionFetishText(
          text: 'Are You Sure About This?',
          size: 18,
          fontWeight: FashionFontWeight.heavy,
          height: 1.05,
        ),
        content: Text(alertText),
        actions: <Widget>[
          alertButton("CANCEL", Theme.of(context).hintColor, context, () async {
            Navigator.of(context).pop();
          }),
          alertButton('DELETE', Theme.of(context).accentColor, context,
            onDeleteBooking(model, context, errorMessage),
          ),
        ],
      );
    },
  );
}

void showDeletedBookingDialog(BuildContext context, String alertText) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        key: Key('ShowDeletedBookingDialog'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: FashionFetishText(
          text: 'Delete Successful!',
          size: 18,
          fontWeight: FashionFontWeight.heavy,
          height: 1.05,
        ),
        content: Text(alertText),
        actions: <Widget>[
          alertButton('Home', Colors.transparent, context, () async {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }),
          alertButton('Back To Trip', Theme.of(context).hintColor, context, () async {
            Navigator.pop(context);
            Navigator.pop(context);
            Navigator.pop(context);
          }),
        ],
      );
    },
  );
}

String getDeleteTextBasedOn(Model model) {
  String modelText;
  if (model is FlightModel) {
    modelText = 'flight booking';
  } else if (model is RentalCarModel) {
    modelText = 'rental car booking';
  } else if (model is AccommodationModel) {
    modelText = 'accommodation booking';
  } else if (model is PublicTransportModel) {
    modelText = 'public transport booking';
  } else if (model is ActivityModel) {
    modelText = 'activity';
  } else {
    modelText = '';
  }
  return modelText;
}
