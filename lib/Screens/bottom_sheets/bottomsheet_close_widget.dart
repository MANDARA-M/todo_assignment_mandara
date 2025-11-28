import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../navigation/navigation_utils.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';

class BottomSheetCloseWidget extends StatefulHookConsumerWidget {
  const BottomSheetCloseWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  ConsumerState<BottomSheetCloseWidget> createState() => _BottomSheetCloseWidgetState();
}

class _BottomSheetCloseWidgetState extends ConsumerState<BottomSheetCloseWidget> {
  ThemeProvider? theme;

  @override
  Widget build(BuildContext context) {
    theme = ref.watch(themeProvider);

    return Stack(
      children: [
        widget.child,
        Positioned(
          top: 0,
          right: 0,
          child: _header,
        ),
      ],
    );
  }

  Widget get _header {
    return Align(
      alignment: Alignment.centerRight,
      child: IconButton(
        icon: Icon(FontAwesomeIcons.circleXmark, color: theme?.iconColor, size: 18,),
        onPressed: () => NavigationUtils.instance.pop(context: context),
      ),
    );
  }
}
