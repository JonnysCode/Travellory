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
  _EditActivityState createState() => _EditActivityState(activityModel);
}

class _EditActivityState extends ActivityState<EditActivity> {
  _EditActivityState(ActivityModel activityModel) {
    _activityModel = activityModel;
  }

  ActivityModel _activityModel;

//  int _selectedIndex;
//
//  @override
//  void initState() {
//    _selectedIndex = activityModel.imageNr - 1;
//    super.initState();
//  }

  // TODO(antilyas): overwrite submit button for editing maybe ?

  @override
  Widget build(BuildContext context) {
    final TripsProvider tripsProvider = Provider.of<TripsProvider>(context, listen: false);
    final TripModel tripModel = tripsProvider.selectedTrip;
//    Provider.of<TripsProvider>(context, listen: false)..selectedActivity = _activityModel;

    return Scaffold(
      key: Key('EditActivity'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: getContent(context, tripsProvider, tripModel),
      ),
    );
  }
}
