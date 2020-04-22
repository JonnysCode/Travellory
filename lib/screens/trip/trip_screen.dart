import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips_provider.dart';
import 'package:travellory/shared/loading.dart';
import 'package:travellory/widgets/font_widgets.dart';
import 'package:travellory/widgets/trip/booking_card.dart';
import 'package:travellory/widgets/trip/trip_header.dart';

class TripScreen extends StatelessWidget {
  const TripScreen({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TripModel tripModel = ModalRoute.of(context).settings.arguments;

    void _openAddBooking(String bookingToAddSite) {
      Navigator.pushNamed(context, bookingToAddSite, arguments: tripModel);
    }

    Widget _subsection(String title, String route) {
      return Container(
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
                onTap: () => _openAddBooking(route),
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
                child: ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _subsection('Flights', '/booking/flight'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Consumer<TripsProvider>( //TODO: choose better option -> consumer/selector (with Tuple)
                    builder: (_, tripsProvider, __) => tripsProvider.isFetching
                        ?  SizedBox(height: 80, child: Loading())
                        :  Column(
                      children: tripsProvider.flights.map((model) => BookingCard(
                          model: model,
                          onTap: () => Navigator.pushNamed(context, '/view/flight', arguments: model),
                          color: getBookingColorAccordingTo(model),
                          getSchedule: getBookingsAccordingTo(model),
                        )
                      ).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _subsection('Accommodation', '/booking/accommodation'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Selector<TripsProvider, List<Model>>(
                    selector: (_, tripsProvider) => tripsProvider.accommodations,
                    builder: (_, accommodations, __) => Column(
                      children: accommodations.map((model) => BookingCard(
                        model: model,
                        onTap: () => Navigator.pushNamed(context, '/view/accommodation', arguments: model),
                        color: getBookingColorAccordingTo(model),
                        getSchedule: getBookingsAccordingTo(model),
                      )
                      ).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _subsection('Activities', '/booking/activity'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Selector<TripsProvider, List<Model>>(
                    selector: (_, tripsProvider) => tripsProvider.activities,
                    builder: (_, activities, __) => Column(
                      children: activities.map((model) => BookingCard(
                        model: model,
                        onTap: () => Navigator.pushNamed(context, '/view/activity', arguments: model),
                        color: getBookingColorAccordingTo(model),
                        getSchedule: getBookingsAccordingTo(model),
                      )
                      ).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _subsection('Car rental', '/booking/rentalcar'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Selector<TripsProvider, List<Model>>(
                    selector: (_, tripsProvider) => tripsProvider.rentalcars,
                    builder: (_, rentalCars, __) => Column(
                      children: rentalCars.map((model) => BookingCard(
                        model: model,
                        onTap: () => Navigator.pushNamed(context, '/view/rentalcar', arguments: model),
                        color: getBookingColorAccordingTo(model),
                        getSchedule: getBookingsAccordingTo(model),
                      )
                      ).toList(),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: _subsection('Transportation', '/booking/publictransport'),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
                  child: Selector<TripsProvider, List<Model>>(
                    selector: (_, tripsProvider) => tripsProvider.publictransports,
                    builder: (_, publicTransports, __) => Column(
                      children: publicTransports.map((model) => BookingCard(
                        model: model,
                        onTap: () => Navigator.pushNamed(context, '/view/publictransport', arguments: model),
                        color: getBookingColorAccordingTo(model),
                        getSchedule: getBookingsAccordingTo(model),
                      )
                      ).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
