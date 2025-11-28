import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../gen/assets.gen.dart';
import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../providers/utils/provider_utility.dart';
import '../theme/theme_utils.dart';

class AppBarWidget extends HookConsumerWidget implements PreferredSizeWidget {
  const AppBarWidget({
    this.title,
    this.overrideTitle,
    this.height = 56,
    this.icons = const <AppbarIcon>[],
    this.actionWidgets = const <Widget>[],
    this.centerTitle = false,
    this.bottom,
    this.elevation = 0.0,
    this.titleColor,
    this.backgroundColor,
    this.isBackButtonVisible = true,
    this.popWithResult,
    this.isDashboard = false,
    Key? key,
  }) : super(key: key);

  final String? title;
  final Widget? overrideTitle;
  final double height;
  final bool isBackButtonVisible;
  final List<AppbarIcon> icons;
  final List<Widget> actionWidgets;
  final bool centerTitle;
  final PreferredSizeWidget? bottom;
  final double elevation;
  final Color? titleColor;
  final Color? backgroundColor;
  final dynamic popWithResult;
  final bool isDashboard;

  @override
  Size get preferredSize => Size.fromHeight(height + (bottom?.preferredSize.height ?? 0));

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final theme = ref.watch(themeProvider);

    return AppBar(
      toolbarHeight: height,
      key: key,
      titleSpacing: 2,
      title: isDashboard ? _appIconWidget : overrideTitle ?? Text(title ?? '', style: theme.ts.extTs16.height24.copyWith(color: titleColor)),
      elevation: elevation,
      actions: _actions(context: context, auth: auth, theme: theme),
      centerTitle: centerTitle,
      bottom: bottom,
      backgroundColor: backgroundColor,
      //leading: isDashboard ? _appIconWidget : null,
      automaticallyImplyLeading: isBackButtonVisible,
    );
  }

  Widget get _appIconWidget => Container(
    padding: const EdgeInsets.all(8),
    child: Assets.appicon.appIcon.image(
      width: 110,
      fit: BoxFit.fill,
    ),
  );

  List<Widget> _actions({required BuildContext context, required AuthProvider auth, required ThemeProvider theme}) {
    final listOfActionIcons = icons
        .map(
          (icon) => Padding(
        padding: EdgeInsets.only(right: icon == icons.last ? 8 : 0),
        child: icon,
      ),
    )
        .toList();

    final listOfActionWidgets = actionWidgets
        .map(
          (icon) => Padding(
        padding: EdgeInsets.only(right: icon == actionWidgets.last ? 16 : 0),
        child: icon,
      ),
    )
        .toList();

    final newIcons = <Widget>[];

    newIcons.addAll(listOfActionIcons);
    newIcons.addAll(listOfActionWidgets);

    return newIcons;
  }
}

class AppbarIcon extends IconButton {
  AppbarIcon({
    required IconData? iconData,
    VoidCallback? onPressed,
    Color? iconColor,
    Key? key,
  }) : super(
    icon: Icon(
      iconData,
      size: 18.0,
      color: iconColor,
    ),
    onPressed: onPressed,
    splashRadius: 20.0,
    key: key,
  );
}
