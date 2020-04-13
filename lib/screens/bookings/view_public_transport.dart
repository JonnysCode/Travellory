import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/widgets/booking_header.dart';
import 'package:travellory/widgets/bookings/view_bookings.dart';
import 'package:travellory/widgets/forms/checkbox_form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';

class PublicTransportView extends StatefulWidget {
  @override
  _PublicTransportViewState createState() => _PublicTransportViewState();
}

class _PublicTransportViewState extends State<PublicTransportView> {
  final String bannerUrl = 'assets/images/bookings/hotel.jpg';
  final String headerTitle = 'Your Public Transport';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('PublicTransportView'),
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
                SectionTitle('Public Transport Details'),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                fieldView(FontAwesomeIcons.train, 'Type',
                    publicTransportModels[0].transportationType, context),
                Divider(),
                fieldView(FontAwesomeIcons.solidBuilding, 'Company',
                    publicTransportModels[0].company, context),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                SectionTitle('Departure Details'),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                fieldView(FontAwesomeIcons.mapMarkerAlt, 'Departure Location',
                    publicTransportModels[0].departureLocation, context),
                Divider(),
                fieldView(FontAwesomeIcons.calendarAlt, 'Departure Date',
                    publicTransportModels[0].departureDate, context),
                Divider(),
                fieldView(FontAwesomeIcons.clock, 'Departure Time',
                    publicTransportModels[0].departureTime, context),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                SectionTitle('Arrival Details'),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                fieldView(FontAwesomeIcons.mapMarkerAlt, 'Arrival Location',
                    publicTransportModels[0].arrivalLocation, context),
                Divider(),
                fieldView(FontAwesomeIcons.calendarAlt, 'Arrival Date',
                    publicTransportModels[0].arrivalDate, context),
                Divider(),
                fieldView(FontAwesomeIcons.clock, 'Arrival Time',
                    publicTransportModels[0].arrivalTime, context),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                SectionTitle('Booking Details'),
                Padding(
                    padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
                    child: Column(children: [
                      checkboxView('Made Booking'),
                      Divider(),
                      checkboxView('Seat Reserved'),
                    ])),
                SectionTitle('Notes'),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                fieldView(
                    FontAwesomeIcons.stickyNote, 'Notes', publicTransportModels[0].notes, context),
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
