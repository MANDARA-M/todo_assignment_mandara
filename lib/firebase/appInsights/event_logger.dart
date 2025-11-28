import 'dart:async';

import 'package:flutter/material.dart';

import '../../enums/app_enums_analytics.dart';
import '../../utilities/app_utils.dart';
import '../../utilities/print_util.dart';
import 'analytics_service.dart';
import 'firebase_logger.dart';

class EventLogger {
  EventLogger._();

  static EventLogger? _instance;
  static final EventLogger instance = _instance ??= EventLogger._();

  Future<void> initialize() async {
    await FirebaseLogger.instance.initialize();
  }

  Future<void> setSession({required String phoneNumber}) async {
    await FirebaseLogger.instance.setSession(phoneNumber: phoneNumber);

    _logCommonEvent(event: AnalyticsEvents.session_change_user_data);
  }

  Future<void> changeTheme(ThemeMode themeMode) async {}

  void _logCommonEvent({
    required AnalyticsEvents event,
    AnalyticsType analyticsType = AnalyticsType.business,
    Map<String, dynamic>? eventProperties,
  }) {
    try {
      final isAnalyticsActive = AppUtils.instance.isRelease && analyticsType.isEnabled;
      if (!isAnalyticsActive) {
        return;
      }
      eventProperties ??= <String, dynamic>{};
      eventProperties['AnalyticsType'] = analyticsType.type;
      //eventProperties.addAll(_getCommonRequestMap());

      AnalyticsService.instance.trackEntryEvent(event: event, eventProperties: eventProperties);
    } catch (e) {
      PrintUtils.instance.printException(e);
    }
  }

  void _screenView({required String name, required AnalyticsEvents event}) {
    final eventProperties = <String, dynamic>{'screen_name': name};
    _logCommonEvent(event: event, eventProperties: eventProperties);
  }

  void logScreenEvent(Widget widget) => _screenView(event: AnalyticsEvents.track_screen_navigation, name: widget.toString());

  void logRouteEvent(String route) => _screenView(event: AnalyticsEvents.track_screen_route, name: route);

  void logEvent({
    required AnalyticsEvents event,
    AnalyticsType analyticsType = AnalyticsType.business,
    Map<String, dynamic>? parameters,
  }) {
    _logEvent(event, analyticsType, parameters);
  }

  void _logEvent(AnalyticsEvents event, AnalyticsType analyticsType, Map<String, dynamic>? parameters) {
    _logCommonEvent(event: event, analyticsType: analyticsType, eventProperties: parameters);
  }

  void logError({required dynamic exception, StackTrace? stackTrace, dynamic reason, bool fatal = false}) =>
      FirebaseLogger.instance.logError(exception: exception, stackTrace: stackTrace, reason: reason, fatal: fatal);

}
