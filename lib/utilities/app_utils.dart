import 'dart:async';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:uuid/uuid.dart';

import '../network/models/response/user/user.dart';
import 'storage/shared_preference/shared_preferences_util.dart';

class AppUtils {
  AppUtils._();

  static AppUtils? _instance;

  static final AppUtils instance = _instance ??= AppUtils._();
  static const defaultPaymentErrorCode = -1;

  Future<void> initializeAppUtils() async {
    appInfoTagsSync = await appInfoTags;
    appInfoMetaDataSync = await appInfoMetaData;
  }

  List<String> appInfoTagsSync = [];
  Map<String, dynamic> appInfoMetaDataSync = {};

  String get uuid => const Uuid().v4();

  bool get isAndroid => Platform.isAndroid;

  bool get isIos => Platform.isIOS;

  bool get isMobile => isAndroid || isIos;

  bool get isDebug => kDebugMode;

  // TEMP CODE - MUNISH THAKUR
  bool get isRelease => kReleaseMode;

  //bool get isRelease => true;

  User? get user => SharedPreferencesUtil.instance.user;

  Future<String> get buildNumber async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.buildNumber;
  }

  Future<int> get versionCode async => int.parse(await buildNumber);

  Future<String> get versionName async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Future<String> get packageName async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.packageName;
  }

  Future<String> get appName async {
    final packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.appName;
  }

  Future<List<String>> get appInfoTags async {
    return [
      'appName:${await appName}',
      'packageName:${await packageName}',
      'versionName:${await versionName}',
      'buildNumber:${await buildNumber}',
      'versionCode:${await versionCode}',
      'uuid:$uuid',
      'isAndroid:$isAndroid',
      'isIos:$isIos',
      'isMobile:$isMobile',
      'isDebug:$isDebug',
      'isRelease:$isRelease',
      'operatingSystem:${Platform.operatingSystem}',
      'operatingSystemVersion:${Platform.operatingSystemVersion}',
    ];
  }

  Future<Map<String, Object>> get appInfoMetaData async {
    final parameters = {
      'appName': await appName,
      'packageName': await packageName,
      'versionName': await versionName,
      'buildNumber': await buildNumber,
      'versionCode': (await versionCode).toString(),
      'uuid': uuid,
      'isAndroid': isAndroid,
      'isIos': isIos,
      'isMobile': isMobile,
      'isDebug': isDebug,
      'isRelease': isRelease,
      'operatingSystem': Platform.operatingSystem,
      'operatingSystemVersion': Platform.operatingSystemVersion,
      'userInfo': user?.toMapShare() ?? {},
    };

    return parameters;
  }

  Future<bool> configApp({required BuildContext context}) async {
    // Comment by - Mandara
    // Config app anytime with required data - specially when app starts or after login
    return true;
  }
}
