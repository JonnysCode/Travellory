import 'package:flutter/material.dart';

class CheckboxFormField extends StatefulWidget {
  CheckboxFormField({Key key, this.initialValue, this.label, this.onChanged}) : super(key: key);

  final bool initialValue;
  final String label;
  final void Function(bool) onChanged;

  CheckboxFormFieldState createState() => CheckboxFormFieldState();
}

class CheckboxFormFieldState extends State<CheckboxFormField> with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  bool checked = false;

  @override
  void initState() {
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
            if (widget.onChanged != null) widget.onChanged(value);
          });
        },
        title: new Text(
          widget.label,
          style: TextStyle(fontSize: 16),
        ),
        controlAffinity: ListTileControlAffinity.leading);
  }
}
