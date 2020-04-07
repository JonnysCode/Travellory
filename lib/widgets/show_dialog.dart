import 'package:flutter/material.dart';
import 'package:travellory/widgets/buttons.dart';

import 'font_widgets.dart';

void showSubmittedBookingDialog(
    BuildContext context, String alertText, void function()) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: FashionFetishText(
          text: "Submit Successful!",
          size: 18,
          fontWeight: FashionFontWeight.HEAVY,
          height: 1.05,
        ),
        content: new Text(alertText),
        actions: <Widget>[
          alertButton("Home", Colors.transparent, context, () async {
            Navigator.popUntil(context, ModalRoute.withName('/home'));
          }),
          alertButton("Back to Trip", Theme.of(context).hintColor, context, () async {
            function();
          }),
        ],
      );
    },
  );
}

void cancellingDialog(BuildContext context, void function()) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: FashionFetishText(
          text: "Are you sure about this?",
          size: 18,
          fontWeight: FashionFontWeight.HEAVY,
          height: 1.05,
        ),
        content: new Text(
            "You are about to abort this booking entry. Do you want to go back to the previous site and discard your changes?"),
        actions: <Widget>[
          alertButton("No", Colors.transparent, context, () async {
            Navigator.pop(context);
          }),
          alertButton("Yes", Color(0xFFF48FB1), context, () async {
            function();
          }),
        ],
      );
    },
  );
}

void missingFormFieldInformationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: FashionFetishText(
          text: "Oops! Looks like something's missing...",
          size: 18,
          fontWeight: FashionFontWeight.HEAVY,
          height: 1.05,
        ),
        content: new Text(
            "The form is not complete. Please look at the marked fields and add the required information."),
        actions: <Widget>[
          alertButton("Edit Booking", Theme.of(context).primaryColor, context, () async {
            Navigator.pop(context);
          }),
        ],
      );
    },
  );
}
