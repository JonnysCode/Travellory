import 'package:flutter/material.dart';
import 'package:travellory/src/components/items/list_models.dart';

class TravelloryFormField extends StatefulWidget {
  const TravelloryFormField(
      {Key key,
      this.icon,
      this.initialValue,
      this.labelText,
      this.optional = false,
      this.controller,
      this.onChanged,
      this.onTap})
      : super(key: key);

  final Icon icon;
  final String initialValue;
  final String labelText;
  final bool optional;
  final TextEditingController controller;
  final void Function(String) onChanged;
  final void Function(TextEditingController) onTap;

  final String validatorText = 'Please enter the required information';

  @override
  TravelloryFormFieldState createState() => TravelloryFormFieldState();
}

class TravelloryFormFieldState extends State<TravelloryFormField>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  TextEditingController controller;

  @override
  void initState() {
    super.initState();
    if (widget.initialValue != null) {
      if (widget.controller == null) {
        controller = TextEditingController()..text = widget.initialValue;
      } else {
        controller = widget.controller
          ..text = widget.initialValue;
      }
    } else {
      if (widget.controller == null) {
        controller = TextEditingController();
      } else {
        controller = widget.controller;
      }
    }
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
      key: Key('Form Field'),
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
        onTap: () {
          if (widget.onTap != null) {
            widget.onTap(controller);
          }
        },
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

void showAdditional(ListModel<Widget> list, Widget parent, Widget additionalField, {bool show}) {
  if (show) {
    list.insert(list.indexOf(parent) + 1, additionalField);
  } else {
    final int idx = list.indexOf(additionalField);
    if (idx > -1) list.removeAt(idx);
  }
}
