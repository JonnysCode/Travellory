import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/font_widgets.dart';
import '../../logger.dart';

final log = getLogger('Edit');

void editModel(Model model, BuildContext context) {
  String changeRoute = '';

  if (model is FlightModel) {
    changeRoute = '/edit/flight';
  } else if (model is RentalCarModel) {
    changeRoute = '/edit/rentalcar';
  } else if (model is AccommodationModel) {
    changeRoute = '/booking/accommodation';
  } else if (model is PublicTransportModel) {
    changeRoute = '/booking/publictransport';
  } else if (model is ActivityModel) {
    changeRoute = '/edit/activity';
  } else {
    log.w('No edit page was found for model');
  }

  Navigator.pushNamed(context, changeRoute, arguments: model);
}

void showEditedBookingDialog(BuildContext context, String alertText) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        key: Key('ShowEditedBookingDialog'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: FashionFetishText(
          text: 'Edit Successful!',
          size: 18,
          fontWeight: FashionFontWeight.heavy,
          height: 1.05,
        ),
        content: Text(alertText),
        actions: <Widget>[
          alertButton('Home', Colors.transparent, context, () async {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }),
          alertButton('Back to Booking', Theme.of(context).hintColor, context, () async {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }),
        ],
      );
    },
  );
}
