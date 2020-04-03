import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:travellory/widgets/form_fields.dart';

void selectDate(BuildContext context, FormFieldDateWidget formFieldDateWidget) async {
  FocusScope.of(context).requestFocus(FocusNode());
  final DateTime pickedDate = await showRoundedDatePicker(
    context: context,
    theme: ThemeData.dark(),
    initialDate: DateTime.now(),
    firstDate: DateTime(DateTime.now().year - 1),
    lastDate: DateTime(DateTime.now().year + 1),
    borderRadius: 16,
  );
  if (pickedDate != null) {
    formFieldDateWidget.selectedDate = pickedDate;
    final String pickedDateString = pickedDate.toString();
    formFieldDateWidget.displayController.text = "$pickedDateString".split(' ')[0];
    formFieldDateWidget.controller.text = pickedDate.toIso8601String();
  }
}

void selectTime(BuildContext context, FormFieldTimeWidget formFieldTimeWidget) async {
  FocusScope.of(context).requestFocus(FocusNode());
  final TimeOfDay pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now());
  if (pickedTime != null && pickedTime != formFieldTimeWidget.selectedTime)  {
    formFieldTimeWidget.displayController.text = pickedTime.format(context);
    final String pickedTimeString = pickedTime.format(context).toString();
    formFieldTimeWidget.controller.text = pickedTimeString;
  }
}
