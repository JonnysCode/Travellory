import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/widgets/forms/dropdown.dart';

List<Item> accommodationTypes = <Item>[
  const Item('Hotel', Icon(FontAwesomeIcons.hotel, color: Color(0xFF167F67))),
  const Item('Airbnb', Icon(FontAwesomeIcons.suitcase, color: Color(0xFF167F67))),
  const Item('Hostel', Icon(FontAwesomeIcons.bed, color: Color(0xFF167F67))),
  const Item('Motel', Icon(FontAwesomeIcons.bed, color: Color(0xFF167F67))),
  const Item('Bed & Breakfast', Icon(FontAwesomeIcons.coffee, color: Color(0xFF167F67))),
  const Item('Other', Icon(FontAwesomeIcons.bed, color: Color(0xFF167F67))),
];