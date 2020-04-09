import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class DateFormField extends StatefulWidget {
  const DateFormField(
      {Key key,
      this.icon,
      this.labelText,
      this.optional = false,
      this.controller,
      this.chosenDate,
      this.chosenDateString,
      this.beforeDateKey,
      this.dateValidationMessage})
      : super(key: key);

  final Icon icon;
  final String labelText;
  final bool optional;
  final TextEditingController controller;
  final void Function(DateTime) chosenDate;
  final void Function(String) chosenDateString;
  final GlobalKey<DateFormFieldState> beforeDateKey;
  final String dateValidationMessage;

  final String validatorText = 'Please enter the required information';

  @override
  DateFormFieldState createState() => DateFormFieldState();
}

class DateFormFieldState extends State<DateFormField> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TextEditingController controller;
  TextEditingController displayController;
  DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    controller = widget.controller != null ? widget.controller : TextEditingController();
    displayController = TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    displayController.dispose();
    super.dispose();
  }

  void selectDate(BuildContext context) async {
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
      selectedDate = pickedDate;
      final String pickedDateString = pickedDate.toString();
      displayController.text = "$pickedDateString".split(' ')[0];
      controller.text = pickedDate.toIso8601String();
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
            controller: displayController,
            validator: (value) {
              if (widget.optional) return null;
              if (value.isEmpty) {
                return widget.validatorText;
              } else if (widget.beforeDateKey != null &&
                  selectedDate.isBefore(widget.beforeDateKey.currentState.selectedDate)) {
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
