import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/widgets/bookings/edit.dart';
import 'package:travellory/services/database/edit_database.dart';
import 'package:travellory/shared/lists_of_types.dart';
import 'package:travellory/utils/list_models.dart';
import 'package:travellory/widgets/bookings/bookings_get_buttons.dart';
import 'package:travellory/widgets/buttons/booking_button.dart';
import 'package:travellory/widgets/forms/checkbox_form_field.dart';
import 'package:travellory/widgets/forms/dropdown.dart';
import 'package:travellory/widgets/forms/form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';
import 'package:travellory/widgets/forms/date_form_field.dart';
import 'package:travellory/widgets/forms/time_form_field.dart';
import 'package:travellory/widgets/trip/trip_header.dart';
import 'package:travellory/services/api/google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:travellory/widgets/buttons/submit_button.dart';

class Accommodation extends StatefulWidget {
  static const route = '/booking/accommodation';

  @override
  AccommodationState createState() => AccommodationState();
}

class AccommodationState<T extends Accommodation> extends State<T> {
  ListModel<Widget> accommodationList;
  final GlobalKey<FormState> accommodationFormKey = GlobalKey<FormState>();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final GlobalKey<DateFormFieldState> _checkinDateFormFieldKey = GlobalKey<DateFormFieldState>();
  final GlobalKey<DateFormFieldState> _checkoutDateFormFieldKey = GlobalKey<DateFormFieldState>();

  bool validateForm() {
    return accommodationFormKey.currentState.validate();
  }

  final String alertText =
      "You've just submitted the booking information for your accommodation booking. "
      "You can see all the information in the trip overview";

  final String cancelText = 'You are about to abort this booking entry. '
      'Do you want to go back to the previous site and discard your changes?';

  Widget _itemBuilder(BuildContext context, int index, Animation<double> animation) {
    return FormItem(animation: animation, child: accommodationList[index]);
  }

  Widget _removedItemBuilder(BuildContext context, Widget item, Animation<double> animation) {
    return FormItem(animation: animation, child: item);
  }

  Column _getAccommodationContent(TripModel tripModel, SingleTripProvider singleTripProvider,
      BuildContext context, AccommodationModel model, bool isNewModel) {
    _setSubmitButton(singleTripProvider, context, model, isNewModel);
    _setCancelButton(context);

    return Column(children: <Widget>[
      TripHeader(tripModel),
      Expanded(
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
        ),
      )
    ]);
  }

  /// Sets the Cancel Button after Animations have been built
  void _setCancelButton(BuildContext context) {
    accommodationList[accommodationList.length - 2] = getBookingCancelButton(
      context,
      () {
        cancellingDialog(context, cancelText);
      },
    );
  }

  /// Sets the Submit Button after Animations have been built
  void _setSubmitButton(SingleTripProvider singleTripProvider, BuildContext context,
      AccommodationModel accommodationModel, bool isNewModel) {
    accommodationList[accommodationList.length - 3] = getSubmitButton(
        context,
        singleTripProvider,
        accommodationModel,
        DatabaseAdder.addAccommodation,
        DatabaseEditor.editAccommodation,
        alertText,
        validateForm,
        isNewModel: isNewModel);
  }

  @override
  Widget build(BuildContext context) {
    final ModifyModelArguments _arguments = ModalRoute.of(context).settings.arguments;
    final AccommodationModel _accommodationModel = _arguments.model;

    final SingleTripProvider singleTripProvider =
        Provider.of<TripsProvider>(context, listen: false).selectedTrip;
    final TripModel tripModel = singleTripProvider.tripModel;

    Widget hotelAdditional;
    Widget airbnbAdditional;
    Widget otherAdditional;
    TravelloryDropdownField accommodationTypeDropdown;

    hotelAdditional = Column(
      children: <Widget>[
        SectionTitle('Further Hotel Details'),
        TravelloryFormField(
            initialValue: _accommodationModel.name,
            labelText: 'Name',
            icon: Icon(FontAwesomeIcons.solidBuilding),
            optional: true,
            onChanged: (value) => _accommodationModel.name = value),
        TravelloryFormField(
          initialValue: _accommodationModel.hotelRoomType,
          labelText: 'Room Type',
          icon: Icon(FontAwesomeIcons.hotel),
          optional: true,
          onChanged: (value) => _accommodationModel.hotelRoomType = value,
        ),
        CheckboxFormField(
          initialValue: _accommodationModel.breakfast,
          label: 'Does your stay include breakfast?',
          onChanged: (value) {
            _accommodationModel.breakfast = value;
          },
        ),
      ],
    );

    airbnbAdditional = Column(
      children: <Widget>[
        TravelloryFormField(
          initialValue: _accommodationModel.airbnbType,
          labelText: 'Specific type of airbnb',
          icon: Icon(FontAwesomeIcons.hotel),
          optional: true,
          onChanged: (value) => _accommodationModel.airbnbType = value,
        ),
      ],
    );

    otherAdditional = Column(
      children: <Widget>[
        TravelloryFormField(
          initialValue: _accommodationModel.specificationOther,
          labelText: "Specification of 'Other'",
          icon: Icon(FontAwesomeIcons.bed),
          optional: true,
          onChanged: (value) => _accommodationModel.specificationOther = value,
        ),
      ],
    );

    accommodationTypeDropdown = TravelloryDropdownField(
        initialValue: _accommodationModel.type,
        title: 'Select Accommodation Type',
        types: accommodationTypes,
        onChanged: (value) {
          _accommodationModel.type = value.name;
          showAdditional(accommodationList, value.name == 'Airbnb', accommodationTypeDropdown,
              airbnbAdditional);
          showAdditional(
              accommodationList, value.name == 'Hotel', accommodationTypeDropdown, hotelAdditional);
          showAdditional(accommodationList, value.name == 'Other Accommodation',
              accommodationTypeDropdown, otherAdditional);
        },
        validatorText: 'Please enter the required information');

    final List<Widget> shown = [
      BookingSiteTitle('Accommodation', FontAwesomeIcons.bed),
      SectionTitle('Accommodation Type'),
      accommodationTypeDropdown,
      SectionTitle('General Information'),
      TravelloryFormField(
          initialValue: _accommodationModel.confirmationNr,
          labelText: 'Confirmation Number',
          icon: Icon(FontAwesomeIcons.ticketAlt),
          optional: true,
          onChanged: (value) => _accommodationModel.confirmationNr = value),
      TravelloryFormField(
        initialValue: _accommodationModel.address,
        labelText: 'Address *',
        icon: Icon(FontAwesomeIcons.mapMarkerAlt),
        optional: false,
        onTap: (controller) async {
          final PlacesDetailsResponse detail = await GooglePlaces.openGooglePlacesSearch(context,
              countryCode: tripModel.countryCode);

          controller.text = detail.result.formattedAddress;
          _accommodationModel.address = detail.result.formattedAddress;
          _accommodationModel.latitude = detail.result.geometry.location.lat;
          _accommodationModel.longitude = detail.result.geometry.location.lng;
        },
        onChanged: (value) => _accommodationModel.address = value,
      ),
      SectionTitle('Check-In Details'),
      DateFormField(
        initialValue: _accommodationModel.checkinDate,
        key: _checkinDateFormFieldKey,
        listenerKey: _checkoutDateFormFieldKey,
        labelText: 'Check-In Date *',
        icon: Icon(FontAwesomeIcons.calendarAlt),
        optional: false,
        tripModel: tripModel,
        model: _accommodationModel,
        chosenDateString: (value) => _accommodationModel.checkinDate = value,
      ),
      TimeFormField(
        initialValue: _accommodationModel.checkinTime,
        labelText: 'Check-In Time',
        icon: Icon(FontAwesomeIcons.clock),
        optional: true,
        chosenTimeString: (value) => _accommodationModel.checkinTime = value,
      ),
      SectionTitle('Check-Out Details'),
      DateFormField(
        key: _checkoutDateFormFieldKey,
        initialValue: _accommodationModel.checkoutDate,
        labelText: 'Check-Out Date *',
        icon: Icon(FontAwesomeIcons.calendarAlt),
        beforeDateKey: _checkinDateFormFieldKey,
        optional: false,
        tripModel: tripModel,
        model: _accommodationModel,
        dateValidationMessage: 'Check-out Date cannot be before Check-in Date',
        chosenDateString: (value) => _accommodationModel.checkoutDate = value,
      ),
      TimeFormField(
        initialValue: _accommodationModel.checkoutTime,
        labelText: 'Check-Out Time',
        icon: Icon(FontAwesomeIcons.clock),
        optional: true,
        chosenTimeString: (value) => _accommodationModel.checkoutTime = value,
      ),
      SectionTitle('Notes'),
      TravelloryFormField(
        initialValue: _accommodationModel.notes,
        labelText: 'Notes',
        icon: Icon(FontAwesomeIcons.stickyNote),
        optional: true,
        onChanged: (value) => _accommodationModel.notes = value,
      ),
      SubmitButton(),
      BookingButton(),
      SizedBox(height: 20),
    ];

    // this builds the animated list
    accommodationList = ListModel<Widget>(
      listKey: _listKey,
      initialItems: shown,
      removedItemBuilder: _removedItemBuilder,
    );

    return Scaffold(
      key: Key('Accommodation'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: _getAccommodationContent(
            tripModel, singleTripProvider, context, _accommodationModel, _arguments.isNewModel),
      ),
    );
  }
}
