import 'package:flutter/material.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/services/add_database.dart';
import 'package:travellory/utils/list_models.dart';
import 'package:travellory/widgets/buttons.dart';
import 'package:travellory/widgets/checkbox_form_field.dart';
import 'package:travellory/widgets/dropdown.dart';
import 'package:travellory/widgets/form_field.dart';
import 'package:travellory/widgets/section_titles.dart';
import 'package:travellory/widgets/show_dialog.dart';
import 'package:travellory/widgets/date_form_field.dart';
import 'package:travellory/widgets/time_form_field.dart';

import 'header.dart';

class Accommodation extends StatefulWidget {
  @override
  _AccommodationState createState() => _AccommodationState();
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
    final List<Widget> shown = [
      BookingSiteTitle('Add Accommodation', Icons.hotel),
      SectionTitle('Accommodation Type'),
      accommodationTypeDropdown,
      SectionTitle('General Information'),
      TravelloryFormField(
          labelText: 'Confirmation Number',
          icon: Icon(Icons.confirmation_number),
          optional: true,
          onChanged: (value) => accommodationModel.confirmationNr = value),
      TravelloryFormField(
          labelText: 'Name *',
          icon: Icon(Icons.supervised_user_circle),
          optional: false,
          onChanged: (value) => accommodationModel.hotelName = value),
      TravelloryFormField(
        labelText: 'Address *',
        icon: Icon(Icons.location_on),
        optional: false,
        onChanged: (value) => accommodationModel.address = value,
      ),
      SectionTitle('Check-In Details'),
      DateFormField(
        key: _checkinDateFormFieldKey,
        labelText: 'Check-In Date *',
        icon: Icon(Icons.date_range),
        optional: false,
        chosenDateString: (value) => accommodationModel.checkinDate = value,
      ),
      TimeFormField(
        labelText: 'Check-In Time',
        icon: Icon(Icons.access_time),
        optional: true,
        chosenTimeString: (value) => accommodationModel.checkinTime = value,
      ),
      TravelloryFormField(
        labelText: 'Nights *',
        icon: Icon(Icons.hotel),
        optional: false,
        onChanged: (value) => accommodationModel.nights = value,
      ),
      SectionTitle('Check-Out Details'),
      DateFormField(
        labelText: 'Check-Out Date *',
        icon: Icon(Icons.date_range),
        beforeDateKey: _checkinDateFormFieldKey,
        optional: false,
        dateValidationMessage: 'Check-out Date cannot be before Check-in Date',
        chosenDateString: (value) => accommodationModel.checkoutDate = value,
      ),
      TimeFormField(
        labelText: 'Check-Out Time',
        icon: Icon(Icons.access_time),
        optional: true,
        chosenTimeString: (value) => accommodationModel.checkoutTime = value,
      ),
      SectionTitle('Notes'),
      TravelloryFormField(
        labelText: 'Notes',
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
          labelText: 'Specific type of airbnb',
          icon: Icon(Icons.hotel),
          optional: true,
          onChanged: (value) => accommodationModel.accommodationType = value,
        ),
      ],
    );

    hotelAdditional = Column(
      children: <Widget>[
        SectionTitle('Further Hotel Details'),
        TravelloryFormField(
          labelText: 'Room Type',
          icon: Icon(Icons.hotel),
          optional: true,
          onChanged: (value) => accommodationModel.roomType = value,
        ),
        CheckboxFormField(
          initialValue: false,
          label: 'Does your stay include breakfast?',
          onChanged: (value) {
            accommodationModel.breakfast = value;
          },
        ),
      ],
    );
  }

  final String alertText =
      "You've just submitted the booking information for your accommodation booking. You can see all the information in the trip overview";

  List<Item> types = <Item>[
    const Item('Hotel', Icon(Icons.hotel, color: Color(0xFF167F67))),
    const Item('Airbnb', Icon(Icons.hotel, color: Color(0xFF167F67))),
    const Item('Hostel', Icon(Icons.hotel, color: Color(0xFF167F67))),
    const Item('Motel', Icon(Icons.hotel, color: Color(0xFF167F67))),
    const Item('Bed & Breakfast', Icon(Icons.hotel, color: Color(0xFF167F67))),
    const Item('Other', Icon(Icons.hotel, color: Color(0xFF167F67))),
  ];

  Widget _itemBuilder(BuildContext context, int index, Animation<double> animation) {
    return FormItem(animation: animation, child: accommodationList[index]);
  }

  Widget _removedItemBuilder(BuildContext context, Widget item, Animation<double> animation) {
    return FormItem(animation: animation, child: item);
  }

  @override
  Widget build(BuildContext context) {
    final TripModel tripModel = ModalRoute.of(context).settings.arguments;

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
      text: 'CANCEL',
      onCancel: () {
        cancellingDialog(context);
      },
    );

    return Scaffold(
      key: Key('Accommodation'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            getBookingHeader(context, tripModel),
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
