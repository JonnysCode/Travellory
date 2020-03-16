import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';
import 'package:travellory/screens/trip/flight.dart';
import 'package:travellory/screens/trip/accomodation.dart';
import 'package:travellory/screens/trip/rentalCar.dart';
import 'package:travellory/screens/trip/activity.dart';
import 'package:cloud_functions/cloud_functions.dart';

class Booking extends StatefulWidget {
  final Function toggleView;

  Booking({this.toggleView});

  @override
  _BookingState createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String dropdownValue = 'Select';

  Future _signOut(BuildContext context) async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    await _auth.signOut();
  }

  Future _showView(String value) async {
    if (value == 'Flight') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Flight()),
      );
    } else if (value == 'Accomodation') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Accomodation()),
      );
    } else if (value == 'Rental Car') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => RentalCar()),
      );
    } else if (value == 'Activity') {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Activity()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      padding: const EdgeInsets.only(top: 20, bottom: 40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text(
            'Add Booking Manually',
            style: TextStyle(fontSize: 20),
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
            _showView(newValue);
          },
          items: <String>[
            'Select',
            'Flight',
            'Accomodation',
            'Rental Car',
            'Activity'
          ].map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
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
          children: [buttonSection, typeDropdown],
        ));
  }

  void _testFunCall() async {
    HttpsCallable callable = CloudFunctions.instance
        .getHttpsCallable(functionName: 'booking-lowercaseBio');
    try {
      final HttpsCallableResult result = await callable.call();
      print(result.data);
    } on CloudFunctionsException catch (e) {
      print('caught firebase functions exception');
      print(e.code);
      print(e.message);
      print(e.details);
    } catch (e) {
      print('caught generic exception');
      print(e);
    }
  }
}
