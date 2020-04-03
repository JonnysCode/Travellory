import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/dropdown.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/section_titles.dart';
import 'package:travellory/widgets/show_dialog.dart';
import 'package:travellory/widgets/form_fields.dart';

class PublicTransport extends StatefulWidget {
  @override
  _PublicTransportState createState() => new _PublicTransportState();
}

class _PublicTransportState extends State<PublicTransport> {
  final FormFieldWidget _typeFormField =
      FormFieldWidget("Type of Transportation *", Icon(Icons.train));
  final FormFieldWidget _companyFormField =
      FormFieldWidget("Company", Icon(Icons.supervised_user_circle));
  final FormFieldWidget _specificTypeFormField =
      FormFieldWidget("Specific Type of Transportation", Icon(Icons.train));
  final FormFieldWidget _bookingReferenceFormField =
      FormFieldWidget("Booking Reference", Icon(Icons.confirmation_number));
  final FormFieldWidget _bookingCompanyFormField =
      FormFieldWidget("Company", Icon(Icons.supervised_user_circle));
  final FormFieldWidget _seatFormField =
      FormFieldWidget("Seat", Icon(Icons.airline_seat_recline_normal));
  final FormFieldWidget _depLocationFormField =
      FormFieldWidget("Departure Location *", Icon(Icons.location_on));
  final FormFieldDateWidget _depDateFormField =
      FormFieldDateWidget("Departure Date *", Icon(Icons.date_range));
  final FormFieldTimeWidget _depTimeFormField =
      FormFieldTimeWidget("Departure Time *", Icon(Icons.access_time));
  final FormFieldWidget _arrLocationFormField =
      FormFieldWidget("Arrival Location *", Icon(Icons.location_on));
  final FormFieldDateWidget _arrDateFormField = FormFieldDateWidget(
      "Arrival Date", Icon(Icons.date_range), "Arrival date cannot be before departure date.");
  final FormFieldTimeWidget _arrTimeFormField =
      FormFieldTimeWidget("Arrival Time", Icon(Icons.access_time));
  final FormFieldWidget _notesFormField = FormFieldWidget("Notes", Icon(Icons.speaker_notes));

  final publicTransportFormKey = GlobalKey<FormState>();

  bool bookingBool = false;
  bool seatBool = false;

  void bookingCheckbox(bool value) {
    setState(() => bookingBool = value);
  }

  void seatCheckbox(bool value) {
    setState(() => seatBool = value);
  }

  final String alertText =
      "You've just submitted the booking information for your public transportation booking. You can see all the information in the trip overview";

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _typeFormField.dispose();
    _companyFormField.dispose();
    _specificTypeFormField.dispose();
    _bookingReferenceFormField.dispose();
    _bookingCompanyFormField.dispose();
    _seatFormField.dispose();
    _depLocationFormField.dispose();
    _depDateFormField.dispose();
    _depTimeFormField.dispose();
    _arrLocationFormField.dispose();
    _arrDateFormField.dispose();
    _arrTimeFormField.dispose();
    _notesFormField.dispose();
    super.dispose();
  }

  Item selectedType;
  List<Item> types = <Item>[
    const Item('Rail', Icon(Icons.directions_railway, color: const Color(0xFF167F67))),
    const Item('Bus', Icon(Icons.directions_bus, color: const Color(0xFF167F67))),
    const Item('Metro', Icon(Icons.train, color: const Color(0xFF167F67))),
    const Item('Ferry', Icon(Icons.directions_boat, color: const Color(0xFF167F67))),
    const Item('Taxi', Icon(Icons.directions_car, color: const Color(0xFF167F67))),
    const Item('Uber', Icon(Icons.directions_car, color: const Color(0xFF167F67))),
    const Item('Other', Icon(Icons.directions_walk, color: const Color(0xFF167F67))),
  ];

  void updateDropdown(Item newValue) {
    setState(() => selectedType = newValue);
  }

  @override
  Widget build(BuildContext context) {
    final TripModel _tripModel = ModalRoute.of(context).settings.arguments;

    void returnToTripScreen() {
      Navigator.pop(context);
    }

    bool validateForm() {
      return publicTransportFormKey.currentState.validate();
    }

    return Scaffold(
      key: Key('Public Transport'),
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
                  key: publicTransportFormKey,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: bookingSiteTitle(context, "Add Public Transport", Icons.train),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Type of Transportation"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: dropdownField('Select Transport Type', selectedType, types,
                          context, 'Please enter the required information', updateDropdown),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _companyFormField.required(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _specificTypeFormField.optional(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Departure Information"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _depLocationFormField.required(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _depDateFormField.firstDate(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _depTimeFormField.timeRequired(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Arrival Information"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _arrLocationFormField.required(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _arrDateFormField.secondDate(context, _depDateFormField),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _arrTimeFormField.time(context),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Booking Details"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15, bottom: 0),
                      child: checkbox(
                          bookingBool, 'Did you book this public transport?', bookingCheckbox),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
                      child: checkbox(seatBool, 'Did you make a seat reservation?', seatCheckbox),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Further Booking Details"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _bookingReferenceFormField.optional(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _bookingCompanyFormField.optional(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _seatFormField.optional(),
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
                            Theme.of(context).primaryColor,
                            validateForm, () async {
                          final PublicTransportModel publicTransport = new PublicTransportModel(
                              transportationType: _typeFormField.controller.text,
                              company: _companyFormField.controller.text,
                              specificType: _specificTypeFormField.controller.text,
                              booked: bookingBool,
                              seatReservation: seatBool,
                              reference: _bookingReferenceFormField.controller.text,
                              companyReservation: _bookingCompanyFormField.controller.text,
                              seat: _seatFormField.controller.text,
                              departureLocation: _depLocationFormField.controller.text,
                              departureDate: _depDateFormField.controller.text,
                              departureTime: _depTimeFormField.controller.text,
                              arrivalLocation: _arrLocationFormField.controller.text,
                              arrivalDate: _arrDateFormField.controller.text,
                              arrivalTime: _arrTimeFormField.controller.text,
                              notes: _notesFormField.controller.text);
                          _addPublicTransport(publicTransport);
                          showSubmittedBookingDialog(context, alertText, returnToTripScreen);
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, left: 15, right: 15),
                      child: Container(
                        child: cancelButton("CANCEL", context, () {
                          cancellingDialog(context);
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

void _addPublicTransport(PublicTransportModel publicTransport) async {
  final HttpsCallable callable =
      CloudFunctions.instance.getHttpsCallable(functionName: 'booking-addPublicTransport');
  try {
    final HttpsCallableResult result = await callable.call(<String, dynamic>{
      "transportationType": publicTransport.transportationType,
      "company": publicTransport.company,
      "specificType": publicTransport.specificType,
      "booked": publicTransport.booked,
      "seatReservation": publicTransport.seatReservation,
      "reference": publicTransport.reference,
      "companyReservation": publicTransport.companyReservation,
      "seat": publicTransport.seat,
      "departureLocation": publicTransport.departureLocation,
      "departureDate": publicTransport.departureDate,
      "departureTime": publicTransport.departureTime,
      "arrivalLocation": publicTransport.arrivalLocation,
      "arrivalDate": publicTransport.arrivalDate,
      "arrivalTime": publicTransport.arrivalTime,
      "notes": publicTransport.notes
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