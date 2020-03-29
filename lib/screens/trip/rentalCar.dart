import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:travellory/models/RentalCarModel.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/section_titles.dart';
import 'package:travellory/widgets/show_dialog.dart';
import 'package:travellory/widgets/form_fields.dart';

class RentalCar extends StatefulWidget {
  @override
  RentalCarState createState() => RentalCarState();
}

class RentalCarState extends State<RentalCar> {
  final FormFieldWidget _bookingReferenceFormField =
      FormFieldWidget("Booking Reference", Icon(Icons.confirmation_number));
  final FormFieldWidget _companyFormField =
      FormFieldWidget("Company", Icon(Icons.supervised_user_circle));
  final FormFieldWidget _pickupLocationFormField =
      FormFieldWidget("Pick Up Location", Icon(Icons.location_on));
  final FormFieldDateWidget _pickupDateFormField =
      FormFieldDateWidget("Pick Up Date", Icon(Icons.date_range));
  final FormFieldWidget _pickupTimeFormField =
      FormFieldWidget("Pick Up Time", Icon(Icons.access_time));
  final FormFieldWidget _returnLocationFormField =
      FormFieldWidget("Return Location", Icon(Icons.location_on));
  final FormFieldDateWidget _returnDateFormField = FormFieldDateWidget(
      "Return Date", Icon(Icons.date_range), "Second date cannot be before first date.");
  final FormFieldWidget _returnTimeFormField =
      FormFieldWidget("Return Time", Icon(Icons.access_time));
  final FormFieldWidget _carDescriptionFormField =
      FormFieldWidget("Car Description", Icon(Icons.directions_car));
  final FormFieldWidget _carPlateFormField =
      FormFieldWidget("Car Plate", Icon(Icons.directions_car));
  final FormFieldWidget _notesFormField = FormFieldWidget("Notes", Icon(Icons.speaker_notes));

  final rentalCarFormKey = GlobalKey<FormState>();

  String siteTitle = 'Add Rental Car';
  final String alertTitle = "Submit Successful!";
  final String alertText =
      "You've just submitted the booking information for your rental car booking. You can see all the information in the trip overview";

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _bookingReferenceFormField.dispose();
    _companyFormField.dispose();
    _pickupLocationFormField.dispose();
    _pickupTimeFormField.dispose();
    _returnLocationFormField.dispose();
    _returnTimeFormField.dispose();
    _carDescriptionFormField.dispose();
    _carPlateFormField.dispose();
    _notesFormField.dispose();
    _pickupDateFormField.dispose();
    _returnDateFormField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TripModel _tripModel = ModalRoute.of(context).settings.arguments;

    void returnToTripScreen() {
      Navigator.pushReplacementNamed(context, '/viewtrip', arguments: _tripModel);
    }

    bool validateForm() {
      return (rentalCarFormKey.currentState.validate());
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
                color: Color(0xFFCCD7DD),
              ),
              child: Stack(children: <Widget>[
                Positioned(
                  top: 0,
                  right: -30,
                  child: FlatButton.icon(
                      onPressed: () => returnToTripScreen(),
                      icon: Icon(Icons.clear, color: Colors.red, size: 32),
                      label: Text('')),
                ),
                Positioned(
                  top: -30,
                  left: -40,
                  child: Hero(
                    tag: 'trip_image' + _tripModel.index.toString(),
                    child: Container(
                      height: 220,
                      width: 220,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: AssetImage(_tripModel.imagePath),
                          fit: BoxFit.fitWidth,
                          alignment: Alignment.bottomCenter,
                        ),
                      ),
                    ),
                  ),
                ),
                Positioned(
                  left: 180,
                  child: Container(
                    padding: EdgeInsets.only(top: 40, left: 10, right: 10),
                    alignment: Alignment.topLeft,
                    width: MediaQuery.of(context).size.width,
                    constraints: BoxConstraints(
                        maxHeight: 100.0, maxWidth: MediaQuery.of(context).size.width - 200),
                    child: FashionFetishText(
                      text: _tripModel.name,
                      size: 24,
                      fontWeight: FashionFontWeight.HEAVY,
                      height: 1.05,
                    ),
                  ),
                ),
                Positioned(
                  top: 110,
                  left: 190,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      FashionFetishText(
                          text: _tripModel.startDate.toString().substring(0, 10) +
                              ' - ' +
                              _tripModel.endDate.toString().substring(0, 10),
                          color: Colors.black54,
                          fontWeight: FashionFontWeight.BOLD,
                          size: 14,
                          height: 1.25),
                      SizedBox(
                        height: 20,
                      ),
                      Row(
                        children: <Widget>[
                          Icon(
                            Icons.location_on,
                            size: 16,
                            color: Colors.redAccent,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 6),
                            child: FashionFetishText(
                              text: _tripModel.destination,
                              size: 14,
                              fontWeight: FashionFontWeight.HEAVY,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ]),
            ),
            Expanded(
              //child: Form(
              child: SingleChildScrollView(
                child: Form(
                  key: rentalCarFormKey,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.time_to_leave,
                            color: Theme.of(context).primaryColor,
                          ),
                          Container(
                              padding: const EdgeInsets.all(8.0),
                              child: FashionFetishText(
                                text: "Add Rental Car Booking",
                                size: 24,
                                fontWeight: FashionFontWeight.HEAVY,
                                height: 1.05,
                              )),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "General Information"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _bookingReferenceFormField.optional(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _companyFormField.required(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Pick Up Information"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _pickupLocationFormField.optional(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _pickupDateFormField.firstDate(context),
                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
//                      child: ListTile(
//                        leading: const Icon(Icons.access_time),
//                        title: TextField(
//                          controller: _pickupTimeController,
//                          style: TextStyle(color: Colors.black),
//                          decoration: InputDecoration(
//                            hintText: "Pick Up Time",
//                            hintStyle: TextStyle(color: Colors.black),
//                          ),
//                        ),
//                      ),
//                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Return Information"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _returnLocationFormField.optional(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _returnDateFormField.secondDate(context, _pickupDateFormField),
                    ),
//                    Padding(
//                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
//                      child: ListTile(
//                        leading: const Icon(Icons.access_time),
//                        title: TextField(
//                          controller: _returnTimeController,
//                          style: TextStyle(color: Colors.black),
//                          decoration: InputDecoration(
//                            hintText: "Return Time",
//                            hintStyle: TextStyle(color: Colors.black),
//                          ),
//                        ),
//                      ),
//                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Car Details"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _carDescriptionFormField.optional(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _carPlateFormField.optional(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _notesFormField.optional(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: Container(
                        child: submitButton(context, Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor, validateForm, () async {
                          RentalCarModel rentalCar = new RentalCarModel(
                              bookingReference: _bookingReferenceFormField.controller.text,
                              company: _companyFormField.controller.text,
                              pickupLocation: _pickupLocationFormField.controller.text,
                              pickupDate: _pickupDateFormField.controller.text,
                              pickupTime: _pickupTimeFormField.controller.text,
                              returnLocation: _returnLocationFormField.controller.text,
                              returnDate: _returnDateFormField.controller.text,
                              returnTime: _returnTimeFormField.controller.text,
                              carDescription: _carDescriptionFormField.controller.text,
                              carNumberPlate: _carPlateFormField.controller.text,
                              notes: _notesFormField.controller.text);
                          _addRentalCar(rentalCar);
                          showSubmittedBookingDialog(
                              context, alertTitle, alertText, returnToTripScreen);
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, left: 15, right: 15),
                      child: Container(
                        child: cancelButton("CANCEL", context, () {
                          cancellingDialog(context, returnToTripScreen);
                        }),
                      ),
                    ),
                    SizedBox(height: 20),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

void _addRentalCar(RentalCarModel rentalCar) async {
  HttpsCallable callable =
      CloudFunctions.instance.getHttpsCallable(functionName: 'booking-addRentalCar');
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
