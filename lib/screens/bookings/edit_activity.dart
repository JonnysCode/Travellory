import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/services/database/edit_database.dart';
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
  final DatabaseEditor databaseEditor = DatabaseEditor();

  int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = activityModel.imageNr - 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TripsProvider tripsProvider = Provider.of<TripsProvider>(context, listen: false);
    final TripModel tripModel = tripsProvider.selectedTrip;

    return Scaffold(
      key: Key('Activity'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: getContent(context, tripsProvider, tripModel, this.activityModel),
      ),
    );
  }
}