import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/utils/list_models.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/form_fields_new.dart';
import 'package:travellory/widgets/section_titles.dart';
import 'package:travellory/widgets/show_dialog.dart';

class RentalCar extends StatefulWidget {
  @override
  _RentalCarState createState() => _RentalCarState();
}

class _RentalCarState extends State<RentalCar> {
  ListModel<Widget> rentalCarList;
  final rentalCarFormKey = GlobalKey<FormState>();
  final FlightModel rentalCarModel = FlightModel();

  final _pickUpDateFormFieldKey = GlobalKey<YDateFormFieldState>();

  bool validateForm() {
    return rentalCarFormKey.currentState.validate();
  }

  final String alertText =
      "You've just submitted the booking information for your rental car booking. You can see all the information in the trip overview";

  @override
  Widget build(BuildContext context) {
    final TripModel _tripModel = ModalRoute.of(context).settings.arguments;

    void returnToTripScreen() {
      Navigator.pop(context);
    }

    return Scaffold(
      key: Key('Rental Car'),
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
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () => returnToTripScreen(),
                      icon: FaIcon(FontAwesomeIcons.times),
                      iconSize: 26,
                      color: Colors.red,
                    ),
                  ),
                  Positioned(
                    top: -30,
                    left: -40,
                    child: Hero(
                      tag: 'trip_image${_tripModel.index.toString()}',
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
                            text: 'From: ${DateConverter.format(_tripModel.startDate)}' +
                                '\n' +
                                'To: ${DateConverter.format(_tripModel.endDate)}',
                            color: Colors.black54,
                            fontWeight: FashionFontWeight.BOLD,
                            size: 14,
                            height: 1.25),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.locationArrow,
                              size: 15,
                              color: Colors.redAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6, left: 3),
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
                ],
              ),
            ),
            Expanded(
              //child: Form(
              child: SingleChildScrollView(
                child: Form(
                  key: rentalCarFormKey,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: BookingSiteTitle('Add Rental Car', Icons.time_to_leave),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('General Information'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: YFormField(
                          labelText: 'Booking Reference',
                          icon: Icon(Icons.confirmation_number),
                          optional: true,
                          onChanged: (value) => rentalCarModel.bookingReference = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: YFormField(
                          labelText: 'Company *',
                          icon: Icon(Icons.supervised_user_circle),
                          optional: false,
                          onChanged: (value) => rentalCarModel.company = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('Pick Up Information'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: YFormField(
                          labelText: 'Pick Up Location',
                          icon: Icon(Icons.location_on),
                          optional: true,
                          onChanged: (value) => rentalCarModel.pickupLocation = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: YDateFormField(
                        key: _pickUpDateFormFieldKey,
                        labelText: "Pick Up Date *",
                        icon: Icon(Icons.date_range),
                        chosenDateString: (value) => rentalCarModel.pickupDate = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: YTimeFormField(
                          labelText: "Pick Up Time",
                          icon: Icon(Icons.access_time),
                          optional: true,
                          chosenTimeString: (value) => rentalCarModel.pickupTime = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle("Return Information"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: YFormField(
                          labelText: 'Return Location',
                          icon: Icon(Icons.location_on),
                          optional: true,
                          onChanged: (value) => rentalCarModel.returnLocation = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: YDateFormField(
                        labelText: "Return Date *",
                        icon: Icon(Icons.date_range),
                        beforeDateKey: _pickUpDateFormFieldKey,
                        dateValidationMessage: "Return Date cannot be before Pick Up Date",
                        chosenDateString: (value) => rentalCarModel.returnDate = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: YTimeFormField(
                          labelText: "Return Time",
                          icon: Icon(Icons.access_time),
                          optional: true,
                          chosenTimeString: (value) => rentalCarModel.returnTime = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle("Car Details"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: YFormField(
                          labelText: 'Car Description',
                          icon: Icon(Icons.directions_car),
                          optional: true,
                          onChanged: (value) => rentalCarModel.carDescription = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: YFormField(
                          labelText: 'Car Plate',
                          icon: Icon(Icons.directions_car),
                          optional: true,
                          onChanged: (value) => rentalCarModel.carNumberPlate = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: YFormField(
                        labelText: "Notes",
                        icon: Icon(Icons.speaker_notes),
                        optional: true,
                        onChanged: (value) => rentalCarModel.notes = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: Container(
                        child: SubmitButton(
                            highlightColor: Theme.of(context).primaryColor,
                            fillColor: Theme.of(context).primaryColor,
                            validationFunction: validateForm,
                            onSubmit: () async {
                              _addRentalCar(rentalCarModel);
                              showSubmittedBookingDialog(context, alertText, returnToTripScreen);
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, left: 15, right: 15),
                      child: Container(
                        child: CancelButton(
                          text: "CANCEL",
                          onCancel: () {
                            cancellingDialog(context);
                          },
                        ),
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

void _addRentalCar(FlightModel rentalCarModel) async {
  final HttpsCallable callable =
      CloudFunctions.instance.getHttpsCallable(functionName: 'booking-addRentalCar');
  try {
    final HttpsCallableResult result = await callable.call(rentalCarModel.toMap());
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
