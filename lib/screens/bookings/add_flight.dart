import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/submit.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/forms/checkbox_form_field.dart';
import 'package:travellory/widgets/forms/form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';
import 'package:travellory/widgets/forms/date_form_field.dart';
import 'package:travellory/widgets/forms/time_form_field.dart';
import 'package:travellory/widgets/trip/trip_header.dart';

class Flight extends StatefulWidget {
  @override
  _FlightState createState() => _FlightState();
}

class _FlightState extends State<Flight> {
  final GlobalKey<FormState> flightFormKey = GlobalKey<FormState>();
  final FlightModel flightModel = FlightModel();
  final DatabaseAdder databaseAdder = DatabaseAdder();

  final GlobalKey<DateFormFieldState> _depDateFormFieldKey = GlobalKey<DateFormFieldState>();

  bool validateForm() {
    return flightFormKey.currentState.validate();
  }

  final String alertText =
      "You've just submitted the booking information for your flight booking. You can see all the information in the trip overview";

  final String cancelText =
      'You are about to abort this booking entry. Do you want to go back to the previous site and discard your changes?';

  @override
  Widget build(BuildContext context) {
    final TripModel tripModel = ModalRoute.of(context).settings.arguments;
    flightModel.tripUID = tripModel.uid;

    return Scaffold(
      key: Key('Flight'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            TripHeader(tripModel),
            Expanded(
              //child: Form(
              child: SingleChildScrollView(
                child: Form(
                  key: flightFormKey,
                  child: Column(children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: BookingSiteTitle('Add Flight', FontAwesomeIcons.plane),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('General Information'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Booking Reference',
                          icon: Icon(FontAwesomeIcons.ticketAlt),
                          optional: true,
                          onChanged: (value) => flightModel.bookingReference = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Airline *',
                          icon: Icon(FontAwesomeIcons.plane),
                          optional: false,
                          onChanged: (value) => flightModel.airline = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Flight Number',
                          icon: Icon(FontAwesomeIcons.ticketAlt),
                          optional: true,
                          onChanged: (value) => flightModel.flightNr = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Seat',
                          icon: Icon(FontAwesomeIcons.chair),
                          optional: true,
                          onChanged: (value) => flightModel.seat = value),
                    ),
                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: CheckboxFormField(
                    initialValue: false,
                    label: 'Does your flight ticket include checked baggage?',
                    onChanged: (value) {
                      flightModel.checkedBaggage = value;
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                    child: CheckboxFormField(
                      initialValue: false,
                      label: 'Does your flight ticket include excess baggage?',
                      onChanged: (value) {
                        flightModel.excessBaggage = value;
                      },
                    ),
                ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('Pick Up Information'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Departure Location *',
                          icon: Icon(FontAwesomeIcons.planeDeparture),
                          optional: false,
                          onChanged: (value) => flightModel.departureLocation = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: DateFormField(
                        key: _depDateFormFieldKey,
                        labelText: 'Departure Date *',
                        icon: Icon(FontAwesomeIcons.calendarAlt),
                        optional: false,
                        chosenDateString: (value) => flightModel.departureDate = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TimeFormField(
                          labelText: 'Departure Time *',
                          icon: Icon(FontAwesomeIcons.clock),
                          optional: false,
                          chosenTimeString: (value) => flightModel.departureTime = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('Arrival Information'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Arrival Location *',
                          icon: Icon(FontAwesomeIcons.planeArrival),
                          optional: false,
                          onChanged: (value) => flightModel.arrivalLocation = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: DateFormField(
                        labelText: 'Arrival Date',
                        icon: Icon(FontAwesomeIcons.calendarAlt),
                        beforeDateKey: _depDateFormFieldKey,
                        optional: true,
                        dateValidationMessage: 'Arrival Date cannot be before Departure Date',
                        chosenDateString: (value) => flightModel.arrivalDate = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TimeFormField(
                          labelText: 'Arrival Time',
                          icon: Icon(FontAwesomeIcons.clock),
                          optional: true,
                          chosenTimeString: (value) => flightModel.arrivalTime = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('Notes'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                        labelText: 'Notes',
                        icon: Icon(FontAwesomeIcons.stickyNote),
                        optional: true,
                        onChanged: (value) => flightModel.notes = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: SubmitButton(
                          highlightColor: Theme.of(context).primaryColor,
                          fillColor: Theme.of(context).primaryColor,
                          validationFunction: validateForm,
                          onSubmit: onSubmitBooking(flightModel, 'booking-addFlight', context,
                              alertText),
                        ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, left: 15, right: 15),
                        child: CancelButton(
                          text: 'CANCEL',
                          onCancel: () {
                            cancellingDialog(context, cancelText);
                          },
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
