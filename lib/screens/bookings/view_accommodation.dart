import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/widgets/booking_header.dart';
import 'package:travellory/widgets/bookings/view_bookings.dart';
import 'package:travellory/widgets/forms/section_titles.dart';

class AccommodationView extends StatefulWidget {
  @override
  _AccommodationViewState createState() => _AccommodationViewState();
}

class _AccommodationViewState extends State<AccommodationView> {
  final String bannerUrl = 'assets/images/bookings/hotel.jpg';
  final String headerTitle = 'Your Accommodation';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('AccommodationView'),
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
                SectionTitle('Accommodation Details'),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                fieldView(FontAwesomeIcons.ticketAlt, 'Confirmation Number',
                    accommodationModels[0].confirmationNr, context),
                Divider(),
                fieldView(FontAwesomeIcons.solidBuilding, 'Name', accommodationModels[0].hotelName,
                    context),
                Divider(),
                fieldView(FontAwesomeIcons.mapMarkerAlt, 'Address', accommodationModels[0].address,
                    context),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                SectionTitle('Check-In Details'),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                fieldView(FontAwesomeIcons.calendarAlt, 'Check-In Date',
                    accommodationModels[0].checkinDate, context),
                Divider(),
                fieldView(FontAwesomeIcons.clock, 'Check-In Time',
                    accommodationModels[0].checkinTime, context),
                Divider(),
                fieldView(
                    FontAwesomeIcons.solidMoon, 'Nights', accommodationModels[0].nights, context),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                SectionTitle('Check-Out Details'),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                fieldView(FontAwesomeIcons.calendarAlt, 'Check-out Date',
                    accommodationModels[0].checkoutDate, context),
                Divider(),
                fieldView(FontAwesomeIcons.clock, 'Check-out Time',
                    accommodationModels[0].checkoutTime, context),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                SectionTitle('Notes'),
                Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
                fieldView(
                    FontAwesomeIcons.stickyNote, 'Notes', accommodationModels[0].notes, context),
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
