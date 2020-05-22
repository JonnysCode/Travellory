import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/models/accommodation_model.dart';
import 'package:travellory/models/activity_model.dart';
import 'package:travellory/models/flight_model.dart';
import 'package:travellory/models/public_transport_model.dart';
import 'package:travellory/models/rental_car_model.dart';
import 'package:travellory/models/trip_model.dart';
import 'package:travellory/utils/trip_date_validity.dart';

class DateFormField extends StatefulWidget {
  const DateFormField(
      {Key key,
      this.icon,
      this.isNewTrip = true,
      this.initialValue,
      this.labelText,
      this.optional = false,
      this.controller,
      this.chosenDate,
      this.chosenDateString,
      this.beforeDateKey,
      this.listenerKey,
      this.tripModel,
      this.model,
      this.dateValidationMessage})
      : super(key: key);

  final Icon icon;
  final bool isNewTrip;
  final String initialValue;
  final String labelText;
  final bool optional;
  final TextEditingController controller;
  final void Function(DateTime) chosenDate;
  final void Function(String) chosenDateString;
  final GlobalKey<DateFormFieldState> beforeDateKey;
  final GlobalKey<DateFormFieldState> listenerKey;
  final TripModel tripModel;
  final Model model;
  final String dateValidationMessage;

  final String validatorText = 'Please enter the required information';
  final String dateInTripValidationMessage = 'The chosen date is not in trip date range';
  final String tripEditDateValidationFailedMessage =
      'Trip date cannot start before / end after a booking date';

  @override
  DateFormFieldState createState() => DateFormFieldState();
}

class DateFormFieldState extends State<DateFormField> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TextEditingController controller;
  DateTime selectedDate;
  DateTime initialDate;

  @override
  void initState() {
    super.initState();
    controller = widget.controller != null ? widget.controller : TextEditingController();
    setInitialDate();
  }

  void setInitialDate() {
    if (widget.initialValue != null && widget.initialValue != '') {
      controller..text = (widget.initialValue);
      initialDate = DateFormat("dd-MM-yyyy", "en_US").parse(widget.initialValue);
      selectedDate = initialDate;
    }
    if (widget.tripModel != null && widget.initialValue == '') {
      initialDate = DateFormat("dd-MM-yyyy", "en_US").parse(widget.tripModel.startDate);
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool pickedDateInTripRange(DateTime pickedDate) {
    if (widget.tripModel != null) {
      final DateTime tripStartDate =
          DateFormat("dd-MM-yyyy", "en_US").parse(widget.tripModel.startDate);
      final DateTime tripEndDate =
          DateFormat("dd-MM-yyyy", "en_US").parse(widget.tripModel.endDate);
      if ((pickedDate.isAfter(tripStartDate) || pickedDate == tripStartDate) &&
          (pickedDate.isBefore(tripEndDate) || pickedDate == tripEndDate)) {
        return true;
      } else {
        return false;
      }
    }
    return true;
  }

  bool secondDateInRange(DateTime pickedDate) {
    if (pickedDate.isBefore(widget.beforeDateKey.currentState.selectedDate) &&
        (controller.text != widget.beforeDateKey.currentState.controller.text)) {
      return false;
    }
    return true;
  }

  void sameDateFieldChanged(DateTime selectedListenerDate) {
    if (widget.initialValue != null &&
        selectedListenerDate != null &&
        (controller.text == null || controller.text == '')) {
      setState(() {
        selectedDate = selectedListenerDate;
        controller.text = DateFormat("dd-MM-yyyy").format(selectedListenerDate);
        if (widget.chosenDate != null) widget.chosenDate(selectedDate);
        if (widget.chosenDateString != null) widget.chosenDateString(controller.text);
      });
    }
  }

  void otherDateFieldChanged(DateTime selectedListenerDate) {
    if (widget.initialValue != null) {
      setState(() {
        selectedDate = selectedListenerDate.add(Duration(days: 1));
        controller.text = DateFormat("dd-MM-yyyy").format(selectedDate);
        if (widget.chosenDate != null) widget.chosenDate(selectedDate);
        if (widget.chosenDateString != null) widget.chosenDateString(controller.text);
      });
    }
  }

  void selectDate(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final DateTime pickedDate = await showRoundedDatePicker(
      context: context,
      theme: ThemeData.dark(),
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      borderRadius: 16,
    );
    if (pickedDate != null) {
      selectedDate = pickedDate;
      controller.text = DateFormat("dd-MM-yyyy").format(pickedDate);
      if (widget.chosenDate != null) widget.chosenDate(selectedDate);
      if (widget.chosenDateString != null) widget.chosenDateString(controller.text);
      if (widget.listenerKey != null &&
          (widget.model is RentalCarModel || widget.model is AccommodationModel)) {
        widget.listenerKey.currentState.otherDateFieldChanged(pickedDate);
      }
      if (widget.listenerKey != null &&
          (widget.model is FlightModel ||
              widget.model is PublicTransportModel ||
              widget.model is ActivityModel)) {
        widget.listenerKey.currentState.sameDateFieldChanged(pickedDate);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      key: Key('Date Field'),
      child: ListTile(
        leading: widget.icon,
        title: TextFormField(
            controller: controller,
            validator: (value) {
              if (widget.optional) return null;
              if (!widget.isNewTrip) {
                if(!tripDateIsValid(value, widget.labelText, context)) {
                  return widget.tripEditDateValidationFailedMessage;
                }
              }
              if (value.isEmpty) {
                return widget.validatorText;
              } else if (!pickedDateInTripRange(selectedDate)) {
                return widget.dateInTripValidationMessage;
              } else if (widget.beforeDateKey != null && !secondDateInRange(selectedDate)) {
                return widget.dateValidationMessage;
              }
              return null;
            },
            onTap: () => selectDate(context),
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: TextStyle(color: Colors.black),
            )),
      ),
    );
  }
}
