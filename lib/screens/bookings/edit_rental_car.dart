import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/screens/bookings/add_rental_car.dart';
import 'package:travellory/services/database/edit.dart';

class EditRentalCar extends RentalCar {
  @override
  _EditRentalCarState createState() => _EditRentalCarState();
}

class _EditRentalCarState extends RentalCarState<EditRentalCar> {
  @override
  Widget build(BuildContext context) {
    final SingleTripProvider singleTripProvider =
        Provider.of<TripsProvider>(context, listen: false).selectedTrip;
    final TripModel tripModel = singleTripProvider.tripModel;

    final ModifyModelArguments arguments = ModalRoute.of(context).settings.arguments;
    final RentalCarModel _rentalCarModel = arguments.model;

    return Scaffold(
      key: Key('EditRentalCar'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: getContent(context, singleTripProvider, tripModel, _rentalCarModel, arguments.isNewModel),
      ),
    );
  }
}
