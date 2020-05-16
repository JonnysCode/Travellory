import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/providers/trips/temp_bookings_provider.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/services/database/add_database.dart';
import 'package:travellory/shared/loading_heart.dart';
import 'package:travellory/widgets/bookings/booking_card.dart';
import 'package:travellory/widgets/buttons/option_button.dart';

class EmailParsedBookingsScreen extends StatelessWidget {
  static final String route = '/booking/emailparsed';
  static final String _forwardMail = 'travellory@in.parseur.com';

  @override
  Widget build(BuildContext context) {
    TripsProvider tripsProvider = Provider.of<TripsProvider>(context);

    return FutureProvider<List<AccommodationModel>>(
      create: (_) => TempBookingsProvider(tripsProvider.user).fetchAccommodations(),
      child: SafeArea(
        child: Scaffold(
          backgroundColor: Theme.of(context).primaryColor,
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
                          const SizedBox(
                              height: 6
                          ),
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
                          const SizedBox(
                              height: 6
                          ),
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
                const SizedBox(
                    height: 16
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(10.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.white,
                      boxShadow: <BoxShadow>[
                        BoxShadow(
                            blurRadius: 6, color: Colors.black.withOpacity(.15), offset: Offset(3.0, 3.0))
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
                            letterSpacing: -2
                          ),
                        ),
                        const SizedBox(
                            height: 10
                        ),
                        Expanded(
                          child: Consumer<List<AccommodationModel>>(
                            builder: (_, accommodations, __) => accommodations == null
                                ? LoadingHeart()
                                : ListView.separated(
                              separatorBuilder: (_, __) => const Divider(),
                              itemCount: accommodations.length,
                              itemBuilder: (context, index) => Row(
                                children: <Widget>[
                                  Expanded(
                                    child: BookingCard(
                                      model: accommodations[index],
                                    ),
                                  ),
                                  SizedBox(
                                    width: 30,
                                    child: OptionButton(
                                      icon: FontAwesomeIcons.plus,
                                      optionItems: tripsProvider.trips.map((trip) => OptionItem(
                                        description: trip.tripModel.name,
                                        onTab: () {
                                          tripsProvider.selectedTrip.addBooking(
                                              accommodations[index], DatabaseAdder.addAccommodation);
                                        }
                                      )).toList(),
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