import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:travellory/src/components/forms/dropdown.dart';

List<Item> accommodationTypes = <Item>[
  const Item('Hotel', Icon(FontAwesomeIcons.hotel, color: Color(0xFF167F67))),
  const Item('Airbnb', Icon(FontAwesomeIcons.suitcase, color: Color(0xFF167F67))),
  const Item('Hostel', Icon(FontAwesomeIcons.bed, color: Color(0xFF167F67))),
  const Item('Motel', Icon(FontAwesomeIcons.bed, color: Color(0xFF167F67))),
  const Item('Bed & Breakfast', Icon(FontAwesomeIcons.coffee, color: Color(0xFF167F67))),
  const Item('Other Accommodation', Icon(FontAwesomeIcons.bed, color: Color(0xFF167F67))),
];

List<Item> publicTransportTypes = <Item>[
  const Item('Rail', Icon(FontAwesomeIcons.train, color: Color(0xFF167F67))),
  const Item('Bus', Icon(FontAwesomeIcons.bus, color: Color(0xFF167F67))),
  const Item('Metro', Icon(FontAwesomeIcons.subway, color: Color(0xFF167F67))),
  const Item('Ferry', Icon(FontAwesomeIcons.ship, color: Color(0xFF167F67))),
  const Item('Taxi', Icon(FontAwesomeIcons.taxi, color: Color(0xFF167F67))),
  const Item('Uber', Icon(FontAwesomeIcons.carSide, color: Color(0xFF167F67))),
  const Item('Other Public Transport', Icon(FontAwesomeIcons.walking, color: Color(0xFF167F67))),
];

List<Item> activityTypes = <Item>[
  const Item('Historic', Icon(FontAwesomeIcons.landmark, color: Color(0xFF167F67))),
  const Item('Outdoors', Icon(FontAwesomeIcons.mountain, color: Color(0xFF167F67))),
  const Item('Culture', Icon(FontAwesomeIcons.diagnoses, color: Color(0xFF167F67))),
  const Item('Social', Icon(FontAwesomeIcons.users, color: Color(0xFF167F67))),
  const Item('Relaxing', Icon(FontAwesomeIcons.hotTub, color: Color(0xFF167F67))),
  const Item('Adventure', Icon(FontAwesomeIcons.hiking, color: Color(0xFF167F67))),
  const Item('Dining', Icon(FontAwesomeIcons.utensils, color: Color(0xFF167F67))),
  const Item('Other Activity', Icon(FontAwesomeIcons.futbol, color: Color(0xFF167F67))),
];

Item getDropdownBookingType(String type) {
  if (type == 'Hotel') {
    return accommodationTypes[0];
  } else if (type == 'Airbnb') {
    return accommodationTypes[1];
  } else if (type == 'Hostel') {
    return accommodationTypes[2];
  } else if (type == 'Motel') {
    return accommodationTypes[3];
  } else if (type == 'Bed & Breakfast') {
    return accommodationTypes[4];
  } else if (type == 'Other Accommodation') {
    return accommodationTypes[5];
  } else if(type == 'Rail') {
    return publicTransportTypes[0];
  } else if (type == 'Bus') {
    return publicTransportTypes[1];
  } else if (type == 'Metro') {
    return publicTransportTypes[2];
  } else if (type == 'Ferry') {
    return publicTransportTypes[3];
  } else if (type == 'Taxi') {
    return publicTransportTypes[4];
  } else if (type == 'Uber') {
    return publicTransportTypes[5];
  } else if (type == 'Other Public Transport') {
    return publicTransportTypes[6];
  } else if(type == 'Historic') {
    return activityTypes[0];
  } else if (type == 'Outdoors') {
    return activityTypes[1];
  } else if (type == 'Culture') {
    return activityTypes[2];
  } else if (type == 'Social') {
    return activityTypes[3];
  } else if (type == 'Relaxing') {
    return activityTypes[4];
  } else if (type == 'Adventure') {
    return activityTypes[5];
  } else if (type == 'Dining') {
    return activityTypes[6];
  } else {
    return activityTypes[7];
  }
}