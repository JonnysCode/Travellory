import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:travellory/utils/controller_wrapper.dart';

void selectDate(BuildContext context, String key, Map dateToSet) async {
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
    String pickedDateString = pickedDate.toString();
    MyControllerWrapper wrapper = dateToSet[key];
    wrapper.displayController.text = "$pickedDateString".split(' ')[0];
    wrapper.controller.text = pickedDate.toIso8601String();
  }
}