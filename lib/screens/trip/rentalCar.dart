import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:travellory/models/RentalCarModel.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/font_widgets.dart';

class RentalCar extends StatefulWidget {
  @override
  _RentalCarState createState() => _RentalCarState();
}

class _RentalCarState extends State<RentalCar> {
  String selectedPickupDate = '';
  String selectedReturnDate = '';
  String siteTitle = 'Add Rental Car';

  @override
  Widget build(BuildContext context) {
    final TripModel _tripModel = ModalRoute.of(context).settings.arguments;
    final TextEditingController _bookingReferenceController =
        TextEditingController();
    final TextEditingController _companyController = TextEditingController();
    final TextEditingController _pickupLocationController =
        TextEditingController();
    final TextEditingController _pickupTimeController = TextEditingController();
    final TextEditingController _returnLocationController =
        TextEditingController();
    final TextEditingController _returnTimeController = TextEditingController();
    final TextEditingController _carDescriptionController =
        TextEditingController();
    final TextEditingController _carNumberPlateController =
        TextEditingController();
    final TextEditingController _notesController = TextEditingController();
    final TextEditingController _pickupDateController = TextEditingController();
    final TextEditingController _returnDateController = TextEditingController();

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
                      Navigator.pushReplacementNamed(context, '/viewtrip',
                          arguments: _tripModel);
                    },
                    padding: EdgeInsets.all(0.0),
                    icon: Icon(Icons.clear, color: Colors.red, size: 28),
                    label: Text('')),
              ],
            ),
          ),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Color(0xFFCCD7DD),
            ),
            child: Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, top: 12.0, right: 30.0, bottom: 7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    FashionFetishText(
                        text: "General Information",
                        size: 15.0,
                        fontWeight: FashionFontWeight.BOLD,
                        color: Colors.black54),
                  ],
                ),
              ),
            ]),
          ),
          ListTile(
            leading: const Icon(Icons.confirmation_number),
            title: TextField(
              controller: _bookingReferenceController,
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
              controller: _companyController,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Company",
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: 40,
            width: MediaQuery.of(context).size.width - 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(40),
              color: Color(0xFFCCD7DD),
            ),
            child: Row(children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    left: 8.0, top: 12.0, right: 30.0, bottom: 7.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[

                    FashionFetishText(
                        text: "Pick Up Information",
                        size: 15.0,
                        fontWeight: FashionFontWeight.BOLD,
                        color: Colors.black54),
                  ],
                ),
              ),
            ]),
          ),
          ListTile(
            leading: const Icon(Icons.location_on),
            title: TextField(
              controller: _pickupLocationController,
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
                          setState(
                              () => selectedPickupDate = pickedDate.toString());
                        _pickupDateController.text =
                            pickedDate.toIso8601String();
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
              controller: _pickupTimeController,
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
              controller: _returnLocationController,
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
                          setState(() =>
                              selectedReturnDate = pickedReturnDate.toString());
                        _returnDateController.text =
                            pickedReturnDate.toIso8601String();
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
              controller: _returnTimeController,
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
              controller: _carDescriptionController,
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
              controller: _carNumberPlateController,
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
              controller: _notesController ,
              style: TextStyle(color: Colors.black),
              decoration: InputDecoration(
                hintText: "Notes",
                hintStyle: TextStyle(color: Colors.black),
              ),
            ),
          ),
          Container(
            // TODO after submitting page routing back to trip
            child: filledButton(
                "SUBMIT",
                Colors.white,
                Theme.of(context).primaryColor,
                Theme.of(context).primaryColor,
                Colors.white, () async {
              RentalCarModel rentalCar = new RentalCarModel(
                  bookingReference: _bookingReferenceController.text,
                  company: _companyController.text,
                  pickupLocation: _pickupLocationController.text,
                  pickupDate: _pickupDateController.text,
                  pickupTime: _pickupTimeController.text,
                  returnLocation: _returnLocationController.text,
                  returnDate: _returnDateController.text,
                  returnTime: _returnTimeController.text,
                  carDescription: _carDescriptionController.text,
                  carNumberPlate: _carNumberPlateController.text,
                  notes: _notesController.text);
              _addRentalCar(rentalCar);
            }),
          )
        ],
      ),
    );
  }
}

void _addRentalCar(RentalCarModel rentalCar) async {
  HttpsCallable callable = CloudFunctions.instance
      .getHttpsCallable(functionName: 'booking-addRentalCar');
  try {
    final HttpsCallableResult result = await callable.call(<String, dynamic>{
      "bookingReference": rentalCar.bookingReference,
      "company": rentalCar.company,
      "pickupLocation": rentalCar.pickupLocation,
      "pickupDate": rentalCar.pickupDate,
      "pickupTime": rentalCar.pickupTime,
      "returnLocation": rentalCar.returnLocation,
      "returnDate": rentalCar.returnDate,
      "returnTime": rentalCar.returnTime,
      "carDescription": rentalCar.carDescription,
      "carNumberPlate": rentalCar.carNumberPlate,
      "notes": rentalCar.notes
    });
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
