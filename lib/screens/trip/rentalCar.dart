import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:travellory/models/trip_model.dart';

class RentalCar extends StatefulWidget {
  final TripModel tripModel;

  const RentalCar({
    Key key,
    @required this.tripModel
  }) : super(key: key);

  @override
  _RentalCarState createState() => _RentalCarState(tripModel);
}

class _RentalCarState extends State<RentalCar> {
  TripModel _tripModel;
  String selectedDate = '';
  String siteTitle = 'Add Rental Car';
  TextEditingController _date = TextEditingController();

  _RentalCarState(TripModel tripModel){
    _tripModel = tripModel;
  }

  @override
  Widget build(BuildContext context) {
    // TODO padd the showRoundedDatePicker smaller into app
    // TODO padd the x better in title
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
                    child: Text('Add Rental Car Booking')),
                FlatButton.icon(
                    onPressed: () {
                      Navigator.pushReplacementNamed(context, '/viewtrip', arguments: _tripModel);
                    },
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.clear, color: Colors.red, size: 28),
                    label: Text('')
                ),
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
