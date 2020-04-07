import 'package:flutter/material.dart';

class Item {
  const Item(this.name, this.icon);

  final String name;
  final Icon icon;
}

class TravelloryDropdownField extends StatefulWidget {
  const TravelloryDropdownField(
      {Key key, this.title, this.selectedType, this.types, this.validatorText, this.onChanged})
      : super(key: key);

  final String title;
  final Item selectedType;
  final List<Item> types;
  final void Function(Item) onChanged;
  final String validatorText;

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
    selectedType = widget.selectedType;
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
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
      ),
    );
  }
}
