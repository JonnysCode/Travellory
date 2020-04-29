import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TimeFormField extends StatefulWidget {
  const TimeFormField(
      {Key key,
      this.icon,
      this.initialValue,
      this.labelText,
      this.optional = false,
      this.controller,
      this.chosenTime,
      this.chosenTimeString})
      : super(key: key);

  final Icon icon;
  final String initialValue;
  final String labelText;
  final bool optional;
  final TextEditingController controller;
  final void Function(TimeOfDay) chosenTime;
  final void Function(String) chosenTimeString;

  final String validatorText = 'Please enter the required information';

  @override
  TimeFormFieldState createState() => TimeFormFieldState();
}

class TimeFormFieldState extends State<TimeFormField> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TextEditingController controller;
  TimeOfDay selectedTime;
  DateTime initialTimeValue;
  TimeOfDay initialTime;

  @override
  void initState() {
    super.initState();
    controller = widget.controller != null ? widget.controller : TextEditingController();
    _getInitialTime();
  }

  // pass string of initial value first to dateTime format,
  // to then make it possible to easily change it to timeOfDay
  TimeOfDay _getInitialTime() {
    if (widget.initialValue != '' && widget.initialValue != null) {
      controller..text = (widget.initialValue);
      initialTimeValue = DateFormat("H:mm", "en_US").parse(widget.initialValue);
      return initialTime = TimeOfDay(hour: initialTimeValue.hour, minute: initialTimeValue.minute);
    } else {
      return TimeOfDay.now();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  void selectTime(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final TimeOfDay pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null && pickedTime != selectedTime) {
      selectedTime = pickedTime;
      controller.text = pickedTime.format(context).toString();
      if (widget.chosenTime != null) widget.chosenTime(selectedTime);
      if (widget.chosenTimeString != null) widget.chosenTimeString(controller.text);
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      key: Key('Time Field'),
      child: ListTile(
        leading: widget.icon,
        title: TextFormField(
            controller: controller,
            validator: (value) {
              if (widget.optional) return null;

              if (value.isEmpty) {
                return widget.validatorText;
              }
              return null;
            },
            onTap: () => selectTime(context),
            decoration: InputDecoration(
              labelText: widget.labelText,
              labelStyle: TextStyle(color: Colors.black),
            )),
      ),
    );
  }
}
