import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'add_activity.dart';

class EditActivity extends Activity {
  EditActivity({
    Key key,
  }) : super(key: key);

  @override
  _EditActivityState createState() => _EditActivityState();
}

class _EditActivityState extends ActivityState<EditActivity> {
  @override
  Widget build(BuildContext context) {
    final SingleTripProvider singleTripProvider =
        Provider.of<TripsProvider>(context, listen: false).selectedTrip;
    final TripModel tripModel = singleTripProvider.tripModel;

    final ActivityModel _activityModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: Key('EditActivity'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: getContent(context, singleTripProvider, tripModel, _activityModel, false),
      ),
    );
  }
}
