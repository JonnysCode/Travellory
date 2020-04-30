import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'add_flight.dart';

class EditFlight extends Flight {
  EditFlight({
    Key key,
  }) : super(key: key);

  @override
  _EditFlightState createState() => _EditFlightState();
}

class _EditFlightState extends FlightState<EditFlight> {
  @override
  Widget build(BuildContext context) {
    final SingleTripProvider singleTripProvider =
        Provider.of<TripsProvider>(context, listen: false).selectedTrip;
    final TripModel tripModel = singleTripProvider.tripModel;

    final FlightModel _flightModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: Key('EditActivity'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: getContent(context, singleTripProvider, tripModel, _flightModel, false),
      ),
    );
  }
}
