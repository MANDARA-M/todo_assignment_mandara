import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../../common_widgets/appbar_widget.dart';
import '../../common_widgets/button_widget.dart';
import '../../constants/margin.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/authentication_provider.dart';
import '../../providers/theme_provider.dart';
import '../../providers/utils/provider_utility.dart';

import '../../enums/app_enums.dart';
import '../../providers/language_provider.dart';
import '../../theme/theme_utils.dart';
import '../../utilities/storage/shared_preference/shared_preferences_util.dart';

class ProfileScreen extends StatefulHookConsumerWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> with SingleTickerProviderStateMixin {
  AppLocalizations? _localizations;

  late ThemeProvider theme;
  late AuthenticationProvider _authProvider;

  User? get user => SharedPreferencesUtil.instance.user;

  String get userId => SharedPreferencesUtil.instance.userId;

  String get userName => SharedPreferencesUtil.instance.userName;

  @override
  Widget build(BuildContext context) {
    _localizations = AppLocalizations.of(context);
    theme = ref.watch(themeProvider);
    _authProvider = ref.watch(authenticationProvider);

    return Scaffold(
      appBar: AppBarWidget(
        title: _localizations?.profile,
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
          Margin.vertical16,
          Divider(),
          Margin.vertical32,
          _changeLanguage,
          Margin.vertical32,
          _changeThemeButton,
          Margin.vertical32,
          _logoutButton,
        ],
      ),
    );
  }

  Widget get _changeLanguage {
    return Row(
      children: [
        Text(_localizations?.changeLanguage ?? '', style: theme.ts.extTs16,),
        Spacer(),
        ..._languageWidget,
      ],
    );
  }

  List<Widget> get _languageWidget {
    final allLanguages = Language.values;

    final widgets = <Widget>[];
    for(final language in allLanguages) {
      final child =  InkWell(
        onTap: () {
          ref.read(languageProvider.notifier).update((_) => language);
        },
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: theme.boxDecorationInfoWidget,
          child: Text(language.languageName, style: theme.ts.extTs12,),
        ),
      );

      widgets.add(child);
      widgets.add(Margin.horizontal8);
    }

    return widgets;
  }

  Widget get _logoutButton {
    return ButtonWidget(title: _localizations?.logout ?? '', prefixIcon: Icons.logout, type: .red, onPressed: () {
      _authProvider.logout(context);
    });
  }


  Widget get _changeThemeButton {
    return ButtonWidget(title: _localizations?.changeTheme ?? '', prefixIcon: Icons.color_lens_outlined, type: .hollow, onPressed: () {
      theme.toggleTheme();
    });
  }
}
