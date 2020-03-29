import 'package:flutter/material.dart';
import 'package:travellory/widgets/date_picker.dart';

ListTile requiredFormField(TextEditingController controller, Icon icon, String labelText) {
  return ListTile(
    leading: icon,
    title: TextFormField(
      controller: controller,
      validator: (value) {
        if (value.isEmpty) {
          return 'Please enter the required information ';
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

ListTile optionalFormField(TextEditingController controller, Icon icon, String labelText) {
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

GestureDetector dateFormField(TextEditingController controller, Icon icon, String labelText,
    BuildContext context, String key, Map dateToSet) {
  return GestureDetector(
      child: ListTile(
        leading: icon,
        title: TextFormField(
            controller: controller,
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter the required information ';
              }
              return null;
            },
            onTap: () => selectDate(context, key, dateToSet),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: TextStyle(color: Colors.black),
            )),
      ),
    );
}
