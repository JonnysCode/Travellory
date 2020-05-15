import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/edit_database.dart';
import 'package:travellory/widgets/bookings/bookings_get_buttons.dart';
import 'package:travellory/widgets/forms/checkbox_form_field.dart';
import 'package:travellory/widgets/forms/form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';
import 'package:travellory/widgets/forms/date_form_field.dart';
import 'package:travellory/widgets/forms/time_form_field.dart';
import 'package:travellory/widgets/trip/trip_header.dart';
import 'package:travellory/services/database/edit.dart';

class Flight extends StatefulWidget {
  static final route = '/booking/flight';

  @override
  FlightState createState() => FlightState();
}

class FlightState<T extends Flight> extends State<T> {
  final GlobalKey<FormState> flightFormKey = GlobalKey<FormState>();

  final GlobalKey<DateFormFieldState> _depDateFormFieldKey = GlobalKey<DateFormFieldState>();
  final GlobalKey<DateFormFieldState> _arrDateFormFieldKey = GlobalKey<DateFormFieldState>();

  bool validateForm() {
    return flightFormKey.currentState.validate();
  }

  final String alertText =
      "You've just submitted the booking information for your flight booking. "
      "You can see all the information in the trip overview";

  final String cancelText =
      'You are about to abort this booking entry. '
      'Do you want to go back to the previous site and discard your changes?';

  Column _getFlightContent(BuildContext context, SingleTripProvider singleTripProvider,
      TripModel tripModel, FlightModel model, bool isNewModel) {
    FlightModel _editFlightModel = FlightModel();
    _editFlightModel = FlightModel.fromData(model.toMap());

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
                  child: BookingSiteTitle('Flight', FontAwesomeIcons.plane),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('General Information'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _editFlightModel.bookingReference,
                      labelText: 'Booking Reference',
                      icon: Icon(FontAwesomeIcons.ticketAlt),
                      optional: true,
                      onChanged: (value) => _editFlightModel.bookingReference = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _editFlightModel.airline,
                      labelText: 'Airline *',
                      icon: Icon(FontAwesomeIcons.plane),
                      optional: false,
                      onChanged: (value) => _editFlightModel.airline = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _editFlightModel.flightNr,
                      labelText: 'Flight Number',
                      icon: Icon(FontAwesomeIcons.ticketAlt),
                      optional: true,
                      onChanged: (value) => _editFlightModel.flightNr = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _editFlightModel.seat,
                      labelText: 'Seat',
                      icon: Icon(FontAwesomeIcons.chair),
                      optional: true,
                      onChanged: (value) => _editFlightModel.seat = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: CheckboxFormField(
                    initialValue: _editFlightModel.checkedBaggage,
                    label: 'Does your flight ticket include checked baggage?',
                    onChanged: (value) {
                      _editFlightModel.checkedBaggage = value;
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: CheckboxFormField(
                    initialValue: _editFlightModel.excessBaggage,
                    label: 'Does your flight ticket include excess baggage?',
                    onChanged: (value) {
                      _editFlightModel.excessBaggage = value;
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
                      initialValue: _editFlightModel.departureLocation,
                      labelText: 'Departure Location *',
                      icon: Icon(FontAwesomeIcons.planeDeparture),
                      optional: false,
                      onChanged: (value) => _editFlightModel.departureLocation = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: DateFormField(
                    initialValue: _editFlightModel.departureDate,
                    key: _depDateFormFieldKey,
                    listenerKey: _arrDateFormFieldKey,
                    labelText: 'Departure Date *',
                    icon: Icon(FontAwesomeIcons.calendarAlt),
                    optional: false,
                    tripModel: tripModel,
                    model: _editFlightModel,
                    chosenDateString: (value) => _editFlightModel.departureDate = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TimeFormField(
                      initialValue: _editFlightModel.departureTime,
                      labelText: 'Departure Time *',
                      icon: Icon(FontAwesomeIcons.clock),
                      optional: false,
                      chosenTimeString: (value) => _editFlightModel.departureTime = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Arrival Information'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _editFlightModel.arrivalLocation,
                      labelText: 'Arrival Location *',
                      icon: Icon(FontAwesomeIcons.planeArrival),
                      optional: false,
                      onChanged: (value) => _editFlightModel.arrivalLocation = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: DateFormField(
                    key: _arrDateFormFieldKey,
                    initialValue: _editFlightModel.arrivalDate,
                    labelText: 'Arrival Date *',
                    icon: Icon(FontAwesomeIcons.calendarAlt),
                    beforeDateKey: _depDateFormFieldKey,
                    optional: false,
                    tripModel: tripModel,
                    model: _editFlightModel,
                    dateValidationMessage: 'Arrival Date cannot be before Departure Date',
                    chosenDateString: (value) => _editFlightModel.arrivalDate = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TimeFormField(
                      initialValue: _editFlightModel.arrivalTime,
                      labelText: 'Arrival Time *',
                      icon: Icon(FontAwesomeIcons.clock),
                      optional: false,
                      chosenTimeString: (value) => _editFlightModel.arrivalTime = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Notes'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                    initialValue: _editFlightModel.notes,
                    labelText: 'Notes',
                    icon: Icon(FontAwesomeIcons.stickyNote),
                    optional: true,
                    onChanged: (value) => _editFlightModel.notes = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: getSubmitButton(context, singleTripProvider, _editFlightModel, isNewModel,
                      DatabaseAdder.addFlight, DatabaseEditor.editFlight, alertText, validateForm),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 2, left: 15, right: 15),
                    child: getBookingCancelButton(
                      context,
                      () {
                        _editFlightModel = model;
                        cancellingDialog(context, cancelText);
                      },
                    )),
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

    final ModifyModelArguments _arguments = ModalRoute.of(context).settings.arguments;
    final FlightModel _flightModel = _arguments.model;

    return Scaffold(
      key: Key('Flight'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child:
            _getFlightContent(context, singleTripProvider, tripModel, _flightModel, _arguments.isNewModel),
      ),
    );
  }
}
