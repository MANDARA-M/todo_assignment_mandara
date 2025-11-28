import 'package:flutter/material.dart';

import '../constants/app_color.dart';

class Loader extends StatelessWidget {
  const Loader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const SizedBox(
          height: 1,
        ),
        CircularProgressIndicator(
          color: AppColor.themeColorGrey,
        ),
        const SizedBox(
          height: 1,
        ),
      ],
    );
  }
}
