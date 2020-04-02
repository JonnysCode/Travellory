import 'package:flutter/material.dart';
import 'package:travellory/widgets/date_picker.dart';

class FormFieldWidget {
  TextEditingController controller = TextEditingController();
  Icon icon;
  String labelText;

  String validatorText = 'Please enter the required information';

  FormFieldWidget(String labelText, Icon icon) {
    this.labelText = labelText;
    this.icon = icon;
  }

  void dispose() {
    controller.dispose();
  }

  ListTile required() {
    return ListTile(
      leading: icon,
      title: TextFormField(
        controller: controller,
        validator: (value) {
          if (value.isEmpty) {
            return validatorText;
          }
          return null;
        },
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }

  ListTile optional() {
    return ListTile(
      leading: icon,
      title: TextFormField(
        controller: controller,
        style: TextStyle(color: Colors.black),
        decoration: InputDecoration(
          labelText: labelText,
          labelStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

class FormFieldTimeWidget extends FormFieldWidget {
  FormFieldTimeWidget(String labelText, Icon icon) : super(labelText, icon);

  TextEditingController displayController = TextEditingController();
  TimeOfDay selectedTime;

  @override
  void dispose() {
    displayController.dispose();
    super.dispose();
  }

  GestureDetector timeRequired(BuildContext context) {
    return GestureDetector(
      key: Key('Time Field Required'),
      child: ListTile(
        leading: icon,
        title: TextFormField(
            controller: displayController,
            validator: (value) {
              if (value.isEmpty) {
                return validatorText;
              }
              return null;
            },
            onTap: () => selectTime(context, this),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.black),
            )),
      ),
    );
  }

  GestureDetector time(BuildContext context) {
    return GestureDetector(
      key: Key('Time Field'),
      child: ListTile(
        leading: icon,
        title: TextFormField(
            controller: displayController,
            onTap: () => selectTime(context, this),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.black),
            )),
      ),
    );
  }
}

class FormFieldDateWidget extends FormFieldWidget {
  FormFieldDateWidget(String labelText, Icon icon, [String validateMessage = ""])
      : super(labelText, icon) {
    this.dateValidationMessage = validateMessage;
  }

  TextEditingController displayController = TextEditingController();
  DateTime selectedDate;
  String dateValidationMessage;

  @override
  void dispose() {
    displayController.dispose();
    super.dispose();
  }

  GestureDetector firstDate(BuildContext context) {
    return GestureDetector(
      key: Key('First Date Field'),
      child: ListTile(
        leading: icon,
        title: TextFormField(
            controller: displayController,
            validator: (value) {
              if (value.isEmpty) {
                return validatorText;
              }
              return null;
            },
            onTap: () => selectDate(context, this),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.black),
            )),
      ),
    );
  }

  GestureDetector secondDateRequired(BuildContext context, FormFieldDateWidget mustBeAfter) {
    return GestureDetector(
      key: Key('Second Date Field Required'),
      child: ListTile(
        leading: icon,
        title: TextFormField(
            controller: displayController,
            validator: (value) {
              if (value.isEmpty) {
                return validatorText;
              } else if (this.selectedDate.isBefore(mustBeAfter.selectedDate)) {
                return dateValidationMessage;
              }
              return null;
            },
            onTap: () => selectDate(context, this),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.black),
            )),
      ),
    );
  }

  GestureDetector secondDate(BuildContext context, FormFieldDateWidget mustBeAfter) {
    return GestureDetector(
      child: ListTile(
        leading: icon,
        title: TextFormField(
            controller: displayController,
            validator: (value) {
              if (this.selectedDate.isBefore(mustBeAfter.selectedDate)) {
                return dateValidationMessage;
              }
              return null;
            },
            onTap: () => selectDate(context, this),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.black),
            )),
      ),
    );
  }
}

CheckboxListTile checkbox(bool checkboxBool, String checkboxText, void function(bool valueBool)) {
  return CheckboxListTile(
          value: checkboxBool,
          onChanged: (bool value) => function(value),
          title: new Text(
            checkboxText,
            style: TextStyle(fontSize: 16),
          ),
          controlAffinity: ListTileControlAffinity.leading
  );
}
