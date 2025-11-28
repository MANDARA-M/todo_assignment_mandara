import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/app_color.dart';
import '../constants/margin.dart';
import '../providers/theme_provider.dart';
import '../providers/utils/provider_utility.dart';
import '../theme/theme_utils.dart';

class ErrorIndicatorWidget extends HookConsumerWidget {
  const ErrorIndicatorWidget({
    required this.error,
    this.showErrorIcon = true,
    super.key,
  });

  final bool showErrorIcon;
  final String? error;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = ref.watch(themeProvider);

    return Column(
      children: [
        if (error != null && error!.isNotEmpty) ...[
          Margin.vertical4,
          Row(
            children: [
              if (showErrorIcon)
                const Icon(
                  Icons.info,
                  color: AppColor.errorRed,
                  size: 11,
                ),
              Margin.horizontal6,
              Flexible(child: Text(error!, style: theme.ts.extTs10.copyWith(color: AppColor.errorRed))),
            ],
          ),
        ],
      ],
    );
  }
}
