import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/src/models/accommodation_model.dart';
import 'package:travellory/src/providers/temp_bookings_provider.dart';
import 'package:travellory/src/providers/trips_provider.dart';
import 'package:travellory/src/screens/accommodation/view_accommodation.dart';
import 'package:travellory/src/services/cloud/add_database.dart';
import 'package:travellory/src/components/animations/loading_heart.dart';
import 'package:travellory/src/components/shared/date_handler.dart';
import 'package:travellory/src/components/booking_cards/booking_card.dart';
import 'package:travellory/src/components/buttons/option_button.dart';

class AddTempBookingsScreen extends StatelessWidget {
  static const String route = '/booking/temp';
  static const String _forwardMail = 'travellory@in.parseur.com';

  List<OptionItem> getAvailableTripOptions(TripsProvider tripsProvider,
      AccommodationModel model,
      TempBookingsProvider tempBookingsProvider,
      BuildContext context) {
    final trips = <OptionItem>[];

    for (final trip in tripsProvider.trips) {
      if (isInTimeFrame(
          getDateTimeFrom(model.checkinDate),
          getDateTimeFrom(model.checkoutDate),
          getDateTimeFrom(trip.tripModel.startDate),
          getDateTimeFrom(trip.tripModel.endDate))) {
        trips.add(OptionItem(
            description: trip.tripModel.name,
            onTab: onSubmitTempAccommodation(
                tempBookingsProvider, trip, model, context)));
      }
    }

    return trips;
  }

  @override
  Widget build(BuildContext context) {
    final TripsProvider tripsProvider = Provider.of<TripsProvider>(context);
    final TempBookingsProvider tempBookingsProvider =
    TempBookingsProvider(tripsProvider.user);
    List<OptionItem> trips;

    return ChangeNotifierProvider<TempBookingsProvider>.value(
      value: tempBookingsProvider,
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme
              .of(context)
              .primaryColor,
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    IconButton(
                      iconSize: 30,
                      icon: Icon(
                        FontAwesomeIcons.chevronLeft,
                        color: Colors.black38,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                    Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            'Forward your booking confirmation mails to',
                            style: TextStyle(
                              fontFamily: 'fashionFetish',
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              height: 1.4,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            _forwardMail,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontFamily: 'fashionFetish',
                              fontWeight: FontWeight.bold,
                              color: Colors.amberAccent,
                              height: 1.2,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 6),
                          Text(
                            'and add them to a trip here.',
                            style: TextStyle(
                              fontFamily: 'fashionFetish',
                              fontWeight: FontWeight.bold,
                              color: Colors.black87,
                              height: 1.2,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            blurRadius: 6,
                            color: Colors.black.withOpacity(.15),
                            offset: Offset(3.0, 3.0))
                      ],
                    ),
                    child: Column(
                      children: <Widget>[
                        Text(
                          'Accommodations',
                          style: TextStyle(
                              fontFamily: 'fashionFetish',
                              fontWeight: FontWeight.w900,
                              color: Colors.black,
                              height: 1.2,
                              fontSize: 20,
                              letterSpacing: -2),
                        ),
                        const SizedBox(height: 10),
                        Expanded(
                          child: Consumer<TempBookingsProvider>(
                            builder: (_, bookings, __) =>
                            bookings.accommodations == null
                                ? LoadingHeart()
                                : ListView.separated(
                              separatorBuilder: (_, __) =>
                              const Divider(),
                              itemCount: bookings.accommodations.length,
                              itemBuilder: (context, index) =>
                                  Row(
                                    children: <Widget>[
                                      Expanded(
                                        child: BookingCard(
                                          model: bookings.accommodations[index],
                                          onTap: () =>
                                              Navigator.pushNamed(context,
                                                  AccommodationView.route,
                                                  arguments: bookings
                                                      .accommodations[index]),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 30,
                                        child: OptionButton(
                                          icon: FontAwesomeIcons.plus,
                                          optionItems: (trips =
                                              getAvailableTripOptions(
                                                  tripsProvider,
                                                  bookings
                                                      .accommodations[index],
                                                  tempBookingsProvider,
                                                  context))
                                              .isEmpty
                                              ? <OptionItem>[
                                            OptionItem(
                                                description:
                                                'We could not find a trip in that time.',
                                                color: Colors.red)
                                          ]
                                              : trips,
                                        ),
                                      ),
                                    ],
                                  ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
