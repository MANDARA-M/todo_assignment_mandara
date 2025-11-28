import 'package:flutter/material.dart';

class BathingListNotifier extends ChangeNotifier {
  bool _isVisible = false;

  bool get isVisible => _isVisible;

  void toggleVisibility() {
    _isVisible = !_isVisible;
    notifyListeners();
  }
}
