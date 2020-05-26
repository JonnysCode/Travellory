import 'package:flutter/material.dart';
import 'package:travellory/src/components/buttons/buttons.dart';
import 'package:travellory/src/components/shared/font_widgets.dart';

void missingFormFieldInformationDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        key: Key('MissingFormFieldInformationDialog'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: FashionFetishText(
          text: "Oops! Looks like something's not right...",
          size: 18,
          fontWeight: FashionFontWeight.heavy,
          height: 1.05,
        ),
        content: Text(
            'The form is not complete. Please look at the marked fields and add the required information.'),
        actions: <Widget>[
          alertButton('Edit Booking', Theme.of(context).primaryColor, context, () async {
            Navigator.pop(context);
          }),
        ],
      );
    },
  );
}
