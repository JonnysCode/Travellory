import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';
import 'package:travellory/models/trip_model.dart';

class DateFormField extends StatefulWidget {
  const DateFormField(
      {Key key,
      this.icon,
      this.initialValue,
      this.labelText,
      this.optional = false,
      this.controller,
      this.chosenDate,
      this.chosenDateString,
      this.beforeDateKey,
      this.tripModel,
      this.dateValidationMessage})
      : super(key: key);

  final Icon icon;
  final String initialValue;
  final String labelText;
  final bool optional;
  final TextEditingController controller;
  final void Function(DateTime) chosenDate;
  final void Function(String) chosenDateString;
  final GlobalKey<DateFormFieldState> beforeDateKey;
  final TripModel tripModel;
  final String dateValidationMessage;

  final String validatorText = 'Please enter the required information';
  final String dateInTripValidationMessage = 'The chosen date is not in trip date range';

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
    getInitialDate();
  }

  DateTime getInitialDate() {
    if (widget.initialValue != '' && widget.initialValue != null) {
      controller..text = (widget.initialValue);
      initialDate = DateFormat("dd-MM-yyyy", "en_US").parse(widget.initialValue);
      selectedDate = initialDate;
      return initialDate;
    } else {
      return DateTime.now();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  bool pickedDateNotInTripRange(DateTime pickedDate) {
    DateTime tripStartDate = DateFormat("dd-MM-yyyy", "en_US").parse(widget.tripModel.startDate);
    DateTime tripEndDate = DateFormat("dd-MM-yyyy", "en_US").parse(widget.tripModel.endDate);
    if ((pickedDate.isAfter(tripStartDate) || pickedDate == tripStartDate) &&
        (pickedDate.isBefore(tripEndDate) || pickedDate == tripEndDate)) {
      return false;
    }
    return true;
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
              if (value.isEmpty) {
                return widget.validatorText;
              } else if (pickedDateNotInTripRange(selectedDate)) {
                return widget.dateInTripValidationMessage;
              } else if (widget.beforeDateKey != null &&
                  selectedDate.isBefore(widget.beforeDateKey.currentState.selectedDate) &&
                  (controller.text != widget.beforeDateKey.currentState.controller.text)) {
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
