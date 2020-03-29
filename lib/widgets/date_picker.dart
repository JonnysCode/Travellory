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
    String pickedDateString = pickedDate.toString();
    formFieldDateWidget.displayController.text = "$pickedDateString".split(' ')[0];
    formFieldDateWidget.controller.text = pickedDate.toIso8601String();
  }
}