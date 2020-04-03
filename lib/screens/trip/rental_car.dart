import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/section_titles.dart';
import 'package:travellory/widgets/show_dialog.dart';
import 'package:travellory/widgets/form_fields.dart';
import 'package:travellory/widgets/trip/trip_header.dart';

class RentalCar extends StatefulWidget {
  @override
  _RentalCarState createState() => _RentalCarState();
}

class _RentalCarState extends State<RentalCar> {
  final FormFieldWidget _bookingReferenceFormField =
      FormFieldWidget("Booking Reference", Icon(Icons.confirmation_number));
  final FormFieldWidget _companyFormField =
      FormFieldWidget("Company *", Icon(Icons.supervised_user_circle));
  final FormFieldWidget _pickupLocationFormField =
      FormFieldWidget("Pick Up Location", Icon(Icons.location_on));
  final FormFieldDateWidget _pickupDateFormField =
      FormFieldDateWidget("Pick Up Date *", Icon(Icons.date_range));
  final FormFieldTimeWidget _pickupTimeFormField =
      FormFieldTimeWidget("Pick Up Time", Icon(Icons.access_time));
  final FormFieldWidget _returnLocationFormField =
      FormFieldWidget("Return Location", Icon(Icons.location_on));
  final FormFieldDateWidget _returnDateFormField = FormFieldDateWidget(
      "Return Date", Icon(Icons.date_range), "Second date cannot be before first date.");
  final FormFieldTimeWidget _returnTimeFormField =
      FormFieldTimeWidget("Return Time", Icon(Icons.access_time));
  final FormFieldWidget _carDescriptionFormField =
      FormFieldWidget("Car Description", Icon(Icons.directions_car));
  final FormFieldWidget _carPlateFormField =
      FormFieldWidget("Car Plate", Icon(Icons.directions_car));
  final FormFieldWidget _notesFormField = FormFieldWidget("Notes", Icon(Icons.speaker_notes));

  final rentalCarFormKey = GlobalKey<FormState>();

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
      Navigator.pop(context);
      Navigator.pop(context);
    }

    bool validateForm() {
      return (rentalCarFormKey.currentState.validate());
    }

    return Scaffold(
      key: Key('Rental Car'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            TripHeader(_tripModel),
            Expanded(
              //child: Form(
              child: SingleChildScrollView(
                child: Form(
                  key: rentalCarFormKey,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: bookingSiteTitle(context, "Add Rental Car", Icons.time_to_leave),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _pickupTimeFormField.time(context),
                    ),
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
                      child: _returnDateFormField.secondDateRequired(context, _pickupDateFormField),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _returnTimeFormField.time(context),
                    ),
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
                              context, alertText, returnToTripScreen);
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