import 'package:flutter/material.dart';
import 'package:travellory/widgets/buttons.dart';

import 'font_widgets.dart';

void showSubmittedBookingDialog(
    BuildContext context, String alertTitle, String alertText, void function()) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: FashionFetishText(
          text: alertTitle,
          size: 18,
          fontWeight: FashionFontWeight.HEAVY,
          height: 1.05,
        ),
        content: new Text(alertText),
        actions: <Widget>[
          alertButton("Home", Theme.of(context).canvasColor, context, () async {
            Navigator.pushReplacementNamed(context, '/home');
          }),
          alertButton("Back to Trip", Theme.of(context).hintColor, context, () async {
            function();
          }),
        ],
      );
    },
  );
}
