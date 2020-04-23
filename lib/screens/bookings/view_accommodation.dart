import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/shared/lists_of_types.dart';
import 'package:travellory/widgets/bookings/view_booking_header.dart';
import 'package:travellory/widgets/bookings/view_bookings.dart';
import 'package:travellory/widgets/forms/checkbox_form_field.dart';
import 'package:travellory/widgets/forms/section_titles.dart';

class AccommodationView extends StatefulWidget {
  @override
  _AccommodationViewState createState() => _AccommodationViewState();
}

class _AccommodationViewState extends State<AccommodationView> {
  final String bannerUrl = 'assets/images/bookings/house_banner.png';
  final String headerTitle = 'Your Accommodation';

  SingleChildScrollView accommodationViewPage() {
    return SingleChildScrollView(
      key: Key('AccommodationViewPage'),
      child: Column(children: [
        BookingHeader(headerTitle, bannerUrl),
        SizedBox(height: 20),
        SectionTitle('Accommodation Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayDropdownField('Accommodation Type', accommodationTypes, accommodationModels[0].type,
            Theme.of(context).primaryColor),
        Divider(),
        // this checks if type chosen is Airbnb
        displayExtraField(
            accommodationModels[0].type,
            'Airbnb',
            FontAwesomeIcons.suitcase,
            'Specific type of airbnb',
            accommodationModels[0].airbnbType,
            Theme.of(context).primaryColor),
        // this checks if type chosen is Other
        displayExtraField(
            accommodationModels[0].type,
            'Other',
            FontAwesomeIcons.bed,
            "Description of type 'Other'",
            accommodationModels[0].specificationOther,
            Theme.of(context).primaryColor),
        displayField(FontAwesomeIcons.ticketAlt, 'Confirmation Number',
            accommodationModels[0].confirmationNr, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.solidBuilding, 'Name', accommodationModels[0].name,
            Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.mapMarkerAlt, 'Address', accommodationModels[0].address,
            Theme.of(context).primaryColor),
        Divider(),
        // this checks for hotel room type
        displayExtraField(accommodationModels[0].type, 'Hotel', FontAwesomeIcons.hotel, 'Room Type',
            accommodationModels[0].hotelRoomType, Theme.of(context).primaryColor),
        displayCheckboxField('Breafast Included', accommodationModels[0].breakfast),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Check-In Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.calendarAlt, 'Check-In Date',
            accommodationModels[0].checkinDate, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.clock, 'Check-In Time', accommodationModels[0].checkinTime,
            Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.solidMoon, 'Nights', accommodationModels[0].nights,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Check-Out Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.calendarAlt, 'Check-Out Date',
            accommodationModels[0].checkoutDate, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.clock, 'Check-Out Time', accommodationModels[0].checkoutTime,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Notes'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.stickyNote, 'Notes', accommodationModels[0].notes,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SizedBox(height: 10),
        bottomBar(context),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final AccommodationModel accommodationModel = ModalRoute.of(context).settings.arguments;
    final List<AccommodationModel> accommodations = [];
    accommodations.add(accommodationModel);
    accommodationModels = accommodations;

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
