import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../gen/assets.gen.dart';
import '../providers/theme_provider.dart';
import '../providers/utils/provider_utility.dart';
import '../theme/theme_utils.dart';

class CustomCloseButton extends HookConsumerWidget {
  const CustomCloseButton({this.onPressed, Key? key}) : super(key: key);

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context, WidgetRef ref) => Material(
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onPressed,
          child: ref.watch(themeProvider).appTheme.isDark
              ? Assets.images.closeDark.image()
              : Assets.images.closeLight.image(),
        ),
      );
}
