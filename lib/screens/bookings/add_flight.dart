import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/edit_database.dart';
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
  Flight({Key key}) : super(key: key);

  @override
  FlightState createState() => FlightState();
}

class FlightState<T extends Flight> extends State<T> {
  final GlobalKey<FormState> flightFormKey = GlobalKey<FormState>();
  FlightModel _flightModel = FlightModel();
  final DatabaseAdder databaseAdder = DatabaseAdder();

  final GlobalKey<DateFormFieldState> _depDateFormFieldKey = GlobalKey<DateFormFieldState>();

  bool validateForm() {
    return flightFormKey.currentState.validate();
  }

  final String alertText =
      "You've just submitted the booking information for your flight booking. You can see all the information in the trip overview";

  final String cancelText =
      'You are about to abort this booking entry. Do you want to go back to the previous site and discard your changes?';

  /* returns either submit new activity booking or edit old booking button */
  Padding _getSubmitButton(
      SingleTripProvider singleTripProvider, FlightModel model, bool isNewModel) {
    void Function() onSubmit;
    if (isNewModel) {
      onSubmit =
          onSubmitBooking(
              singleTripProvider, model, 'booking-addFlight', context, alertText);
    } else {
      onSubmit = onEditBooking(singleTripProvider, model, context, errorMessage);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: SubmitButton(
        highlightColor: Theme.of(context).primaryColor,
        fillColor: Theme.of(context).primaryColor,
        validationFunction: validateForm,
        onSubmit: onSubmit,
      ),
    );
  }

  Column getContent(BuildContext context, SingleTripProvider singleTripProvider,
      TripModel tripModel, FlightModel model, bool isNewModel) {
    // set activityModel instance to edit or new model
    _flightModel = model;

    return Column(
      children: <Widget>[
        TripHeader(tripModel),
        Expanded(
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
                    initialValue: _flightModel.bookingReference,
                      labelText: 'Booking Reference',
                      icon: Icon(FontAwesomeIcons.ticketAlt),
                      optional: true,
                      onChanged: (value) => _flightModel.bookingReference = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _flightModel.airline,
                      labelText: 'Airline *',
                      icon: Icon(FontAwesomeIcons.plane),
                      optional: false,
                      onChanged: (value) => _flightModel.airline = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _flightModel.flightNr,
                      labelText: 'Flight Number',
                      icon: Icon(FontAwesomeIcons.ticketAlt),
                      optional: true,
                      onChanged: (value) => _flightModel.flightNr = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _flightModel.seat,
                      labelText: 'Seat',
                      icon: Icon(FontAwesomeIcons.chair),
                      optional: true,
                      onChanged: (value) => _flightModel.seat = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: CheckboxFormField(
                    initialValue: _flightModel.checkedBaggage,
                    label: 'Does your flight ticket include checked baggage?',
                    onChanged: (value) {
                      _flightModel.checkedBaggage = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: CheckboxFormField(
                    initialValue: _flightModel.excessBaggage,
                    label: 'Does your flight ticket include excess baggage?',
                    onChanged: (value) {
                      _flightModel.excessBaggage = value;
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
                      initialValue: _flightModel.departureLocation,
                      labelText: 'Departure Location *',
                      icon: Icon(FontAwesomeIcons.planeDeparture),
                      optional: false,
                      onChanged: (value) => _flightModel.departureLocation = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: DateFormField(
                    initialValue: _flightModel.departureDate,
                    key: _depDateFormFieldKey,
                    labelText: 'Departure Date *',
                    icon: Icon(FontAwesomeIcons.calendarAlt),
                    optional: false,
                    tripModel: tripModel,
                    chosenDateString: (value) => _flightModel.departureDate = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TimeFormField(
                      initialValue: _flightModel.departureTime,
                      labelText: 'Departure Time *',
                      icon: Icon(FontAwesomeIcons.clock),
                      optional: false,
                      chosenTimeString: (value) => _flightModel.departureTime = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Arrival Information'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _flightModel.arrivalLocation,
                      labelText: 'Arrival Location *',
                      icon: Icon(FontAwesomeIcons.planeArrival),
                      optional: false,
                      onChanged: (value) => _flightModel.arrivalLocation = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: DateFormField(
                    initialValue: _flightModel.arrivalDate,
                    labelText: 'Arrival Date',
                    icon: Icon(FontAwesomeIcons.calendarAlt),
                    beforeDateKey: _depDateFormFieldKey,
                    optional: true,
                    tripModel: tripModel,
                    dateValidationMessage: 'Arrival Date cannot be before Departure Date',
                    chosenDateString: (value) => _flightModel.arrivalDate = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TimeFormField(
                      initialValue: _flightModel.arrivalTime,
                      labelText: 'Arrival Time',
                      icon: Icon(FontAwesomeIcons.clock),
                      optional: false,
                      chosenTimeString: (value) => _flightModel.arrivalTime = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Notes'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                    initialValue: _flightModel.notes,
                    labelText: 'Notes',
                    icon: Icon(FontAwesomeIcons.stickyNote),
                    optional: true,
                    onChanged: (value) => _flightModel.notes = value,
                  ),
                ),
                _getSubmitButton(singleTripProvider, _flightModel, isNewModel),
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
    );
  }

  @override
  Widget build(BuildContext context) {
    final SingleTripProvider singleTripProvider =
        Provider.of<TripsProvider>(context, listen: false).selectedTrip;
    final TripModel tripModel = singleTripProvider.tripModel;
    _flightModel.tripUID = tripModel.uid;

    return Scaffold(
      key: Key('Flight'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: getContent(context, singleTripProvider, tripModel, _flightModel, true),
      ),
    );
  }
}
