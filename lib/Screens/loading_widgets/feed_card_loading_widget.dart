import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shimmer/shimmer.dart';

import '../../../constants/margin.dart';
import '../../common_widgets/shimmer_placeholders.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';

class FeedCardLoadingWidget extends StatefulHookConsumerWidget {
  const FeedCardLoadingWidget({super.key});

  @override
  ConsumerState<FeedCardLoadingWidget> createState() => _FeedCardLoadingWidgetState();
}

class _FeedCardLoadingWidgetState extends ConsumerState<FeedCardLoadingWidget> {
  ThemeProvider? theme;

  @override
  Widget build(BuildContext context) {
    theme = ref.watch(themeProvider);

    return _mainWidget;
  }

  Widget get _mainWidget {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Shimmer.fromColors(
          baseColor: theme?.shimmerColorBase ?? Colors.grey.shade300,
          highlightColor: theme?.shimmerColorHighlight ?? Colors.grey.shade100,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ContentPlaceholder(lineType: ContentLineType.twoLines),
              Margin.vertical4,
              BannerPlaceholder(),
            ],
          ),
        ),
      ),
    );
  }
}
