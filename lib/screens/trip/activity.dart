import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/services/add_database.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/dropdown.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/form_field.dart';
import 'package:travellory/widgets/section_titles.dart';
import 'package:travellory/widgets/show_dialog.dart';
import 'package:travellory/widgets/date_form_field.dart';
import 'package:travellory/widgets/time_form_field.dart';

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
    const Item('Historic', Icon(FontAwesomeIcons.landmark, color: const Color(0xFF167F67))),
    const Item('Outdoors', Icon(FontAwesomeIcons.mountain, color: const Color(0xFF167F67))),
    const Item('Culture', Icon(FontAwesomeIcons.diagnoses, color: const Color(0xFF167F67))),
    const Item('Social', Icon(FontAwesomeIcons.users, color: const Color(0xFF167F67))),
    const Item('Relaxing', Icon(FontAwesomeIcons.hotTub, color: const Color(0xFF167F67))),
    const Item('Adventure', Icon(FontAwesomeIcons.hiking, color: const Color(0xFF167F67))),
    const Item('Dining', Icon(FontAwesomeIcons.utensils, color: const Color(0xFF167F67))),
    const Item('Other', Icon(FontAwesomeIcons.futbol, color: const Color(0xFF167F67))),
  ];

  @override
  Widget build(BuildContext context) {
    final TripModel _tripModel = ModalRoute.of(context).settings.arguments;

    void returnToTripScreen() {
      Navigator.pop(context);
    }

    return Scaffold(
      key: Key('Activity'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            Container(
              height: 190,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(80)),
                color: Color(0xFFCCD7DD),
              ),
              child: Stack(
                children: <Widget>[
                  Positioned(
                    top: 0,
                    right: 0,
                    child: IconButton(
                      onPressed: () => returnToTripScreen(),
                      icon: FaIcon(FontAwesomeIcons.times),
                      iconSize: 26,
                      color: Colors.red,
                    ),
                  ),
                  Positioned(
                    top: -30,
                    left: -40,
                    child: Hero(
                      tag: 'trip_image${_tripModel.index.toString()}',
                      child: Container(
                        height: 220,
                        width: 220,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(_tripModel.imagePath),
                            fit: BoxFit.fitWidth,
                            alignment: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    left: 180,
                    child: Container(
                      padding: EdgeInsets.only(top: 40, left: 10, right: 10),
                      alignment: Alignment.topLeft,
                      width: MediaQuery.of(context).size.width,
                      constraints: BoxConstraints(
                          maxHeight: 100.0, maxWidth: MediaQuery.of(context).size.width - 200),
                      child: FashionFetishText(
                        text: _tripModel.name,
                        size: 24,
                        fontWeight: FashionFontWeight.HEAVY,
                        height: 1.05,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 110,
                    left: 190,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        FashionFetishText(
                            text: 'From: ${DateConverter.format(_tripModel.startDate)}' +
                                '\n' +
                                'To: ${DateConverter.format(_tripModel.endDate)}',
                            color: Colors.black54,
                            fontWeight: FashionFontWeight.BOLD,
                            size: 14,
                            height: 1.25),
                        SizedBox(
                          height: 12,
                        ),
                        Row(
                          children: <Widget>[
                            Icon(
                              FontAwesomeIcons.locationArrow,
                              size: 15,
                              color: Colors.redAccent,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 6, left: 3),
                              child: FashionFetishText(
                                text: _tripModel.destination,
                                size: 14,
                                fontWeight: FashionFontWeight.HEAVY,
                                color: Colors.black54,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
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
                            ;
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
                        labelText: "Start Date *",
                        icon: Icon(Icons.date_range),
                        optional: false,
                        chosenDateString: (value) => activityModel.startDate = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TimeFormField(
                          labelText: "Start Time",
                          icon: Icon(Icons.access_time),
                          optional: true,
                          chosenTimeString: (value) => activityModel.startTime = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: DateFormField(
                        labelText: "End Date *",
                        icon: Icon(Icons.date_range),
                        beforeDateKey: _startDateFormFieldKey,
                        optional: false,
                        dateValidationMessage: "End Date cannot be before Start Date",
                        chosenDateString: (value) => activityModel.endDate = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TimeFormField(
                          labelText: "End Time",
                          icon: Icon(Icons.access_time),
                          optional: true,
                          chosenTimeString: (value) => activityModel.endTime = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                        labelText: "Notes",
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
                            onSubmit: () async {
                              databaseAdder.addModel(activityModel, 'booking-addActivity');
                              showSubmittedBookingDialog(context, alertText, returnToTripScreen);
                            }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 2, left: 15, right: 15),
                      child: Container(
                        child: CancelButton(
                          text: "CANCEL",
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
