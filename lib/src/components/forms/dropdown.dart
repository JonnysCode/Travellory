import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/src/components/items/lists_of_types.dart';

class Item {
  const Item(this.name, this.icon);

  final String name;
  final Icon icon;
}

class TravelloryDropdownField extends StatefulWidget {
  const TravelloryDropdownField(
      {Key key, this.title, this.initialValue, this.selectedType, this.types, this.validatorText, this.onChanged})
      : super(key: key);

  final String title;
  final String initialValue;
  final Item selectedType;
  final List<Item> types;
  final void Function(Item) onChanged;
  final String validatorText;

  @override
  TravelloryDropdownFieldState createState() => TravelloryDropdownFieldState();
}

class TravelloryDropdownFieldState extends State<TravelloryDropdownField>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  Item selectedType;

  @override
  void initState() {
    super.initState();
    _getSelectedType();
  }

  void _getSelectedType() {
    if(widget.initialValue != null && widget.initialValue != '') {
      selectedType = getDropdownBookingType(widget.initialValue);
    } else {
      selectedType = widget.selectedType;
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return ListTile(
      key: Key('Dropdown Menu'),
      leading: Icon(FontAwesomeIcons.listUl),
      title: Theme(
          data: Theme.of(context).copyWith(
            canvasColor: Colors.white,
          ),
          child: DropdownButtonFormField<Item>(
            value: selectedType,
            hint: Text(widget.title, style: TextStyle(color: Colors.black)),
            onChanged: (value) {
              setState(() {
                selectedType = value;
                if (widget.onChanged != null) {
                  widget.onChanged(value);
                }
              });
            },
            validator: (value) {
              if (value == null) {
                return widget.validatorText;
              }
              return null;
            },
            items: widget.types.map((Item type) {
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
    );
  }
}
