import 'package:flutter/material.dart';

import '../constants/app_color.dart';

class CustomDivider extends StatelessWidget {
  const CustomDivider({
    this.color,
    this.height,
    this.thickness,
    Key? key,
  }) : super(key: key);

  final Color? color;
  final double? height;
  final double? thickness;

  @override
  Widget build(BuildContext context) => Divider(
        thickness: thickness ?? 1,
        height: height ?? 1,
        color: color ?? AppColor.themeColorGrey,
      );
}
