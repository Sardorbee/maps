import 'package:flutter/material.dart';

class TabProvider with ChangeNotifier {
  int currentIndex = 0;

  updateTab(int index) {
    currentIndex = index;
    notifyListeners();
  }

  updateCurIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}
