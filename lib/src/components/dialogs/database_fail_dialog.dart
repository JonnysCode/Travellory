import 'package:flutter/material.dart';
import 'package:travellory/src/components/buttons/buttons.dart';
import 'package:travellory/src/components/shared/font_widgets.dart';

void addToDataBaseFailedDialog(BuildContext context) {
  const String errorMessage = "Seems like there's a connection problem. "
      "Please check your internet connection and try submitting again.";

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        key: Key('AddToDataBaseFailedDialog'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: FashionFetishText(
          text: "Oh no! Looks like there's a problem...",
          size: 18,
          fontWeight: FashionFontWeight.heavy,
          height: 1.05,
        ),
        content: Text(errorMessage),
        actions: <Widget>[
          alertButton("Try Again", Theme.of(context).hintColor, context, () async {
            Navigator.pop(context);
          }),
        ],
      );
    },
  );
}
