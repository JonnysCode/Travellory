import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/services/add_database.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/form_field.dart';
import 'package:travellory/widgets/section_titles.dart';
import 'package:travellory/widgets/show_dialog.dart';
import 'package:travellory/widgets/date_form_field.dart';
import 'package:travellory/widgets/time_form_field.dart';

class Flight extends StatefulWidget {
  @override
  _FlightState createState() => _FlightState();
}

class _FlightState extends State<Flight> {
  final flightFormKey = GlobalKey<FormState>();
  final FlightModel flightModel = FlightModel();
  final DatabaseAdder databaseAdder = DatabaseAdder();

  final _depDateFormFieldKey = GlobalKey<DateFormFieldState>();

  bool validateForm() {
    return flightFormKey.currentState.validate();
  }

  final String alertText =
      "You've just submitted the booking information for your flight booking. You can see all the information in the trip overview";

  final String cancelText =
      'You are about to abort this booking entry. Do you want to go back to the previous site and discard your changes?';

  @override
  Widget build(BuildContext context) {
    final TripModel _tripModel = ModalRoute.of(context).settings.arguments;

    void returnToTripScreen() {
      Navigator.pop(context);
    }

    return Scaffold(
      key: Key('Flight'),
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
                  key: flightFormKey,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: BookingSiteTitle('Add Flight', Icons.time_to_leave),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('General Information'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Booking Reference',
                          icon: Icon(Icons.confirmation_number),
                          optional: true,
                          onChanged: (value) => flightModel.bookingReference = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Airline *',
                          icon: Icon(Icons.flight),
                          optional: false,
                          onChanged: (value) => flightModel.airline = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Flight Number',
                          icon: Icon(Icons.confirmation_number),
                          optional: true,
                          onChanged: (value) => flightModel.flightNr = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Seat',
                          icon: Icon(Icons.airline_seat_recline_normal),
                          optional: true,
                          onChanged: (value) => flightModel.seat = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('Pick Up Information'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Departure Location *',
                          icon: Icon(Icons.location_on),
                          optional: false,
                          onChanged: (value) => flightModel.departureLocation = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: DateFormField(
                        key: _depDateFormFieldKey,
                        labelText: "Departure Date *",
                        icon: Icon(Icons.date_range),
                        optional: false,
                        chosenDateString: (value) => flightModel.departureDate = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TimeFormField(
                          labelText: "Departure Time *",
                          icon: Icon(Icons.access_time),
                          optional: false,
                          chosenTimeString: (value) => flightModel.departureTime = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle("Arrival Information"),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Arrival Location *',
                          icon: Icon(Icons.location_on),
                          optional: false,
                          onChanged: (value) => flightModel.arrivalLocation = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: DateFormField(
                        labelText: "Arrival Date",
                        icon: Icon(Icons.date_range),
                        beforeDateKey: _depDateFormFieldKey,
                        optional: true,
                        dateValidationMessage: "Arrival Date cannot be before Departure Date",
                        chosenDateString: (value) => flightModel.arrivalDate = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TimeFormField(
                          labelText: "Arrival Time",
                          icon: Icon(Icons.access_time),
                          optional: true,
                          chosenTimeString: (value) => flightModel.arrivalTime = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                        labelText: "Notes",
                        icon: Icon(Icons.speaker_notes),
                        optional: true,
                        onChanged: (value) => flightModel.notes = value,
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
                              databaseAdder.addModel(flightModel, 'booking-addFlight');
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
                            cancellingDialog(context, cancelText);
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
