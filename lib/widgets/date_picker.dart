import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:travellory/utils/Wrapper.dart';

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
    wrapper.text = "$pickedDateString".split(' ')[0];
    wrapper.controller.text = pickedDate.toIso8601String();

//    dateToSet[key] = "$pickedDateString".split(' ')[0])
//    if (dateToSet[key]) {
//      setState(() => key = "$pickedDateString".split(' ')[0]);
//      _pickupDateController.text = pickedDate.toIso8601String();
//    } else if (dateToSet == _selectedReturnDate) {
//      setState(() => _selectedReturnDate = "$pickedDateString".split(' ')[0]);
//      _returnDateController.text = pickedDate.toIso8601String();
//    }
  }
}