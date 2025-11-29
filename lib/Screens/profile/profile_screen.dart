import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:inSTA/common_widgets/button_widget.dart';
import 'package:inSTA/constants/margin.dart';
import 'package:inSTA/providers/authentication_provider.dart';
import 'package:inSTA/providers/theme_provider.dart';
import 'package:inSTA/theme/theme_utils.dart';
import 'package:inSTA/utilities/storage/shared_preference/shared_preferences_util.dart';

import '../../common_widgets/appbar_widget.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/utils/provider_utility.dart';

class ProfileScreen extends StatefulHookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> with SingleTickerProviderStateMixin {
  late final _localizations = AppLocalizations.of(context)!;

  late ThemeProvider theme;
  late AuthenticationProvider _authProvider;

  User? get user => SharedPreferencesUtil.instance.user;

  String get userId => SharedPreferencesUtil.instance.userId;

  String get userName => SharedPreferencesUtil.instance.userName;

  @override
  Widget build(BuildContext context) {
    theme = ref.watch(themeProvider);
    _authProvider = ref.watch(authenticationProvider);

    return Scaffold(
      appBar: AppBarWidget(
        title: _localizations.profile,
        icons: [AppbarIcon(iconData: FontAwesomeIcons.ellipsisVertical, onPressed: null)],
      ),
      body: _mainWidget,
    );
  }

  Widget get _mainWidget {
    return Padding(
      padding: EdgeInsets.all(16.0),
      child: Column(
        children: [
          Text(userName, style: theme.ts.extTs24),
          Margin.vertical16,
          Text(user?.phoneNumber ?? '', style: theme.ts.extTs36),
          Margin.vertical32,
          _logoutButton,
        ],
      ),
    );
  }

  Widget get _logoutButton {
    return ButtonWidget(title: 'Logout', prefixIcon: Icons.logout, type: .red, onPressed: () {
      _authProvider.logout(context);
    });
  }
}
