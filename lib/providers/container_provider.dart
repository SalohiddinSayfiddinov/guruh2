import 'package:flutter/material.dart';

class ContainerProvider extends ChangeNotifier {
  final List<Color> colors = [];

  void addToList(Color color) {
    if (colors.contains(color)) {
      colors.remove(color);
    } else {
      colors.add(color);
    }
    notifyListeners();
  }
}
