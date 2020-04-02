import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/form_fields.dart';
import 'package:travellory/widgets/section_titles.dart';
import 'package:travellory/widgets/show_dialog.dart';

class Accommodation extends StatefulWidget {
  @override
  _AccommodationState createState() => new _AccommodationState();
}

class _AccommodationState extends State<Accommodation> {
  final FormFieldWidget _typeFormField =
      FormFieldWidget("Type of Accommodation *", Icon(Icons.hotel));
  final FormFieldWidget _confirmationFormField =
      FormFieldWidget("Confirmation Number", Icon(Icons.confirmation_number));
  final FormFieldWidget _nameFormField =
      FormFieldWidget("Name *", Icon(Icons.supervised_user_circle));
  final FormFieldWidget _addressFormField = FormFieldWidget("Address *", Icon(Icons.location_on));
  final FormFieldDateWidget _checkinDateFormField =
      FormFieldDateWidget("Check-In Date *", Icon(Icons.date_range));
  final FormFieldTimeWidget _checkinTimeFormField =
      FormFieldTimeWidget("Check-In Time", Icon(Icons.access_time));
  final FormFieldWidget _nightsFormField = FormFieldWidget("Nights *", Icon(Icons.hotel));
  final FormFieldDateWidget _checkoutDateFormField =
      FormFieldDateWidget("Check-Out Date *", Icon(Icons.date_range));
  final FormFieldTimeWidget _checkoutTimeFormField =
      FormFieldTimeWidget("Check-Out Time", Icon(Icons.access_time));
  final FormFieldWidget _hotelRoomTypeFormField = FormFieldWidget("Room Type", Icon(Icons.hotel));
  final FormFieldWidget _airbnbTypeFormField =
      FormFieldWidget("Accommodation Type", Icon(Icons.hotel));
  final FormFieldWidget _notesFormField = FormFieldWidget("Notes", Icon(Icons.speaker_notes));

  final accommodationFormKey = GlobalKey<FormState>();

  bool breakfastBool = false;

  void breakfastCheckbox(bool value) {
    setState(() => breakfastBool = value);
  }

  final String alertText =
      "You've just submitted the booking information for your public transportation booking. You can see all the information in the trip overview";

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _typeFormField.dispose();
    _confirmationFormField.dispose();
    _nameFormField.dispose();
    _addressFormField.dispose();
    _checkinDateFormField.dispose();
    _checkinTimeFormField.dispose();
    _nightsFormField.dispose();
    _checkoutDateFormField.dispose();
    _checkoutTimeFormField.dispose();
    _hotelRoomTypeFormField.dispose();
    _airbnbTypeFormField.dispose();
    _notesFormField.dispose();
    super.dispose();
  }

  bool validateForm() {
    return (accommodationFormKey.currentState.validate());
  }

  @override
  Widget build(BuildContext context) {
    final TripModel _tripModel = ModalRoute.of(context).settings.arguments;

    void returnToTripScreen() {
      Navigator.pop(context);
    }

    return Scaffold(
      key: Key('Accommodation'),
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
                          maxHeight: 100.0,
                          maxWidth: MediaQuery.of(context).size.width - 200
                      ),
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
                            text: 'From: ${DateConverter.format( _tripModel.startDate)}'
                                + '\n'
                                + 'To: ${DateConverter.format( _tripModel.endDate)}',
                            color: Colors.black54,
                            fontWeight: FashionFontWeight.BOLD,
                            size: 14,
                            height: 1.25
                        ),
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
                  key: accommodationFormKey,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: bookingSiteTitle(context, "Add Accommodation", Icons.hotel),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "General Information"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _typeFormField.required(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _confirmationFormField.optional(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _nameFormField.required(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _addressFormField.required(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Check-In Information"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _checkinDateFormField.firstDate(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _checkinTimeFormField.time(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _nightsFormField.required(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Check-Out Information"),
                    ),
                    // TODO automatically calculate this date with nr of nights and checkin date
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _checkoutDateFormField.secondDate(context, _checkinDateFormField),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _checkoutTimeFormField.time(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Booking Information"),
                    ),
                    // TODO this only appears when type is hotel
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _hotelRoomTypeFormField.optional(),
                    ),
                    // TODO this only appears when type is hotel
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 0),
                      child: checkbox(
                          breakfastBool, 'Does your stay include breakfast?', breakfastCheckbox),
                    ),
                    // TODO this only appears when type is airbnb
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _airbnbTypeFormField.optional(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Notes"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _notesFormField.optional(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: Container(
                        child: submitButton(
                            context,
                            Theme.of(context).primaryColor,
                            // TODO handle bool from checkboxes
                            Theme.of(context).primaryColor,
                            validateForm, () async {
                          AccommodationModel accommodation = new AccommodationModel(
                              type: _typeFormField.controller.text,
                              hotelName: _nameFormField.controller.text,
                              confirmationNr: _confirmationFormField.controller.text,
                              address: _addressFormField.controller.text,
                              nights: _nightsFormField.controller.text,
                              checkinDate: _checkinDateFormField.controller.text,
                              checkinTime: _checkinTimeFormField.controller.text,
                              checkoutDate: _checkoutDateFormField.controller.text,
                              checkoutTime: _checkoutTimeFormField.controller.text,
                              breakfast: breakfastBool,
                              roomType: _hotelRoomTypeFormField.controller.text,
                              accommodationType: _airbnbTypeFormField.controller.text,
                              notes: _notesFormField.controller.text);
                          _addAccommodation(accommodation);
                          showSubmittedBookingDialog(context, alertText, returnToTripScreen);
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

void _addAccommodation(AccommodationModel accommodation) async {
  HttpsCallable callable =
      CloudFunctions.instance.getHttpsCallable(functionName: 'booking-addPublicTransport');
  try {
    final HttpsCallableResult result = await callable.call(<String, dynamic>{
      "type": accommodation.type,
      "hotelName": accommodation.hotelName,
      "confirmationNr": accommodation.confirmationNr,
      "address": accommodation.address,
      "nights": accommodation.nights,
      "checkinDate": accommodation.checkinDate,
      "checkinTime": accommodation.checkinTime,
      "checkoutDate": accommodation.checkoutDate,
      "checkoutTime": accommodation.checkoutTime,
      "breakfast": accommodation.breakfast,
      "roomType": accommodation.roomType,
      "accommodationType": accommodation.accommodationType,
      "notes": accommodation.notes
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

// old code

//bool _valueBreakfast = false;
//static String accommodationType = '';
//static List<String> types = ["Hotel", "Airbnb", "Hostel", "Motel", "Bed&Breakfast", "Other"];
//
//void _valueBreakfastChanged(bool value) => setState(() => _valueBreakfast = value);
//
//Widget dropdown = DropDownField(
//    value: accommodationType,
//    required: true,
//    strict: true,
//    labelText: 'Type of accommodation',
//    // icon: Icon(Icons.account_balance),
//    items: types,
//    setter: (dynamic newValue) {
//      accommodationType = newValue;
//    }
//);
//
//Widget breakfast = Container(
//  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
//  child: new Column(
//    children: <Widget>[
//      new CheckboxListTile(
//          value: _valueBreakfast,
//          onChanged: _valueBreakfastChanged,
//          title: new Text(
//            'Is breakfast included in your stay?',
//            style: TextStyle(fontSize: 16),
//          ),
//          controlAffinity: ListTileControlAffinity.leading
//      ),
//    ],
//  ),
//);
