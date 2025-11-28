import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../enums/app_enums_analytics.dart';
import '../firebase/appInsights/analytics_service.dart';
import '../firebase/appInsights/event_logger.dart';
import '../utilities/print_util.dart';

class BaseWidgetWrapper extends StatefulHookConsumerWidget {
  const BaseWidgetWrapper({required this.child, super.key});

  final Widget child;

  @override
  ConsumerState<BaseWidgetWrapper> createState() => _BaseWidgetWrapperState();
}

// Observe resume / pause state of the app
class _BaseWidgetWrapperState extends ConsumerState<BaseWidgetWrapper> with SingleTickerProviderStateMixin, WidgetsBindingObserver {

  bool isBuildFirstTime = true;

  @override
  void initState() {
    super.initState();
    _appInit();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    AnalyticsService.instance.dispose();
    _logAnalyticsEvent(AnalyticsEvents.app_state_close);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    PrintUtils.instance.printLog('AppLifecycleState: $state');
    if (state == AppLifecycleState.resumed) {
      _appResumed();
    } else if (state == AppLifecycleState.inactive) {
      _appInactive();
    }
  }

  void _logAnalyticsEvent(AnalyticsEvents event) {
    EventLogger.instance.logEvent(event: event);
  }

  void _appInit() {
    WidgetsBinding.instance.addObserver(this);
    _logAnalyticsEvent(AnalyticsEvents.app_state_open);
  }

  void _appResumed() {
    _logAnalyticsEvent(AnalyticsEvents.app_state_resume);
    AnalyticsService.instance.appResumed();
  }

  void _appInactive() {
    _logAnalyticsEvent(AnalyticsEvents.app_state_background);
    AnalyticsService.instance.appInactive();
  }

  @override
  Widget build(BuildContext context) {
    if (isBuildFirstTime) {
      isBuildFirstTime = false;
    }

    return widget.child;
  }
}
