import 'package:flutter/material.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/shared/lists_of_types.dart';
import 'package:travellory/utils/list_models.dart';
import 'package:travellory/services/database/submit.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/forms/checkbox_form_field.dart';
import 'package:travellory/widgets/forms/dropdown.dart';
import 'package:travellory/widgets/forms/form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';
import 'package:travellory/widgets/forms/date_form_field.dart';
import 'package:travellory/widgets/forms/time_form_field.dart';
import 'package:travellory/widgets/trip/trip_header.dart';

// to get places detail (lat/lng)
GoogleMapsPlaces _places = GoogleMapsPlaces(apiKey: 'AIzaSyBTerG6FzsWzMxLZGxkz8KAXqUNCNtwsE0');

class Accommodation extends StatefulWidget {
  @override
  _AccommodationState createState() => _AccommodationState();
}

class _AccommodationState extends State<Accommodation> {
  ListModel<Widget> accommodationList;
  final GlobalKey<FormState> accommodationFormKey = GlobalKey<FormState>();
  final AccommodationModel accommodationModel = AccommodationModel();
  final DatabaseAdder databaseAdder = DatabaseAdder();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final GlobalKey<DateFormFieldState> _checkinDateFormFieldKey = GlobalKey<DateFormFieldState>();

  TravelloryDropdownField accommodationTypeDropdown;
  Widget hotelAdditional;
  Widget airbnbAdditional;
  Widget otherAdditional;

  final nameController = TextEditingController(); /// for accomodation name field
  final addressController = TextEditingController(); /// for accomodation address field

  bool validateForm() {
    return accommodationFormKey.currentState.validate();
  }

  @override
  void initState() {
    super.initState();

    accommodationTypeDropdown = TravelloryDropdownField(
        title: 'Select Accommodation Type',
        types: accommodationTypes,
        onChanged: (value) {
          accommodationModel.airbnbType = value.name;
          showAdditional(accommodationList, value.name == 'Airbnb', accommodationTypeDropdown,
              airbnbAdditional);
          showAdditional(
              accommodationList, value.name == 'Hotel', accommodationTypeDropdown, hotelAdditional);
          showAdditional(
              accommodationList, value.name == 'Other', accommodationTypeDropdown, otherAdditional);
        },
        validatorText: 'Please enter the required information');

    // don't put in build because it will be recreated on every build
    // with state changes this is not appreciated
    final List<Widget> shown = [
      BookingSiteTitle('Add Accommodation', FontAwesomeIcons.bed),
      SectionTitle('Accommodation Type'),
      accommodationTypeDropdown,
      SectionTitle('General Information'),
      TravelloryFormField(
          labelText: 'Confirmation Number',
          icon: Icon(FontAwesomeIcons.ticketAlt),
          optional: true,
          onChanged: (value) => accommodationModel.confirmationNr = value),
      TravelloryFormField(
          labelText: 'Name *',
          icon: Icon(FontAwesomeIcons.solidBuilding),
          optional: false,
          controller: nameController,
          onTap: _openGooglePlacesSearch,
          onChanged: (value) => accommodationModel.name = value),
      TravelloryFormField(
        labelText: 'Address *',
        icon: Icon(FontAwesomeIcons.mapMarkerAlt),
        optional: false,
        controller: addressController,
        onChanged: (value) => accommodationModel.address = value,
      ),
      SectionTitle('Check-In Details'),
      DateFormField(
        key: _checkinDateFormFieldKey,
        labelText: 'Check-In Date *',
        icon: Icon(FontAwesomeIcons.calendarAlt),
        optional: false,
        chosenDateString: (value) => accommodationModel.checkinDate = value,
      ),
      TimeFormField(
        labelText: 'Check-In Time',
        icon: Icon(FontAwesomeIcons.clock),
        optional: true,
        chosenTimeString: (value) => accommodationModel.checkinTime = value,
      ),
      TravelloryFormField(
        labelText: 'Nights *',
        icon: Icon(FontAwesomeIcons.solidMoon),
        optional: false,
        onChanged: (value) => accommodationModel.nights = value,
      ),
      SectionTitle('Check-Out Details'),
      DateFormField(
        labelText: 'Check-Out Date *',
        icon: Icon(FontAwesomeIcons.calendarAlt),
        beforeDateKey: _checkinDateFormFieldKey,
        optional: false,
        dateValidationMessage: 'Check-out Date cannot be before Check-in Date',
        chosenDateString: (value) => accommodationModel.checkoutDate = value,
      ),
      TimeFormField(
        labelText: 'Check-Out Time',
        icon: Icon(FontAwesomeIcons.clock),
        optional: true,
        chosenTimeString: (value) => accommodationModel.checkoutTime = value,
      ),
      SectionTitle('Notes'),
      TravelloryFormField(
        labelText: 'Notes',
        icon: Icon(FontAwesomeIcons.stickyNote),
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
          icon: Icon(FontAwesomeIcons.hotel),
          optional: true,
          onChanged: (value) => accommodationModel.airbnbType = value,
        ),
      ],
    );

    hotelAdditional = Column(
      children: <Widget>[
        SectionTitle('Further Hotel Details'),
        TravelloryFormField(
          labelText: 'Room Type',
          icon: Icon(FontAwesomeIcons.hotel),
          optional: true,
          onChanged: (value) => accommodationModel.hotelRoomType = value,
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

    otherAdditional = Column(
      children: <Widget>[
        TravelloryFormField(
          labelText: "Specification of 'Other'",
          icon: Icon(FontAwesomeIcons.bed),
          optional: true,
          onChanged: (value) => accommodationModel.specificationOther = value,
        ),
      ],
    );
  }

  final String alertText =
      "You've just submitted the booking information for your accommodation booking. You can see all the information in the trip overview";

  final String cancelText =
      'You are about to abort this booking entry. Do you want to go back to the previous site and discard your changes?';

  Widget _itemBuilder(BuildContext context, int index, Animation<double> animation) {
    return FormItem(animation: animation, child: accommodationList[index]);
  }

  Widget _removedItemBuilder(BuildContext context, Widget item, Animation<double> animation) {
    return FormItem(animation: animation, child: item);
  }

  @override
  Widget build(BuildContext context) {
    final SingleTripProvider singleTripProvider =
        Provider.of<TripsProvider>(context, listen: false).selectedTrip;
    final TripModel tripModel = singleTripProvider.tripModel;
    accommodationModel.tripUID = tripModel.uid;

    // replace widget to get the context
    accommodationList[accommodationList.length - 3] = SubmitButton(
      highlightColor: Theme.of(context).primaryColor,
      fillColor: Theme.of(context).primaryColor,
      validationFunction: validateForm,
      onSubmit: onSubmitBooking(
          singleTripProvider, accommodationModel, 'booking-addAccommodation', context, alertText),
    );

    accommodationList[accommodationList.length - 2] = CancelButton(
      text: 'CANCEL',
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
            TripHeader(tripModel),
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

  Future<void> _openGooglePlacesSearch() async {
    // show input autocomplete with selected mode
    // then get the Prediction selected
    Prediction p = await PlacesAutocomplete.show(
      context: context,
      apiKey: 'AIzaSyBTerG6FzsWzMxLZGxkz8KAXqUNCNtwsE0',
      //onError: onError,
      mode: Mode.overlay,
      language: "en",
      components: [Component(Component.country, "ch")],
    );

    PlacesDetailsResponse detail = await _places.getDetailsByPlaceId(p.placeId);
    final lat = detail.result.geometry.location.lat;
    final lng = detail.result.geometry.location.lng;

    print(detail.result.geometry.toJson());

    print('NameController: ${nameController.value}');
    print('AddressController: ${addressController.value}');

    nameController.text = detail.result.name;
    addressController.text = detail.result.formattedAddress;
    accommodationModel.name = detail.result.name;
    accommodationModel.address = detail.result.formattedAddress;
    accommodationModel.latitude = detail.result.geometry.location.lat;
    accommodationModel.longitude = detail.result.geometry.location.lng;

  }
}
