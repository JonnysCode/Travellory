import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/trips_provider.dart';
import 'package:travellory/screens/bookings/accommodation.dart';
import 'package:travellory/screens/bookings/activity.dart';
import 'package:travellory/screens/bookings/flight.dart';
import 'package:travellory/screens/bookings/public_transport.dart';
import 'package:travellory/screens/bookings/rental_car.dart';
import 'package:travellory/screens/bookings/view_accommodation.dart';
import 'package:travellory/screens/bookings/view_activity.dart';
import 'package:travellory/screens/bookings/view_flight.dart';
import 'package:travellory/screens/bookings/view_public_transport.dart';
import 'package:travellory/screens/bookings/view_rental_car.dart';
import 'package:travellory/shared/loading_heart.dart';
import 'package:travellory/widgets/bookings/edit.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/booking_cards/booking_card.dart';
import 'package:travellory/widgets/trip/trip_header.dart';

class TripScreen extends StatelessWidget {
  static const route = '/viewtrip';

  @override
  Widget build(BuildContext context) {
    final TripModel tripModel =
        Provider.of<TripsProvider>(context, listen: false).selectedTrip.tripModel;

    Widget _subsection(
        String title, String route, ModifyModelArguments Function() passedModelArguments) {
      return Container(
        key: Key('SubSection'),
        height: 40,
        width: MediaQuery.of(context).size.width,
        child: Stack(
          children: <Widget>[
            Positioned(
              top: 16,
              width: 240,
              child: FashionFetishText(
                text: title,
                size: 24,
                fontWeight: FashionFontWeight.heavy,
              ),
            ),
            Positioned(
              top: 17,
              right: 34,
              child: FashionFetishText(
                text: 'Add',
                size: 16,
                fontWeight: FashionFontWeight.bold,
                color: Colors.black45,
              ),
            ),
            Positioned(
              top: 6,
              right: 0,
              child: GestureDetector(
                onTap: () =>
                    {Navigator.pushNamed(context, route, arguments: passedModelArguments())},
                child: Container(
                  height: 28,
                  width: 28,
                  padding: EdgeInsets.only(top: 20, right: 10),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/home/trip/add.png'),
                      fit: BoxFit.fitWidth,
                      alignment: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    }

    return Scaffold(
      key: Key('TripScreen'),
      body: Container(
        color: Colors.white,
        child: Column(
          children: <Widget>[
            TripHeader(tripModel),
            Expanded(
              child: Consumer<TripsProvider>(
                builder: (_, tripsProvider, __) {
                  final trip = tripsProvider.selectedTrip;
                  return ListView(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: _subsection('Flights', Flight.route, () {
                          final FlightModel flightModel = FlightModel();
                          flightModel.tripUID = tripModel.uid;
                          return ModifyModelArguments(model: flightModel, isNewModel: true);
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: trip.isFetchingFlights
                            ? LoadingHeart()
                            : Column(
                                children: trip.flights
                                    .map((model) => Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: BookingCard(
                                            model: model,
                                            onTap: () => Navigator.pushNamed(
                                                context, FlightView.route,
                                                arguments: model),
                                          ),
                                        ))
                                    .toList(),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: _subsection('Accommodation', Accommodation.route, () {
                          final AccommodationModel accommodationModel = AccommodationModel();
                          accommodationModel.tripUID = tripModel.uid;
                          return ModifyModelArguments(model: accommodationModel, isNewModel: true);
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: trip.isFetchingAccommodations
                            ? LoadingHeart()
                            : Column(
                                children: trip.accommodations
                                    .map((model) => Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: BookingCard(
                                            model: model,
                                            onTap: () => Navigator.pushNamed(
                                                context, AccommodationView.route,
                                                arguments: model),
                                          ),
                                        ))
                                    .toList(),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: _subsection('Activities', Activity.route, () {
                          final ActivityModel activityModel = ActivityModel();
                          activityModel.tripUID = tripModel.uid;
                          return ModifyModelArguments(model: activityModel, isNewModel: true);
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: trip.isFetchingActivities
                            ? LoadingHeart()
                            : Column(
                                children: trip.activities
                                    .map((model) => Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: BookingCard(
                                            model: model,
                                            onTap: () => Navigator.pushNamed(
                                                context, ActivityView.route,
                                                arguments: model),
                                          ),
                                        ))
                                    .toList(),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: _subsection('Car rental', RentalCar.route, () {
                          final RentalCarModel rentalCarModel = RentalCarModel();
                          rentalCarModel.tripUID = tripModel.uid;
                          return ModifyModelArguments(model: rentalCarModel, isNewModel: true);
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: trip.isFetchingRentalCars
                            ? LoadingHeart()
                            : Column(
                                children: trip.rentalCars
                                    .map((model) => Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: BookingCard(
                                            model: model,
                                            onTap: () => Navigator.pushNamed(
                                                context, RentalCarView.route,
                                                arguments: model),
                                          ),
                                        ))
                                    .toList(),
                              ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: _subsection('Transportation', PublicTransport.route, () {
                          final PublicTransportModel publicTransportModel = PublicTransportModel();
                          publicTransportModel.tripUID = tripModel.uid;
                          return ModifyModelArguments(
                              model: publicTransportModel, isNewModel: true);
                        }),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                        child: trip.isFetchingPublicTransports
                            ? LoadingHeart()
                            : Column(
                                children: trip.publicTransports
                                    .map((model) => Padding(
                                          padding: const EdgeInsets.only(bottom: 10),
                                          child: BookingCard(
                                            model: model,
                                            onTap: () => Navigator.pushNamed(
                                                context, PublicTransportView.route,
                                                arguments: model),
                                          ),
                                        ))
                                    .toList(),
                              ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
