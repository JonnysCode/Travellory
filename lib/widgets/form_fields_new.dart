import 'package:flutter/material.dart';
import 'package:flutter_rounded_date_picker/rounded_picker.dart';

class YFormField extends StatefulWidget {
  const YFormField(
      {Key key, this.icon, this.labelText, this.optional = false, this.controller, this.onChanged})
      : super(key: key);

  final Icon icon;
  final String labelText;
  final bool optional;
  final TextEditingController controller;
  final void Function(String) onChanged;

  final String validatorText = 'Please enter the required information';

  YFormFieldState createState() => YFormFieldState();
}

class YFormFieldState extends State<YFormField> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    controller = widget.controller != null ? widget.controller : TextEditingController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListTile(
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
        style: TextStyle(color: Colors.black),
        onChanged: widget.onChanged,
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class YTimeFormField extends StatefulWidget {
  YTimeFormField(
      {Key key,
        this.icon,
        this.labelText,
        this.optional = false,
        this.controller,
        this.chosenTime,
        this.chosenTimeString})
      : super(key: key);

  final Icon icon;
  final String labelText;
  final bool optional;
  final TextEditingController controller;
  final void Function(TimeOfDay) chosenTime;
  final void Function(String) chosenTimeString;

  final String validatorText = 'Please enter the required information';

  YTimeFormFieldState createState() => YTimeFormFieldState();
}

class YTimeFormFieldState extends State<YTimeFormField> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TextEditingController controller;
  TextEditingController displayController;
  TimeOfDay selectedTime;

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

  void selectTime(BuildContext context) async {
    FocusScope.of(context).requestFocus(FocusNode());
    final TimeOfDay pickedTime =
    await showTimePicker(context: context, initialTime: TimeOfDay.now());
    if (pickedTime != null && pickedTime != selectedTime) {
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

class YDateFormField extends StatefulWidget {
  YDateFormField(
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
  final GlobalKey<YDateFormFieldState> beforeDateKey;
  final String dateValidationMessage;

  final String validatorText = 'Please enter the required information';

  YDateFormFieldState createState() => YDateFormFieldState();
}

class YDateFormFieldState extends State<YDateFormField> with AutomaticKeepAliveClientMixin {
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

class YCheckboxFormField extends StatefulWidget {
  YCheckboxFormField({Key key, this.initialValue, this.label, this.onChanged}) : super(key: key);

  final bool initialValue;
  final String label;
  final void Function(bool) onChanged;

  YCheckboxFormFieldState createState() => YCheckboxFormFieldState();
}

class YCheckboxFormFieldState extends State<YCheckboxFormField> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool checked = false;

  @override
  void initState(){
    checked = widget.initialValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return CheckboxListTile(
        value: checked,
        onChanged: (value) {
          setState(() {
            checked = value;
            if (widget.onChanged != null)
              widget.onChanged(value);
          });
        },
        title: new Text(
          widget.label,
          style: TextStyle(fontSize: 16),
        ),
        controlAffinity: ListTileControlAffinity.leading);
  }
}