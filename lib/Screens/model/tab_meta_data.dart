import 'package:flutter/material.dart';

class TabMetaData {
  TabMetaData({
    required this.title,
    required this.child,
    this.id,
  });

  final String? id;
  final String title;
  final Widget child;
}
