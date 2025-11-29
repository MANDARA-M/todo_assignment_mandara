import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../enums/app_enums.dart';
import '../../../firebase/appInsights/event_logger.dart';
import '../../../network/models/other/app_meta_data.dart';
import '../../../theme/theme_utils.dart';

class SharedPreferencesUtil {
  SharedPreferencesUtil._() {
    alSpKeysToRemove = <String>[keyTheme, keySession];
  }

  static SharedPreferencesUtil? _instance;

  static final SharedPreferencesUtil instance = _instance ??= SharedPreferencesUtil._();

  final String keyTheme = 'appTheme';
  final String keySession = 'session';
  final String keyAppMetaData = 'appMetaData';
  final String keyLanguageCode = 'languageCode';

  late List<String> alSpKeysToRemove;

  static late SharedPreferences _storage;

  static Future<SharedPreferences> initialize() async {
    return _storage = await SharedPreferences.getInstance();
  }

  //sets
  Future<bool> setBool(String key, bool value) async => _storage.setBool(key, value);

  Future<bool> setDouble(String key, double value) async => _storage.setDouble(key, value);

  Future<bool> setInt(String key, int value) async => _storage.setInt(key, value);

  Future<bool> setString(String key, String value) async => _storage.setString(key, value);

  Future<bool> setStringList(String key, List<String> value) async => _storage.setStringList(key, value);

  //gets
  bool? getBool(String key) => _storage.getBool(key);

  bool getBoolOrDefault(String key, bool defaultValue) => _storage.getBool(key) ?? defaultValue;

  double? getDouble(String key) => _storage.getDouble(key);

  int? getInt(String key) => _storage.getInt(key);

  String? getString(String key) => _storage.getString(key);

  List<String>? getStringList(String key) => _storage.getStringList(key);

  //deletes..
  Future<bool> remove(String key) async => _storage.remove(key);

  Future<bool> clear() async => _storage.clear();

  Future<bool> setLanguageCode(Language languageCode) async => setString(keyLanguageCode, languageCode.languageCode);

  String? getLanguageCode() => getString(keyLanguageCode);
}

extension SharedPreferencesUtilExtension on SharedPreferencesUtil {
  Map<String, dynamic>? getSharedPreferenceMap(String key) {
    try {
      final spAppMetaData = getString(key);

      if (spAppMetaData != null) {
        final json = jsonDecode(spAppMetaData) as Map<String, dynamic>;
        return json;
      }
      return null;
    } catch (e) {
      EventLogger.instance.logError(exception: e, stackTrace: StackTrace.current);
      // ErrorLogger.log(e, StackTrace.current);
      return null;
    }
  }

  Future<bool> saveAppTheme(ThemeMode theme) async => setString(keyTheme, theme.name);

  ThemeMode getAppTheme() => getString(keyTheme) != null ? ThemeUtils.getThemeFromString(getString(keyTheme)!) : ThemeMode.dark;

  User? get _sessionUser {
    final _auth = FirebaseAuth.instance;
    return _auth.currentUser;
  }


  User? get user => _sessionUser;

  String get userId => user?.uid ?? '~';

  String get userName => user?.displayName ?? '';

  bool get isLogin => userId.length > 5;

  Future<void> logout() async {
    for (final key in alSpKeysToRemove) {
      await remove(key);
    }
  }

  Future<bool> setAppMetData(AppMetaData appMetaData) async => setString(keyAppMetaData, json.encode(appMetaData));

  AppMetaData get appMetaData {
    try {
      final map = getSharedPreferenceMap(keyAppMetaData);
      if (map != null) {
        return AppMetaData.fromJson(map);
      }
    } catch (e) {
      EventLogger.instance.logError(exception: e, stackTrace: StackTrace.current);
    }

    return AppMetaData();
  }

  Future<bool> setOnBoardingCompleted() async => setAppMetData(appMetaData..isOnBoardingCompleted = true);

  Future<bool> setAppFirstTimeLaunchCompleted() async => setAppMetData(appMetaData..isAppFirstTimeLaunch = false);

  bool get isOnBoardingCompleted => appMetaData.isOnBoardingCompleted;

  bool get isAppFirstTimeLaunch => appMetaData.isAppFirstTimeLaunch;
}
