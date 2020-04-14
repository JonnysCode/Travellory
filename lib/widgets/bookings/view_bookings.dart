import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/widgets/buttons/buttons.dart';
import 'package:travellory/widgets/forms/dropdown.dart';
import '../font_widgets.dart';

Container bookingView(SingleChildScrollView child) {
  return Container(
    padding: const EdgeInsets.all(5.0),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.vertical(top: Radius.circular(0), bottom: Radius.circular(20)),
      color: Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(blurRadius: 6, color: Colors.black.withOpacity(.15), offset: Offset(3.0, 3.0))
      ],
    ),
    child: child,
  );
}

Container bottomBar(
  BuildContext context,
) {
  void _edit() {
    // TODO
  }

  void _delete() {
    // TODO
  }

  return Container(
    padding: EdgeInsets.all(20.0),
    height: 130.0,
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(40.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        filledButton('EDIT', Colors.white, Theme.of(context).primaryColor,
            Theme.of(context).primaryColor, Colors.white, _edit),
        filledButton('DELETE', Colors.white, Theme.of(context).primaryColor,
            Theme.of(context).primaryColor, Colors.white, _delete),
      ],
    ),
  );
}

Padding displayField(IconData icon, String title, String details, BuildContext context) {
  if (details != null && details != '') {
    return fieldDetailsView(icon, title, details, context);
  } else {
    return fieldNoDetailsView(icon, title, context);
  }
}

Padding displayDropdownField(String title, List<Item> types, String details, BuildContext context) {
  if (details != null && details != '') {
    if (details == 'Hotel') {
      return fieldDetailsView(FontAwesomeIcons.hotel, title, details, context);
    } else if (details == 'Airbnb') {
      return fieldDetailsView(FontAwesomeIcons.suitcase, title, details, context);
    } else if (details == 'Bed & Breakfast') {
      return fieldDetailsView(FontAwesomeIcons.coffee, title, details, context);
    } else {
      return fieldDetailsView(FontAwesomeIcons.bed, title, details, context);
    }
  } else {
    return fieldNoDetailsView(FontAwesomeIcons.hotel, title, context);
  }
}

Padding fieldDetailsView(IconData icon, String title, String details, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Row(children: <Widget>[
        SizedBox(width: 30.0),
        Icon(
          icon,
          size: 30.0,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(width: 15.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FashionFetishText(
                text: title, size: 15.0, fontWeight: FashionFontWeight.bold, color: Colors.black54),
            Text(
              details,
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ]));
}

Padding fieldNoDetailsView(IconData icon, String title, BuildContext context) {
  return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Row(children: <Widget>[
        SizedBox(width: 30.0),
        Icon(
          icon,
          size: 30.0,
          color: Theme.of(context).primaryColor,
        ),
        SizedBox(width: 15.0),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            FashionFetishText(
                text: title, size: 15.0, fontWeight: FashionFontWeight.bold, color: Colors.black54),
            Text(
              'No information',
              style: TextStyle(fontSize: 20.0),
            ),
          ],
        ),
      ]));
}
