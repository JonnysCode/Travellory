import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/widgets/bookings/edit.dart';
import 'package:travellory/services/database/edit_database.dart';
import 'package:travellory/widgets/forms/date_form_field.dart';
import 'package:travellory/widgets/forms/form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';
import 'package:travellory/widgets/forms/time_form_field.dart';
import 'package:travellory/widgets/trip/trip_header.dart';
import 'package:travellory/services/api/google_places.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:travellory/widgets/bookings/bookings_get_buttons.dart';

class RentalCar extends StatefulWidget {
  static const route = '/booking/rentalcar';

  @override
  RentalCarState createState() => RentalCarState();
}

class RentalCarState<T extends RentalCar> extends State<T> {
  final GlobalKey<FormState> rentalCarFormKey = GlobalKey<FormState>();

  final GlobalKey<DateFormFieldState> _pickUpDateFormFieldKey = GlobalKey<DateFormFieldState>();
  final GlobalKey<DateFormFieldState> _returnDateFormFieldKey = GlobalKey<DateFormFieldState>();

  bool validateForm() {
    return rentalCarFormKey.currentState.validate();
  }

  final String alertText =
      "You've just submitted the booking information for your rental car booking. You can see all the information in the trip overview";

  final String cancelText =
      'You are about to abort this booking entry. Do you want to go back to the previous site and discard your changes?';

  Column _getRentalCarContent(BuildContext context, SingleTripProvider singleTripProvider,
      TripModel tripModel, RentalCarModel model, bool isNewModel) {
    RentalCarModel _editRentalCarModel = RentalCarModel();
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
                  child: BookingSiteTitle(siteTitle: 'Rental Car', icon: FontAwesomeIcons.car),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: SectionTitle(sectionTitle: 'General Information'),
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
                  child: SectionTitle(sectionTitle: 'Pick Up Information'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _editRentalCarModel.pickupLocation,
                      labelText: 'Pick Up Location *',
                      icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                      optional: false,
                      onTap: (controller) async {
                        final PlacesDetailsResponse detail =
                            await GooglePlaces.openGooglePlacesSearch(
                          context,
                        );
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
                    listenerKey: _returnDateFormFieldKey,
                    labelText: 'Pick Up Date *',
                    optional: false,
                    tripModel: tripModel,
                    icon: Icon(FontAwesomeIcons.calendarAlt),
                    model: _editRentalCarModel,
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
                  child: SectionTitle(sectionTitle: 'Return Information'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: TravelloryFormField(
                      initialValue: _editRentalCarModel.returnLocation,
                      labelText: 'Return Location',
                      icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                      optional: true,
                      onTap: (controller) async {
                        final PlacesDetailsResponse detail =
                            await GooglePlaces.openGooglePlacesSearch(context,
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
                    key: _returnDateFormFieldKey,
                    initialValue: _editRentalCarModel.returnDate,
                    labelText: 'Return Date *',
                    icon: Icon(FontAwesomeIcons.calendarAlt),
                    beforeDateKey: _pickUpDateFormFieldKey,
                    optional: false,
                    tripModel: tripModel,
                    model: _editRentalCarModel,
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
                  child: SectionTitle(sectionTitle: 'Car Details'),
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
                  child: SectionTitle(sectionTitle: 'Notes'),
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
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: getSubmitButton(
                      context,
                      singleTripProvider,
                      _editRentalCarModel,
                      DatabaseAdder.addRentalCar,
                      DatabaseEditor.editRentalCar,
                      alertText,
                      validateForm,
                      isNewModel: isNewModel),
                ),
                Padding(
                    padding: const EdgeInsets.only(top: 2, left: 15, right: 15),
                    child: getBookingCancelButton(
                      context,
                      () {
                        _editRentalCarModel = model;
                        cancellingDialog(context, cancelText);
                      },
                    )),
                SizedBox(height: 20),
              ]),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    final SingleTripProvider singleTripProvider =
        Provider.of<TripsProvider>(context, listen: false).selectedTrip;
    final TripModel tripModel = singleTripProvider.tripModel;

    final ModifyModelArguments _arguments = ModalRoute.of(context).settings.arguments;
    final RentalCarModel _rentalCarModel = _arguments.model;

    return Scaffold(
      key: Key('Rental Car'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: _getRentalCarContent(
            context, singleTripProvider, tripModel, _rentalCarModel, _arguments.isNewModel),
      ),
    );
  }
}
