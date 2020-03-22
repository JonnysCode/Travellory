import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class RentalCar extends StatefulWidget {
  final Function toggleView;

  RentalCar({this.toggleView});

  @override
  _RentalCarState createState() => _RentalCarState();
}

class _RentalCarState extends State<RentalCar> {
  String selectedDate = '';
  TextEditingController _date = new TextEditingController();

  // this is the datepicker that will be called
  // I'll look at the styling some more after it finally all works - Y
  Future _selectDate(BuildContext context) async {
    DateTime picked = await showRoundedDatePicker(
      context: context,
      theme: ThemeData.dark(),
      initialDate: DateTime.now(),
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      borderRadius: 16,
    );
    if (picked != null) setState(() => selectedDate = picked.toString());
    // or
    // if (picked != null && picked != selectedDate) selectDate(picked);
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
            'Add Rental Car',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );

    // ha usegfunde dass mit gesturedetector theoretisch das ghandlet söt werde für e textfield
    // source: https://stackoverflow.com/questions/51907936/how-to-show-date-picker-on-the-onclick-of-text-field-instead-of-keyboard-in-flut
    // example with light bulb: https://api.flutter.dev/flutter/widgets/GestureDetector-class.html
    Widget datePicker = Container(
      child: GestureDetector(
        onTap: () => _selectDate(context),
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                child: new Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  TextField(
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Date',
                      labelText: "$selectedDate".split(' ')[0],
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ),
      ),
    );

    // here I tried to create the input box for the date similar to the we already had
    // the weird thing is it only works with the box
    // I don't want the datepicker to be opened when clicking the RaisedButton
    // it should appear as soon as we press into the textfield
    Widget date = Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
      child: new Center(
        child: new Column(
          children: <Widget>[
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Date',
                labelText: "$selectedDate".split(' ')[0],
              ),
            ),
            new RaisedButton(
              onPressed: () => _selectDate(context),
              child: Text('Select date'),
            ),
          ],
        ),
      ),
    );

    Widget rentalCar = Container(
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
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Pick up Location',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Date',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Pick Up Time',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Car Type',
              ),
            ),
            SizedBox(height: 20.0),
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
        body: ListView(
          children: [buttonSection, datePicker, date, rentalCar],
        ));
  }
}
