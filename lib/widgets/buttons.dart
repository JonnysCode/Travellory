import 'package:flutter/material.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';

Widget filledButton(String text, Color splashColor, Color highlightColor, Color fillColor,
    Color textColor, void function()) {
  return RaisedButton(
    key: Key(text.toLowerCase().trim() + 'Button'),
    highlightElevation: 0.0,
    splashColor: splashColor,
    highlightColor: highlightColor,
    elevation: 0.0,
    color: fillColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
    ),
    onPressed: () => function(),
  );
}

Widget alertButton(String text, Color fillColor, BuildContext context, void function()) {
  return RaisedButton(
    key: Key(text.toLowerCase().trim() + 'Button'),
    highlightElevation: 0.0,
    splashColor: Colors.white,
    highlightColor: Theme.of(context).primaryColor,
    elevation: 0.0,
    color: fillColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 20),
    ),
    onPressed: () => function(),
  );
}

Widget cancelButton(String text, BuildContext context, void function()) {
  return RaisedButton(
    key: Key('CancelButton'),
    highlightElevation: 0.0,
    splashColor: Colors.white,
    highlightColor: Theme.of(context).primaryColor,
    elevation: 0.0,
    color: Color(0xFFF48FB1),
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 20),
    ),
    onPressed: () => function(),
  );
}

class CancelButton extends StatelessWidget {
  final String text;
  final void Function() onCancel;

  const CancelButton({Key key, this.text, this.onCancel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        key: Key('CancelButton'),
        highlightElevation: 0.0,
        splashColor: Colors.white,
        highlightColor: Theme.of(context).primaryColor,
        elevation: 0.0,
        color: Color(0xFFF48FB1),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 20),
        ),
        onPressed: onCancel,
      ),
    );
  }
}

class SubmitButton extends StatelessWidget {
  final Color highlightColor;
  final Color fillColor;
  final bool Function() validationFunction;
  final void Function() onSubmit;

  const SubmitButton(
      {Key key, this.highlightColor, this.fillColor, this.validationFunction, this.onSubmit})
      : super(key: key);

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
          child: Text(
            'SUBMIT',
            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
          ),
          onPressed: () {
            if (validationFunction()) {
              onSubmit();
            } else {
              missingFormFieldInformationDialog(context);
            }
          }),
    );
  }
}

Widget submitButton(BuildContext context, Color highlightColor, Color fillColor,
    bool validatedFunction(), void function()) {
  return RaisedButton(
      key: Key('SubmitButton'),
      highlightElevation: 0.0,
      splashColor: Colors.white,
      highlightColor: highlightColor,
      elevation: 0.0,
      color: fillColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: Text(
        "SUBMIT",
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
      ),
      onPressed: () {
        if (validatedFunction()) {
          function();
        } else {
          missingFormFieldInformationDialog(context);
        }
      });
}
