import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/models/abstract_model.dart';
import 'package:travellory/services/database/edit.dart';
import 'package:travellory/widgets/buttons/booking_button.dart';
import 'package:travellory/widgets/forms/dropdown.dart';
import '../font_widgets.dart';
import 'edit_delete_dialogs.dart';

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

Container bottomBar(BuildContext context, Model model, String deleteFunctionName) {
  final String modelText = getDeleteTextBasedOn(model);
  final String deleteAlertText = 'You are about to delete your ' +
      modelText +
      ' entry. Are you sure you want to continue? This action cannot be undone!';

  return Container(
    key: Key('BottomBar'),
    padding: EdgeInsets.all(20.0),
    height: 60.0,
    decoration: BoxDecoration(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(40.0),
    ),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Center(
          child: Container(
            height: 32,
            width: 120,
            child: BookingButton(
              buttonTitle: 'EDIT',
              highlightColor: Theme.of(context).primaryColor,
              fillColor: Theme.of(context).primaryColor,
              onPressed: () {
                editModel(model, context);
              },
            ),
          ),
        ),
        Center(
          child: Container(
            height: 32,
            width: 120,
            child: BookingButton(
              buttonTitle: 'DELETE',
              highlightColor: Theme.of(context).primaryColor,
              fillColor: Theme.of(context).primaryColor,
              onPressed: () {
                showDeleteDialog(model, context, deleteAlertText, deleteFunctionName);
              },
            ),
          ),
        ),
      ],
    ),
  );
}

Positioned exitViewPage(BuildContext context) {
  return Positioned(
    key: Key('ExitViewPage'),
    top: 15,
    right: 10,
    child: IconButton(
      onPressed: () => Navigator.pop(context),
      icon: FaIcon(FontAwesomeIcons.times),
      iconSize: 26,
      color: Colors.red,
    ),
  );
}

Padding displayField(IconData icon, String title, String details, Color color) {
  if (details != null && details != '') {
    return fieldDetailsView(icon, title, details, color);
  } else {
    return fieldNoDetailsView(icon, title, color);
  }
}

Padding displayDropdownField(String title, List<Item> types, String details, Color color) {
  if (details != null && details != '') {
    if (details == 'Hotel') {
      return fieldDetailsView(FontAwesomeIcons.hotel, title, details, color);
    } else if (details == 'Airbnb') {
      return fieldDetailsView(FontAwesomeIcons.suitcase, title, details, color);
    } else if (details == 'Bed & Breakfast') {
      return fieldDetailsView(FontAwesomeIcons.coffee, title, details, color);
    } else {
      return fieldDetailsView(FontAwesomeIcons.bed, title, details, color);
    }
  } else {
    return fieldNoDetailsView(FontAwesomeIcons.hotel, title, color);
  }
}

Padding fieldDetailsView(IconData icon, String title, String details, Color color) {
  return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Row(children: <Widget>[
        SizedBox(width: 30.0),
        Icon(
          icon,
          size: 30.0,
          color: color,
        ),
        SizedBox(width: 15.0),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              FashionFetishText(
                  text: title,
                  size: 15.0,
                  fontWeight: FashionFontWeight.bold,
                  color: Colors.black54),
              Text(
                details,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(fontSize: 20.0),
              ),
            ],
          ),
        ),
      ]));
}

Padding fieldNoDetailsView(IconData icon, String title, Color color) {
  return Padding(
      padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
      child: Row(children: <Widget>[
        SizedBox(width: 30.0),
        Icon(
          icon,
          size: 30.0,
          color: color,
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

Column displayExtraField(String toCompare, String comparison, IconData icon, String displayText,
    String display, Color color) {
  if (toCompare == comparison) {
    return Column(children: [
      displayField(icon, displayText, display, color),
      Divider(),
    ]);
  } else {
    return Column(children: [
      Padding(padding: const EdgeInsets.only(top: 0, left: 0, right: 0)),
    ]);
  }
}
