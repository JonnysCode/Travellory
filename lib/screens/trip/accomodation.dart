import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';

class Accomodation extends StatelessWidget {
  final Function toggleView;

  Accomodation({this.toggleView});

  Future _signOut(BuildContext context) async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      padding: const EdgeInsets.only(top: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Add Accomodation',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );

    Widget accomodation = Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Hotel Name',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Nights',
              ),
            ),
          ],
        ),
      ),
    );

    Widget checkin = Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            Text(
              'Check-In',
              style: TextStyle(fontSize: 20),
            ),
            Row(children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(hintText: "Date"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(hintText: "Time"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ])
          ],
        ),
      ),
    );

    Widget checkout = Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            Text(
              'Check-Out',
              style: TextStyle(fontSize: 20),
            ),
            Row(children: [
              Expanded(
                child: TextField(
                  decoration: InputDecoration(hintText: "Location"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(hintText: "Time"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
            ])
          ],
        ),
      ),
    );

    Widget notes = Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            SizedBox(height: 40.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Room Type',
              ),
            ),
            // TODO: adapt height
            SizedBox(height: 40.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Notes',
              ),
            ),
          ],
        ),
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
          children: [buttonSection, accomodation, checkin, checkout, notes],
        ));
  }
}