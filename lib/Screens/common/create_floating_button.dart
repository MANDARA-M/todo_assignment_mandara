import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';

class CreateFloatingButton extends HookConsumerWidget {
  const CreateFloatingButton({
    this.onTap,
    this.size = 42.0,
    this.overrideChild,
    this.backgroundColor,
    super.key,
  });

  final GestureTapCallback? onTap;
  final double size;
  final Widget? overrideChild;
  final Color? backgroundColor;

  //@override
  //Widget build(BuildContext context) => createButton;

  //ThemeProvider? theme;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);
    return createButton(theme: theme);
  }

  Widget createButton({required ThemeProvider theme}) {
    return SizedBox(
      width: size,
      height: size,
      child: FloatingActionButton(
        onPressed: onTap,
        backgroundColor: backgroundColor ?? theme.textColor.withValues(alpha: 0.9),
        shape: const CircleBorder(),
        child: overrideChild ??
            Icon(
              Icons.add,
              color: theme.backgroundColor,
              size: size - 6,
            ),
      ),
    );
  }
}
