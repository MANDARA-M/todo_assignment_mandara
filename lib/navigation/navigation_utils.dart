import 'package:flutter/material.dart';

import '../common_widgets/issue_screen.dart';
import '../enums/app_enums.dart';
import '../gen/assets.gen.dart';
import '../l10n/app_localizations.dart';
import '../providers/authentication_provider.dart';
import '../utilities/extension_utils.dart';
import '../utilities/print_util.dart';
import '../utilities/storage/shared_preference/shared_preferences_util.dart';
import 'navigation_utils_base.dart';
import 'router_configs.dart';

class NavigationUtils extends NavigationUtilsBase {
  NavigationUtils._();

  static final NavigationUtils instance = NavigationUtils._();

  void restart(BuildContext context) => moveToRoute(context: context, route: AppRoute.splash, isRemoveAllOtherScreens: true);

  Future<void> showInternetIssueScreen(BuildContext context) {
    final localizations = AppLocalizations.of(context)!;

    return moveToScreenAsync<void>(
      context,
      IssueScreen(image: Assets.images.astronautNointernet.assetImage, title: localizations.youWentOffline, subtitle: localizations.youWentOfflineSupportText),
    );
  }

  ///
  /// Router Navigation Methods - Start
  ///

  Future<void> checkAppStateAndProceedFurther(State state, {required AuthenticationProvider auth}) async {
    final isOnBoardingCompleted = SharedPreferencesUtil.instance.isOnBoardingCompleted;

    if (state.mounted) {
      final context = state.context;

      if (isOnBoardingCompleted) {
        NavigationUtils.instance.moveToHomeScreen(context: context);
      } else {
        NavigationUtils.instance.moveToOnBoardingScreen(context: context);
      }
    }
  }

  Future<void> onBoardingCompleted(BuildContext context, {bool isSkip = false}) async {
    await SharedPreferencesUtil.instance.setOnBoardingCompleted();
    if (context.mounted) {
      if (isSkip) {
        NavigationUtils.instance.moveToHomeScreen(context: context);
      } else {
        NavigationUtils.instance.moveToLoginScreen(context: context /*, isRemoveAllOtherScreens: true*/);
      }
    }
  }

  void logout(BuildContext context) => moveToSplashScreen(context: context);

  void moveToSplashScreen({required BuildContext context}) => moveToRoute(context: context, route: AppRoute.splash, isRemoveAllOtherScreens: true);

  void moveToOnBoardingScreen({required BuildContext context}) => moveToRoute(context: context, route: AppRoute.onboarding, isRemoveAllOtherScreens: true);

  void moveToLoginScreen({required BuildContext context, bool isRemoveAllOtherScreens = false}) =>
      moveToRoute(context: context, route: AppRoute.login, isRemoveAllOtherScreens: isRemoveAllOtherScreens);

  void moveToOTPScreen(BuildContext context, {required String phoneNumber}) => moveToRoute(context: context, route: AppRoute.otp, extra: phoneNumber);

  void moveToHomeScreen({required BuildContext context}) => moveToRoute(context: context, route: AppRoute.dashboard, isRemoveAllOtherScreens: true);

  void moveToProfileScreen({required BuildContext context}) => moveToRoute(context: context, route: AppRoute.profile);

  void moveToCreateTaskScreen({required BuildContext context, CreateTaskScreenRouteObject? routeObject}) =>
      moveToRoute(context: context, route: AppRoute.createTask, extra: routeObject);
}
