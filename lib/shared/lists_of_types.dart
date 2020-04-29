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

List<Item> publicTransportTypes = <Item>[
  const Item('Rail', Icon(FontAwesomeIcons.train, color: Color(0xFF167F67))),
  const Item('Bus', Icon(FontAwesomeIcons.bus, color: Color(0xFF167F67))),
  const Item('Metro', Icon(FontAwesomeIcons.subway, color: Color(0xFF167F67))),
  const Item('Ferry', Icon(FontAwesomeIcons.ship, color: Color(0xFF167F67))),
  const Item('Taxi', Icon(FontAwesomeIcons.taxi, color: Color(0xFF167F67))),
  const Item('Uber', Icon(FontAwesomeIcons.carSide, color: Color(0xFF167F67))),
  const Item('Other', Icon(FontAwesomeIcons.walking, color: Color(0xFF167F67))),
];

List<Item> activityTypes = <Item>[
  const Item('Historic', Icon(FontAwesomeIcons.landmark, color: Color(0xFF167F67))),
  const Item('Outdoors', Icon(FontAwesomeIcons.mountain, color: Color(0xFF167F67))),
  const Item('Culture', Icon(FontAwesomeIcons.diagnoses, color: Color(0xFF167F67))),
  const Item('Social', Icon(FontAwesomeIcons.users, color: Color(0xFF167F67))),
  const Item('Relaxing', Icon(FontAwesomeIcons.hotTub, color: Color(0xFF167F67))),
  const Item('Adventure', Icon(FontAwesomeIcons.hiking, color: Color(0xFF167F67))),
  const Item('Dining', Icon(FontAwesomeIcons.utensils, color: Color(0xFF167F67))),
  const Item('Other', Icon(FontAwesomeIcons.futbol, color: Color(0xFF167F67))),
];
