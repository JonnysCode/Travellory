import 'package:flutter/material.dart';

class EmailParsedBookingsScreen extends StatelessWidget {
  static final String route = '/booking/emailparsed';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                'Forward your booking confirmation mails to',
                style: TextStyle(
                  fontFamily: 'fashionFetish',
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.3,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                  height: 8
              ),
              Text(
                'travellory@gmail.com',
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontFamily: 'fashionFetish',
                  fontWeight: FontWeight.bold,
                  color: Colors.amberAccent,
                  height: 1.2,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                  height: 8
              ),
              Text(
                'and add them to a trip here.',
                style: TextStyle(
                  fontFamily: 'fashionFetish',
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                  height: 1.2,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                  height: 16
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(5.0),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          blurRadius: 6, color: Colors.black.withOpacity(.15), offset: Offset(3.0, 3.0))
                    ],
                  ),
                  child: Container(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
