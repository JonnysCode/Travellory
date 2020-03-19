import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';

class Accommodation extends StatefulWidget {
  final Function toggleView;

  Accommodation({this.toggleView});

  @override
  _AccommodationState createState() => new _AccommodationState();
}

class _AccommodationState extends State<Accommodation> {
  bool _valueBreakfast = false;

  void _valueBreakfastChanged(bool value) => setState(() => _valueBreakfast = value);

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
            'Add Accommodation',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );

    Widget accommodation = Container(
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
                labelText: 'Confirmation Number',
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
                  // TODO automatically calculate this date with nr of nights and checkin date
                  decoration: InputDecoration(hintText: "*Checkout Date*"),
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

    Widget breakfast = Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
      child: new Column(
        children: <Widget>[
          new CheckboxListTile(
              value: _valueBreakfast,
              onChanged: _valueBreakfastChanged,
              title: new Text(
                'Is breakfast included in your stay?',
                style: TextStyle(fontSize: 16),
              ),
              controlAffinity: ListTileControlAffinity.leading
          ),
        ],
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
          children: [buttonSection, accommodation, checkin, checkout, breakfast, notes],
        ));
  }
}