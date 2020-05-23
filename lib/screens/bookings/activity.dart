import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/widgets/bookings/edit.dart';
import 'package:travellory/services/database/edit_database.dart';
import 'package:travellory/shared/lists_of_types.dart';
import 'package:travellory/widgets/bookings/bookings_get_buttons.dart';
import 'package:travellory/widgets/forms/dropdown.dart';
import 'package:travellory/widgets/forms/form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';
import 'package:travellory/widgets/forms/date_form_field.dart';
import 'package:travellory/widgets/forms/time_form_field.dart';
import 'package:travellory/widgets/trip/trip_header.dart';
import 'package:travellory/services/api/google_places.dart';
import 'package:google_maps_webservice/places.dart';

class Activity extends StatefulWidget {
  static const route = '/booking/activity';

  @override
  ActivityState createState() => ActivityState();
}

class ActivityState<T extends Activity> extends State<T> {
  final GlobalKey<FormState> activityFormKey = GlobalKey<FormState>();
  final GlobalKey<DateFormFieldState> _startDateFormFieldKey = GlobalKey<DateFormFieldState>();
  final GlobalKey<DateFormFieldState> _endDateFormFieldKey = GlobalKey<DateFormFieldState>();

  ActivityModel _activityModel;

  static const int _imageItemCount = 13;

  bool validateForm() {
    return activityFormKey.currentState.validate();
  }

  final String alertText =
      "You've just submitted the booking information for your activity booking."
      "You can see all the information in the trip overview";

  final String cancelText =
      'You are about to abort this booking entry. '
      'Do you want to go back to the previous site and discard your changes?';

  int _selectedIndex;

  @override
  void initState() {
    _activityModel = ActivityModel();
    _selectedIndex = 0;
    _activityModel.imageNr = 1;
    super.initState();
  }

  Column _getActivityContent(BuildContext context, SingleTripProvider singleTripProvider,
      TripModel tripModel, ActivityModel model, bool isNewModel) {
    // set activityModel instance to edit or new model
    ActivityModel _editActivityModel = ActivityModel();
    _editActivityModel = ActivityModel.fromData(model.toMap());
    _activityModel = _editActivityModel;

    // need to set selecetedIndex for editModel
    if(!isNewModel) {
      _selectedIndex = _editActivityModel.imageNr - 1;
    }

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
                  child: BookingSiteTitle('Activity', FontAwesomeIcons.fortAwesome),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Category'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryDropdownField(
                      initialValue: _editActivityModel.category,
                      title: 'Select Category',
                      types: activityTypes,
                      onChanged: (value) {
                        _editActivityModel.category = value.name;
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
                      initialValue: _editActivityModel.title,
                      labelText: 'Activity Title *',
                      icon: Icon(FontAwesomeIcons.star),
                      optional: false,
                      onChanged: (value) => _editActivityModel.title = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _editActivityModel.description,
                      labelText: 'Description',
                      icon: Icon(FontAwesomeIcons.info),
                      optional: true,
                      onChanged: (value) => _editActivityModel.description = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Schedule'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _editActivityModel.location,
                      labelText: 'Location *',
                      icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                      optional: false,
                      onTap: (controller) async {
                        final PlacesDetailsResponse detail =
                            await GooglePlaces.openGooglePlacesSearch(context,
                                countryCode: tripModel.countryCode);

                        controller.text = detail.result.formattedAddress;
                        _editActivityModel.location = detail.result.formattedAddress;
                        _editActivityModel.latitude = detail.result.geometry.location.lat;
                        _editActivityModel.longitude = detail.result.geometry.location.lng;
                      },
                      onChanged: (value) => _editActivityModel.location = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: DateFormField(
                    initialValue: _editActivityModel.startDate,
                    key: _startDateFormFieldKey,
                    listenerKey: _endDateFormFieldKey,
                    labelText: 'Start Date *',
                    icon: Icon(FontAwesomeIcons.calendarAlt),
                    optional: false,
                    tripModel: tripModel,
                    model: _editActivityModel,
                    chosenDateString: (value) => _editActivityModel.startDate = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TimeFormField(
                      initialValue: _editActivityModel.startTime,
                      labelText: 'Start Time',
                      icon: Icon(FontAwesomeIcons.clock),
                      optional: true,
                      chosenTimeString: (value) => _editActivityModel.startTime = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: DateFormField(
                    key: _endDateFormFieldKey,
                    initialValue: _editActivityModel.endDate,
                    labelText: 'End Date *',
                    icon: Icon(FontAwesomeIcons.calendarAlt),
                    beforeDateKey: _startDateFormFieldKey,
                    optional: false,
                    tripModel: tripModel,
                    model: _editActivityModel,
                    dateValidationMessage: 'End Date cannot be before Start Date',
                    chosenDateString: (value) => _editActivityModel.endDate = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TimeFormField(
                      initialValue: _editActivityModel.endTime,
                      labelText: 'End Time',
                      icon: Icon(FontAwesomeIcons.clock),
                      optional: true,
                      chosenTimeString: (value) => _editActivityModel.endTime = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Notes'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                    initialValue: _editActivityModel.notes,
                    labelText: 'Notes',
                    icon: Icon(FontAwesomeIcons.stickyNote),
                    optional: true,
                    onChanged: (value) => _editActivityModel.notes = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: getSubmitButton(context, singleTripProvider, _editActivityModel,
                      isNewModel, DatabaseAdder.addActivity, DatabaseEditor.editActivity,
                      alertText, validateForm),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 2, left: 15, right: 15),
                    child: getBookingCancelButton(
                      context,
                      () {
                        _editActivityModel = model;
                        cancellingDialog(context, cancelText);
                      },
                    )),
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

    final ModifyModelArguments arguments = ModalRoute.of(context).settings.arguments;
    final ActivityModel _activityModel = arguments.model;

    return Scaffold(
      key: Key('Activity'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: _getActivityContent(
            context, singleTripProvider, tripModel, _activityModel, arguments.isNewModel),
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
