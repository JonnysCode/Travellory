import 'package:flutter/material.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/utils/list_models.dart';

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
      controller = widget.controller != null ? widget.controller : TextEditingController()
        ..text = (widget.initialValue);
    } else {
      controller = widget.controller != null ? widget.controller : TextEditingController();
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
        onTap: () => widget.onTap(controller),
        decoration: InputDecoration(
          labelText: widget.labelText,
          labelStyle: TextStyle(color: Colors.black),
        ),
      ),
    );
  }
}

void showAdditional(ListModel<Widget> list, bool show, Widget parent, Widget additionalField) {
  if (show) {
    list.insert(list.indexOf(parent) + 1, additionalField);
  } else {
    final int idx = list.indexOf(additionalField);
    if (idx > -1) list.removeAt(idx);
  }
}
