import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/widgets/bookings/view_booking_header.dart';
import 'package:travellory/widgets/bookings/view_bookings.dart';
import 'package:travellory/widgets/forms/section_titles.dart';

List<RentalCarModel> rentalCarModels = <RentalCarModel>[
  RentalCarModel(
    bookingReference: 'R1',
    company: 'Hertz',
    pickupLocation: 'London',
    pickupDate: '2020-05-01',
    pickupTime: '15:10:00',
    returnLocation: 'London',
    returnDate: '2020-05-04',
    returnTime: '17:00:00',
    carDescription: 'Audi',
    carNumberPlate: 'FAB123',
    notes: null,
  ),
];

class RentalCarView extends StatefulWidget {
  @override
  _RentalCarViewState createState() => _RentalCarViewState();
}

class _RentalCarViewState extends State<RentalCarView> {
  final String bannerUrl = 'assets/images/bookings/rentalcar_banner.jpg';
  final String headerTitle = 'Your Rental Car';

  SingleChildScrollView rentalCarViewPage() {
    return SingleChildScrollView(
      key: Key('RentalCarViewPage'),
      child: Column(children: [
        BookingHeader(headerTitle, bannerUrl),
        SizedBox(height: 20),
        SectionTitle('Rental Car Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.ticketAlt, 'Booking Reference',
            rentalCarModels[0].bookingReference, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.solidBuilding, 'Company', rentalCarModels[0].company,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Pick Up Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.mapMarkerAlt, 'Pick Up Location',
            rentalCarModels[0].pickupLocation, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.calendarAlt, 'Pick Up Date', rentalCarModels[0].pickupDate,
            Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.clock, 'Pick Up Time', rentalCarModels[0].pickupTime,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Return Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.mapMarkerAlt, 'Return Location',
            rentalCarModels[0].returnLocation, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.calendarAlt, 'Return Date', rentalCarModels[0].returnDate,
            Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.clock, 'Return Time', rentalCarModels[0].returnTime,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Car Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.car, 'Car Description', rentalCarModels[0].carDescription,
            Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.car, 'Car Number Plate', rentalCarModels[0].carNumberPlate,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Notes'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.stickyNote, 'Notes', rentalCarModels[0].notes,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SizedBox(height: 10),
        bottomBar(context),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('RentalCarView'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: bookingView(
            rentalCarViewPage(),
          ),
        ),
      ]),
    );
  }
}
