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

  @override
  Widget build(BuildContext context) {
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

    // TODO start Date is no date
    // TODO padd the showRoundedDatePicker smaller into app
    Widget datePicker = Container(
      child: GestureDetector(
        child: Container(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
                child: new Column(children: <Widget>[
                  SizedBox(height: 20.0),
                  TextField(
                    onTap: () async {
                      DateTime pickedDate = DateTime(1900);
                      FocusScope.of(context).requestFocus(new FocusNode());

                      pickedDate = await showRoundedDatePicker(
                        context: context,
                        theme: ThemeData.dark(),
                        initialDate: DateTime.now(),
                        firstDate: DateTime(DateTime.now().year - 1),
                        lastDate: DateTime(DateTime.now().year + 1),
                        borderRadius: 16,
                      );
                      if (pickedDate != null)
                        setState(() => selectedDate = pickedDate.toString());
                      _date.text = pickedDate.toIso8601String();
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      hintText: 'Date',
                      labelText: "$selectedDate".split(' ')[0],
                      labelStyle: new TextStyle(color: Colors.black),
                    ),
                  ),
                ]),
              ),
            ],
          ),
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
          children: [buttonSection, datePicker, rentalCar],
        ));
  }
}
