import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/services/database/submit.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/forms/date_form_field.dart';
import 'package:travellory/widgets/forms/form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';
import 'package:travellory/widgets/forms/show_dialog.dart';
import 'package:travellory/widgets/forms/time_form_field.dart';
import 'package:travellory/widgets/trip/trip_header.dart';

class RentalCar extends StatefulWidget {
  @override
  _RentalCarState createState() => _RentalCarState();
}

class _RentalCarState extends State<RentalCar> {
  final GlobalKey<FormState> rentalCarFormKey = GlobalKey<FormState>();
  final RentalCarModel rentalCarModel = RentalCarModel();
  final DatabaseAdder databaseAdder = DatabaseAdder();

  final GlobalKey<DateFormFieldState> _pickUpDateFormFieldKey = GlobalKey<DateFormFieldState>();

  bool validateForm() {
    return rentalCarFormKey.currentState.validate();
  }

  final String alertText =
      "You've just submitted the booking information for your rental car booking. You can see all the information in the trip overview";

  final String cancelText =
      'You are about to abort this booking entry. Do you want to go back to the previous site and discard your changes?';

  @override
  Widget build(BuildContext context) {
    final TripModel tripModel = ModalRoute.of(context).settings.arguments;
    rentalCarModel.tripUID = tripModel.uid;

    return Scaffold(
      key: Key('Rental Car'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            TripHeader(tripModel),
            Expanded(
              //child: Form(
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
                          labelText: 'Booking Reference',
                          icon: Icon(FontAwesomeIcons.ticketAlt),
                          optional: true,
                          onChanged: (value) => rentalCarModel.bookingReference = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Company *',
                          icon: Icon(FontAwesomeIcons.solidBuilding),
                          optional: false,
                          onChanged: (value) => rentalCarModel.company = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('Pick Up Information'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Pick Up Location',
                          icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                          optional: true,
                          onChanged: (value) => rentalCarModel.pickupLocation = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: DateFormField(
                        key: _pickUpDateFormFieldKey,
                        labelText: 'Pick Up Date *',
                        icon: Icon(FontAwesomeIcons.calendarAlt),
                        chosenDateString: (value) => rentalCarModel.pickupDate = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TimeFormField(
                          labelText: 'Pick Up Time',
                          icon: Icon(FontAwesomeIcons.clock),
                          optional: true,
                          chosenTimeString: (value) => rentalCarModel.pickupTime = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('Return Information'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Return Location',
                          icon: Icon(FontAwesomeIcons.mapMarkerAlt),
                          optional: true,
                          onChanged: (value) => rentalCarModel.returnLocation = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: DateFormField(
                        labelText: 'Return Date *',
                        icon: Icon(FontAwesomeIcons.calendarAlt),
                        beforeDateKey: _pickUpDateFormFieldKey,
                        dateValidationMessage: 'Return Date cannot be before Pick Up Date',
                        chosenDateString: (value) => rentalCarModel.returnDate = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TimeFormField(
                          labelText: 'Return Time',
                          icon: Icon(FontAwesomeIcons.clock),
                          optional: true,
                          chosenTimeString: (value) => rentalCarModel.returnTime = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('Car Details'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Car Description',
                          icon: Icon(FontAwesomeIcons.car),
                          optional: true,
                          onChanged: (value) => rentalCarModel.carDescription = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                          labelText: 'Car Plate',
                          icon: Icon(FontAwesomeIcons.car),
                          optional: true,
                          onChanged: (value) => rentalCarModel.carNumberPlate = value),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: SectionTitle('Notes'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                      child: TravelloryFormField(
                        labelText: 'Notes',
                        icon: Icon(FontAwesomeIcons.stickyNote),
                        optional: true,
                        onChanged: (value) => rentalCarModel.notes = value,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: SubmitButton(
                          highlightColor: Theme.of(context).primaryColor,
                          fillColor: Theme.of(context).primaryColor,
                          validationFunction: validateForm,
                          onSubmit: onSubmitBooking(rentalCarModel, 'booking-addRentalCar', context,
                              alertText),
                        ),
                    ),
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
        ),
      ),
    );
  }
}
