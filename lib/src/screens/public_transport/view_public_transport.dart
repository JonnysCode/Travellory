import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/src/models/public_transport_model.dart';
import 'package:travellory/src/services/cloud/delete_database.dart';
import 'package:travellory/src/components/items/lists_of_types.dart';
import 'package:travellory/src/components/bookings/booking_header.dart';
import 'package:travellory/src/components/bookings/view_bookings.dart';
import 'package:travellory/src/components/forms/checkbox_form_field.dart';
import 'package:travellory/src/components/shared/section_titles.dart';

class PublicTransportView extends StatefulWidget {
  static const route = '/view/publictransport';

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
        SectionTitle(sectionTitle: 'Public Transport Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayDropdownField('Public Transport Type', publicTransportTypes,
            publicTransportModels[0].transportationType, Theme.of(context).primaryColor),
        Divider(),
        displayExtraField(
            publicTransportModels[0].transportationType,
            'Other',
            FontAwesomeIcons.walking,
            "Description of type 'Other'",
            publicTransportModels[0].specificType,
            Theme.of(context).primaryColor),
        displayField(FontAwesomeIcons.solidBuilding, 'Company',
            publicTransportModels[0].publicTransportCompany, Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle(sectionTitle: 'Departure Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.mapMarkerAlt, 'Departure Location',
            publicTransportModels[0].departureLocation, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.calendarAlt, 'Departure Date',
            publicTransportModels[0].departureDate, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.clock, 'Departure Time',
            publicTransportModels[0].departureTime, Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle(sectionTitle: 'Arrival Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.mapMarkerAlt, 'Arrival Location',
            publicTransportModels[0].arrivalLocation, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.calendarAlt, 'Arrival Date',
            publicTransportModels[0].arrivalDate, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.clock, 'Arrival Time', publicTransportModels[0].arrivalTime,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle(sectionTitle: 'Booking Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayCheckboxField('Made Booking', checkboxValue: publicTransportModels[0].booked),
        Divider(),
        displayCheckboxField('Seat Reserved', checkboxValue: publicTransportModels[0].seatReserved),
        Divider(),
        displayExtraField(
            publicTransportModels[0].booked.toString(),
            'true',
            FontAwesomeIcons.ticketAlt,
            'Booking Reference Number',
            publicTransportModels[0].referenceNr,
            Theme.of(context).primaryColor),
        displayExtraField(
            publicTransportModels[0].seatReserved.toString(),
            'true',
            FontAwesomeIcons.chair,
            'Seat',
            publicTransportModels[0].seat,
            Theme.of(context).primaryColor),
        displayField(FontAwesomeIcons.stickyNote, 'Notes', publicTransportModels[0].notes,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SizedBox(height: 10),
        bottomBar(context, publicTransportModels[0], DatabaseDeleter.deletePublicTransportation),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final PublicTransportModel publicTransportModel = ModalRoute.of(context).settings.arguments;
    final List<PublicTransportModel> publicTransports = [];
    publicTransports.add(publicTransportModel);
    publicTransportModels = publicTransports;

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
        exitViewPage(context),
      ]),
    );
  }
}
