import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/services/database/edit_database.dart';
import 'package:travellory/shared/lists_of_types.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/services/database/submit.dart';
import 'package:travellory/widgets/forms/dropdown.dart';
import 'package:travellory/widgets/forms/form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';
import 'package:travellory/widgets/forms/date_form_field.dart';
import 'package:travellory/widgets/forms/time_form_field.dart';
import 'package:travellory/widgets/trip/trip_header.dart';

class Activity extends StatefulWidget {
  Activity({Key key}) : super(key: key);

  @override
  ActivityState createState() => ActivityState();
}

class ActivityState<T extends Activity> extends State<T> {
  final GlobalKey<FormState> activityFormKey = GlobalKey<FormState>();
  final GlobalKey<DateFormFieldState> _startDateFormFieldKey = GlobalKey<DateFormFieldState>();

  ActivityModel _activityModel = ActivityModel();

  static const int _imageItemCount = 13;

  bool validateForm() {
    return activityFormKey.currentState.validate();
  }

  final String alertText =
      "You've just submitted the booking information for your activity booking."
      "You can see all the information in the trip overview";

  final String cancelText =
      'You are about to abort this booking entry. Do you want to go back to the previous site and discard your changes?';

  final String errorMessage = "Seems like there's a connection problem. "
      "Please check your internet connection and try submitting again.";

  int _selectedIndex;

  /* returns either submit new activity booking or edit old booking button */
  Padding _getSubmitButton(
      SingleTripProvider singleTripProvider, ActivityModel model, bool isNewModel) {
    void Function() onSubmit;
    if (isNewModel) {
      onSubmit =
          onSubmitBooking(singleTripProvider, model, 'activity-addActivity', context, alertText);
    } else {
      onSubmit = onEditBooking(singleTripProvider, model, context, errorMessage);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: SubmitButton(
        highlightColor: Theme.of(context).primaryColor,
        fillColor: Theme.of(context).primaryColor,
        validationFunction: validateForm,
        onSubmit: onSubmit,
      ),
    );
  }

  Column getContent(BuildContext context, SingleTripProvider singleTripProvider,
      TripModel tripModel, ActivityModel model, bool isNewModel) {
    // set activityModel instance to edit or new model
    _activityModel = model;

    // this selects the correct image for editing or adding the activity
    _selectedIndex = _activityModel.imageNr - 1;

    return Column(
      children: <Widget>[
        TripHeader(tripModel),
        Expanded(
          //child: Form(
          child: SingleChildScrollView(
            child: Form(
              key: activityFormKey,
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: BookingSiteTitle('Add Activity', FontAwesomeIcons.fortAwesome),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Category'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryDropdownField(
                      initialValue: _activityModel.category,
                      title: 'Select Category',
                      types: activityTypes,
                      onChanged: (value) {
                        _activityModel.category = value.name;
                      },
                      validatorText: 'Please enter the required information'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _imageSelection(),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('More Details'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _activityModel.title,
                      labelText: 'Activity Title *',
                      icon: Icon(FontAwesomeIcons.star),
                      optional: false,
                      onChanged: (value) => _activityModel.title = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _activityModel.description,
                      labelText: 'Description',
                      icon: Icon(FontAwesomeIcons.info),
                      optional: true,
                      onChanged: (value) => _activityModel.description = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Schedule'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _activityModel.location,
                      labelText: 'Location *',
                      icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                      optional: false,
                      onChanged: (value) => _activityModel.location = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: DateFormField(
                    initialValue: _activityModel.startDate,
                    key: _startDateFormFieldKey,
                    labelText: 'Start Date *',
                    icon: Icon(FontAwesomeIcons.calendarAlt),
                    optional: false,
                    chosenDateString: (value) => _activityModel.startDate = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TimeFormField(
                      initialValue: _activityModel.startTime,
                      labelText: 'Start Time',
                      icon: Icon(FontAwesomeIcons.clock),
                      optional: true,
                      chosenTimeString: (value) => _activityModel.startTime = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: DateFormField(
                    initialValue: _activityModel.endDate,
                    labelText: 'End Date *',
                    icon: Icon(FontAwesomeIcons.calendarAlt),
                    beforeDateKey: _startDateFormFieldKey,
                    optional: false,
                    dateValidationMessage: 'End Date cannot be before Start Date',
                    chosenDateString: (value) => _activityModel.endDate = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TimeFormField(
                      initialValue: _activityModel.endTime,
                      labelText: 'End Time',
                      icon: Icon(FontAwesomeIcons.clock),
                      optional: true,
                      chosenTimeString: (value) => _activityModel.endTime = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Notes'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                    initialValue: _activityModel.notes,
                    labelText: 'Notes',
                    icon: Icon(FontAwesomeIcons.stickyNote),
                    optional: true,
                    onChanged: (value) => _activityModel.notes = value,
                  ),
                ),
                _getSubmitButton(singleTripProvider, _activityModel, isNewModel),
                Padding(
                  padding: const EdgeInsets.only(top: 2, left: 15, right: 15),
                  child: CancelButton(
                    text: 'CANCEL',
                    onCancel: () {
                      cancellingDialog(context, cancelText);
                    },
                  ),
                ),
                SizedBox(height: 20),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final SingleTripProvider singleTripProvider =
        Provider.of<TripsProvider>(context, listen: false).selectedTrip;
    final TripModel tripModel = singleTripProvider.tripModel;
    _activityModel.tripUID = tripModel.uid;

    return Scaffold(
      key: Key('Activity'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: getContent(context, singleTripProvider, tripModel, _activityModel, true),
      ),
    );
  }

  Widget _imageSelection() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 96,
        child: ListView.separated(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: _imageItemCount,
          itemBuilder: (context, index) {
            return _imageItem(index);
          },
          separatorBuilder: (context, index) => const SizedBox(),
        ),
      ),
    );
  }

  void _selectImage(index) {
    setState(() {
      _selectedIndex = index;
      _activityModel.imageNr = _selectedIndex + 1;
    });
  }

  Widget _imageItem(int index) {
    return Center(
      child: GestureDetector(
        onTap: () => _selectImage(index),
        child: AnimatedContainer(
          duration: Duration(milliseconds: 200),
          height: _selectedIndex == index ? 80 : 72,
          width: _selectedIndex == index ? 80 : 72,
          padding: _selectedIndex == index ? const EdgeInsets.all(8.0) : const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color: _selectedIndex == index ? Colors.black26 : Colors.transparent,
          ),
          child: Container(
            key: Key('image_icon'),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/activity/activity_${(index + 1).toString()}.png'),
                fit: BoxFit.fitWidth,
              ),
              borderRadius: BorderRadius.circular(33.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 4, color: Colors.black.withOpacity(.25), offset: Offset(2.0, 2.0))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
