import 'package:flutter/material.dart';
import 'package:travellory/models/day_model.dart';
import 'package:travellory/models/schedule_entry.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/providers/single_trip_provider.dart';
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
    var endDateTime = getDateTimeFrom(tripModel.endDate);

    do {
      days.add(Day(
          date: dateTime
      ));
      dateTime = dateTime.add(Duration(days: 1));
    } while (dateTime.compareTo(endDateTime) <= 0);
  }

  void _addBookingToDays(trip){
    for(var day in days){
      trip.flights.forEach((flight) {
        var startDate = getDateTimeFrom(flight.departureDate);
        var endDate = getDateTimeFrom(flight.arrivalDate) ?? startDate;
        if(day.isInBetween(startDate, endDate)){
          day.entries.add(ScheduleEntry(
            booking: flight,
            dayType: getDayType(day.date, startDate, endDate)
          ));
        }
      });
      trip.rentalCars.forEach((rentalCar) {
        var startDate = getDateTimeFrom(rentalCar.pickupDate);
        var endDate = getDateTimeFrom(rentalCar.returnDate) ?? startDate;
        if(day.isInBetween(startDate, endDate)) {
          day.entries.add(ScheduleEntry(
              booking: rentalCar,
              dayType: getDayType(day.date, startDate, endDate)
          ));
        }
      });
      trip.publicTransports.forEach((publicTransport) {
        var startDate = getDateTimeFrom(publicTransport.departureDate);
        var endDate = getDateTimeFrom(publicTransport.arrivalDate) ?? startDate;
        if(day.isInBetween(startDate, endDate)) {
          day.entries.add(ScheduleEntry(
              booking: publicTransport,
              dayType: getDayType(day.date, startDate, endDate)
          ));
        }
      });
      trip.accommodations.forEach((accommodation){
        var startDate = getDateTimeFrom(accommodation.checkinDate);
        var endDate = getDateTimeFrom(accommodation.checkoutDate) ?? startDate;
        if(day.isInBetween(startDate, endDate)) {
          day.entries.add(ScheduleEntry(
              booking: accommodation,
              dayType: getDayType(day.date, startDate, endDate)
          ));
        }
      });
      trip.activities.forEach((activity){
        var startDate = getDateTimeFrom(activity.startDate);
        var endDate = getDateTimeFrom(activity.endDate) ?? startDate;
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