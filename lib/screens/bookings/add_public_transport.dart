import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/services/database/edit.dart';
import 'package:travellory/services/database/edit_database.dart';
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
import 'package:travellory/services/api/google_places.dart';
import 'package:google_maps_webservice/places.dart';

class PublicTransport extends StatefulWidget {
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
      "You've just submitted the booking information for your public transportation booking. You can see all the information in the trip overview";

  final String cancelText =
      'You are about to abort this booking entry. Do you want to go back to the previous site and discard your changes?';

  Widget itemBuilder(BuildContext context, int index, Animation<double> animation) {
    return FormItem(animation: animation, child: publicTransportList[index]);
  }

  Widget _removedItemBuilder(BuildContext context, Widget item, Animation<double> animation) {
    return FormItem(animation: animation, child: item);
  }

  void _getCancelButton(BuildContext context) {
    publicTransportList[publicTransportList.length - 2] = CancelButton(
      text: 'CANCEL',
      onCancel: () {
        cancellingDialog(context, cancelText);
      },
    );
  }

  void _getSubmitButton(SingleTripProvider singleTripProvider, BuildContext context,
      PublicTransportModel model, bool isNewModel) {
    void Function() onSubmit;
    if (isNewModel) {
      onSubmit = onSubmitBooking(
          singleTripProvider, model, 'booking-addPublicTransportation', context, alertText);
    } else {
      onSubmit = onEditBooking(singleTripProvider, model, context, errorMessage);
    }

    publicTransportList[publicTransportList.length - 3] = SubmitButton(
      highlightColor: Theme.of(context).primaryColor,
      fillColor: Theme.of(context).primaryColor,
      validationFunction: validateForm,
      onSubmit: onSubmit,
    );
  }

  Column getContent(TripModel tripModel, SingleTripProvider singleTripProvider,
      BuildContext context, PublicTransportModel model, bool isNewModel) {
    _getSubmitButton(singleTripProvider, context, model, isNewModel);
    _getCancelButton(context);

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
    CheckboxFormField seatReservedCheckbox;

    Widget typeSpecificationAdditional;
    Widget bookingMadeAdditional;
    Widget seatReservationAdditional;

    transportTypeDropdown = TravelloryDropdownField(
        initialValue: _publicTransportModel.transportationType,
        title: 'Select Transport Type',
        types: publicTransportTypes,
        onChanged: (value) {
          _publicTransportModel.transportationType = value.name;
          showAdditional(publicTransportList, value.name == 'Other', transportTypeDropdown,
              typeSpecificationAdditional);
        },
        validatorText: 'Please enter the required information');

    bookingMadeCheckbox = CheckboxFormField(
      initialValue: _publicTransportModel.booked,
      label: 'Did you book this public transport?',
      onChanged: (value) {
        _publicTransportModel.booked = value;
        showAdditional(publicTransportList, value, bookingMadeCheckbox, bookingMadeAdditional);
      },
    );

    seatReservedCheckbox = CheckboxFormField(
        initialValue: _publicTransportModel.seatReserved,
        label: 'Did you make a seat reservation?',
        onChanged: (value) {
          _publicTransportModel.seatReserved = value;
          showAdditional(
              publicTransportList, value, seatReservedCheckbox, seatReservationAdditional);
        });

    // don't put in build because it will be recreated on every build
    // with state changes this is not appreciated
    final List<Widget> shown = [
      BookingSiteTitle('Add Public Transport', FontAwesomeIcons.train),
      SectionTitle('Type of Transportation'),
      transportTypeDropdown,
      TravelloryFormField(
          initialValue: _publicTransportModel.publicTransportCompany,
          labelText: 'Company',
          icon: Icon(FontAwesomeIcons.solidBuilding),
          optional: true,
          onChanged: (value) => _publicTransportModel.publicTransportCompany = value),
      SectionTitle('Departure Information'),
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
      SectionTitle('Arrival Information'),
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
      SectionTitle('Booking Details'),
      bookingMadeCheckbox,
      seatReservedCheckbox,
      SectionTitle('Notes'),
      TravelloryFormField(
        initialValue: _publicTransportModel.notes,
        labelText: 'Notes',
        icon: Icon(FontAwesomeIcons.stickyNote),
        optional: true,
        onChanged: (value) => _publicTransportModel.notes = value,
      ),
      SubmitButton(),
      CancelButton(),
      SizedBox(height: 20),
    ];

    // this builds the animated list
    publicTransportList = ListModel<Widget>(
      listKey: _listKey,
      initialItems: shown,
      removedItemBuilder: _removedItemBuilder,
    );

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
        child: getContent(
            tripModel, singleTripProvider, context, _publicTransportModel, arguments.isNewModel),
      ),
    );
  }
}
