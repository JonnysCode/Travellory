import 'package:flutter/material.dart';
import 'package:travellory/src/models/abstract_model.dart';
import 'package:travellory/src/models/accommodation_model.dart';
import 'package:travellory/src/models/activity_model.dart';
import 'package:travellory/src/models/flight_model.dart';
import 'package:travellory/src/models/public_transport_model.dart';
import 'package:travellory/src/models/rental_car_model.dart';
import 'package:travellory/src/components/booking_cards/bookings_accommodation.dart';
import 'package:travellory/src/components/booking_cards/bookings_activity.dart';
import 'package:travellory/src/components/booking_cards/bookings_flight.dart';
import 'package:travellory/src/components/booking_cards/bookings_publict_transport.dart';
import 'package:travellory/src/components/booking_cards/bookings_rental_car.dart';

class BookingCard extends StatelessWidget {
  const BookingCard({
    Key key,
    @required this.model,
    this.onTap,
  }) : super(key: key);

  final Model model;
  final Function onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      key: Key('booking_card'),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: getBookingColorAccordingTo(model),
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(.2), offset: Offset(0.0, 6.0))
          ],
        ),
        child: getBookingsAccordingTo(model),
      ),
    );
  }
}

Widget getBookingsAccordingTo(Model model) {
  Widget widget;
  if (model is FlightModel) {
    widget = FlightBookings(model);
  } else if (model is RentalCarModel) {
    widget = RentalCarBookings(model);
  } else if (model is AccommodationModel) {
    widget = AccommodationBookings(model);
  } else if (model is PublicTransportModel) {
    widget = PublicTransportBookings(model);
  } else if (model is ActivityModel) {
    widget = ActivityBookings(model);
  } else {
    widget = Container();
  }
  return widget;
}

Color getBookingColorAccordingTo(Model model) {
  Color color;
  if (model is FlightModel) {
    color = Colors.blue[100];
  } else if (model is RentalCarModel) {
    color = Colors.yellow[600];
  } else if (model is AccommodationModel) {
    color = Colors.deepOrange[200];
  } else if (model is PublicTransportModel) {
    color = Colors.grey;
  } else if (model is ActivityModel) {
    color = Colors.green[300];
  } else {
    color = Colors.grey;
  }
  return color;
}
