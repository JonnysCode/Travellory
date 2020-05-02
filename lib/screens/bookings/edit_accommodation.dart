import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/screens/bookings/add_accommodation.dart';
import 'package:travellory/services/database/submit.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';

class EditAccommodation extends Accommodation {
  EditAccommodation({
    Key key,
  }) : super(key: key);

  @override
  _EditAccommodationState createState() => _EditAccommodationState();
}

class _EditAccommodationState extends AccommodationState<EditAccommodation> {

//  @override
//  Widget build(BuildContext context) {
//    final SingleTripProvider singleTripProvider =
//        Provider.of<TripsProvider>(context, listen: false).selectedTrip;
//    final TripModel tripModel = singleTripProvider.tripModel;
//
//    final AccommodationModel _accommodationModel = ModalRoute.of(context).settings.arguments;
//
//    return Scaffold(
//      key: Key('EditAccommodation'),
//      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//      body: Container(
//        color: Colors.white,
////        child: getContent(context, singleTripProvider, tripModel, _accommodationModel, false),
//      ),
//    );
//  }

  @override
  Widget build(BuildContext context) {
    final SingleTripProvider singleTripProvider =
        Provider.of<TripsProvider>(context, listen: false).selectedTrip;
    final TripModel tripModel = singleTripProvider.tripModel;

    final AccommodationModel _accommodationModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: Key('EditAccommodation'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: getContent(tripModel, singleTripProvider, context),
      ),
    );
  }
}
