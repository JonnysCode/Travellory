import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/src/models/activity_model.dart';
import 'package:travellory/src/services/cloud/delete_database.dart';
import 'package:travellory/src/components/items/lists_of_types.dart';
import 'package:travellory/src/components/bookings/booking_header.dart';
import 'package:travellory/src/components/bookings/view_bookings.dart';
import 'package:travellory/src/components/shared/section_titles.dart';

class ActivityView extends StatefulWidget {
  static const route = '/view/activity';

  @override
  _ActivityViewState createState() => _ActivityViewState();
}

class _ActivityViewState extends State<ActivityView> {
  final String activityBannerUrl = 'assets/images/activity/hill_sky_banner.jpg';
  final String cinemaBannerUrl = 'assets/images/activity/cinema_banner.jpg';
  final String feastBannerUrl = 'assets/images/activity/feast_banner.jpg';
  final String mountainBannerUrl = 'assets/images/activity/mountain_banner.jpg';
  final String restaurantBannerUrl = 'assets/images/activity/restaurant_banner.jpg';
  final String seaBannerUrl = 'assets/images/activity/sea_banner.jpg';
  final String seaMountainBannerUrl = 'assets/images/activity/sea_mountain_banner.jpg';
  final String campBannerUrl = 'assets/images/activity/camp_banner.jpg';

  final String headerTitle = 'Your Activity';

  BookingHeader _getHeader(String title, int imageNr) {
    String url;
    switch (imageNr) {
      case 1:
        url = cinemaBannerUrl;
        break;
      case 3:
        url = seaBannerUrl;
        break;
      case 4:
        url = feastBannerUrl;
        break;
      case 6:
        url = restaurantBannerUrl;
        break;
      case 8:
        url = campBannerUrl;
        break;
      case 10:
        url = restaurantBannerUrl;
        break;
      case 12:
        url = restaurantBannerUrl;
        break;
      case 13:
        url = mountainBannerUrl;
        break;
      default:
        url = activityBannerUrl;
        break;
    }
    return BookingHeader(title, url);
  }

  SingleChildScrollView flightViewPage(ActivityModel activityModel) {
    return SingleChildScrollView(
      key: Key('ActivityViewPage'),
      child: Stack(
        children: <Widget>[
          Column(children: [
            _getHeader(headerTitle, activityModel.imageNr),
            SizedBox(height: 20),
            SectionTitle(sectionTitle: 'Activity Details'),
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
            SectionTitle(sectionTitle: 'Schedule'),
            Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
            displayField(FontAwesomeIcons.mapMarkerAlt, 'Location', activityModels[0].location,
                Theme.of(context).primaryColor),
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
            SectionTitle(sectionTitle: 'Notes'),
            Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
            displayField(FontAwesomeIcons.stickyNote, 'Notes', activityModels[0].notes,
                Theme.of(context).primaryColor),
            Padding(padding: const EdgeInsets.only(top: 10, left: 15, right: 15)),
            SizedBox(height: 10),
            bottomBar(context, activityModel, DatabaseDeleter.deleteActivity),
          ]),
          _activityIcon(activityModel),
        ],
      ),
    );
  }

  Positioned _activityIcon(ActivityModel activityModel) {
    return Positioned(
      key: Key('ActivityIcon'),
      top: 160,
      left: 20,
      child: Container(
        height: 80,
        width: 80,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          boxShadow: <BoxShadow>[
            BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(.3), offset: Offset(3.0, 3.0))
          ],
          image: DecorationImage(
            image: AssetImage(activityModel.imagePath),
            fit: BoxFit.fitWidth,
            alignment: Alignment.bottomCenter,
          ),
        ),
      ),
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
            flightViewPage(activityModel),
          ),
        ),
        exitViewPage(context),
      ]),
    );
  }
}
