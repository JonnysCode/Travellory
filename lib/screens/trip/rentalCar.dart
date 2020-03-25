import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class RentalCar extends StatefulWidget {
  final Function toggleView;

  RentalCar({this.toggleView});

  @override
  _RentalCarState createState() => _RentalCarState();
}

class _RentalCarState extends State<RentalCar> {
  String selectedDate = '';
  String siteTitle = 'Add Rental Car';
  TextEditingController _date = TextEditingController();

  @override
  Widget build(BuildContext context) {
    // TODO padd the showRoundedDatePicker smaller into app
//    Widget datePicker = Container(
//      child: GestureDetector(
//        child: Container(
//          child: Column(
//            mainAxisAlignment: MainAxisAlignment.center,
//            children: <Widget>[
//              Padding(
//                padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
//                child: new Column(children: <Widget>[
//                  SizedBox(height: 20.0),
//                  TextField(
//                    onTap: () async {
//                      DateTime pickedDate = DateTime(1900);
//                      FocusScope.of(context).requestFocus(new FocusNode());
//
//                      pickedDate = await showRoundedDatePicker(
//                        context: context,
//                        theme: ThemeData.dark(),
//                        initialDate: DateTime.now(),
//                        firstDate: DateTime(DateTime.now().year - 1),
//                        lastDate: DateTime(DateTime.now().year + 1),
//                        borderRadius: 16,
//                      );
//                      if (pickedDate != null)
//                        setState(() => selectedDate = pickedDate.toString());
//                      _date.text = pickedDate.toIso8601String();
//                    },
//                    decoration: InputDecoration(
//                      border: OutlineInputBorder(),
//                      hintText: 'Date',
//                      labelText: "$selectedDate".split(' ')[0],
//                      labelStyle: new TextStyle(color: Colors.black),
//                    ),
//                  ),
//                ]),
//              ),
//            ],
//          ),
//        ),

//      ),
//    );

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Column(
        children: <Widget>[
          AppBar(
            backgroundColor: Colors.white,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.time_to_leave,
                  color: Theme.of(context).primaryColor,
                ),
                Container(
                    padding: const EdgeInsets.all(8.0),
                    child: Text('Add Booking of Rental Car'))
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.supervised_user_circle),
            title: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Company",
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Pick Up Location",
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          // TODO show Text "Date" before a date has been chosen
          GestureDetector(
            child: Container(
              child: Column(children: <Widget>[
                ListTile(
                    leading: const Icon(Icons.date_range),
                    title: TextField(
                      onTap: () async {
                        DateTime pickedDate = DateTime(1900);
                        FocusScope.of(context).requestFocus(FocusNode());

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
                        hintText: 'Date',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: "$selectedDate".split(' ')[0],
                        labelStyle: TextStyle(color: Colors.black),
                      ),
                    )),
              ]),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.access_time),
            title: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Pick Up Time",
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.directions_car),
            title: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Car Description",
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          ListTile(
            leading: const Icon(Icons.speaker_notes),
            title: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Notes",
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
