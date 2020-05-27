import 'package:flutter/material.dart';
import 'package:travellory/src/components/animations/loading_heart.dart';
import 'package:travellory/src/components/buttons/buttons.dart';
import '../shared/font_widgets.dart';

/// this dialog is shown when a booking has successfully been added to the database
void showSubmittedBookingDialog(BuildContext context, String alertText) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        key: Key('ShowSubmittedBookingDialog'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: FashionFetishText(
          text: 'Submit Successful!',
          size: 18,
          fontWeight: FashionFontWeight.heavy,
          height: 1.05,
        ),
        content: Text(alertText),
        actions: <Widget>[
          alertButton('Home', Colors.transparent, context, () async {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }),
          alertButton("Back to Trip", Theme.of(context).hintColor, context, () async {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }),
        ],
      );
    },
  );
}

/// this dialog is shown when a trip has successfully been added to the database
void showSubmittedTripDialog(BuildContext context, String alertText) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        key: Key('showSubmittedTripDialog'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: FashionFetishText(
          text: 'Submit Successful!',
          size: 18,
          fontWeight: FashionFontWeight.heavy,
          height: 1.05,
        ),
        content: Text(alertText),
        actions: <Widget>[
          alertButton('Home', Colors.transparent, context, () async {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }),
        ],
      );
    },
  );
}

/// this dialog is shown when a temp booking has successfully been added to the database
void showSubmittedTempBookingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        key: Key('ShowSubmittedBookingDialog'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: FashionFetishText(
          text: 'Submit Successful!',
          size: 18,
          fontWeight: FashionFontWeight.heavy,
          height: 1.05,
        ),
        content: Text('We have added your booking to the trip.'),
        actions: <Widget>[
          alertButton('Home', Colors.transparent, context, () async {
            Navigator.of(context).popUntil((route) => route.isFirst);
          }),
          alertButton("OK", Theme.of(context).hintColor, context, () async {
            Navigator.of(context).pop();
          }),
        ],
      );
    },
  );
}

/// when database functions are being performed this dialog will be displayed
void showLoadingDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: Text(
          'We are working on it...',
          textAlign: TextAlign.center,
        ),
        content: SizedBox(
          height: 150,
          width: 300,
          child: LoadingHeart()
        ),
      );
    },
  );
}

/// this dialog is shown when a booking has successfully been edited in the database
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