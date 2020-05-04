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

  final GlobalKey<DateFormFieldState> _pickUpDateFormFieldKey = GlobalKey<DateFormFieldState>();

  bool validateForm() {
    return rentalCarFormKey.currentState.validate();
  }

  final String alertText =
      "You've just submitted the booking information for your rental car booking. You can see all the information in the trip overview";

  final String cancelText =
      'You are about to abort this booking entry. Do you want to go back to the previous site and discard your changes?';

  Column getContent(BuildContext context, SingleTripProvider singleTripProvider,
      TripModel tripModel, RentalCarModel model, bool isNewModel) {
    RentalCarModel _editRentalCarModel = RentalCarModel();
//  _editRentalCarModel = model;
    _editRentalCarModel = RentalCarModel.fromData(model.toMap());

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
                      initialValue: _editRentalCarModel.bookingReference,
                      labelText: 'Booking Reference',
                      icon: Icon(FontAwesomeIcons.ticketAlt),
                      optional: true,
                      onChanged: (value) => _editRentalCarModel.bookingReference = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _editRentalCarModel.company,
                      labelText: 'Company *',
                      icon: Icon(FontAwesomeIcons.solidBuilding),
                      optional: false,
                      onChanged: (value) => _editRentalCarModel.company = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Pick Up Information'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _editRentalCarModel.pickupLocation,
                      labelText: 'Pick Up Location *',
                      icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                      optional: false,
                      onTap: (controller) async {
                        PlacesDetailsResponse detail =
                            await GooglePlaces.openGooglePlacesSearch(context);
                        controller.text = detail.result.formattedAddress;
                        _editRentalCarModel.pickupLocation = detail.result.formattedAddress;
                        _editRentalCarModel.pickupLatitude = detail.result.geometry.location.lat;
                        _editRentalCarModel.pickupLongitude = detail.result.geometry.location.lng;
                      },
                      onChanged: (value) => _editRentalCarModel.pickupLocation = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: DateFormField(
                    initialValue: _editRentalCarModel.pickupDate,
                    key: _pickUpDateFormFieldKey,
                    labelText: 'Pick Up Date *',
                    optional: false,
                    tripModel: tripModel,
                    icon: Icon(FontAwesomeIcons.calendarAlt),
                    chosenDateString: (value) => _editRentalCarModel.pickupDate = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TimeFormField(
                      initialValue: _editRentalCarModel.pickupTime,
                      labelText: 'Pick Up Time',
                      icon: Icon(FontAwesomeIcons.clock),
                      optional: true,
                      chosenTimeString: (value) => _editRentalCarModel.pickupTime = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Return Information'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _editRentalCarModel.returnLocation,
                      labelText: 'Return Location',
                      icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                      optional: true,
                      onTap: (controller) async {
                        PlacesDetailsResponse detail = await GooglePlaces.openGooglePlacesSearch(
                            context,
                            countryCode: tripModel.countryCode);

                        controller.text = detail.result.formattedAddress;
                        _editRentalCarModel.returnLocation = detail.result.formattedAddress;
                        _editRentalCarModel.returnLatitude = detail.result.geometry.location.lat;
                        _editRentalCarModel.returnLongitude = detail.result.geometry.location.lng;
                      },
                      onChanged: (value) => _editRentalCarModel.returnLocation = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: DateFormField(
                    initialValue: _editRentalCarModel.returnDate,
                    labelText: 'Return Date *',
                    icon: Icon(FontAwesomeIcons.calendarAlt),
                    beforeDateKey: _pickUpDateFormFieldKey,
                    optional: false,
                    tripModel: tripModel,
                    dateValidationMessage: 'Return Date cannot be before Pick Up Date',
                    chosenDateString: (value) => _editRentalCarModel.returnDate = value,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TimeFormField(
                      initialValue: _editRentalCarModel.returnTime,
                      labelText: 'Return Time',
                      icon: Icon(FontAwesomeIcons.clock),
                      optional: true,
                      chosenTimeString: (value) => _editRentalCarModel.returnTime = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Car Details'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _editRentalCarModel.carDescription,
                      labelText: 'Car Description',
                      icon: Icon(FontAwesomeIcons.car),
                      optional: true,
                      onChanged: (value) => _editRentalCarModel.carDescription = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _editRentalCarModel.carNumberPlate,
                      labelText: 'Car Plate',
                      icon: Icon(FontAwesomeIcons.car),
                      optional: true,
                      onChanged: (value) => _editRentalCarModel.carNumberPlate = value),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle('Notes'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                    initialValue: _editRentalCarModel.notes,
                    labelText: 'Notes',
                    icon: Icon(FontAwesomeIcons.stickyNote),
                    optional: true,
                    onChanged: (value) => _editRentalCarModel.notes = value,
                  ),
                ),
                _getSubmitButton(singleTripProvider, _editRentalCarModel, isNewModel),
                Padding(
                  padding: const EdgeInsets.only(top: 2, left: 15, right: 15),
                  child: CancelButton(
                    text: 'CANCEL',
                    onCancel: () {
                      // If cancel, then model shouldn't be saved
                      _editRentalCarModel = model;
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
          onSubmitBooking(singleTripProvider, model, 'booking-addRentalCar', context, alertText);
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
    RentalCarModel _rentalCarModel = RentalCarModel();
    _rentalCarModel.tripUID = tripModel.uid;

    return Scaffold(
      key: Key('Rental Car'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: getContent(context, singleTripProvider, tripModel, _rentalCarModel, true),
      ),
    );
  }
}
