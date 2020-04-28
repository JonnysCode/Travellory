import 'package:flutter/material.dart';

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
  TextEditingController displayController;
  TimeOfDay selectedTime;
  TimeOfDay initialTime;

  @override
  void initState() {
    super.initState();
    controller = widget.controller != null ? widget.controller : TextEditingController();
    displayController = TextEditingController();
    // TODO(antilyas): check if getInitialTime works
    getInitialTime();
  }

  TimeOfDay getInitialTime() {
    if (widget.initialValue != null) {
      displayController..text = (widget.initialValue);
      return initialTime = TimeOfDay(
          hour: int.parse(widget.initialValue.split(":")[0]),
          minute: int.parse(widget.initialValue.split(":")[1]));
    } else {
      return TimeOfDay.now();
    }
  }

  @override
  void dispose() {
    controller.dispose();
    displayController.dispose();
    super.dispose();
  }

  void selectTime(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final TimeOfDay pickedTime =
        await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null && pickedTime != selectedTime) {
      // TODO(antilyas): only need one controller
      selectedTime = pickedTime;
      displayController.text = pickedTime.format(context);
      final String pickedTimeString = pickedTime.format(context).toString();
      controller.text = pickedTimeString;
      if (widget.chosenTime != null) widget.chosenTime(selectedTime);
      if (widget.chosenTimeString != null) widget.chosenTimeString(pickedTimeString);
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
            controller: displayController,
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
