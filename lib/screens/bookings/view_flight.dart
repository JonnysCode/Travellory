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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('FlightView'),
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
                Divider(),
                Padding(
                    padding: const EdgeInsets.only(top: 0, left: 15, right: 15),
                    child: Column(children: [
                      checkboxView('Checked Baggage'),
                      Divider(),
                      checkboxView('Excess Baggage'),
                    ])),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                SectionTitle('Departure Details'),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                displayField(FontAwesomeIcons.planeDeparture, 'Departure Location',
                    flightModels[0].departureLocation, context),
                Divider(),
                displayField(FontAwesomeIcons.calendarAlt, 'Departure Date',
                    flightModels[0].departureDate, context),
                Divider(),
                displayField(FontAwesomeIcons.clock, 'Departure Time', flightModels[0].departureTime,
                    context),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                SectionTitle('Arrival Details'),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                displayField(FontAwesomeIcons.planeArrival, 'Arrival Location',
                    flightModels[0].arrivalLocation, context),
                Divider(),
                displayField(FontAwesomeIcons.calendarAlt, 'Arrival Date', flightModels[0].arrivalDate,
                    context),
                Divider(),
                displayField(
                    FontAwesomeIcons.clock, 'Arrival Time', flightModels[0].arrivalTime, context),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                SectionTitle('Notes'),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                displayField(FontAwesomeIcons.stickyNote, 'Notes', flightModels[0].notes, context),
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
