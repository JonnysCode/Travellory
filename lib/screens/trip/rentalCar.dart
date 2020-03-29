import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:travellory/models/RentalCarModel.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/utils/controller_wrapper.dart';
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
  static final String selectedPickupDateKey = "selectedPickupDate";
  static final String selectedReturnDateKey = "selectedReturnDate";

  final TextEditingController _bookingReferenceController = TextEditingController();
  final TextEditingController _companyController = TextEditingController();
  final TextEditingController _pickupLocationController = TextEditingController();
  final TextEditingController _pickupTimeController = TextEditingController();
  final TextEditingController _returnLocationController = TextEditingController();
  final TextEditingController _returnTimeController = TextEditingController();
  final TextEditingController _carDescriptionController = TextEditingController();
  final TextEditingController _carNumberPlateController = TextEditingController();
  final TextEditingController _notesController = TextEditingController();

  Map datesToSet = {
    selectedPickupDateKey: MyControllerWrapper(),
    selectedReturnDateKey: MyControllerWrapper(),
  };

  final rentalCarFormKey = GlobalKey<FormState>();

  String siteTitle = 'Add Rental Car';
  final String alertTitle = "Submit Successful!";
  final String alertText =
      "You've just submitted the booking information for your rental car booking. You can see all the information in the trip overview";

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _bookingReferenceController.dispose();
    _companyController.dispose();
    _pickupLocationController.dispose();
    _pickupTimeController.dispose();
    _returnLocationController.dispose();
    _returnTimeController.dispose();
    _carDescriptionController.dispose();
    _carNumberPlateController.dispose();
    _notesController.dispose();
    datesToSet[selectedPickupDateKey].displayController.dispose();
    datesToSet[selectedReturnDateKey].displayController.dispose();
    datesToSet[selectedPickupDateKey].controller.dispose();
    datesToSet[selectedReturnDateKey].controller.dispose();
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
                      child: optionalFormField(_bookingReferenceController, Icon(Icons.confirmation_number),
                          "Booking Reference"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: requiredFormField(_companyController, Icon(Icons.supervised_user_circle),
                          "Company"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Pick Up Information"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: optionalFormField(_pickupLocationController, Icon(Icons.location_on),
                          "Pick Up Location"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: dateFormField(datesToSet[selectedPickupDateKey].displayController, Icon(Icons.date_range),
                          "Pick Up Date", context, selectedPickupDateKey, datesToSet),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: ListTile(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Return Information"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: optionalFormField(_returnLocationController, Icon(Icons.location_on),
                          "Return Location"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      // TODO add constraint that this cannot be before pickup date
                      child: dateFormField(datesToSet[selectedReturnDateKey].displayController, Icon(Icons.date_range),
                          "Return Date", context, selectedReturnDateKey, datesToSet),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: ListTile(
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
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Car Details"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: optionalFormField(_carDescriptionController, Icon(Icons.directions_car),
                          "Car Description"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: optionalFormField(_carNumberPlateController, Icon(Icons.directions_car),
                          "Car Plate"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: optionalFormField(_notesController, Icon(Icons.speaker_notes),
                          "Notes"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: Container(
                        child: submitButton(context, Theme.of(context).primaryColor,
                            Theme.of(context).primaryColor, validateForm, () async {
                          RentalCarModel rentalCar = new RentalCarModel(
                              bookingReference: _bookingReferenceController.text,
                              company: _companyController.text,
                              pickupLocation: _pickupLocationController.text,
                              pickupDate: datesToSet[selectedPickupDateKey].controller.text,
                              pickupTime: _pickupTimeController.text,
                              returnLocation: _returnLocationController.text,
                              returnDate: datesToSet[selectedReturnDateKey].controller.text,
                              returnTime: _returnTimeController.text,
                              carDescription: _carDescriptionController.text,
                              carNumberPlate: _carNumberPlateController.text,
                              notes: _notesController.text);
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
