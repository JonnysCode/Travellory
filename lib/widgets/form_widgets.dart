import 'package:flutter/material.dart';
import 'package:travellory/utils/list_models.dart';

void showAdditional (ListModel<Widget> list, bool show, Widget parent, Widget additionalField) {
  if (show) {
    list.insert(list.indexOf(parent) + 1, additionalField);
  } else {
    int idx = list.indexOf(additionalField);
    if (idx > -1) list.removeAt(idx);
  }
}