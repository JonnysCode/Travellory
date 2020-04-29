import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'add_activity.dart';

class EditActivity extends Activity {
  EditActivity({
    Key key,
    this.activityModel,
  }) : super(key: key);

  final ActivityModel activityModel;

  @override
  _EditActivityState createState() => _EditActivityState();
}

class _EditActivityState extends ActivityState<EditActivity> {
  // TODO(antilyas): overwrite submit button for editing maybe ?

  @override
  Widget build(BuildContext context) {
    final TripsProvider tripsProvider = Provider.of<TripsProvider>(context, listen: false);
    final TripModel tripModel = tripsProvider.selectedTrip;
    ActivityModel _activityModel = tripsProvider.selectedActivity;
    final int _selectedIndex = _activityModel.imageNr - 1;

    return Scaffold(
      key: Key('EditActivity'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: getContent(context, tripsProvider, tripModel, _selectedIndex),
      ),
    );
  }
}
