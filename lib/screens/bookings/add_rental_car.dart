import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/services/database/edit_database.dart';
import 'package:travellory/services/database/submit.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/forms/date_form_field.dart';
import 'package:travellory/widgets/forms/form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';
import 'package:travellory/widgets/forms/time_form_field.dart';
import 'package:travellory/widgets/trip/trip_header.dart';
import 'package:travellory/services/api/google_places.dart';
import 'package:google_maps_webservice/places.dart';

class RentalCar extends StatefulWidget {
  RentalCar({Key key}) : super(key: key);

  @override
  RentalCarState createState() => RentalCarState();
}

class RentalCarState<T extends RentalCar> extends State<T> {
  final GlobalKey<FormState> rentalCarFormKey = GlobalKey<FormState>();
  RentalCarModel _rentalCarModel = RentalCarModel();

  final GlobalKey<DateFormFieldState> _pickUpDateFormFieldKey = GlobalKey<DateFormFieldState>();

  final pickupLocationController = TextEditingController();
  final returnLocationController = TextEditingController();

  bool validateForm() {
    return rentalCarFormKey.currentState.validate();
  }

  final String alertText =
      "You've just submitted the booking information for your rental car booking. You can see all the information in the trip overview";

  final String cancelText =
      'You are about to abort this booking entry. Do you want to go back to the previous site and discard your changes?';

  Column getContent(BuildContext context, SingleTripProvider singleTripProvider,
      TripModel tripModel, RentalCarModel model, bool isNewModel) {

    _rentalCarModel = model;

    return Column(
      children: <Widget>[
        TripHeader(tripModel),
        Expanded(
          child: SingleChildScrollView(
            child: Form(
              key: rentalCarFormKey,
              child: Column(children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: BookingSiteTitle('Add Rental Car', FontAwesomeIcons.car),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('General Information'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                    initialValue: _rentalCarModel.bookingReference,
                      labelText: 'Booking Reference',
                      icon: Icon(FontAwesomeIcons.ticketAlt),
                      optional: true,
                      onChanged: (value) => _rentalCarModel.bookingReference = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _rentalCarModel.company,
                      labelText: 'Company *',
                      icon: Icon(FontAwesomeIcons.solidBuilding),
                      optional: false,
                      onChanged: (value) => _rentalCarModel.company = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Pick Up Information'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _rentalCarModel.pickupLocation,
                      labelText: 'Pick Up Location',
                      icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                      optional: false,
                      controller: pickupLocationController,
                      onTap: () async {
                        PlacesDetailsResponse detail = await GooglePlaces.openGooglePlacesSearch(context);
                        pickupLocationController.text = detail.result.formattedAddress;
                        _rentalCarModel.pickupLocation = detail.result.formattedAddress;
                        _rentalCarModel.pickupLatitude = detail.result.geometry.location.lat;
                        _rentalCarModel.pickupLongitude = detail.result.geometry.location.lng;
                      },
                      onChanged: (value) => _rentalCarModel.pickupLocation = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: DateFormField(
                    initialValue: _rentalCarModel.pickupDate,
                    key: _pickUpDateFormFieldKey,
                    labelText: 'Pick Up Date *',
                    optional: false,
                    icon: Icon(FontAwesomeIcons.calendarAlt),
                    chosenDateString: (value) => _rentalCarModel.pickupDate = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TimeFormField(
                      initialValue: _rentalCarModel.pickupTime,
                      labelText: 'Pick Up Time',
                      icon: Icon(FontAwesomeIcons.clock),
                      optional: true,
                      chosenTimeString: (value) => _rentalCarModel.pickupTime = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Return Information'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _rentalCarModel.returnLocation,
                      labelText: 'Return Location',
                      icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                      optional: true,
                      controller: returnLocationController,
                      onTap: () async {
                        PlacesDetailsResponse detail = await GooglePlaces.openGooglePlacesSearch(context, countryCode: tripModel.countryCode);

                        returnLocationController.text = detail.result.formattedAddress;
                        _rentalCarModel.returnLocation = detail.result.formattedAddress;
                        _rentalCarModel.returnLatitude = detail.result.geometry.location.lat;
                        _rentalCarModel.returnLongitude = detail.result.geometry.location.lng;
                      },
                      onChanged: (value) => _rentalCarModel.returnLocation = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: DateFormField(
                    initialValue: _rentalCarModel.returnDate,
                    labelText: 'Return Date *',
                    icon: Icon(FontAwesomeIcons.calendarAlt),
                    beforeDateKey: _pickUpDateFormFieldKey,
                    optional: false,
                    dateValidationMessage: 'Return Date cannot be before Pick Up Date',
                    chosenDateString: (value) => _rentalCarModel.returnDate = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TimeFormField(
                      initialValue: _rentalCarModel.returnTime,
                      labelText: 'Return Time',
                      icon: Icon(FontAwesomeIcons.clock),
                      optional: true,
                      chosenTimeString: (value) => _rentalCarModel.returnTime = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Car Details'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _rentalCarModel.carDescription,
                      labelText: 'Car Description',
                      icon: Icon(FontAwesomeIcons.car),
                      optional: true,
                      onChanged: (value) => _rentalCarModel.carDescription = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _rentalCarModel.carNumberPlate,
                      labelText: 'Car Plate',
                      icon: Icon(FontAwesomeIcons.car),
                      optional: true,
                      onChanged: (value) => _rentalCarModel.carNumberPlate = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Notes'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                    initialValue: _rentalCarModel.notes,
                    labelText: 'Notes',
                    icon: Icon(FontAwesomeIcons.stickyNote),
                    optional: true,
                    onChanged: (value) => _rentalCarModel.notes = value,
                  ),
                ),
                _getSubmitButton(singleTripProvider, model, isNewModel),
                Padding(
                  padding: const EdgeInsets.only(top: 2, left: 15, right: 15),
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
    );
  }

  /* returns either submit new activity booking or edit old booking button */
  Padding _getSubmitButton(
      SingleTripProvider singleTripProvider, RentalCarModel model, bool isNewModel) {
    void Function() onSubmit;
    if (isNewModel) {
      onSubmit =
          onSubmitBooking(
              singleTripProvider, model, 'booking-addRentalCar', context, alertText);
    } else {
      onSubmit = onEditBooking(singleTripProvider, model, context, errorMessage);
    }

    return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: SubmitButton(
        highlightColor: Theme.of(context).primaryColor,
        fillColor: Theme.of(context).primaryColor,
        validationFunction: validateForm,
        onSubmit: onSubmit,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final SingleTripProvider singleTripProvider =
        Provider.of<TripsProvider>(context, listen: false).selectedTrip;
    final TripModel tripModel = singleTripProvider.tripModel;
    _rentalCarModel.tripUID = tripModel.uid;

    return Scaffold(
      key: Key('Rental Car'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: getContent(context, singleTripProvider, tripModel, _rentalCarModel, false),
      ),
    );
  }
}
