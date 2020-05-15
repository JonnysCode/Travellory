import 'package:flutter/material.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/widgets/trip/trip_form.dart';

class EditTrip extends StatelessWidget {
  static final route = '/edittrip';

  @override
  Widget build(BuildContext context) {
    final TripModel tripModel = ModalRoute.of(context).settings.arguments;

    return SafeArea(
      child: Scaffold(
        key: Key('edit_trip'),
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: TripForm.edit(
            tripModel: tripModel,
          ),
        ),
      ),
    );
  }
}