import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/services/database/delete_database.dart';
import 'package:travellory/widgets/bookings/view_booking_header.dart';
import 'package:travellory/widgets/bookings/view_bookings.dart';
import 'package:travellory/widgets/forms/checkbox_form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';

class FlightView extends StatefulWidget {
  static const route = '/view/flight';

  @override
  _FlightViewState createState() => _FlightViewState();
}

class _FlightViewState extends State<FlightView> {
  final String bannerUrl = 'assets/images/bookings/plane_banner.png';
  final String headerTitle = 'Your Flight';

  SingleChildScrollView flightViewPage() {
    return SingleChildScrollView(
      key: Key('FlightViewPage'),
      child: Column(children: [
        BookingHeader(headerTitle, bannerUrl),
        SizedBox(height: 20),
        SectionTitle('Flight Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.ticketAlt, 'Booking Reference',
            flightModels[0].bookingReference, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.plane, 'Airline', flightModels[0].airline,
            Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.ticketAlt, 'Flight Number', flightModels[0].flightNr,
            Theme.of(context).primaryColor),
        Divider(),
        displayField(
            FontAwesomeIcons.chair, 'Seat', flightModels[0].seat, Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 15, left: 15, right: 15)),
        SectionTitle('Departure Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.planeDeparture, 'Departure Location',
            flightModels[0].departureLocation, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.calendarAlt, 'Departure Date', flightModels[0].departureDate,
            Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.clock, 'Departure Time', flightModels[0].departureTime,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Arrival Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.planeArrival, 'Arrival Location',
            flightModels[0].arrivalLocation, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.calendarAlt, 'Arrival Date', flightModels[0].arrivalDate,
            Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.clock, 'Arrival Time', flightModels[0].arrivalTime,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Baggage Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayCheckboxField('Checked Baggage', flightModels[0].checkedBaggage),
        Divider(),
        displayCheckboxField('Excess Baggage', flightModels[0].excessBaggage),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Notes'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.stickyNote, 'Notes', flightModels[0].notes,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SizedBox(height: 10),
        bottomBar(context, flightModels[0], DatabaseDeleter.deleteFlight),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final FlightModel flightModel = ModalRoute.of(context).settings.arguments;
    final List<FlightModel> flights = [];
    flights.add(flightModel);
    flightModels = flights;

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
        exitViewPage(context),
      ]),
    );
  }
}
