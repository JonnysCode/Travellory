import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/widgets/booking_header.dart';
import 'package:travellory/widgets/bookings/view_bookings.dart';
import 'package:travellory/widgets/forms/checkbox_form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';

class FlightView extends StatefulWidget {
  @override
  _FlightViewState createState() => _FlightViewState();
}

class _FlightViewState extends State<FlightView> {
  final String bannerUrl = 'assets/images/bookings/airline_banner.jpg';
  final String headerTitle = 'View Your Flight Booking';

  SingleChildScrollView flightViewPage() {
    return SingleChildScrollView(
      child: Column(children: [
        BookingHeader(headerTitle, bannerUrl),
        SizedBox(height: 20),
        SectionTitle('Flight Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.ticketAlt, 'Booking Reference',
            flightModels[0].bookingReference, context),
        Divider(),
        displayField(FontAwesomeIcons.plane, 'Airline', flightModels[0].airline, context),
        Divider(),
        displayField(
            FontAwesomeIcons.ticketAlt, 'Flight Number', flightModels[0].flightNr, context),
        Divider(),
        displayField(FontAwesomeIcons.chair, 'Seat', flightModels[0].seat, context),
        Padding(padding: const EdgeInsets.only(top: 15, left: 15, right: 15)),
        SectionTitle('Departure Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.planeDeparture, 'Departure Location',
            flightModels[0].departureLocation, context),
        Divider(),
        displayField(
            FontAwesomeIcons.calendarAlt, 'Departure Date', flightModels[0].departureDate, context),
        Divider(),
        displayField(
            FontAwesomeIcons.clock, 'Departure Time', flightModels[0].departureTime, context),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Arrival Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.planeArrival, 'Arrival Location',
            flightModels[0].arrivalLocation, context),
        Divider(),
        displayField(
            FontAwesomeIcons.calendarAlt, 'Arrival Date', flightModels[0].arrivalDate, context),
        Divider(),
        displayField(FontAwesomeIcons.clock, 'Arrival Time', flightModels[0].arrivalTime, context),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Baggage Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayCheckboxField('Checked Baggage', flightModels[0].checkedBaggage),
        Divider(),
        displayCheckboxField('Excess Baggage', flightModels[0].excessBaggage),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Notes'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.stickyNote, 'Notes', flightModels[0].notes, context),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SizedBox(height: 10),
        bottomBar(context),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('FlightView'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: bookingView(
            flightViewPage(),
          ),
        ),
      ]),
    );
  }
}
