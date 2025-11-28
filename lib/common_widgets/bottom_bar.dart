import 'package:flutter/material.dart';

import '../constants/margin.dart';

class BottomBar extends StatelessWidget {
  const BottomBar({
    required this.currentIndex,
    required this.selectedColor,
    required this.unselectedColor,
    required this.items,
    this.onTap,
    Key? key,
  }) : super(key: key);

  final int currentIndex;
  final Color selectedColor;
  final Color unselectedColor;
  final List<BottomNavigationBarItem> items;
  final ValueChanged<int>? onTap;

  bool isSelected(BottomNavigationBarItem item) =>
      currentIndex == items.indexOf(item);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewPadding.bottom,
      ),
      child: Row(
        children: [
          for (final item in items)
            Expanded(
              child: InkWell(
                highlightColor: Colors.transparent,
                splashColor: Colors.transparent,
                onTap: () => onTap?.call(items.indexOf(item)),
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Column(
                    children: [
                      IconTheme(
                        data: IconThemeData(
                          size: 24,
                          color: isSelected(item)
                              ? selectedColor
                              : unselectedColor,
                        ),
                        child: isSelected(item) ? item.activeIcon : item.icon,
                      ),
                      Margin.vertical8,
                      /* Text(
                        item.label ?? '',
                        style: AppStyle.regular12Text.copyWith(
                          color: isSelected(item)
                              ? selectedColor
                              : unselectedColor,
                        ),
                      ),*/
                    ],
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
