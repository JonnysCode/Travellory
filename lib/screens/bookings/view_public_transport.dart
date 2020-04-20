import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/shared/lists_of_types.dart';
import 'package:travellory/widgets/bookings/view_booking_header.dart';
import 'package:travellory/widgets/bookings/view_bookings.dart';
import 'package:travellory/widgets/forms/checkbox_form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';

List<PublicTransportModel> publicTransportModels = <PublicTransportModel>[
  PublicTransportModel(
    transportationType: 'Rail',
    publicTransportCompany: 'RENFE',
    specificType: null,
    booked: true,
    seatReserved: true,
    referenceNr: 'R1A6',
    reservationCompany: 'RENFE',
    seat: '13F',
    departureLocation: 'Madrid',
    departureDate: '2020-06-20',
    departureTime: '12:00:00',
    arrivalLocation: 'Sevilla',
    arrivalDate: '2020-06-20',
    arrivalTime: '15:23:00',
    notes: 'Coche 8',
  ),
  PublicTransportModel(
    transportationType: 'Other',
    publicTransportCompany: 'RENFE',
    specificType: 'Cercanias',
    booked: true,
    seatReserved: false,
    referenceNr: 'R1A6',
    reservationCompany: 'RENFE',
    seat: '13F',
    departureLocation: 'Madrid',
    departureDate: '2020-06-20',
    departureTime: '12:00:00',
    arrivalLocation: 'Sevilla',
    arrivalDate: '2020-06-20',
    arrivalTime: '15:23:00',
    notes: 'Coche 8',
  )
];

class PublicTransportView extends StatefulWidget {
  @override
  _PublicTransportViewState createState() => _PublicTransportViewState();
}

class _PublicTransportViewState extends State<PublicTransportView> {
  final String bannerUrl = 'assets/images/bookings/rail_banner.png';
  final String headerTitle = 'Your Public Transport';

  SingleChildScrollView publicTransportViewPage() {
    return SingleChildScrollView(
      key: Key('PublicTransportViewPage'),
      child: Column(children: [
        BookingHeader(headerTitle, bannerUrl),
        SizedBox(height: 20),
        SectionTitle('Public Transport Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayDropdownField('Public Transport Type', publicTransportTypes,
            publicTransportModels[1].transportationType, Theme.of(context).primaryColor),
        Divider(),
        displayExtraField(
            publicTransportModels[1].transportationType,
            'Other',
            FontAwesomeIcons.walking,
            "Description of type 'Other'",
            publicTransportModels[1].specificType,
            Theme.of(context).primaryColor),
        displayField(FontAwesomeIcons.solidBuilding, 'Company',
            publicTransportModels[1].publicTransportCompany, Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Departure Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.mapMarkerAlt, 'Departure Location',
            publicTransportModels[1].departureLocation, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.calendarAlt, 'Departure Date',
            publicTransportModels[1].departureDate, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.clock, 'Departure Time',
            publicTransportModels[1].departureTime, Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Arrival Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.mapMarkerAlt, 'Arrival Location',
            publicTransportModels[1].arrivalLocation, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.calendarAlt, 'Arrival Date',
            publicTransportModels[1].arrivalDate, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.clock, 'Arrival Time', publicTransportModels[1].arrivalTime,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Booking Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayCheckboxField('Made Booking', publicTransportModels[1].booked),
        Divider(),
        displayCheckboxField('Seat Reserved', publicTransportModels[1].seatReserved),
        Divider(),
        displayExtraField(
            publicTransportModels[1].booked.toString(),
            'true',
            FontAwesomeIcons.ticketAlt,
            'Booking Reference Number',
            publicTransportModels[1].referenceNr,
            Theme.of(context).primaryColor),
        displayExtraField(
            publicTransportModels[1].seatReserved.toString(),
            'true',
            FontAwesomeIcons.chair,
            'Seat',
            publicTransportModels[1].seat,
            Theme.of(context).primaryColor),
        displayField(FontAwesomeIcons.stickyNote, 'Notes', publicTransportModels[1].notes,
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
      key: Key('PublicTransportView'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: bookingView(
            publicTransportViewPage(),
          ),
        ),
        Positioned(
          top: 15,
          right: 10,
          child: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: FaIcon(FontAwesomeIcons.times),
            iconSize: 26,
            color: Colors.red,
          ),
        ),
      ]),
    );
  }
}
