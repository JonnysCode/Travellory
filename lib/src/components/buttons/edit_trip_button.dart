import 'package:flutter/material.dart';

class EditTripButton extends StatelessWidget {
  const EditTripButton({Key key,  this.highlightColor, this.fillColor, this.text, this.onPressed})
      : super(key: key);

  final Color highlightColor;
  final Color fillColor;
  final String text;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: RaisedButton(
        key: Key('BookingButton'),
        highlightElevation: 0.0,
        splashColor: Colors.white,
        highlightColor: highlightColor,
        elevation: 0.0,
        color: fillColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
        onPressed: onPressed,
        child: Text(
          'EDIT TRIP',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white, fontSize: 20),
        ),
      ),
    );
  }
}