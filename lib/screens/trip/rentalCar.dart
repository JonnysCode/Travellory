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
  String selectedPickupDate = '';
  String selectedReturnDate = '';
  String siteTitle = 'Add Rental Car';
  TextEditingController _pickupDate = TextEditingController();
  TextEditingController _returnDate = TextEditingController();


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
            leading: const Icon(Icons.confirmation_number),
            title: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Booking Reference",
                hintStyle: TextStyle(color: Colors.black),
              ),
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
                          setState(() => selectedPickupDate = pickedDate.toString());
                        _pickupDate.text = pickedDate.toIso8601String();
                      },
                      decoration: InputDecoration(
                        hintText: 'Pick Up Date',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: "$selectedPickupDate".split(' ')[0],
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
            leading: const Icon(Icons.location_on),
            title: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Return Location",
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
                      // TODO add constraint that this cannot be before pickup date
                      onTap: () async {
                        DateTime pickedReturnDate = DateTime(1900);
                        FocusScope.of(context).requestFocus(FocusNode());

                        pickedReturnDate = await showRoundedDatePicker(
                          context: context,
                          theme: ThemeData.dark(),
                          initialDate: DateTime.now(),
                          firstDate: DateTime(DateTime.now().year - 1),
                          lastDate: DateTime(DateTime.now().year + 1),
                          borderRadius: 16,
                        );
                        if (pickedReturnDate != null)
                          setState(() => selectedReturnDate = pickedReturnDate.toString());
                        _returnDate.text = pickedReturnDate.toIso8601String();
                      },
                      decoration: InputDecoration(
                        hintText: 'Return Date',
                        hintStyle: TextStyle(color: Colors.black),
                        labelText: "$selectedReturnDate".split(' ')[0],
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
                hintText: "Return Time",
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
            leading: const Icon(Icons.directions_car),
            title: TextField(
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Car Number Plate",
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
