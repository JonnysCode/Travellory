import 'package:flutter/material.dart';

class EmailParsedBookingsScreen extends StatelessWidget {
  static final String route = '/booking/emailparsed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Column(
        children: <Widget>[
          Text(
            'Forward your booking confirmation mails to',
            style: TextStyle(
              fontFamily: 'fashionFetish',
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }
}
