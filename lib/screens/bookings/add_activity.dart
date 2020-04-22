import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/services/database/add_database.dart';
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
  @override
  _ActivityState createState() => _ActivityState();
}

class _ActivityState extends State<Activity> {
  final GlobalKey<FormState> activityFormKey = GlobalKey<FormState>();
  final ActivityModel activityModel = ActivityModel();
  final DatabaseAdder databaseAdder = DatabaseAdder();

  static const int _imageItemCount = 13;

  final GlobalKey<DateFormFieldState> _startDateFormFieldKey =
      GlobalKey<DateFormFieldState>();

  bool validateForm() {
    return activityFormKey.currentState.validate();
  }

  final String alertText =
      "You've just submitted the booking information for your activity booking."
      "You can see all the information in the trip overview";

  final String cancelText =
      'You are about to abort this booking entry. Do you want to go back to the previous site and discard your changes?';

  List<Item> types = <Item>[
    const Item(
        'Historic', Icon(FontAwesomeIcons.landmark, color: Color(0xFF167F67))),
    const Item(
        'Outdoors', Icon(FontAwesomeIcons.mountain, color: Color(0xFF167F67))),
    const Item(
        'Culture', Icon(FontAwesomeIcons.diagnoses, color: Color(0xFF167F67))),
    const Item(
        'Social', Icon(FontAwesomeIcons.users, color: Color(0xFF167F67))),
    const Item(
        'Relaxing', Icon(FontAwesomeIcons.hotTub, color: Color(0xFF167F67))),
    const Item(
        'Adventure', Icon(FontAwesomeIcons.hiking, color: Color(0xFF167F67))),
    const Item(
        'Dining', Icon(FontAwesomeIcons.utensils, color: Color(0xFF167F67))),
    const Item(
        'Other', Icon(FontAwesomeIcons.futbol, color: Color(0xFF167F67))),
  ];

//  ActivityModel activityModel;
  int _selectedIndex;

  @override
  void initState() {
    _selectedIndex = 0;
    activityModel.imageNr = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final TripsProvider tripsProvider = Provider.of<TripsProvider>(context, listen: false);
    final TripModel tripModel = tripsProvider.selectedTrip;
    activityModel.tripUID = tripModel.uid;

    return Scaffold(
      key: Key('Activity'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            TripHeader(tripModel),
            Expanded(
              //child: Form(
              child: SingleChildScrollView(
                child: Form(
                  key: activityFormKey,
                  child: Column(children: <Widget>[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: BookingSiteTitle(
                          'Add Activity', FontAwesomeIcons.fortAwesome),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('Category'),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryDropdownField(
                          title: 'Select Category',
                          types: types,
                          onChanged: (value) {
                            activityModel.category = value.name;
                          },
                          validatorText:
                              'Please enter the required information'),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: _imageSelection(),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('More Details'),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Activity Title *',
                          icon: Icon(FontAwesomeIcons.star),
                          optional: false,
                          onChanged: (value) => activityModel.title = value),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Description',
                          icon: Icon(FontAwesomeIcons.info),
                          optional: true,
                          onChanged: (value) =>
                              activityModel.description = value),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('Schedule'),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Location *',
                          icon: Icon(Icons.location_on),
                          optional: false,
                          onChanged: (value) => activityModel.location = value),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: DateFormField(
                        key: _startDateFormFieldKey,
                        labelText: 'Start Date *',
                        icon: Icon(Icons.date_range),
                        optional: false,
                        chosenDateString: (value) =>
                            activityModel.startDate = value,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TimeFormField(
                          labelText: 'Start Time',
                          icon: Icon(Icons.access_time),
                          optional: true,
                          chosenTimeString: (value) =>
                              activityModel.startTime = value),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: DateFormField(
                        labelText: 'End Date *',
                        icon: Icon(Icons.date_range),
                        beforeDateKey: _startDateFormFieldKey,
                        optional: false,
                        dateValidationMessage:
                            'End Date cannot be before Start Date',
                        chosenDateString: (value) =>
                            activityModel.endDate = value,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TimeFormField(
                          labelText: 'End Time',
                          icon: Icon(Icons.access_time),
                          optional: true,
                          chosenTimeString: (value) =>
                              activityModel.endTime = value),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('Notes'),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                        labelText: 'Notes',
                        icon: Icon(Icons.speaker_notes),
                        optional: true,
                        onChanged: (value) => activityModel.notes = value,
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SubmitButton(
                        highlightColor: Theme.of(context).primaryColor,
                        fillColor: Theme.of(context).primaryColor,
                        validationFunction: validateForm,
                        onSubmit: onSubmitBooking(tripsProvider, activityModel,
                            'activity-addActivity', context, alertText),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 2, left: 15, right: 15),
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
        ),
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
      activityModel.imageNr = _selectedIndex + 1;
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
          padding: _selectedIndex == index
              ? const EdgeInsets.all(8.0)
              : const EdgeInsets.all(3.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(40.0),
            color:
                _selectedIndex == index ? Colors.black26 : Colors.transparent,
          ),
          child: Container(
            key: Key('image_icon'),
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                    'assets/images/activity/activity_${(index + 1).toString()}.png'),
                fit: BoxFit.fitWidth,
              ),
              borderRadius: BorderRadius.circular(33.0),
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 4,
                    color: Colors.black.withOpacity(.25),
                    offset: Offset(2.0, 2.0))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
