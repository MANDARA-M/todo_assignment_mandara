import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../constants/margin.dart';
import '../l10n/app_localizations.dart';
import '../providers/theme_provider.dart';
import '../providers/utils/provider_utility.dart';
import '../theme/theme_utils.dart';
import 'button_widget.dart';

class IssueScreen extends StatefulHookConsumerWidget {
  const IssueScreen({
    required this.title,
    required this.subtitle,
    this.image,
    super.key,
  });

  final ImageProvider? image;
  final String title;
  final String subtitle;

  @override
  ConsumerState<IssueScreen> createState() => _IssueScreenState();
}

class _IssueScreenState extends ConsumerState<IssueScreen> {
  late final theme = ref.watch(themeProvider);
  late final _localizations = AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (widget.image != null)
              Image(image: widget.image!, width: 344, height: 344),
            Margin.vertical16,
            Text(
              widget.title,
              style: theme.ts.extTs32.weightBold,
              textAlign: TextAlign.center,
            ),
            Text(
              widget.subtitle,
              style: theme.ts.extTs14,
              textAlign: TextAlign.center,
            ),
            Margin.vertical16,
            ButtonWidget(
              title: _localizations.ok,
              onPressed: Navigator.of(context).pop,
            ),
          ],
        ),
      ),
    );
  }
}
