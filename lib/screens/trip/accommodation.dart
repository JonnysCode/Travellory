import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/services/add_database.dart';
import 'package:travellory/utils/date_converter.dart';
import 'package:travellory/utils/list_models.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/checkbox_form_field.dart';
import 'package:travellory/widgets/dropdown.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/form_field.dart';
import 'package:travellory/widgets/form_widgets.dart';
import 'package:travellory/widgets/section_titles.dart';
import 'package:travellory/widgets/show_dialog.dart';
import 'package:travellory/widgets/date_form_field.dart';
import 'package:travellory/widgets/time_form_field.dart';

class Accommodation extends StatefulWidget {
  @override
  _AccommodationState createState() => new _AccommodationState();
}

class _AccommodationState extends State<Accommodation> {
  ListModel<Widget> accommodationList;
  final accommodationFormKey = GlobalKey<FormState>();
  final AccommodationModel accommodationModel = AccommodationModel();
  final DatabaseAdder databaseAdder = DatabaseAdder();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final _checkinDateFormFieldKey = GlobalKey<DateFormFieldState>();

  TravelloryDropdownField accommodationTypeDropdown;
  Widget hotelAdditional;
  Widget airbnbAdditional;

  bool validateForm() {
    return accommodationFormKey.currentState.validate();
  }

  @override
  void initState() {
    super.initState();

    accommodationTypeDropdown = TravelloryDropdownField(
        title: 'Select Accommodation Type',
        types: types,
        onChanged: (value) {
          accommodationModel.accommodationType = value.name;
          showAdditional(accommodationList, value.name == 'Airbnb', accommodationTypeDropdown,
              airbnbAdditional);
          showAdditional(
              accommodationList, value.name == 'Hotel', accommodationTypeDropdown, hotelAdditional);
        },
        validatorText: 'Please enter the required information');

    // don't put in build because it will be recreated on every build
    // with state changes this is not appreciated
    List<Widget> shown = [
      BookingSiteTitle("Add Accommodation", Icons.hotel),
      SectionTitle("Accommodation Type"),
      accommodationTypeDropdown,
      SectionTitle('General Information'),
      TravelloryFormField(
          labelText: "Confirmation Number",
          icon: Icon(Icons.confirmation_number),
          optional: true,
          onChanged: (value) => accommodationModel.confirmationNr = value),
      TravelloryFormField(
          labelText: "Name *",
          icon: Icon(Icons.supervised_user_circle),
          optional: false,
          onChanged: (value) => accommodationModel.hotelName = value),
      TravelloryFormField(
        labelText: "Address *",
        icon: Icon(Icons.location_on),
        optional: false,
        onChanged: (value) => accommodationModel.address = value,
      ),
      SectionTitle('Check-In Details'),
      DateFormField(
        key: _checkinDateFormFieldKey,
        labelText: "Check-In Date *",
        icon: Icon(Icons.date_range),
        optional: false,
        chosenDateString: (value) => accommodationModel.checkinDate = value,
      ),
      TimeFormField(
        labelText: "Check-In Time",
        icon: Icon(Icons.access_time),
        optional: true,
        chosenTimeString: (value) => accommodationModel.checkinTime = value,
      ),
      TravelloryFormField(
        labelText: "Nights *",
        icon: Icon(Icons.hotel),
        optional: false,
        onChanged: (value) => accommodationModel.nights = value,
      ),
      SectionTitle('Check-Out Details'),
      DateFormField(
        labelText: "Check-Out Date *",
        icon: Icon(Icons.date_range),
        beforeDateKey: _checkinDateFormFieldKey,
        optional: false,
        dateValidationMessage: "Check-out Date cannot be before Check-in Date",
        chosenDateString: (value) => accommodationModel.checkoutDate = value,
      ),
      TimeFormField(
        labelText: "Check-Out Time",
        icon: Icon(Icons.access_time),
        optional: true,
        chosenTimeString: (value) => accommodationModel.checkoutTime = value,
      ),
      SectionTitle("Notes"),
      TravelloryFormField(
        labelText: "Notes",
        icon: Icon(Icons.speaker_notes),
        optional: true,
        onChanged: (value) => accommodationModel.notes = value,
      ),
      SubmitButton(),
      CancelButton(),
      SizedBox(height: 20),
    ];

    // this builds the animated list
    accommodationList = ListModel<Widget>(
      listKey: _listKey,
      initialItems: shown,
      removedItemBuilder: _removedItemBuilder,
    );

    airbnbAdditional = Column(
      children: <Widget>[
        TravelloryFormField(
          labelText: "Specific type of airbnb",
          icon: Icon(Icons.hotel),
          optional: true,
          onChanged: (value) => accommodationModel.accommodationType = value,
        ),
      ],
    );

    hotelAdditional = Column(
      children: <Widget>[
        SectionTitle("Further Hotel Details"),
        TravelloryFormField(
          labelText: "Room Type",
          icon: Icon(Icons.hotel),
          optional: true,
          onChanged: (value) => accommodationModel.roomType = value,
        ),
        CheckboxFormField(
          initialValue: false,
          label: 'Does your stay include breakfast??',
          onChanged: (value) {
            accommodationModel.breakfast = value;
          },
        ),
      ],
    );
  }

  final String alertText =
      "You've just submitted the booking information for your accommodation booking. You can see all the information in the trip overview";

  final String cancelText =
      'You are about to abort this booking entry. Do you want to go back to the previous site and discard your changes?';

  List<Item> types = <Item>[
    const Item('Hotel', Icon(Icons.hotel, color: const Color(0xFF167F67))),
    const Item('Airbnb', Icon(Icons.hotel, color: const Color(0xFF167F67))),
    const Item('Hostel', Icon(Icons.hotel, color: const Color(0xFF167F67))),
    const Item('Motel', Icon(Icons.hotel, color: const Color(0xFF167F67))),
    const Item('Bed & Breakfast', Icon(Icons.hotel, color: const Color(0xFF167F67))),
    const Item('Other', Icon(Icons.hotel, color: const Color(0xFF167F67))),
  ];

  Widget _itemBuilder(BuildContext context, int index, Animation<double> animation) {
    return FormItem(animation: animation, child: accommodationList[index]);
  }

  Widget _removedItemBuilder(BuildContext context, Widget item, Animation<double> animation) {
    return FormItem(animation: animation, child: item);
  }

  @override
  Widget build(BuildContext context) {
    final TripModel _tripModel = ModalRoute.of(context).settings.arguments;

    void returnToTripScreen() {
      Navigator.pop(context);
    }

    // replace widget to get the context
    accommodationList[accommodationList.length - 3] = SubmitButton(
        highlightColor: Theme.of(context).primaryColor,
        fillColor: Theme.of(context).primaryColor,
        validationFunction: validateForm,
        onSubmit: () async {
          databaseAdder.addModel(accommodationModel, 'booking-addAccommodation');
          showSubmittedBookingDialog(context, alertText, returnToTripScreen);
        });

    accommodationList[accommodationList.length - 2] = CancelButton(
      text: "CANCEL",
      onCancel: () {
        cancellingDialog(context, cancelText);
      },
    );

    return Scaffold(
      key: Key('Accommodation'),
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
                child: Container(
              height: double.infinity,
              child: Form(
                key: accommodationFormKey,
                child: Column(
                  children: <Widget>[
                    Expanded(
                      child: AnimatedList(
                        key: _listKey,
                        initialItemCount: accommodationList.length,
                        itemBuilder: _itemBuilder,
                      ),
                    ),
                  ],
                ),
              ),
            )),
          ],
        ),
      ),
    );
  }
}
