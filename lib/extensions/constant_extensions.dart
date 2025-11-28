import 'package:flutter/material.dart';

import '../constants/constant.dart';

extension ConstantExtension on Constant {
  void init(BuildContext context) {
    screenWidth = MediaQuery.of(context).size.width;
  }
}
