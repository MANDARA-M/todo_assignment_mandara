import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../../constants/margin.dart';
import '../../../enums/app_enums.dart';
import '../../../navigation/navigation_utils.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/utils/provider_utility.dart';
import '../../../theme/theme_utils.dart';
import '../bottom_sheet_model/bottom_options.dart';

class BottomOptionsUI extends StatefulHookConsumerWidget {
  const BottomOptionsUI({
    required this.uiType,
    required this.options,
    this.scrollController,
    this.scrollPhysics = const NeverScrollableScrollPhysics(),
    super.key,
  });

  final BottomSheetEventOptionsUI uiType;
  final List<BottomOptions> options;
  final ScrollController? scrollController;
  final ScrollPhysics scrollPhysics;

  @override
  ConsumerState<BottomOptionsUI> createState() => _BottomOptionsUIState();
}

class _BottomOptionsUIState extends ConsumerState<BottomOptionsUI> {
  late ThemeProvider _theme;

  @override
  Widget build(BuildContext context) {
    _theme = ref.watch(themeProvider);
    return _mainWidget();
  }

  Widget _mainWidget() {
    switch (widget.uiType) {
      case BottomSheetEventOptionsUI.poppins:
        return _poppinsWidget();
      //return _poppinsWidgetWrap();
      case BottomSheetEventOptionsUI.listTile:
        return _listWidget();
    }
  }

  Widget _poppinsWidget() {
    var index = -1;
    return Container(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0),
      child: GridView.count(
        crossAxisCount: 4,
        shrinkWrap: true,
        childAspectRatio: 0.85,
        physics: const NeverScrollableScrollPhysics(),
        children: widget.options.map((e) {
          index++;
          return _poppinsItemWidget(e, index);
        }).toList(),
      ),
    );
  }

  Widget _poppinsItemWidget(BottomOptions e, int index) {

    final iconColor = e.color ?? _theme.getBottomChipColor(index);

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: () {
        NavigationUtils.instance.pop(context: context);
        e.onTap();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: _theme.themeColorCreateFeedPoppins,
              borderRadius: BorderRadius.circular(12),
              border: _theme.isDark ? null : Border.all(color: ThemeUtils.instance.themeColorBlack, width: 0.1),
            ),
            padding: const EdgeInsets.all(18),
            child: Icon(e.icon, color: iconColor, size: 18),
            //child: e.icon.image(color: Colors.white, width: 24, height: 24),
          ),
          Margin.vertical12,
          Text(e.title, style: _theme.ts.extTs12.copyWith(color: _theme.textColor)),
        ],
      ),
    );
  }

  Widget _listWidget() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.0),
      child: ListView.builder(
          shrinkWrap: true,
          controller: widget.scrollController,
          physics: widget.scrollPhysics,
          itemBuilder: (context, index) {
            final e = widget.options[index];

            final iconColor = e.color ?? _theme.iconColor;

            return ListTile(
              visualDensity: const VisualDensity(vertical: -2),
              splashColor: _theme.inkWellRippleColorGrey,
              onTap: () {
                NavigationUtils.instance.pop(context: context);
                e.onTap();
              },
              leading: Icon(e.icon, color: iconColor, size: 16,),
              //leading: e.icon.image(color: e.color ?? _theme.iconColor, width: 20, height: 20),
              title: Text(e.title, style: _theme.ts.copyWith(color: e.color)),
              trailing: e.suffix,
            );
          },
          itemCount: widget.options.length),
    );
  }
}
