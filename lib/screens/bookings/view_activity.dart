import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/shared/lists_of_types.dart';
import 'package:travellory/widgets/bookings/view_booking_header.dart';
import 'package:travellory/widgets/bookings/view_bookings.dart';
import 'package:travellory/widgets/forms/section_titles.dart';

class ActivityView extends StatefulWidget {
  @override
  _ActivityViewState createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  // TODO(antilyas): change banner image based on chosen category
  final String activityBannerUrl = 'assets/images/activity/hill_sky_banner.jpg';
  final String cinemaBannerUrl = 'assets/images/activity/cinema_banner.jpg';
  final String feastBannerUrl = 'assets/images/activity/feast_banner.jpg';
  final String mountainBannerUrl = 'assets/images/activity/mountain_banner.jpg';
  final String restaurantBannerUrl = 'assets/images/activity/restaurant_banner.jpg';
  final String seaBannerUrl = 'assets/images/activity/sea_banner.jpg';
  final String seaMountainBannerUrl = 'assets/images/activity/sea_mountain_banner.jpg';
  final String stageBannerUrl = 'assets/images/activity/stage_banner.jpg';
  final String campBannerUrl = 'assets/images/activity/camp_banner.jpg';

  final String headerTitle = 'Your Activity';

  BookingHeader getHeader(String title) {
    return BookingHeader(title, activityBannerUrl);
  }

  SingleChildScrollView flightViewPage() {
    return SingleChildScrollView(
      key: Key('ActivityViewPage'),
      child: Column(children: [
        getHeader(headerTitle),
        SizedBox(height: 20),
        SectionTitle('Activity Details'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayDropdownField('Category', activityTypes, activityModels[0].category,
            Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.star, 'Activity Title', activityModels[0].title,
            Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.info, 'Description', activityModels[0].description,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 15, left: 15, right: 15)),
        SectionTitle('Schedule'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.mapMarkerAlt, 'Location',
            activityModels[0].location, Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.calendarAlt, 'Start Date', activityModels[0].startDate,
            Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.clock, 'Start Time', activityModels[0].startTime,
            Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.calendarAlt, 'End Date', activityModels[0].endDate,
            Theme.of(context).primaryColor),
        Divider(),
        displayField(FontAwesomeIcons.clock, 'End Time', activityModels[0].endTime,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SectionTitle('Notes'),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        displayField(FontAwesomeIcons.stickyNote, 'Notes', activityModels[0].notes,
            Theme.of(context).primaryColor),
        Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
        SizedBox(height: 10),
        bottomBar(context),
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    final ActivityModel activityModel = ModalRoute.of(context).settings.arguments;
    final List<ActivityModel> activities = [];
    activities.add(activityModel);
    activityModels = activities;

    return Scaffold(
      key: Key('ActivityView'),
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
