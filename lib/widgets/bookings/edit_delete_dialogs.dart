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

void showDeleteDialog(BuildContext context, String alertText) {
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
          alertButton('Continue With Delete', Theme.of(context).accentColor, context, () async {
            onDeleteBooking();
            print('true');
          }),
          alertButton("Back to Booking", Theme.of(context).hintColor, context, () async {
            Navigator.of(context).pop();
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
