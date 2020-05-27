import 'package:flutter/material.dart';
import 'package:travellory/src/components/dialogs/missing_information_dialog.dart';

class SubmitButton extends StatelessWidget {
  const SubmitButton(
      {Key key, this.highlightColor, this.fillColor, this.validationFunction, this.onSubmit})
      : super(key: key);

  final Color highlightColor;
  final Color fillColor;
  final bool Function() validationFunction;
  final void Function() onSubmit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        key: Key('SubmitButton'),
        highlightElevation: 0.0,
        splashColor: Colors.white,
        highlightColor: highlightColor,
        elevation: 0.0,
        color: fillColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: () {
          if (validationFunction()) {
            onSubmit();
          } else {
            missingFormFieldInformationDialog(context);
          }
        },
        child: Text(
          'SUBMIT',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}