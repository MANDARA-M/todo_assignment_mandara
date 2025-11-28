import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/margin.dart';
import '../gen/assets.gen.dart';
import '../providers/theme_provider.dart';
import '../providers/utils/provider_utility.dart';
import '../theme/theme_utils.dart';

class NoItemsScreen extends HookConsumerWidget {
  const NoItemsScreen({
    required this.title,
    required this.subtitle,
    this.isAppIconVisible = true,
    this.image,
    Key? key,
  }) : super(key: key);

  final Widget? image;
  final String title;
  final String subtitle;
  final bool isAppIconVisible;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    late final theme = ref.watch<ThemeProvider>(themeProvider);

    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 32, 16, 16),
      child: Center(
        child: Column(
          children: [
            if (image != null) ...[
              image!,
            ],
            if (isAppIconVisible) ...[
              Margin.vertical8,
              ClipRRect(
                borderRadius: BorderRadius.circular(1000),
                child: Assets.appicon.appIcon.image(
                  height: 150,
                  width: 150,
                  fit: BoxFit.fill,
                ),
              ),
            ],
            Margin.vertical16,
            Text(
              title,
              textAlign: TextAlign.center,
              style: theme.ts.extTs18.weightBold.color75,
            ),
            Margin.vertical8,
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: theme.ts.extTs14.weightRegular.color75,
            ),
          ],
        ),
      ),
    );
  }
}
