import 'package:flutter/material.dart';

import '../constants/app_color.dart';
import '../constants/margin.dart';
import '../providers/theme_provider.dart';
import '../theme/theme_utils.dart';

typedef CheckBoxChange = void Function(bool? isChecked);
typedef OnDateChange = void Function(DateTime? changedDate);

class CustomWidget {
  CustomWidget._();

  static CustomWidget? _instance;

  static final CustomWidget instance = _instance ??= CustomWidget._();

  Widget getLinksBottomSheetTopUI({required ThemeProvider? theme, required String title, required String description, double? height}) {
    return Row(
      children: [
        Container(width: 3, height: height ?? (description.isNotEmpty ? 42 : 30), color: AppColor.primaryLight),
        Margin.horizontal8,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: theme?.ts.extTs16.weightBold, maxLines: 1, overflow: TextOverflow.ellipsis),
              if (description.isNotEmpty) ...[Margin.vertical2, Text(description, style: theme?.ts.extTs10, maxLines: 2, overflow: TextOverflow.ellipsis)],
            ],
          ),
        ),
      ],
    );
  }
}
