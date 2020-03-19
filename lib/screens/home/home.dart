import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/screens/schedule/dailySchedule.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/screens/trip/booking.dart';

import '../../services/auth.dart';

class Home extends StatelessWidget {

  Future _signOut(BuildContext context) async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    Widget buttonSectionBooking = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => Booking()),
                );
              }
          ),
          Text('Plan and manage trip itinerary'),
        ],
      ),
    );

    Widget buttonSectionDailySchedule = Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => DailySchedule()),
                );
              }
          ),
          Text('See Daily Schedule for Trip'),
        ],
      ),
    );

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: Text('travellory'),
          backgroundColor: Theme.of(context).primaryColor,
          elevation: 0.0,
          actions: <Widget>[
            FlatButton.icon(
              onPressed: () => _signOut(context),
              icon: Icon(Icons.person),
              label: Text('logout'),
            )
          ],
        ),
        body: ListView(
          children: [
            buttonSectionBooking, buttonSectionDailySchedule
          ],
        )
    );
  }
}
