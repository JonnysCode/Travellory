import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';

class PublicTransport extends StatefulWidget {
  final Function toggleView;

  PublicTransport({this.toggleView});

  @override
  _PublicTransportState createState() => new _PublicTransportState();
}

class _PublicTransportState extends State<PublicTransport> {
  String dropdownValue = 'Select';
  bool _valueBooking = false;
  bool _valueSeatReservation = false;

  void _valueBookingChanged(bool value) =>
      setState(() => _valueBooking = value);

  void _valueSeatReservationChanged(bool value) =>
      setState(() => _valueSeatReservation = value);

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
            'Add Public Transport',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );

    Widget firstQuestion = Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'What type of public transport are you adding?',
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );

    Widget typeDropdown = Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: ButtonTheme(
        alignedDropdown: true,
        child: DropdownButton<String>(
          value: dropdownValue,
          icon: Icon(Icons.arrow_downward),
          iconSize: 24,
          elevation: 16,
          style: TextStyle(color: Theme.of(context).primaryColor),
          underline: Container(
            height: 2,
            color: Theme.of(context).primaryColor,
          ),
          onChanged: (String newValue) {
            setState(() {
              dropdownValue = newValue;
            });
          },
          items: <String>[
            'Select',
            'Rail',
            'Bus',
            'Metro',
            'Ferry',
            'Taxi',
            'Uber',
            'Other'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
        ),
      ),
    );

    Widget publicTransportGeneral = Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Company',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              // TODO This should only appear if user chooses 'Other'
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Specific Type Of Transport',
              ),
            ),
          ],
        ),
      ),
    );

    Widget reservations = Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
      child: new Column(
        children: <Widget>[
          new CheckboxListTile(
              value: _valueBooking,
              onChanged: _valueBookingChanged,
              title: new Text(
                'Did you book this public transport?',
                style: TextStyle(fontSize: 16),
              ),
              controlAffinity: ListTileControlAffinity.leading),
          new CheckboxListTile(
              value: _valueSeatReservation,
              onChanged: _valueSeatReservationChanged,
              title: new Text(
                'Did you make a seat reservation?',
                style: TextStyle(fontSize: 16),
              ),
              controlAffinity: ListTileControlAffinity.leading),
        ],
      ),
    );

    // TODO: The following info should only be shown to users who marked the checkbox about the reservation
    Widget publicTransportBooked = Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Booking Reference',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Company',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Seat',
              ),
            ),
          ],
        ),
      ),
    );

    Widget departure = Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            Text(
              'Departure',
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
                  decoration: InputDecoration(hintText: "Date / Time"),
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

    Widget arrival = Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            Text(
              'Arrival',
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
                  decoration: InputDecoration(hintText: "Date / Time"),
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
          children: [
            buttonSection,
            firstQuestion,
            typeDropdown,
            publicTransportGeneral,
            reservations,
            publicTransportBooked,
            departure,
            arrival,
            notes
          ],
        ));
  }
}
