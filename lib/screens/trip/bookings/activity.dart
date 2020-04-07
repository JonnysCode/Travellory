import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/services/add_database.dart';
import 'package:travellory/widgets/booking_related.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/dropdown.dart';
import 'package:travellory/widgets/form_field.dart';
import 'package:travellory/widgets/section_titles.dart';
import 'package:travellory/widgets/show_dialog.dart';
import 'package:travellory/widgets/date_form_field.dart';
import 'package:travellory/widgets/time_form_field.dart';

import 'header.dart';

class Activity extends StatefulWidget {
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final activityFormKey = GlobalKey<FormState>();
  final ActivityModel activityModel = ActivityModel();
  final DatabaseAdder databaseAdder = DatabaseAdder();

  final _startDateFormFieldKey = GlobalKey<DateFormFieldState>();

  bool validateForm() {
    return activityFormKey.currentState.validate();
  }

  final String alertText =
      "You've just submitted the booking information for your activity booking."
      "You can see all the information in the trip overview";

  List<Item> types = <Item>[
    const Item('Historic', Icon(FontAwesomeIcons.landmark, color: Color(0xFF167F67))),
    const Item('Outdoors', Icon(FontAwesomeIcons.mountain, color: Color(0xFF167F67))),
    const Item('Culture', Icon(FontAwesomeIcons.diagnoses, color: Color(0xFF167F67))),
    const Item('Social', Icon(FontAwesomeIcons.users, color: Color(0xFF167F67))),
    const Item('Relaxing', Icon(FontAwesomeIcons.hotTub, color: Color(0xFF167F67))),
    const Item('Adventure', Icon(FontAwesomeIcons.hiking, color: Color(0xFF167F67))),
    const Item('Dining', Icon(FontAwesomeIcons.utensils, color: Color(0xFF167F67))),
    const Item('Other', Icon(FontAwesomeIcons.futbol, color: Color(0xFF167F67))),
  ];

  @override
  Widget build(BuildContext context) {
    final TripModel tripModel = ModalRoute.of(context).settings.arguments;

    return Scaffold(
      key: Key('Activity'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            getBookingHeader(context, tripModel),
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
                          title: 'Select Category',
                          types: types,
                          onChanged: (value) {
                            activityModel.category = value.name;
                          },
                          validatorText: 'Please enter the required information'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('More Details'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Activity Title *',
                          icon: Icon(FontAwesomeIcons.star),
                          optional: false,
                          onChanged: (value) => activityModel.title = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Description',
                          icon: Icon(FontAwesomeIcons.info),
                          optional: true,
                          onChanged: (value) => activityModel.description = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('Schedule'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Location',
                          icon: Icon(Icons.location_on),
                          optional: false,
                          onChanged: (value) => activityModel.location = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: DateFormField(
                        key: _startDateFormFieldKey,
                        labelText: 'Start Date *',
                        icon: Icon(Icons.date_range),
                        optional: false,
                        chosenDateString: (value) => activityModel.startDate = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TimeFormField(
                          labelText: 'Start Time',
                          icon: Icon(Icons.access_time),
                          optional: true,
                          chosenTimeString: (value) => activityModel.startTime = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: DateFormField(
                        labelText: 'End Date *',
                        icon: Icon(Icons.date_range),
                        beforeDateKey: _startDateFormFieldKey,
                        optional: false,
                        dateValidationMessage: 'End Date cannot be before Start Date',
                        chosenDateString: (value) => activityModel.endDate = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TimeFormField(
                          labelText: 'End Time',
                          icon: Icon(Icons.access_time),
                          optional: true,
                          chosenTimeString: (value) => activityModel.endTime = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('Notes'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                        labelText: 'Notes',
                        icon: Icon(Icons.speaker_notes),
                        optional: true,
                        onChanged: (value) => activityModel.notes = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: Container(
                        child: SubmitButton(
                          highlightColor: Theme.of(context).primaryColor,
                          fillColor: Theme.of(context).primaryColor,
                          validationFunction: validateForm,
                          onSubmit: onSubmitBooking(
                              activityModel, 'booking-addActivity', context, alertText),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, left: 15, right: 15),
                      child: Container(
                        child: CancelButton(
                          text: 'CANCEL',
                          onCancel: () {
                            cancellingDialog(context);
                          },
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
