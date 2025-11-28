import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/appbar_widget.dart';
import '../../l10n/app_localizations.dart';

class ProfileScreen extends StatefulHookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> with SingleTickerProviderStateMixin {
  late final _localizations = AppLocalizations.of(context)!;

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBarWidget(
        title: _localizations.profile,
        icons: [AppbarIcon(iconData: FontAwesomeIcons.ellipsisVertical, onPressed: null)],
      ),
      body: _mainWidget,
    );
  }

  Widget get _mainWidget {
    return const SizedBox.shrink();
  }
}
