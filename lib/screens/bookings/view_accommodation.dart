import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/shared/lists_of_types.dart';
import 'package:travellory/widgets/booking_header.dart';
import 'package:travellory/widgets/bookings/view_bookings.dart';
import 'package:travellory/widgets/forms/checkbox_form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';

class AccommodationView extends StatefulWidget {
  @override
  _AccommodationViewState createState() => _AccommodationViewState();
}

class _AccommodationViewState extends State<AccommodationView> {
  final String bannerUrl = 'assets/images/bookings/hotel.jpg';
  final String headerTitle = 'Your Accommodation';

//  Column displayExtraFieldRoomType() {
//    if (accommodationModels[0].type == 'Hotel') {
//      return Column(children: [
//        displayField(
//            FontAwesomeIcons.hotel, 'Room Type', accommodationModels[0].hotelRoomType, context),
//        Divider()
//      ]);
//    } else {
//      return Column(children: [
//        Padding(
//          padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
//        )
//      ]);
//    }
//  }

//  Column displayExtraFieldAirbnbType() {
//    if (accommodationModels[0].type == 'Airbnb') {
//      return Column(children: [
//        displayField(FontAwesomeIcons.suitcase, 'Specific type of airbnb',
//            accommodationModels[0].airbnbType, context),
//        Divider()
//      ]);
//    } else {
//      return Column(children: [
//        Padding(
//          padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
//        )
//      ]);
//    }
//  }

//  Column displayExtraFieldOtherType() {
//    if (accommodationModels[0].type == 'Other') {
//      return Column(children: [
//        displayField(FontAwesomeIcons.suitcase, "Description of type 'Other'",
//            accommodationModels[0].airbnbType, context),
//        Divider()
//      ]);
//    } else {
//      return Column(children: [
//        Padding(
//          padding: const EdgeInsets.only(top: 0, left: 0, right: 0),
//        )
//      ]);
//    }
//  }

  Column displayExtraField(String toCompare, String comparison, IconData icon, String displayText,
      String display, BuildContext context) {
    if (toCompare == comparison) {
      return Column(children: [
        displayField(icon, displayText, display, context),
        Divider(),
      ]);
    } else {
      return Column(children: [
        Padding(padding: const EdgeInsets.only(top: 0, left: 0, right: 0)),
      ]);
    }
  }

  SingleChildScrollView accommodationViewPage() {
    return SingleChildScrollView(
      child: Column(children: [
        BookingHeader(headerTitle, bannerUrl),
        SizedBox(height: 20),
        SectionTitle('Accommodation Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayDropdownField(
            'Accommodation Type', accommodationTypes, accommodationModels[0].type, context),
        Divider(),

//        displayExtraFieldAirbnbType(),
//        displayExtraFieldOtherType(),

        // this checks if type chosen is Airbnb
        displayExtraField(accommodationModels[0].type, 'Airbnb', FontAwesomeIcons.suitcase,
            'Specific type of airbnb', accommodationModels[0].airbnbType, context),
        // this checks if type chosen is Other
        displayExtraField(accommodationModels[0].type, 'Other', FontAwesomeIcons.bed,
            "Description of type 'Other'", accommodationModels[0].specificationOther, context),
        displayField(FontAwesomeIcons.ticketAlt, 'Confirmation Number',
            accommodationModels[0].confirmationNr, context),
        Divider(),
        displayField(FontAwesomeIcons.solidBuilding, 'Name', accommodationModels[0].name, context),
        Divider(),
        displayField(
            FontAwesomeIcons.mapMarkerAlt, 'Address', accommodationModels[0].address, context),
        Divider(),
//        displayExtraFieldRoomType(),
        // this checks for hotel room type
        displayExtraField(accommodationModels[0].type, 'Hotel', FontAwesomeIcons.hotel, 'Room Type',
            accommodationModels[0].hotelRoomType, context),
        displayCheckboxField('Breafast Included', accommodationModels[0].breakfast),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Check-In Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.calendarAlt, 'Check-In Date',
            accommodationModels[0].checkinDate, context),
        Divider(),
        displayField(
            FontAwesomeIcons.clock, 'Check-In Time', accommodationModels[0].checkinTime, context),
        Divider(),
        displayField(FontAwesomeIcons.solidMoon, 'Nights', accommodationModels[0].nights, context),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Check-Out Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.calendarAlt, 'Check-Out Date',
            accommodationModels[0].checkoutDate, context),
        Divider(),
        displayField(
            FontAwesomeIcons.clock, 'Check-Out Time', accommodationModels[0].checkoutTime, context),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Notes'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.stickyNote, 'Notes', accommodationModels[0].notes, context),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SizedBox(height: 10),
        bottomBar(context),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Key('AccommodationView'),
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Stack(children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 8),
          child: bookingView(
            accommodationViewPage(),
          ),
        ),
      ]),
    );
  }
}
