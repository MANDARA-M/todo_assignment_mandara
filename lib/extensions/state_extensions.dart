import 'package:flutter/material.dart';

extension StateExtensions on State {
  void get refresh {
    if (mounted) {
      setState(() {});
    }
  }
}
