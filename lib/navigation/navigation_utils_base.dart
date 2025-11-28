import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../firebase/appInsights/event_logger.dart';
import 'animated_page_transitions.dart';
import 'router_configs.dart';

class NavigationUtilsBase {
  void pop({required BuildContext context}) {
    Navigator.pop(context);
  }

  void popWithData<T>({required BuildContext context, T? data}) {
    Navigator.pop(context, data);
  }

  void moveToScreen({
    required BuildContext context,
    required Widget screen,
    String? name,
    bool isRemoveAllOtherScreens = false,
    AnimationType animationType = AnimationType.slideFromRight,
  }) {
    EventLogger.instance.logScreenEvent(screen);
    final transitionBuilder = animationType.transitionBuilder;
    final route = transitionBuilder(screen);

    if (isRemoveAllOtherScreens) {
      Navigator.of(context).pushAndRemoveUntil(route, (route) => false);
    } else {
      Navigator.push(context, route);
    }
  }

  Future<T?> moveToScreenAsync<T>(
    BuildContext context,
    Widget screen, {
    String? name,
    AnimationType animationType = AnimationType.slideFromRight,
  }) async {
    EventLogger.instance.logScreenEvent(screen);

    final transitionBuilder = animationType.transitionBuilder;
    final route = transitionBuilder(screen);

    final result = await Navigator.push(context, route);
    return result as T?;

    /*EventLogger.logScreenEvent(screenToMoveOn);
    if (name != null) {
      return Navigator.push<T>(
        context,
        MaterialPageRoute<T>(
          builder: (context) => screenToMoveOn,
          settings: RouteSettings(name: name),
        ),
      );
    } else {
      return Navigator.push<T>(
        context,
        MaterialPageRoute<T>(
          builder: (context) => screenToMoveOn,
        ),
      );
    }*/
  }

  void moveToRoute({
    required BuildContext context,
    required AppRoute route,
    bool isRemoveAllOtherScreens = false,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    final routeName = route.name;
    EventLogger.instance.logRouteEvent(route.name);

    if (isRemoveAllOtherScreens) {
      context.goNamed(
        routeName,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );
    } else {
      context.pushNamed(
        routeName,
        pathParameters: pathParameters,
        queryParameters: queryParameters,
        extra: extra,
      );
    }
  }

  void pushReplacementToRoute({
    required BuildContext context,
    required AppRoute route,
    bool isRemoveAllOtherScreens = false,
    Map<String, String> pathParameters = const <String, String>{},
    Map<String, dynamic> queryParameters = const <String, dynamic>{},
    Object? extra,
  }) {
    final routeName = route.name;
    EventLogger.instance.logRouteEvent(route.name);

    context.pushReplacementNamed(
      routeName,
      pathParameters: pathParameters,
      queryParameters: queryParameters,
      extra: extra,
    );
  }
}
