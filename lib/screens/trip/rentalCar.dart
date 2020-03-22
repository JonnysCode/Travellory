import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';

class RentalCar extends StatelessWidget {
  final Function toggleView;

  RentalCar({this.toggleView});

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
            'Add Rental Car',
            style: TextStyle(fontSize: 20),
          ),
        ],
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
          children: [buttonSection, rentalCar],
        ));
  }
}
