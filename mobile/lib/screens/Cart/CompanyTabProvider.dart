import 'package:flutter/material.dart';

class CompanyTabProvider extends ChangeNotifier {
  int _selected = -1;
  int get selected => _selected;

  set select(int id) {
    _selected = id;
    notifyListeners();
  }

  bool isSelected(int id) => selected == id;
  bool get nothingSelected => selected == -1;
}
