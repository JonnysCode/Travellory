import 'package:flutter/material.dart';
import '../font_widgets.dart';

class CheckboxFormField extends StatefulWidget {
  const CheckboxFormField({Key key, this.initialValue, this.label, this.onChanged})
      : super(key: key);

  final bool initialValue;
  final String label;
  final void Function(bool) onChanged;

  @override
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
        title: Text(
          widget.label,
          style: TextStyle(fontSize: 16),
        ),
        controlAffinity: ListTileControlAffinity.leading);
  }
}

CheckboxListTile displayCheckboxField(String text, bool checkboxValue) {
  checkboxValue = checkboxValue ?? false;
  if (checkboxValue) {
    return checkedView(text);
  } else {
    return notCheckedView(text);
  }
}

CheckboxListTile checkedView(String text) {
  return CheckboxListTile(
    value: true,
    onChanged: null,
    title: FashionFetishText(
        text: text, size: 15.0, fontWeight: FashionFontWeight.bold, color: Colors.black54),
  );
}

CheckboxListTile notCheckedView(String text) {
  return CheckboxListTile(
    value: false,
    onChanged: null,
    title: FashionFetishText(
        text: text + ' (not elected)',
        size: 15.0,
        fontWeight: FashionFontWeight.bold,
        color: Colors.black54),
  );
}
