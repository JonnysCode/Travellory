import 'package:flutter/material.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/widgets/trip/trip_form.dart';

class CreateTrip extends StatelessWidget {
  static final route = '/createtrip';

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        key: Key('create_trip'),
        backgroundColor: Theme.of(context).primaryColor,
        body: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: TripForm.create(
            tripModel: TripModel(),
          ),
        ),
      ),
    );
  }
}
