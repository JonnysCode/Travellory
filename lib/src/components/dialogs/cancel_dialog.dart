import 'package:flutter/material.dart';
import 'package:travellory/src/components/buttons/buttons.dart';
import 'package:travellory/src/components/shared/font_widgets.dart';

void cancellingDialog(BuildContext context, String cancelDialog) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        key: Key('CancellingDialog'),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        title: FashionFetishText(
          text: 'Are you sure about this?',
          size: 18,
          fontWeight: FashionFontWeight.heavy,
          height: 1.05,
        ),
        content: Text(cancelDialog),
        actions: <Widget>[
          alertButton('No', Colors.transparent, context, () async {
            Navigator.pop(context);
          }),
          alertButton('Yes', Color(0xFFF48FB1), context, () async {
            Navigator.pop(context);
            Navigator.pop(context);
          }),
        ],
      );
    },
  );
}
