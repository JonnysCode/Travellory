import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/shared/lists_of_types.dart';
import 'package:travellory/widgets/booking_header.dart';
import 'package:travellory/widgets/bookings/view_bookings.dart';
import 'package:travellory/widgets/forms/checkbox_form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';

class PublicTransportView extends StatefulWidget {
  @override
  _PublicTransportViewState createState() => _PublicTransportViewState();
}

class _PublicTransportViewState extends State<PublicTransportView> {
  final String bannerUrl = 'assets/images/bookings/metro.jpg';
  final String headerTitle = 'Your Public Transport';

  SingleChildScrollView publicTransportViewPage() {
    return SingleChildScrollView(
      child: Column(children: [
        BookingHeader(headerTitle, bannerUrl),
        SizedBox(height: 20),
        SectionTitle('Public Transport Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayDropdownField('Public Transport Type', publicTransportTypes,
            publicTransportModels[1].transportationType, context),
        Divider(),
        displayExtraField(
            publicTransportModels[1].transportationType,
            'Other',
            FontAwesomeIcons.walking,
            "Description of type 'Other'",
            publicTransportModels[1].specificType,
            context),
        displayField(FontAwesomeIcons.solidBuilding, 'Company',
            publicTransportModels[1].publicTransportCompany, context),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Departure Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.mapMarkerAlt, 'Departure Location',
            publicTransportModels[1].departureLocation, context),
        Divider(),
        displayField(FontAwesomeIcons.calendarAlt, 'Departure Date',
            publicTransportModels[1].departureDate, context),
        Divider(),
        displayField(FontAwesomeIcons.clock, 'Departure Time',
            publicTransportModels[1].departureTime, context),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Arrival Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.mapMarkerAlt, 'Arrival Location',
            publicTransportModels[1].arrivalLocation, context),
        Divider(),
        displayField(FontAwesomeIcons.calendarAlt, 'Arrival Date',
            publicTransportModels[1].arrivalDate, context),
        Divider(),
        displayField(
            FontAwesomeIcons.clock, 'Arrival Time', publicTransportModels[1].arrivalTime, context),
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
            context),
        displayExtraField(publicTransportModels[1].seatReserved.toString(), 'true',
            FontAwesomeIcons.chair, 'Seat', publicTransportModels[1].seat, context),
        displayField(FontAwesomeIcons.stickyNote, 'Notes', publicTransportModels[1].notes, context),
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
      ]),
    );
  }
}
