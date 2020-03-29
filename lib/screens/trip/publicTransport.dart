import 'package:cloud_functions/cloud_functions.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/RentalCarModel.dart';
import 'package:travellory/models/publicTransportModel.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/widgets/buttons.dart';
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
  final FormFieldWidget _checkboxBookingFormField =
      FormFieldWidget("Checkbox Booking", Icon(Icons.confirmation_number));
  final FormFieldWidget _checkboxSeatFormField =
      FormFieldWidget("Checkbox Seat", Icon(Icons.airline_seat_recline_normal));
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

  final String alertText =
      "You've just submitted the booking information for your public transportation booking. You can see all the information in the trip overview";

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    _typeFormField.dispose();
    _companyFormField.dispose();
    _specificTypeFormField.dispose();
    _checkboxBookingFormField.dispose();
    _checkboxSeatFormField.dispose();
    _bookingReferenceFormField.dispose();
    _bookingCompanyFormField.dispose();
    _seatFormField.dispose();
    _notesFormField.dispose();
    _depLocationFormField.dispose();
    _depDateFormField.dispose();
    _depTimeFormField.dispose();
    _arrLocationFormField.dispose();
    _arrDateFormField.dispose();
    _arrTimeFormField.dispose();
    _notesFormField.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final TripModel _tripModel = ModalRoute.of(context).settings.arguments;

    void returnToTripScreen() {
      Navigator.pushReplacementNamed(context, '/viewtrip', arguments: _tripModel);
    }

    bool validateForm() {
      return (publicTransportFormKey.currentState.validate());
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
                            text: 'From: ' +
                                DateConverter.toShortenedMonthString(_tripModel.startDate) +
                                '\n' +
                                'To: ' +
                                DateConverter.toShortenedMonthString(_tripModel.endDate),
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
                  key: publicTransportFormKey,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: bookingSiteTitle(context, "Add Public Transport Booking", Icons.train),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: sectionTitle(context, "Type of Transportation"),
                    ),
                    // TODO add type dropdown
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _typeFormField.required(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _companyFormField.required(),
                    ),
                    // TODO specific type only when type is other
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
                    // TODO checkbox for booking
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _checkboxBookingFormField.optional(),
                    ),
                    // TODO checkbox for seat
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _checkboxSeatFormField.optional(),
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
                          PublicTransportModel publicTransport = new PublicTransportModel(
                              transportationType: _typeFormField.controller.text,
                              company: _companyFormField.controller.text,
                              specificType: _specificTypeFormField.controller.text,
                              //booked: _checkboxBookedFormField.controller.text,
                              //seatReservation: _CheckboxSeatFormField.controller.text,
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

void _addPublicTransport(PublicTransportModel publicTransport) async {
  HttpsCallable callable =
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

//old code
//
//String dropdownValue = 'Select';
//bool _valueBooking = false;
//bool _valueSeatReservation = false;
//
//void _valueBookingChanged(bool value) =>
//    setState(() => _valueBooking = value);
//
//void _valueSeatReservationChanged(bool value) =>
//    setState(() => _valueSeatReservation = value);
//
//Widget typeDropdown = Container(
//  padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
//  child: ButtonTheme(
//    alignedDropdown: true,
//    child: DropdownButton<String>(
//      value: dropdownValue,
//      icon: Icon(Icons.arrow_downward),
//      iconSize: 24,
//      elevation: 16,
//      style: TextStyle(color: Theme.of(context).primaryColor),
//      underline: Container(
//        height: 2,
//        color: Theme.of(context).primaryColor,
//      ),
//      onChanged: (String newValue) {
//        setState(() {
//          dropdownValue = newValue;
//        });
//      },
//      items: <String>[
//        'Select',
//        'Rail',
//        'Bus',
//        'Metro',
//        'Ferry',
//        'Taxi',
//        'Uber',
//        'Other'
//      ].map<DropdownMenuItem<String>>((String value) {
//        return DropdownMenuItem<String>(
//          value: value,
//          child: Text(value),
//        );
//      }).toList(),
//    ),
//  ),
//);
//
//Widget reservations = Container(
//  padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 50.0),
//  child: new Column(
//    children: <Widget>[
//      new CheckboxListTile(
//          value: _valueBooking,
//          onChanged: _valueBookingChanged,
//          title: new Text(
//            'Did you book this public transport?',
//            style: TextStyle(fontSize: 16),
//          ),
//          controlAffinity: ListTileControlAffinity.leading),
//      new CheckboxListTile(
//          value: _valueSeatReservation,
//          onChanged: _valueSeatReservationChanged,
//          title: new Text(
//            'Did you make a seat reservation?',
//            style: TextStyle(fontSize: 16),
//          ),
//          controlAffinity: ListTileControlAffinity.leading),
//    ],
//  ),
//);
