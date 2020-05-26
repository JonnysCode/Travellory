import 'package:flushbar/flushbar.dart';
import 'package:flutter/material.dart';

Widget showSnackBar(
    String messageToDisplay, BuildContext context, {bool isSuccessful}) {
  return SnackBar(
    content: Flushbar(
        flushbarStyle: FlushbarStyle.FLOATING,
        title: isSuccessful ? 'Success' : 'Error',
        message: messageToDisplay,
        backgroundColor:
            isSuccessful ? Theme.of(context).primaryColor : Colors.redAccent,
        margin: EdgeInsets.all(8),
        borderRadius: 12,
        duration: Duration(seconds: 3))
      ..show(context),
  );
}
