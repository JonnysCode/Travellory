import 'package:flutter/material.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';

Widget filledButton(String text, Color splashColor, Color highlightColor, Color fillColor,
    Color textColor, void function()) {
  return RaisedButton(
    key: Key('${text.toLowerCase().trim()}Button'),
    highlightElevation: 0.0,
    splashColor: splashColor,
    highlightColor: highlightColor,
    elevation: 0.0,
    color: fillColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    onPressed: () => function(),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, color: textColor, fontSize: 20),
    ),
  );
}

Widget alertButton(String text, Color fillColor, BuildContext context, void function()) {
  return RaisedButton(
    key: Key('${text.toLowerCase().trim()}Button'),
    highlightElevation: 0.0,
    splashColor: Colors.white,
    highlightColor: Theme.of(context).primaryColor,
    elevation: 0.0,
    color: fillColor,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
    onPressed: () => function(),
    child: Text(
      text,
      style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 20),
    ),
  );
}

class CancelButton extends StatelessWidget {
  const CancelButton({Key key, this.text, this.onCancel}) : super(key: key);

  final String text;
  final void Function() onCancel;

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
        onPressed: onCancel,
        child: Text(
          text,
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black54, fontSize: 20),
        ),
      ),
    );
  }
}

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

Widget socialButton(IconData icon, Color color, void function()) {
  return IconButton(
    padding: EdgeInsets.only(
      top: 0,
    ),
    alignment: Alignment.topRight,
    iconSize: 25,
    icon: Icon(
      icon,
      color: color,
    ),
    onPressed: function,
  );
}