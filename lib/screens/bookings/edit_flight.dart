import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/services/database/edit.dart';
import 'add_flight.dart';

class EditFlight extends Flight {
  static final route = '/edit/flight';

  @override
  _EditFlightState createState() => _EditFlightState();
}

class _EditFlightState extends FlightState<EditFlight> {
  @override
  Widget build(BuildContext context) {
    final SingleTripProvider singleTripProvider =
        Provider.of<TripsProvider>(context, listen: false).selectedTrip;
    final TripModel tripModel = singleTripProvider.tripModel;

    final ModifyModelArguments arguments = ModalRoute.of(context).settings.arguments;
    final FlightModel _flightModel = arguments.model;

    return Scaffold(
      key: Key('EditFlight'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: getContent(context, singleTripProvider, tripModel, _flightModel, arguments.isNewModel),
      ),
    );
  }
}
