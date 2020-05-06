import 'package:flutter/material.dart';
import 'package:travellory/models/day_model.dart';
import 'package:travellory/models/schedule_entry.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/trips/single_trip_provider.dart';
import 'package:travellory/utils/date_converter.dart';


class ScheduleProvider extends ChangeNotifier{
  ScheduleProvider(SingleTripProvider trip){
    _initDays(trip.tripModel);
    _addBookingToDays(trip);
  }

  List<Day> days;

  void _initDays(TripModel tripModel) {
    days = <Day>[];
    var dateTime = getDateTimeFrom(tripModel.startDate);
    final endDateTime = getDateTimeFrom(tripModel.endDate);

    do {
      days.add(Day(
          date: dateTime
      ));
      dateTime = dateTime.add(Duration(days: 1));
    } while (dateTime.compareTo(endDateTime) <= 0);
  }

  void _addBookingToDays(trip){
    for(final day in days){
      trip.flights.forEach((flight) {
        final startDate = getDateTimeFrom(flight.departureDate);
        final endDate = getDateTimeFrom(flight.arrivalDate) ?? startDate;
        if(day.isInBetween(startDate, endDate)){
          day.entries.add(ScheduleEntry(
            booking: flight,
            dayType: getDayType(day.date, startDate, endDate)
          ));
        }
      });
      trip.rentalCars.forEach((rentalCar) {
        final startDate = getDateTimeFrom(rentalCar.pickupDate);
        final endDate = getDateTimeFrom(rentalCar.returnDate) ?? startDate;
        if(day.isInBetween(startDate, endDate)) {
          day.entries.add(ScheduleEntry(
              booking: rentalCar,
              dayType: getDayType(day.date, startDate, endDate)
          ));
        }
      });
      trip.publicTransports.forEach((publicTransport) {
        final startDate = getDateTimeFrom(publicTransport.departureDate);
        final endDate = getDateTimeFrom(publicTransport.arrivalDate) ?? startDate;
        if(day.isInBetween(startDate, endDate)) {
          day.entries.add(ScheduleEntry(
              booking: publicTransport,
              dayType: getDayType(day.date, startDate, endDate)
          ));
        }
      });
      trip.accommodations.forEach((accommodation){
        final startDate = getDateTimeFrom(accommodation.checkinDate);
        final endDate = getDateTimeFrom(accommodation.checkoutDate) ?? startDate;
        if(day.isInBetween(startDate, endDate)) {
          day.entries.add(ScheduleEntry(
              booking: accommodation,
              dayType: getDayType(day.date, startDate, endDate)
          ));
        }
      });
      trip.activities.forEach((activity){
        final startDate = getDateTimeFrom(activity.startDate);
        final endDate = getDateTimeFrom(activity.endDate) ?? startDate;
        if(day.isInBetween(startDate, endDate)) {
          day.entries.add(ScheduleEntry(
              booking: activity,
              dayType: getDayType(day.date, startDate, endDate)
          ));
        }
      });
    }
  }
}