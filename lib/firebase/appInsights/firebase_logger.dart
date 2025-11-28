import 'dart:async';

import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';

import '../../utilities/app_utils.dart';

class FirebaseLogger {
  FirebaseLogger._();

  static FirebaseLogger? _instance;
  static final FirebaseLogger instance = _instance ??= FirebaseLogger._();

  final _analyticsCommonProperties = <String, Object>{};

  Future<void> initialize() async {
    await _setSessionMetaData();
  }

  Map<String, String> _formatParameters(Map<String, Object> parameters) {
    final stringParameters = <String, String>{};
    parameters.forEach((key, value) {
      stringParameters[key] = value.toString();
    });
    return stringParameters;
  }

  Future<void> _setDefaultEventParameters(Map<String, Object> parameters) async {
    final stringParameters = _formatParameters(parameters);
    return FirebaseAnalytics.instance.setDefaultEventParameters(stringParameters);
  }

  Future<void> _setSessionMetaData() async {
    final appInfoMetaData = await AppUtils.instance.appInfoMetaData;
    _analyticsCommonProperties.clear();
    _analyticsCommonProperties.addAll(appInfoMetaData);

    await _setDefaultEventParameters(appInfoMetaData);
  }

  Future<void> _appendSessionMetaData(Map<String, Object> parameters) async {
    if (_analyticsCommonProperties.isEmpty) {
      await _setSessionMetaData();
    }
    _analyticsCommonProperties.addAll(parameters);
    await _setDefaultEventParameters(_analyticsCommonProperties);
  }

  Future<void> setSession({required String phoneNumber}) async {
    await FirebaseAnalytics.instance.setUserId(id: phoneNumber);
    final parameters = {'phone_number': phoneNumber};
    await _appendSessionMetaData(parameters);
  }

  void logError({required dynamic exception, StackTrace? stackTrace, dynamic reason, bool fatal = false}) =>
      FirebaseCrashlytics.instance.recordError(exception, stackTrace, reason: reason, fatal: fatal);

  void logEvent(String name, {required Map<String, Object> parameters}) {
    final stringParameters = _formatParameters(parameters);
    FirebaseAnalytics.instance.logEvent(name: name, parameters: stringParameters);
  }
}
