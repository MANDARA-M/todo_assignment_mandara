import 'package:flutter/material.dart';

import '../../../enums/app_enums.dart';

class BottomOptions<T> {
  BottomOptions({
    required this.title,
    required this.icon,
    required this.onTap,
    this.color,
    this.suffix,
    this.id,
  });

  final T? id;
  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final Color? color;
  final Widget? suffix;
}
