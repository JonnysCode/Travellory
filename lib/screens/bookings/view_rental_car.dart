import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/widgets/booking_header.dart';
import 'package:travellory/widgets/bookings/view_bookings.dart';
import 'package:travellory/widgets/forms/section_titles.dart';

class RentalCarView extends StatefulWidget {
  @override
  _RentalCarViewState createState() => _RentalCarViewState();
}

class _RentalCarViewState extends State<RentalCarView> {
  String bannerUrl = 'assets/images/bookings/vehicles.png';
  String headerTitle = 'Your Rental Car Booking';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('RentalCarView'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: Container(
            padding: const EdgeInsets.all(5.0),
            decoration: BoxDecoration(
              borderRadius:
              BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(20)),
              color: Colors.white,
              boxShadow: <BoxShadow>[
                BoxShadow(
                    blurRadius: 6, color: Colors.black.withOpacity(.15), offset: Offset(3.0, 3.0))
              ],
            ),
            child: SingleChildScrollView(
              child: Column(children: [
                BookingHeader(headerTitle, bannerUrl),
                SizedBox(height: 20),
                SectionTitle('Rental Car Details'),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                fieldView(FontAwesomeIcons.ticketAlt, 'Booking Reference',
                    rentalCarModels[0].bookingReference, context),
                Divider(),
                fieldView(FontAwesomeIcons.solidBuilding, 'Company', rentalCarModels[0].company, context),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                SectionTitle('Pick Up Details'),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                fieldView(
                    FontAwesomeIcons.mapMarkerAlt, 'Pick Up Location', rentalCarModels[0].pickupLocation, context),
                Divider(),
                fieldView(FontAwesomeIcons.calendarAlt, 'Pick Up Date', rentalCarModels[0].pickupDate, context),
                Divider(),
                fieldView(FontAwesomeIcons.clock, 'Pick Up Time', rentalCarModels[0].pickupTime, context),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                SectionTitle('Return Details'),
                fieldView(
                    FontAwesomeIcons.mapMarkerAlt, 'Return Location', rentalCarModels[0].returnLocation, context),
                Divider(),
                fieldView(FontAwesomeIcons.calendarAlt, 'Return Date', rentalCarModels[0].returnDate, context),
                Divider(),
                fieldView(FontAwesomeIcons.clock, 'Return Time', rentalCarModels[0].returnTime, context),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                SectionTitle('Car Details'),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                fieldView(FontAwesomeIcons.car, 'Car Description', rentalCarModels[0].carDescription, context),
                Divider(),
                fieldView(FontAwesomeIcons.car, 'Car Number Plate', rentalCarModels[0].carNumberPlate, context),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                SectionTitle('Notes'),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                fieldView(FontAwesomeIcons.stickyNote, 'Notes', rentalCarModels[0].notes, context),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                SizedBox(height: 10),
                bottomBar(context),
              ]),
            ),
          ),
        ),
      ]),
    );
  }
}
