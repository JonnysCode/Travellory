import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';
import 'package:intl/intl.dart';

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
  DateTime initialDate;

  @override
  void initState() {
    super.initState();
    controller = widget.controller != null ? widget.controller : TextEditingController();
    displayController = TextEditingController();
    // TODO(antilyas): check if dateformating works
    getInitialDate();
  }

  DateTime getInitialDate() {
    if (widget.initialValue != null) {
      displayController..text = (widget.initialValue);;
      return initialDate = DateFormat("dd-MM-yyyy", "en_US").parse(widget.initialValue);
    } else {
      return DateTime.now();
    }
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
      initialDate: initialDate,
      firstDate: DateTime(DateTime.now().year - 1),
      lastDate: DateTime(DateTime.now().year + 1),
      borderRadius: 16,
    );
    if (pickedDate != null) {
      selectedDate = pickedDate;
      // TODO(antilyas): one controller is enough now that dates are saved as strings to database
//      final String pickedDateString = pickedDate.toString();
      displayController.text = DateFormat("dd-MM-yyyy").format(pickedDate);
      controller.text = DateFormat("dd-MM-yyyy").format(pickedDate);
//      displayController.text = "$pickedDateString".split(' ')[0];
//      controller.text = "$pickedDateString".split(' ')[0];
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
                  selectedDate.isBefore(widget.beforeDateKey.currentState.selectedDate) &&
                  (displayController.text !=
                      widget.beforeDateKey.currentState.displayController.text)) {
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
