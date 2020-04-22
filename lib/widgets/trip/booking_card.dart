import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/widgets/bookings/bookings_accommodation.dart';
import 'package:travellory/widgets/bookings/bookings_activity.dart';
import 'package:travellory/widgets/bookings/bookings_flight.dart';
import 'package:travellory/widgets/bookings/bookings_publict_transport.dart';
import 'package:travellory/widgets/bookings/bookings_rental_car.dart';
import 'package:travellory/widgets/trip/schedule/accommodation_schedule.dart';
import 'package:travellory/widgets/trip/schedule/activity_schedule.dart';
import 'package:travellory/widgets/trip/schedule/flight_schedule.dart';
import 'package:travellory/widgets/trip/schedule/public_transport_schedule.dart';
import 'package:travellory/widgets/trip/schedule/rental_car_schedule.dart';


class BookingCard extends StatelessWidget {
  const BookingCard({
    Key key,
    @required this.model,
    this.onTap,
    this.color,
    this.getSchedule,
  }) : super(key : key);

  final Model model;
  final Function onTap;
  final Color color;
  final Widget getSchedule;

  @override
  Widget build(BuildContext context) {
    return  GestureDetector(
      key: Key('booking_card'),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6.0),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(12.0),
          boxShadow: [
            BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(.2), offset: Offset(0.0, 6.0))
          ],
        ),
        child: getSchedule,
      ),
    );
  }
}

Widget getScheduleAccordingTo(Model model){
  Widget widget;
  if (model is FlightModel){
    widget = FlightSchedule(model);
  } else if (model is RentalCarModel){
    widget = RentalCarSchedule(model);
  } else if (model is AccommodationModel){
    widget = AccommodationSchedule(model);
  } else if (model is PublicTransportModel){
    widget = PublicTransportSchedule(model);
  } else if (model is ActivityModel){
    widget = ActivitySchedule(model);
  } else {
    widget = Container();
  }
  return widget;
}

Widget getBookingsAccordingTo(Model model){
  Widget widget;
  if (model is FlightModel){
    widget = FlightBookings(model);
  } else if (model is RentalCarModel){
    widget = RentalCarBookings(model);
  } else if (model is AccommodationModel){
    widget = AccommodationBookings(model);
  } else if (model is PublicTransportModel){
    widget = PublicTransportBookings(model);
  } else if (model is ActivityModel){
    widget = ActivityBookings(model);
  } else {
    widget = Container();
  }
  return widget;
}

Color getColorAccordingTo(Model model){
  Color color;
  if (model is FlightModel){
    color = Colors.blue[100];
  } else if (model is RentalCarModel){
    color = Colors.yellow[700];
  } else if (model is AccommodationModel){
    color = Colors.deepOrange[200];
  } else if (model is PublicTransportModel){
    color = Colors.teal[300];
  } else if (model is ActivityModel){
    color = Color(0xFFA1B9C6);
  } else {
    color = Colors.grey;
  }

  return color;
}

Color getBookingColorAccordingTo(Model model){
  Color color;
  if (model is FlightModel){
    color = Colors.blue[100];
  } else if (model is RentalCarModel){
    color = Colors.yellow[600];
  } else if (model is AccommodationModel){
    color = Colors.deepOrange[200];
  } else if (model is PublicTransportModel){
    color = Colors.teal[300];
  } else if (model is ActivityModel){
    color = Colors.grey;
  } else {
    color = Colors.grey;
  }
  return color;
}