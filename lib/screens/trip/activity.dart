import 'package:flutter/material.dart';
import 'package:travellory/providers/auth_provider.dart';
import 'package:travellory/services/auth.dart';

class Activity extends StatefulWidget {
  final Function toggleView;

  Activity({this.toggleView});

  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  String dropdownValue = 'Select';

  Future _signOut(BuildContext context) async {
    final BaseAuthService _auth = AuthProvider.of(context).auth;
    await _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    Color color = Theme.of(context).primaryColor;

    Widget buttonSection = Container(
      padding: const EdgeInsets.only(top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        mainAxisSize: MainAxisSize.max,
        children: [
          Text(
            'Add Activity',
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
            'How would you categorize your activity? ',
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
            'Historic',
            'Outdoors',
            'Culture',
            'Social',
            'Relaxing',
            'Adventure',
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

    Widget activity = Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Activity Title',
              ),
            ),
            SizedBox(height: 20.0),
            TextField(
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                // TODO adapt height
                labelText: 'Description',
              ),
            ),
          ],
        ),
      ),
    );

    Widget schedule = Container(
      padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
      child: Form(
        child: Column(
          children: [
            Text(
              'Schedule activity ',
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
                  decoration: InputDecoration(hintText: "Start Date / Time"),
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: TextField(
                  decoration: InputDecoration(hintText: "End Date / Time"),
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
          children: [buttonSection, firstQuestion, typeDropdown, activity, schedule, notes],
        ));
  }
}