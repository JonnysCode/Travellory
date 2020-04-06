import 'package:flutter/material.dart';

class TravelloryFormField extends StatefulWidget {
  const TravelloryFormField(
      {Key key, this.icon, this.labelText, this.optional = false, this.controller, this.onChanged})
      : super(key: key);

  final Icon icon;
  final String labelText;
  final bool optional;
  final TextEditingController controller;
  final void Function(String) onChanged;

  final String validatorText = 'Please enter the required information';

  TravelloryFormFieldState createState() => TravelloryFormFieldState();
}

class TravelloryFormFieldState extends State<TravelloryFormField> with AutomaticKeepAliveClientMixin {
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
