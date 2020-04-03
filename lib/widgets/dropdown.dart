import 'package:flutter/material.dart';

class Item {
  const Item(this.name, this.icon);

  final String name;
  final Icon icon;
}

ListTile dropdownField(String dropdownTitle, Item selectedType, List<Item> types,
    BuildContext context, String validatorText, void function(Item newValue)) {
  return ListTile(
    key: Key('Dropdown Menu'),
    leading: Icon(Icons.menu),
    title: Container(
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: Colors.white,
        ),
        child: DropdownButtonFormField<Item>(
          value: selectedType,
          hint: Text(dropdownTitle, style: TextStyle(color: Colors.black)),
          onChanged: (Item newValue) => function(newValue),
          validator: (value) {
            if (value == null) {
              return validatorText;
            }
            return null;
          },
          items: types.map((Item type) {
            return DropdownMenuItem<Item>(
              value: type,
              child: Row(
                children: <Widget>[
                  type.icon,
                  SizedBox(width: 10),
                  Text(
                    type.name,
                    style: TextStyle(color: Colors.black),
                  ),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    ),
  );
}