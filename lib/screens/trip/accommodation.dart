import 'package:flutter/material.dart';
import 'package:dropdownfield/dropdownfield.dart';

class Accommodation extends StatefulWidget {
  @override
  _AccommodationState createState() => new _AccommodationState();
}

class _AccommodationState extends State<Accommodation> {
  bool _valueBreakfast = false;
  static String accommodationType = '';
  static List<String> types = ["Hotel", "Airbnb", "Hostel", "Motel", "Bed&Breakfast", "Other"];

  void _valueBreakfastChanged(bool value) => setState(() => _valueBreakfast = value);

  Widget dropdown = DropDownField(
      value: accommodationType,
      required: true,
      strict: true,
      labelText: 'Type of accommodation',
      // icon: Icon(Icons.account_balance),
      items: types,
      setter: (dynamic newValue) {
        accommodationType = newValue;
      }
  );

  @override
  Widget build(BuildContext context) {

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
                labelText: 'Confirmation Number',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Name',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Address',
              ),
            ),
            // TODO this will be after check in info
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

    // TODO date and timepickers
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

    // TODO date and timepickers
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

    // TODO this only appears when type is hotel
    Widget roomType = Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Room Type',
              ),
            ),

          ],
        ),
      ),
    );

    // TODO this only appears when type is hotel
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

    // TODO this only appears if type is Airbnb
    Widget airbnbType = Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Accommodation Type',
              ),
            ),

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
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );

    return Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: ListView(
          children: [buttonSection, dropdown, accommodation, checkin, checkout, roomType, breakfast, airbnbType, notes],
        ));
  }
}