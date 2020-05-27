import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/src/components/items/form_items.dart';
import 'package:travellory/src/models/public_transport_model.dart';
import 'package:travellory/src/models/trip_model.dart';
import 'package:travellory/src/providers/single_trip_provider.dart';
import 'package:travellory/src/providers/trips_provider.dart';
import 'package:travellory/src/services/cloud/add_database.dart';
import 'package:travellory/src/services/cloud/edit_database.dart';
import 'package:travellory/src/components/items/lists_of_types.dart';
import 'package:travellory/src/components/items/list_models.dart';
import 'package:travellory/src/components/bookings/bookings_get_buttons.dart';
import 'package:travellory/src/components/buttons/booking_button.dart';
import 'package:travellory/src/components/forms/checkbox_form_field.dart';
import 'package:travellory/src/components/forms/dropdown.dart';
import 'package:travellory/src/components/forms/form_field.dart';
import 'package:travellory/src/components/shared/section_titles.dart';
import 'package:travellory/src/components/dialogs/cancel_dialog.dart';
import 'package:travellory/src/components/forms/date_form_field.dart';
import 'package:travellory/src/components/forms/time_form_field.dart';
import 'package:travellory/src/components/trip/trip_header.dart';
import 'package:travellory/src/services/api/google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:travellory/src/components/buttons/submit_button.dart';
import 'package:travellory/src/components/bookings/new_booking_models.dart';

class PublicTransport extends StatefulWidget {
  static const route = '/booking/publictransport';

  @override
  PublicTransportState createState() => PublicTransportState();
}

class PublicTransportState<T extends PublicTransport> extends State<T> {
  ListModel<Widget> publicTransportList;
  final GlobalKey<FormState> publicTransportFormKey = GlobalKey<FormState>();

  final GlobalKey<AnimatedListState> _listKey = GlobalKey<AnimatedListState>();
  final GlobalKey<DateFormFieldState> _depDateFormFieldKey = GlobalKey<DateFormFieldState>();
  final GlobalKey<DateFormFieldState> _arrDateFormFieldKey = GlobalKey<DateFormFieldState>();

  bool validateForm() {
    return publicTransportFormKey.currentState.validate();
  }

  @override
  void initState() {
    super.initState();
  }

  final String alertText =
      "You've just submitted the booking information for your public transportation booking. "
      "You can see all the information in the trip overview";

  final String cancelText = 'You are about to abort this booking entry. '
      'Do you want to go back to the previous site and discard your changes?';

  Widget itemBuilder(BuildContext context, int index, Animation<double> animation) {
    return FormItem(animation: animation, child: publicTransportList[index]);
  }

  Widget _removedItemBuilder(BuildContext context, Widget item, Animation<double> animation) {
    return FormItem(animation: animation, child: item);
  }

  void _setCancelButton(BuildContext context) {
    publicTransportList[publicTransportList.length - 2] = getBookingCancelButton(
      context,
      () {
        cancellingDialog(context, cancelText);
      },
    );
  }

  void _setSubmitButton(SingleTripProvider singleTripProvider, BuildContext context,
      PublicTransportModel publicTransportModel, bool isNewModel) {
    publicTransportList[publicTransportList.length - 3] = getSubmitButton(
      context,
      singleTripProvider,
      publicTransportModel,
      DatabaseAdder.addPublicTransportation,
      DatabaseEditor.editPublicTransportation,
      alertText,
      validateForm,
      isNewModel: isNewModel,
    );
  }

  Column _getPublicTransportContent(TripModel tripModel, SingleTripProvider singleTripProvider,
      BuildContext context, PublicTransportModel publicTransportModel, bool isNewModel) {
    _setSubmitButton(singleTripProvider, context, publicTransportModel, isNewModel);
    _setCancelButton(context);

    return Column(
      children: <Widget>[
        TripHeader(tripModel),
        Expanded(
            child: Container(
          height: double.infinity,
          child: Form(
            key: publicTransportFormKey,
            child: Column(
              children: <Widget>[
                Expanded(
                  child: AnimatedList(
                    key: _listKey,
                    initialItemCount: publicTransportList.length,
                    itemBuilder: itemBuilder,
                  ),
                ),
              ],
            ),
          ),
        )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final SingleTripProvider singleTripProvider =
        Provider.of<TripsProvider>(context, listen: false).selectedTrip;
    final TripModel tripModel = singleTripProvider.tripModel;

    final ModifyModelArguments arguments = ModalRoute.of(context).settings.arguments;
    final PublicTransportModel _publicTransportModel = arguments.model;

    TravelloryDropdownField transportTypeDropdown;
    CheckboxFormField bookingMadeCheckbox;

    Widget doesSeatReservationExistAdditional;
    Widget typeSpecificationAdditional;
    Widget bookingMadeAdditional;
    Widget seatReservationAdditional;

    transportTypeDropdown = TravelloryDropdownField(
        initialValue: _publicTransportModel.transportationType,
        title: 'Select Transport Type',
        types: publicTransportTypes,
        onChanged: (value) {
          _publicTransportModel.transportationType = value.name;
          showAdditional(publicTransportList, transportTypeDropdown, typeSpecificationAdditional,
              show: value.name == 'Other');
          showAdditional(
              publicTransportList, transportTypeDropdown, doesSeatReservationExistAdditional,
              show: (value.name == 'Other' ||
                  value.name == 'Rail' ||
                  value.name == 'Bus' ||
                  value.name == 'Ferry'));
        },
        validatorText: 'Please enter the required information');

    bookingMadeCheckbox = CheckboxFormField(
      initialValue: _publicTransportModel.booked,
      label: 'Did you book this public transport?',
      onChanged: (value) {
        _publicTransportModel.booked = value;
        showAdditional(publicTransportList, bookingMadeCheckbox, bookingMadeAdditional,
            show: value);
      },
    );

    // don't put in build because it will be recreated on every build
    // with state changes this is not appreciated
    final List<Widget> shown = [
      BookingSiteTitle(siteTitle: 'Public Transport', icon: FontAwesomeIcons.train),
      SectionTitle(sectionTitle: 'Type of Transportation'),
      transportTypeDropdown,
      TravelloryFormField(
          initialValue: _publicTransportModel.publicTransportCompany,
          labelText: 'Company',
          icon: Icon(FontAwesomeIcons.solidBuilding),
          optional: true,
          onChanged: (value) => _publicTransportModel.publicTransportCompany = value),
      SectionTitle(sectionTitle: 'Departure Information'),
      TravelloryFormField(
        initialValue: _publicTransportModel.departureLocation,
        labelText: 'Departure Location *',
        icon: Icon(FontAwesomeIcons.mapMarkerAlt),
        optional: false,
        onTap: (controller) async {
          final PlacesDetailsResponse detail = await GooglePlaces.openGooglePlacesSearch(context,
              countryCode: tripModel.countryCode);

          controller.text = detail.result.name;
          _publicTransportModel.departureLocation = detail.result.name;
          _publicTransportModel.departureLatitude = detail.result.geometry.location.lat;
          _publicTransportModel.departureLongitude = detail.result.geometry.location.lng;
        },
        onChanged: (value) => _publicTransportModel.departureLocation = value,
      ),
      DateFormField(
        initialValue: _publicTransportModel.departureDate,
        key: _depDateFormFieldKey,
        listenerKey: _arrDateFormFieldKey,
        labelText: 'Departure Date *',
        icon: Icon(FontAwesomeIcons.calendarAlt),
        tripModel: tripModel,
        model: _publicTransportModel,
        chosenDateString: (value) => _publicTransportModel.departureDate = value,
      ),
      TimeFormField(
        initialValue: _publicTransportModel.departureTime,
        labelText: 'Departure Time *',
        icon: Icon(FontAwesomeIcons.clock),
        chosenTimeString: (value) => _publicTransportModel.departureTime = value,
      ),
      SectionTitle(sectionTitle: 'Arrival Information'),
      TravelloryFormField(
        initialValue: _publicTransportModel.arrivalLocation,
        labelText: 'Arrival Location *',
        icon: Icon(FontAwesomeIcons.mapMarkerAlt),
        optional: false,
        onTap: (controller) async {
          final PlacesDetailsResponse detail = await GooglePlaces.openGooglePlacesSearch(context);

          controller.text = detail.result.name;
          _publicTransportModel.arrivalLocation = detail.result.name;
          _publicTransportModel.arrivalLatitude = detail.result.geometry.location.lat;
          _publicTransportModel.arrivalLongitude = detail.result.geometry.location.lng;
        },
        onChanged: (value) => _publicTransportModel.arrivalLocation = value,
      ),
      DateFormField(
        key: _arrDateFormFieldKey,
        initialValue: _publicTransportModel.arrivalDate,
        labelText: 'Arrival Date *',
        icon: Icon(FontAwesomeIcons.calendarAlt),
        beforeDateKey: _depDateFormFieldKey,
        tripModel: tripModel,
        model: _publicTransportModel,
        dateValidationMessage: 'Departure Date cannot be before Arrival Date',
        chosenDateString: (value) => _publicTransportModel.arrivalDate = value,
      ),
      TimeFormField(
        initialValue: _publicTransportModel.arrivalTime,
        labelText: 'Arrival Time',
        icon: Icon(FontAwesomeIcons.clock),
        optional: true,
        chosenTimeString: (value) => _publicTransportModel.arrivalTime = value,
      ),
      SectionTitle(sectionTitle: 'Booking Details'),
      bookingMadeCheckbox,
      SectionTitle(sectionTitle: 'Notes'),
      TravelloryFormField(
        initialValue: _publicTransportModel.notes,
        labelText: 'Notes',
        icon: Icon(FontAwesomeIcons.stickyNote),
        optional: true,
        onChanged: (value) => _publicTransportModel.notes = value,
      ),
      SubmitButton(),
      BookingButton(),
      SizedBox(height: 20),
    ];

    // this builds the animated list
    publicTransportList = ListModel<Widget>(
      listKey: _listKey,
      initialItems: shown,
      removedItemBuilder: _removedItemBuilder,
    );

    doesSeatReservationExistAdditional = Column(children: <Widget>[
      CheckboxFormField(
          initialValue: _publicTransportModel.seatReserved,
          label: 'Did you make a seat reservation?',
          onChanged: (value) {
            _publicTransportModel.seatReserved = value;
            showAdditional(publicTransportList, doesSeatReservationExistAdditional, seatReservationAdditional,
                show: value);
          }),
    ]);

    typeSpecificationAdditional = Column(
      children: <Widget>[
        TravelloryFormField(
          initialValue: _publicTransportModel.specificType,
          labelText: 'Specific Type of Transportation',
          icon: Icon(FontAwesomeIcons.train),
          optional: true,
          onChanged: (value) => _publicTransportModel.specificType = value,
        ),
      ],
    );

    bookingMadeAdditional = Column(
      children: <Widget>[
        TravelloryFormField(
          initialValue: _publicTransportModel.referenceNr,
          labelText: 'Booking Reference',
          icon: Icon(FontAwesomeIcons.ticketAlt),
          optional: true,
          onChanged: (value) => _publicTransportModel.referenceNr = value,
        ),
        TravelloryFormField(
          initialValue: _publicTransportModel.reservationCompany,
          labelText: 'Booking Company',
          icon: Icon(FontAwesomeIcons.building),
          optional: true,
          onChanged: (value) => _publicTransportModel.reservationCompany = value,
        ),
      ],
    );

    seatReservationAdditional = Column(
      children: <Widget>[
        TravelloryFormField(
          initialValue: _publicTransportModel.seat,
          labelText: 'Seat',
          icon: Icon(FontAwesomeIcons.chair),
          optional: true,
          onChanged: (value) => _publicTransportModel.seat = value,
        ),
      ],
    );

    return Scaffold(
      key: Key('Public Transport'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: _getPublicTransportContent(
            tripModel, singleTripProvider, context, _publicTransportModel, arguments.isNewModel),
      ),
    );
  }
}
